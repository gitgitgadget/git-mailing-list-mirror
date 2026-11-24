Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553045;
	b=4bIQec6THEFkFThLHUlqVqyCEqZlnpAmRCvAVrGc/4Qy/t8qhI2W/CAToGMGQtWFOyan
	 jbz8tHWyZRGK+cYsJOLq/sip0Y6T4EK0wSo5oQw3W9aWghN58tYDEEdKYUbRjpj4IAKrM
	 KuamIeTiOP8sGsLoovjU9UALbDIgftXggmDPP4EGvQb+bEjTwsM3OPJOS4YWWyOlm2HAd
	 15OVmFA043Bo+jfgXwhT6Cmz91XHZCdnRCNrLx0ZB01WWuHrwwwRLEyv9WCOD098xXbYJ
	 FgrIwwd8o1z5NEr5Ql4/JZv1BAT06LNNpkDkxKY5wJnpYhesAaYkRDwpCVi5wfVE4/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553045;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zpBrbeOSdMXmVpLQAETpFIVlqXaCrtz+Z9KLtul3SQo=;
	b=4uSTowVMx+Av4Y4HIOgSlKSK/k7rUg6s3EZPYvBk6W/CfqpZ6yOHOkxH1ZyYaueo440Q
	 22ehqpeeq2hLGoWsQWsKDQruFttIGugySNdp8SfkYyhs0wnyrHvTdmhVBxG5rq5Qxe06S
	 brRsPeeraAZ1xzkDl09pXqH69ePvkOblQhUzdHw1d2rCooJRoIr6dJO5A+NjiaBd5GGjq
	 Eqap5oaciWSznzdV+V5RsrzaKlW63CGEGmXC0kmFvSXZNcNwN38EGqrldB3hc5sgFMKEC
	 ETGwWx7TiTklmvKcdzGskhSY7Vr/9LEq6ZChMDaT1Qjb4DZYC/50/EKzEzMYCZWgvUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XSzzz1kk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sAUPinYY;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE85606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE85606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XSzzz1kk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sAUPinYY
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 65142EC09C2
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:44:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 15:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795553044; x=1795639444; bh=zpBrbeOSdM
	XmVpLQAETpFIVlqXaCrtz+Z9KLtul3SQo=; b=XSzzz1kkGSJactTlbH8Hj9/EAW
	RyvCpiHQyTmnBnrHOm3YWTg6ZKzwW5M2sVO3humraH9cNBpAQ2mHy/+OprEI5ZN0
	0/saCOiMsHg+5kzjMEaAKoU8AkfJOY0ncKxVbOkcxJ02slGAF+AbNmxjZTl1e/HY
	USmnN1CgtJ/fUH2bfDDgKktK5eXYTzmlhMk6Y+b5xbylYHDOBnsQkgtW87U7bcC0
	VpugVvq/VjtGDTQN5r5EzyryppF7GrDWX0uF/yTw227wDebQik0ZS4qvZ18YozEs
	j7Pzg8cAWHmIhTOsnCM0IzQsVXhj1GWsIIjPP6Y9w/d7J4NVNBPOAnT5iIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795553044; x=1795639444; bh=zpBrbeOSdMXmVpLQAETpFIVlqXaCrtz+Z9K
	Ltul3SQo=; b=sAUPinYYfrMw5QBU7C0Ed417ciTf4pe56nuAjxtEZlkVYYdJk4I
	8LPkMhgGQceG0fXRVHwdPg/GkTDaMNdqqHVan8NeOcCEXsu4rUURCF+xUCWnTrya
	eRf+Yu4CYT1G3c5MGRwUwHOGYaXHCEaYQJrA1El/jO6fjmqhAv+EgGIgL6pc3nnf
	1xVY/8VzH2jSxR64o6wpeIsP0Xj8Tnoib14mqjVDLChUcXs+CVY0t3qwDN5dSGhS
	sXkV+b7PiA3bQKyZ/PmNMhWhLMSghA+g5mWnS20AE6hXnb4nD6yV6OD0oJp+RmQd
	NN3m3IIU6ti/ycShA+qdn7znIk/Wqp+SnlQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795553044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WANsdu8fri2nBTE3+/fPQ3mi6V+OZ46/93qsegySuyIzKiN
	8e7BtCc40AJQNV6PNjowfL+Rq4q5beZTYYpQkEPa09+2g8ZH613K0W0OmS1Us1LO
	2qdBIcchCx18L/MyLmhUSbQ8OiU5+v7scG65/9dsXtiYPsNvCglNrAu4jOfTur1G
	8u+zFjSqfr+DCaJcVqC+rwYtAIkwPyguYjf94D3HcGYhg8cnVVTSOJhaAnUBFgdX
	ywZjIYk/0qpOpgJm0j9r9Nr6L/MjtDp7ai8Xuz9R8HSpvalmCoQHQz7Ea4wLihFa
	eORCZrVQu3WJbIbqiFKQzJ5nfSMDcS26GfiuUJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:09m6fBH1xdQ9JxgxM3+2M+KoDjzqHYBbumzV+G03HM8=:Rl4bS2zHKh7lk9YwSya7XpElLmufVQdjVaUtuzIRAkw=;
X-ME-Sender: <xms:FPcFazY3jabn54wbhQw2poza7JrJSAhvidqRiqquS1DDFb4jY_cTtQ>
    <xme:FPcFa5bGsebO_ozbL328nM__0Tq89AmuOoy4RhWAfdE8TRMgySGcfQGlEGAsYKrJd
    FJEXHte_WvFdAdIj3dNsGB7v0hGdq_5JDEwjwaKBQhck12HpVCQGg>
