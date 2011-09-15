From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Wed, 14 Sep 2011 20:41:11 -0700
Message-ID: <7vwrdaqxpk.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
 <7v1uvta97o.fsf@alter.siamese.dyndns.org>
 <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
 <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
 <7vk49k48q4.fsf@alter.siamese.dyndns.org>
 <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
 <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
 <alpine.DEB.2.00.1109082123300.12564@debian>
 <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
 <alpine.DEB.2.00.1109090900301.12564@debian>
 <alpine.DEB.2.00.1109122139110.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 05:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R42pL-0006BM-1O
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 05:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1IODlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 23:41:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab1IODlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 23:41:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B575621;
	Wed, 14 Sep 2011 23:41:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZSdeMPHu0aDDcZD/vN6HBv2nSc=; b=oRGwjs
	FjAfg1xjbw8HJKOHr2KSHJX6xXKW9kHjfpvlUFdI9AY2TTFU0uZOtl/nGDN5beEl
	rVnm/NSmkOG1kQFgJH+f2mIQyxP8Jag2xPnI2+4xbIKtxII90NArW8oKc1521qOU
	kXMDhkZg5cAtoesDfCtfY1x689YOmuQwVH4C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oDo/u4CtKVN/BDrzwd1UDDva3Ogum9fJ
	6Xxebh5qh4Y12Dr3dM4BmXm4iqCp5cU3U2Nzwijd4DX/rJYTh9W3etBRzlb3LBqY
	ERtbwCJQ1ptYbCi6u4SoouFCM2oTqW7ZPwgRMbhhZxTdJ2JBq5mVTz+MYeUINf6p
	nxgs4yePEPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69BD65620;
	Wed, 14 Sep 2011 23:41:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3BFC561F; Wed, 14 Sep 2011
 23:41:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1109122139110.12564@debian> (Martin von
 Zweigbergk's message of "Wed, 14 Sep 2011 22:19:39 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED7EBF4-DF4C-11E0-86BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181431>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

>  2. Somehow modify git-rebase--am.sh not to depend on format-patch. In
>     [1], Junio mentions rewriting git-rebase--am.sh "to have
>     format-patch avoid the cost of actually generating the patch text"
>     and "when using "am" for rebasing we do not really care anything
>     but the commit object names". If all we need is the commit name,
>     why would we not use cherry-pick/sequencer instead of git-am?

What I said is "all 'am' need to use from its input while rebasing is the
commit object name"; that is very different from "we have only commit
object name so we must use cherry-pick" or "because we have commit object
name, we can afford to use cherry-pick".

Look for $rebasing in git-am.sh and notice that:

 - We run get-author-ident-from-commit on $commit to keep the authorship
   information in $dotest/author-script for later use, instead of letting
   them read from $dotest/info prepared by "mailinfo".

 - My "fixing it would be just the matter of doing this" patch in a
   separate thread we had recently ("mailinfo" would obviously have
   trouble telling where the message ends whilerebasing a change with
   patch text in the commit log message) adds a similar logic to extract
   the patch text out of $commit in the same place as above, to override
   what "mailinfo" prepares in $dotest/patch.

 - Even with the above two differences from the normal "separate the
   metainfo and patch from the mailbox, and use them" codepath, $rebasing
   codepath uses the same "git apply && git write-tree && git commit-tree"
   flow.

Use of "apply && write-tree && commit-tree" is to avoid the merge overhead
of using cherry-pick, and historically, it used to matter a lot, because
starting merge-recursive was very slow (it was a Python script). Even
though we have merge-recursive rewritten in C these days, it probably
still matters, especially for large-ish projects, because merge will trash
the cached-tree information in the index, making write-tree inefficient.
