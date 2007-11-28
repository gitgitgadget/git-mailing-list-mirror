From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase/cherry-picking idea
Date: Wed, 28 Nov 2007 01:47:12 -0800
Message-ID: <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:30:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [129.240.10.42] (helo=mail-forward.uio.no)
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKJN-00010a-Fy
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:38:33 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJaQ-0004Gq-UO
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:52:06 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJaI-00068D-Ci
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbXK1JrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 04:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbXK1JrV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 04:47:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56941 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbXK1JrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 04:47:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5D8462F0;
	Wed, 28 Nov 2007 04:47:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 94309999FA;
	Wed, 28 Nov 2007 04:47:35 -0500 (EST)
In-Reply-To: <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> (Wincent
	Colaiuta's message of "Wed, 28 Nov 2007 09:52:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required=5.0, autolearn=disabled, AWL=2.084,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 88A8E86A2EC87FD08EA6F8C40D3E8C3CDE8415D1
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -48 maxlevel 200 minaction 2 bait 0 mail/h: 105 total 724273 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66287>

Wincent Colaiuta <win@wincent.com> writes:

> The problem in this case was that my patch didn't receive any
> meaningful feedback (ie. suggestions for improvement), only a lot of
> bikeshed stuff about whether the environment variable should have an
> underscore prefix or not, whether or not I should use "export FOO=..."
> or not etc. So I didn't know what was necessary in order to get it
> accepted.

I do not think that is the case.

I think _GIT_FOO vs GIT_FOO is an important detail, not at all a
bikeshed color, to make things consistent.  "export VAR=VAL" also is a
valid concern (you said in a separate message you only know about bash,
and I later asked people if they use shells that get affected with it
but we happily run otherwise.  I personally do not think the latter is a
problem, but since somebody already raised it as a potential issue, it
gave us a good chance to hear from people on minority platforms, if only
to build confidence in us to use that POSIX form.

Maybe it is just me, but I think my suggestion to replace not just "git
commit" part but also "git add" part is also an important design issue.

In any case, after a discussion, sending out a readily applyable patch
would help to make sure we reached a reasonable consensus; it makes it
easier for other people to try out your proposed draft of the consensus
without waiting for me or anybody else and give positive feedback.

The difference between the variant I posted and your revised one I see
are:

 * As discussed, we have precedence like GITHEAD_* and GIT_REFLOG_ACTION
   that are used purely for inter-tool communication without the leading
   underscore, so I followed them for consistency.

 * The part of the message that is overridable is made wider; that way,
   we can later choose to have "git rebase --continue" do the final "git
   add -u" step, just like we made "git rebase --skip" to run "git reset
   --hard", without changing revert/cherry-pick,as I explained in the
   comment to my patch.

 * I made the help-message creation into a separate function.  This is
   just a minor detail, but I think it is good for readability.

 * I am setting and exporting the help environment near the beginning of
   rebase--interactive just once; again I think this is more readable.

But other than that, the basic idea is the same and is all yours.

If these details (I do not think the overridability is a minor detail,
though) look like bikeshedding to you, that is somewhat sad.  You seem
to be very capable of producing usable code, but these details
(consistency and flexibility) matter for longer term stability, and I
would really want to see capable people pay attention to such details,
especially I sometimes fail to do so myself.
