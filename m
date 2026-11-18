Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031530;
	b=I4HFyc7C6lXMxTiP2WB7niZ9IrKHfytCJIJBvTLZu/HYjMT/UI5uxpfaHi8rXvR1QyKj
	 83I6B4OjgJgQpRLESzkkqFALwEptL0HBxcciLBwOmpuygU5uif9l3A+iCzYSXllU5Do2L
	 sQsIzRWE4kXQuYoLHXvXJy1FiJRdVGApbEKMzh0Uo1zt8HcTdqg2dDBHUqNoFj8dYYgxi
	 Q6qUIhfSDwEptbdmGmK710BoDYxKVRgFLmf4TM37tczoSgx6+GBGLA9BYfIt2hhz4Q+On
	 yRKyVukDAhotGe34U0tf3IPy9kZXuW5Y3mTI2UbugTsGfdPhHzg7p6m1Oo4uO0RMWEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031530;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FFvjfwWuuzYfps6cyLZlb+U1l0Eahw4FA5Ouz+f6NRE=;
	b=KrDFgRLbfsx1hJtP6rpL/ZpY4ElFnTpljtR+y9SmSJh2yZ+KFHi2yshubp5hIFHZUDuD
	 XoOIzmnA1Ty/4sHI0xeKVg2vScm+9vSbX/Fk5E4vnJsuXMCGIIQwFoyyenIAkLqOYVGkV
	 NiL4HvJPvxDpz4nYmf5LNc0baID/qbEEBT0iK2UKbkXz6m6qX9uv/CNy5KkpEyhJCC+kN
	 ENhVvSTqu9sRlU6j1kdGNhyysjzgcJfIAzdr9EyJ4/cFEbXlLslFpM7wbQLT8HZrgQ37S
	 jmkvGwMqTw+9/VO0UmiC6hSt5PZuKeryXxgiW45wt1vAJ1K2d4BW0OpYcIVg1U9FEiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RjogJBts;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R2Ycfw3j;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70321606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70321606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RjogJBts;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R2Ycfw3j
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DE111400035
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:52:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 14:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795031529; x=1795117929; bh=FFvjfwWuuz
	Yfps6cyLZlb+U1l0Eahw4FA5Ouz+f6NRE=; b=RjogJBts+RCGE0NGolsPWANic7
	iS3oN5nAetv5Mrz87FTzaX6kXgLLw+6cuzN40YlzKYbdZGsjTe4GLmDwvbjlzF2I
	0WM3PJacj3pVmIgKfDAMb+0e9keatjs3p13pcgV1xNSkk4KxVYGVWaMit5BUbCqQ
	inhwKzYtmtgJL3avzGOeS+Ec0ptFDVHHQmUhH9QeHXXhrWgdSVwsF49fPNK276x7
	ihG7hW1axd5t+rt7Em9LhIt0H2+NjoCh3EmZFxLuRPcbMI0bt3WMJZ+LUimLLKnT
	ZGOW49F3vwko9y4lcc6mVAPe/PwaPO6fm54LfDlDva+Z7lFSV8TZYgGlDbwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795031529; x=1795117929; bh=FFvjfwWuuzYfps6cyLZlb+U1l0Eahw4FA5O
	uz+f6NRE=; b=R2Ycfw3jALNyHqK4Qd5q51txCHffdeHu+w+WIkFjd3elgp5O8MX
	2hvpYMcgRgBZczHJHrV3O9K4znVx+kldLq8o/mfBR9A6oMa9b22EIFdV0srTvKzR
	qV0UoOc1ZxNElVUxhOq7EOh72gkuDYQToAqozrvjQCiH7PwryGM/faQmrTL/x4AX
	XxL0ccloIfvLWgG5FxM/UHmYi3NaadR2BGtTHDOHGYMhk8Efh4hWCv+Tf0VjYBUm
	49EWJ6mJcUNYDJOv+3M4D5FFhTM1Qg1yZ28Sp4PtZFxWblwKjO+IwctaSpQOwdDs
	Cbrd4mt73OHVik86k3ROmFRnq+kxKWPAsSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795031529; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dSHgseOlEff3iE3sO+/8kBFHzdkelz28Kik9T2p+pfStPUh
	EshrQxDYcbaB6rqN66HV5nXqx0f3HQCnpyQ+TKOxBO8BTYadM8NthFxo6pTn8oun
	uc+iY/uiaXKcma8jAkNpczhTIjWmZsI8kqAFusSPkLFF5shunpKJea6+AOPYbV28
	dEIZgpWUFwV2ovBlPJyzmPOnqRZWg3D0uB4K36NetQLJK0UCc05k+2OaegELSL8/
	aqI7A54MB3XNqNgsMMtn/sTLdC4uxj189BJV4/TZZGF7//9o8N6iUcSh/6uj6UoS
	Q0mEx7+GGiIeGvBXMjjHb3atk1phyxyiadqjN4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CQM8CMSr5wzG2rIVT1eU+O/APujCGO4IZndNQ/Wc6SY=:pDl/qIKBpcbbc9PpdhePOVkE3U6Kkepc6fPsuiSsZjs=;
