From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 09 Sep 2008 14:05:28 -0700
Message-ID: <7vfxo958tj.fsf@gitster.siamese.dyndns.org>
References: <20080909132212.GA25476@cuci.nl>
 <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
 <20080909195930.GA2785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAQ8-0000Sa-Us
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYIIVFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYIIVFh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:05:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYIIVFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:05:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6CB65A6B8;
	Tue,  9 Sep 2008 17:05:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DEF5B5A6AF; Tue,  9 Sep 2008 17:05:30 -0400 (EDT)
In-Reply-To: <20080909195930.GA2785@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Sep 2008 15:59:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0C0C3B1E-7EB3-11DD-A6B5-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95431>

Jeff King <peff@peff.net> writes:

> And yes, you can get _too_ general to the point where your semantics
> become meaningless. But I don't think that is the case here. You are
> defining the origin field as "by the way, the difference between state X
> and state Y was used to make this commit". cherry-pick just happens to
> make Y=X^, but something like rebase could use a series.

Another thing that made me wonder...

To be consistent, when you are at HEAD and are merging side branch B,
because that merge is to incorporate what happened on the side branch
while you are looking the other way, we should say "by the way, the
difference between state $(git merge-base HEAD B) and state B was used to
make this commit." in the resulting merge commit, shouldn't we?

What happens if there is more than one merge base?