X-ME-Received: <xmr:FPcFa69fToaPYqKjoDTsNtbGhcPV2nR7WomdME8KjhXuEius3NVhFWpvodtgYjL56_I5i609_dUe_F6VBevVoLlJOFH8LpQXk4--q9k>
X-ME-Proxy-Cause: dmFkZTGI8pEnokAYkPxZAV6jAm4FRBANdGj8q6CyPC93Yp7kgXbkp9cWQ3RYWwZ26ynv7U
    Ofcl0WgZalmR5bF0NQe8hZGFmXYKSEw9rVi/SynG8lada2JZRT9FKZXuUjb1Bd0CU6GBfv
    OU+gQfmY/A3P19OQ48J33RlxkObt/8Fzz+fW1u+5nnVfJhxli5gTBSACHxUnvl7eysPJLh
    lnj7mG4eD23O+gwtj4k2Z7RX5GYdv9RCVY3bJg53QJpsgEEAxp5IpJtpDEDuwovObsyWhi
    1SnoVjIhj6a6fbVzQzfGfRm/hE0aAAFx700O4VZIyuU3kmVvayflGBPxhI4V8eIy8yxGbB
    uBZFJWV6zJIgERPNWpZWh0u2alBq05CZN1zTakKGoLJrL/cejJYw6fxug60Yn831vNZJzb
    MVHCui1V27MD2+jxqXuxmb7q7H1AgCgyvUFW0m7s5+DdUr2wgSAEu6IaZXdemfdesxsA9j
    /zxKRQWeI3yVUl7ALWX3gG5o3gs6S81dfB0XYNltFexB7gzuIZn+ueh7bIHCm0UIQg998T
    lXDTXt9wqUvcdHryDl7O8L/Wiv6zLMIP56+W7Gwoju+NZxAmopMh4JRG6SdpMdcuU98NXw
    HBPjCCBxYZQMn9S8Zd2Xo5xeaaANCARMmYOCzVHBoUSYiTHg3/vqy53Qw6Pw
X-ME-Proxy: <xmx:FPcFa4gFymlmvIX4joAdU0oRsxdE4XX_QOXaiUNLY_vd8XEoXDp-ww>
    <xmx:FPcFa6fAnUIcbeWR5G9knizHP6qHkN-eYongzVRNbG30ayRklbJkXA>
    <xmx:FPcFa_pey9KQqyink0lE7J_Ve3HLt3evkkM4J0ll_ip-L6YE_ypq2g>
    <xmx:FPcFa_AfT1qdQBRxqVVurD6VtpdUaXJL2sY_CWwi0LFsKQ_iWyvF2A>
    <xmx:FPcFa6dWtUP13-kKJn7h4WwgL1Mufvecqe5_fRxXfCNre_3tXJTNw9G4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:44:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 3/3] submodule init: copy submodule.<name>.gitdir to
 config.worktree
In-Reply-To: <b5d203d0147715dc2b38f13be427ef8d2138321d.1795273853.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Sat, 21 Nov 2026
	15:10:53 +0000")
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
	<b5d203d0147715dc2b38f13be427ef8d2138321d.1795273853.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 12:44:02 -0800
Message-ID: <xmqqo6benenh.fsf@gitster.g>
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

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Make 'git submodule init' copy an existing setting to the worktree
> config only if it belongs to the current worktree; otherwise, generate
> a new setting.
>
> Warn when an existing setting does not match the current worktree and
> is not copied to the worktree config.

This makes the transition to extensions.worktreeConfig much safer for
existing repositories, and the new warning plus test cases covering both
main-worktree and linked-worktree migration look solid.

> +static bool submodule_git_dir_matches_current_worktree(const char *gitdir)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	struct strbuf submodule = STRBUF_INIT;
> +	char *super;
> +	bool matches;
> +
> +	if (is_absolute_path(gitdir))
> +		strbuf_addstr(&submodule, gitdir);
> +	else if (!repo_worktree_path_append(the_repository, &submodule,
> +					    "%s", gitdir))
> +		return false;
> +
> +	if (strbuf_normalize_path(&submodule)) {
> +		strbuf_release(&submodule);
> +		return false;
> +	}
> +
> +	super = absolute_pathdup(repo_get_git_dir(the_repository));
> +	matches = starts_with(relative_path(submodule.buf, super, &tmp),
> +			      "modules/");

Isn't there a subtle symlink / normalization mismatch here?

repo_worktree_path_append() uses 'the_repository->worktree', which is
canonicalized via real_pathdup() during repository setup.  In contrast,
absolute_pathdup(repo_get_git_dir(the_repository)) uses 'PWD' (if
matching 'getcwd()') without resolving symlinks when the gitdir is
relative, and copies an explicit absolute GIT_DIR verbatim without
resolving symlinks or normalizing '.' / '..'.

While 'git submodule' normally runs cd_to_toplevel() (resetting PWD)
when GIT_DIR is unset, running 'GIT_DIR=.git git submodule init' from a
symlinked path to the worktree (or 'GIT_DIR=.git/../.git', or invoking
'git submodule--helper init' directly via a symlink) causes 'super' and
'submodule' to diverge, triggering a false mismatch warning and
generating a new gitdir instead of copying the existing one, no?

Using real_pathdup(repo_get_git_dir(the_repository), 1) for 'super' (and
strbuf_realpath_forgiving() for 'submodule' in case an existing absolute
'gitdir' config contains symlinks) keeps both sides canonicalized, which
might make it safer (though the resulting path may become uglier, as it
often is the reason why people use symlinks that are more comfortable to
the eyes and "cd" to a directory through them).