X-ME-Sender: <xms:6AH-as1IOzTZ_422EDRZo57WxldhD9XlZ7VAVeaHKNuHIWcNZxSi-g>
    <xme:6AH-agadj0epLVbjfRF8cwAyRaiLhoonv9mYN40XU_Yg7PILbV5RriTsLkPbfBYqa
    sqRZRMK4DR9u-A1Y6K15tted77HEEFhdV0Yl_hkrA8ujNxJBc_Xfw>
X-ME-Received: <xmr:6AH-asION9vaGaDGsqKauIkxk0KReE383DAlCBc5N7QrWNMRQnaela5rPNXrRxc6cyXw9YblxFG_y_WrAC5MVA7CSXk72qIdnjTU>
X-ME-Proxy-Cause: dmFkZTGkbQdv05j5YjCHvTasyCSTHxe1pRnrkwjKmiJ4WU4p21Ip3+/9wq62/A+9pOYjru
    0vPuW8ITX4xdZxefEvEd9+iEyzheQ+P7KtTqhwKKBc11tdn7dasZf7o+63kCqA1lIIaH4L
    iIYDt4Udoyh+q2VH3UdAXQ7c3+G4NqTip5+hVPXB0J6oBcBXlwPbOMlWm0jeD39NVrhW2v
    KhMxdTlGY5be2ar7SEQQF2tt72+2PNWwVmg7LzQUzaVoj7CW+e355211uVwf3hMomW2Y56
    qZluydFUbr+xodmebkbNQl4zE+JJX4ja6dkpnfc4WvZIiFTO8tRlkP4rWV57UNJSWzjKEb
    gziW3U1aWfGPNQtiL2gQHbNCsto81HtGgTqJ9gRljx7hQERFXhZ30FLtaj2HCZ/rvvDYGE
    fIbMY9RtFuu7w6XhZ6o+gaa/8kHf24m9GeOigifdJtfZXFJwYY8bXFYRbGBI03PP6nv29H
    d9rHKlQ2zxLOKWfQuXgtlYODTd+LXrvW2vXgo+BXEH2cBKEddbOlmPD7AZfoVL4O4zb+wY
    CsQvR8aJXXDjj+nQB8DgMiq5cY7sekXm3PFz/H4VyaqVl9J9bGWVx1yRoHmEwii5r1GloH
    YVRnjvn8aVEnC17m8JdTPmlkGuRsghTxN5VPZCTpQPcT480aKzv4B8JJjQyA
