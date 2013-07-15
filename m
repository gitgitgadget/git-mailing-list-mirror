From: Junio C Hamano <gitster@pobox.com>
Subject: Default expectation of --lockref
Date: Mon, 15 Jul 2013 08:47:51 -0700
Message-ID: <7va9lnddug.fsf_-_@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
	<7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org>
	<7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org>
	<7v61wdgdd1.fsf@alter.siamese.dyndns.org> <51E3084D.2040504@kdbg.org>
	<7vd2qkfpm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 17:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyl0T-0002Cs-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140Ab3GOPr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:47:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092Ab3GOPry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:47:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3A930C40;
	Mon, 15 Jul 2013 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XKi/qjYfiZYQgjyqogVwtjQ/SiM=; b=V7kQke
	5/w81V2d/Ktjt1pujQwuFl2paP2Y9doyhATujs3U4Ef+hoDkVYtTz2J2BI5ZEQVS
	s5Oib4WgSUN3tTK1Z36J97XOzrWgTQpuaSjruNxFYe06dVi9HaBQAky1DuAZoJq6
	K/QzPGMnPFHTMKJOy/K7r3E2zy1XGeRV1Uco8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/kPGN+n1eYsWXAlyiQiapXkoFcjl0O3
	rrz9S+pa/xzaXtPnkVTE5gXO9X6tnjqoCQiLiEYU3R9Cje5KNiTDGvvvslJ9a2sx
	0Y0pqxsbA1D0t5UeexAxBPwtDREJtDqtTLmtq07RTBhiObmJ0MS+ybLolDmKU3Kj
	Q/XYAlrxbPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C27BD30C3F;
	Mon, 15 Jul 2013 15:47:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E749A30C3C;
	Mon, 15 Jul 2013 15:47:52 +0000 (UTC)
In-Reply-To: <7vd2qkfpm8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 14 Jul 2013 20:50:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E85344-ED65-11E2-9BB9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230483>


> I think the use of "reverse tracking" is way overrated.  It is
> probably the only default value that we could use, if the user is
> too lazy not to specify it, but I do not think it is particularly a
> sensible or safe default.
>
> The following does not discuss "should --lockref automatically
> disable the 'must fast-forward' check?".  The problem highlighted is
> the same, regardless of the answer to that question.
>
> After rebasing beyond what is already published, you try the
> "lockref" push, e.g. (we assume you work on master and push back to
> update master at your origin):
>
>       $ git fetch
>       $ git rebase -i @{u}~4 ;# rebase beyond what is there
>       $ git push ;# of course this will not fast-forward
>       $ git push --lockref
>
> If somebody else pushed while you are working on the rebase, the
> last step (one of the above push) will fail due to stale
> expectation.  What now?
>
> The user would want to keep the updated tip, so the first thing that
> happens will always be
>
>       $ git fetch
>       $ git log ..@{u} ;# what will we be losing?
>
> The right thing to do at this point is to rebase your 'master' again
> on top of @{u}
>
>       $ git rebase -i @{u}
>
> before attempting to push back again.  If you do that, then you can
> do another "lockref" push.
>
> But the thing is, a novice who does not know what he is doing will
> likely to do this:
>
>       $ git push --lockref
>
>       ... rejected due to stale expectation
>       $ git fetch
>
> You just have updated the lockref base, so if you did, without doing
> anything else, 
>
>       $ git push --lockref
>
> then you will lose the updated contents.

We _might_ be able to use the reflog on refs/remotes/origin/master
to come up with a better default expectation.

We are pushing an updated master, and the commit at the tip of the
branch has a committer timestamp.  refs/remotes/origin/master should
at least have two reflog entries for it at this point.  The latest
one is our latest "git fetch" after the previous lockref push failed
(and we see somebody else updated the master at the origin).  One
before is the one we based our judgement that the rebased result can
replace it.  They both have timestamps for reflog updates.

So we _could_ use refs/remotes/origin/master@{$timestamp} where
the $timestamp is the committer timestamp of the tip of 'master'
we are pushing to replace the 'master' branch at 'origin'.

I do not particularly like this approach, though.  I do not
particulary like the "look at the tracking branch of what we are
updating" in the first place myself, because it requires you to have
such a tracking branch, but now with this, we will also require you
to have a reflog on such a tracking branch, too, which is even
worse.  And it is making it too complex and obscure, even though I
think the semantics would make sense.
