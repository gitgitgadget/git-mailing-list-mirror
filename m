From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Tue, 01 Jul 2008 18:20:15 -0700
Message-ID: <7v4p79hyk0.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <200807012004.11563.jnareb@gmail.com> <20080701195033.GD5301@leksak.fem-net>
 <200807020239.41613.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 03:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDr2B-00033w-74
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 03:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbYGBBU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 21:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYGBBU0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 21:20:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYGBBUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 21:20:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3176326D95;
	Tue,  1 Jul 2008 21:20:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 615AF26D94; Tue,  1 Jul 2008 21:20:18 -0400 (EDT)
In-Reply-To: <200807020239.41613.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 2 Jul 2008 02:39:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B2A0218-47D5-11DD-BF59-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87075>

Jakub Narebski <jnareb@gmail.com> writes:

>> No. It is "git-update-ref <ref> HEAD".
>
> So what do you envision would this be used for?

A simple answer and a more elaborate one.

 * It is the final step of "git rebase" which detaches HEAD while it
   operates these days.

 * You can drive sequencer backend from a front-end that rewrite history
   while rewriting tags, like filter-branch does.

>>> What is important is: does it update reflog (correctly)?

That is not very important question, as reflog updates would happen as
long as you use update-ref automatically.

Much more important question you did not ask is how it would interact with
"sequencer --abort".  Ideally it should rewind the ref update (and without
relying on the user having reflog on that ref).

I however personally feel that this "ref" thing is being a bit too
ambitious.