X-ME-Proxy: <xmx:6AH-anGzuzMdtK8REYOkS0ONE1EihoYHqt1JOaFFlFEYjyS5v_OEZg>
    <xmx:6AH-artjVyIi1DWghibqN689l0LnqjrhU2cSHtDEaGgBgEeeJBZs_Q>
    <xmx:6AH-aut8ATy5i-VRs14K6Wk4mwby7VFu3i64Ptgc4ZXEyH5F0YTnpw>
    <xmx:6AH-ahAuxcDpd-yn6tKmASFfKgdCi102MLoXTd1KRSSbQYFQiBBrzg>
    <xmx:6QH-ap79_PaKV2JooIZUTO_KxGMgVPAIMJOrT-QeX1K9dPQjkcj_XJBq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 14:52:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Andreas Wendleder <gonsolo@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/3] submodule: accept a linked worktree as the
 submodule's git dir
In-Reply-To: <20261118163249.1693361-4-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 18 Nov 2026 18:32:49 +0200")
References: <avuJBGlB3pRU3JU0@pampelmuse>
	<20261118163249.1693361-1-adrian.ratiu@collabora.com>
	<20261118163249.1693361-4-adrian.ratiu@collabora.com>
Date: Wed, 18 Nov 2026 11:52:07 -0800
Message-ID: <xmqqv75t534o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> A submodule's working tree can be a linked worktree of the submodule's
> repository, created e.g. with:
>
>   git -C super/sub worktree add ../../wt/sub
>
> Its .git file then points to "super/.git/modules/sub/worktrees/<id>"
> instead of "super/.git/modules/sub". t2405 already creates such a
> submodule, but it doesn't test a recursive checkout, and its worktree
> id happens to match the submodule name.

It is tempting to say "don't do it then", but if we can cater to the
use case that is great ;-)

> @@ -2132,6 +2171,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	const struct submodule *sub;
>  	int *error_code_ptr, error_code;
> +	int is_worktree = 0;
>  
>  	if (!is_submodule_active(the_repository, path))
>  		return 0;
> @@ -2170,8 +2210,9 @@ int submodule_move_head(const char *path, const char *super_prefix,
>  				char *git_dir = xstrdup(read_gitfile(dotgit));
>  
>  				free(dotgit);
> -				if (validate_submodule_git_dir(git_dir,
> -							       sub->name) < 0) {
> +				is_worktree = validate_submodule_gitfile_dir(git_dir,
> +									     sub->name);
> +				if (is_worktree < 0) {
>  					if (!the_repository->repository_format_submodule_path_cfg)
>  						advise(_("enabling extensions.submodulePathConfig "
>  							 "might fix the following error."));

Earlier near the beginning of the function we initialized
is_worktree to 0 and then only when submodule_uses_gitfile() is
true, we update it with validate_submodule_gitfile_dir().

> @@ -2191,7 +2232,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
>  			submodule_reset_index(path, super_prefix);
>  		}
>  
> -		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
> +		/*
> +		 * Do not reconnect a linked worktree to the submodule's
> +		 * main git dir: that would take over the git dir of another
> +		 * working tree.
> +		 */
> +		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) &&
> +		    !is_worktree) {

If a linked-worktree submodule 'sub' contains a nested submodule
'inner' whose .git is a directory, submodule_uses_gitfile("sub")
would have returned 0 (because the check is recursive), we ran
absorb_git_dir_into_superproject() (which is also recursive so it
would cause .git in 'inner' to be absorbed), and is_worktree is
still 0 at this point, which means if() condition here is satisfied
(if forced) and we will enter this block.  Would it cause an issue?

I am wondering if the check for is_worktree should be moved outside
the else clause, i.e. making the overall flow look more like

        if (old_head) {
                if (!submodule_uses_gitfile(path))
                        absorb_git_dir_into_superproject(path, super_prefix);

                /*
                 * Now path/.git is guaranteed to be a gitfile; 
                 * validate and detect worktrees.
                 */
                ...
                is_worktree = validate_submodule_gitfile_dir(git_dir, sub->name);
                ...
        }

Or am I grossly misreading the code flow?

Thanks.
