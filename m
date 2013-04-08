From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 13:30:08 -0700
Message-ID: <7v8v4swysv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin>
 <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
 <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
 <7v1ual12pj.fsf@alter.siamese.dyndns.org>
 <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
 <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
 <CALkWK0m4o=F=bh_mt9NGDfXKExgVtLhaZ7uxA_XFhpF5AN5-Fg@mail.gmail.com>
 <7vk3ocx0qq.fsf@alter.siamese.dyndns.org>
 <CALkWK0npHgsf_TyjrMRJdcT-twg_jRXOHtoNpmX+2XNeLq=ZAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 22:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPIho-0004DY-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935925Ab3DHUaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 16:30:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935832Ab3DHUaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 16:30:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 082E515D8B;
	Mon,  8 Apr 2013 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a3qkmEI3nle+fF3upRVJc2EttIY=; b=p2atpE
	xnxCDphvR8ll76nDRNVHiOnjQ3dZC82lG10FUXEtn2ANVDaJS5qH9Txpegu23253
	NDc9NnE2sDS24cq2qqy08C0n+NiiONLuNZL3RHIKAijE2qcMNpyuwgp342A+P8cr
	yGuwu0kMYtFh+e5yxoJZYufuM8rFjSVvL3cpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sbfCU/xc6BWzx5YOoP0qdshVO9M6HDeU
	A5fvOFjniH2f4UjEeyCEprUO7yh7KDkGGaNBExSntm1zFh7OLB+KJ2EhIDq787li
	6Znc/zIjScsV6I67HfqwGGtavLBn5Pf1tODWqjuaW8byIbu5TVmxqeQXjLNyFzuV
	dQI8fM5+mdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFEC015D8A;
	Mon,  8 Apr 2013 20:30:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D05D315D88; Mon,  8 Apr
 2013 20:30:09 +0000 (UTC)
In-Reply-To: <CALkWK0npHgsf_TyjrMRJdcT-twg_jRXOHtoNpmX+2XNeLq=ZAQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 01:24:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BA76C20-A08B-11E2-80CF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220511>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Does git diff/ commit/ add/ rm or any other command you can think of
>>> rely on a special file in the worktree (aka .gitmodules) to be checked
>>> out?
>>
>> Try "git add foo~" with usual suspect in .gitignore ;-)
>
> First, it's not a hard requirement: in the worst case, git add will
> add the file even without a -f.

In the same sense .gitmodules is not a hard requirement, either.  I
use a submodule without .gitmodules in one of my repositories (the
top-level houses the source to generete my dotfiles and is cloned to
my environment at work, but the submodule houses my private files
that live only at home).  The gitlink entry in the index and the
tree and presence of the .git repository in the submodule checkout
(where it exists) is sufficient to make the layout work.

If your complaints were "I cannot make X work with the current
system, even with changes to git-submodule and some core part of the
system, and I think the reason is because the way module information
is stored is in a separate file .gitmodules", with a concrete X,
people who are more versed with the submodule subsystem may be able
to help you come up with a cleaner solution without throwing the
baby with the bathwater, but I do not think we saw any concrete X
mentioned.

The same sentence followed by "... and with an object of a new type
stored at the path of the submodule, I can make it work by doing A,
B and C", with concrete A, B and C, some people may be interested in
pursuing that avenue with you, but I do not think we saw such
combinations of <X, A, B, C> either.

If all of your argument starts from "I think .gitmodules is ugly
because it is not an object of a separate type stored at the path of
the submodule, and here are the reasons why I think it is ugly", I
have nothing more to say to you.  That "ugly" is at best skewed
aesthetics, and each and every example that comes up in this
discussion, like this "'git add' works with .gitignore", and the one
I sent on ".gitattributes vs .gitmodules on the default" in the
nearby subthread to Jonathan, makes me realize that .gitmodules is
_more_ in line with the rest of the system, not less.
