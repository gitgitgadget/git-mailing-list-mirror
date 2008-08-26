From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Tue, 26 Aug 2008 16:31:30 -0700
Message-ID: <7vsksr1hgt.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080822211902.GA31884@coredump.intra.peff.net>
 <48B3B8B0.4020609@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY81z-0001kb-Uj
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYHZXbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYHZXbj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:31:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYHZXbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:31:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B47AF5D2CC;
	Tue, 26 Aug 2008 19:31:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD1095D2C7; Tue, 26 Aug 2008 19:31:33 -0400 (EDT)
In-Reply-To: <48B3B8B0.4020609@fastmail.fm> (Michael J. Gruber's message of
 "Tue, 26 Aug 2008 10:02:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20D179CA-73C7-11DD-AFC9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93833>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> This allows the use of author abbreviations when specifying commit
> authors via the --author option to git commit. "--author=$key" is
> resolved by looking up "user.$key.name" and "user.$key.email" in the
> config.

Maybe it is just me, but I am hesitant about the contamination of user.*
configuration namespace.  This patch as a general solution does not scale
well, once you start working with more than a few dozen people.

Why was it insufficient to use an external shortname-to-fullname mapping
file like git-svn and git-cvsimport does, again?
