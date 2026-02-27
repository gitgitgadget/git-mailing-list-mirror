Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E636EAAD
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186303; cv=none; b=EoPOPVbIWHAcTZfMobjRuEMSSPOgNO9Q8SGLj5ktylg61taqNKgQ7INZ1fpZDBcA57TzUadLSNAHm2yTySS3hz+Gr6sAviQMCqcujSwWAuu3sHC+P6uO5iq7ie73gK02BbJckfuO6GK9tVR3NrFTneaQkuZnXXpLE5eQZtQstA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186303; c=relaxed/simple;
	bh=Pf+HfC8b83C3SCA4UcC+M0+6gtUHAYMg6IwFSNQ1HR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVO6EAYyqa71hERzBiMCXRIAhn4hyDUaKNFHIFMx+UsJ1+XFBTn9rHYZ4YE2tJ0p9QISNV9j/N9PbBeotD3OBdAGwQXr4NaQk+/a833BdotigsVfZcrZjqqi8U2jPUk5KLAJj31ogx1+LwVSo2iw0B5eShkh4kyBB4Vwj4LNGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=IYRD5jP/; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="IYRD5jP/"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5D3114D412
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 10:58:10 +0100 (CET)
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 43A725FFAA;
	Fri, 27 Feb 2026 10:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1772186282;
	bh=Pf+HfC8b83C3SCA4UcC+M0+6gtUHAYMg6IwFSNQ1HR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IYRD5jP/SV20/adQd+r+QBz7pr/EOl6aSLxGXEmLyhlmcSGlLPPXwKGPk1hs2MKsd
	 uj/akYh4be8ZsZGEw/8M9QOnwznWk4f1g5GhsaOXdvnlZAz/Jq6ctLW9SkvuXTag/W
	 g3HpuYkt7tTBvSfrVURVFZQsKO1eKetNwnLtYiVV0+9oT6kf38MjtPBzVzIiWkw9jG
	 zapWMddHJdqR9qpqJ+N8H7fywtrBcfcxfA2wuUSWu9SyPOA9pNO8fGCqNHqEyignvJ
	 4JgSVnUxeWF7reRX17PhUxDWAin0e4I5ub6EtvenOXKITUlVYqlOFDRWgTzX08Yo/y
	 5kA8h2BpdP+ew==
Message-ID: <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
Date: Fri, 27 Feb 2026 10:57:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: diff-options.adoc: show format.noprefix for
 format-patch
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
 <V2_CV_format.noprefix_boolean.421@msgid.xyz>
 <V2_format.noprefix_and_--default-prefix.423@msgid.xyz>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <V2_format.noprefix_and_--default-prefix.423@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/02/2026 à 00:30, kristofferhaugsbakk@fastmail.com a écrit :
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> git-format-patch(1) uses `format.noprefix` and ignores `diff.noprefix`.
> 
> The configuration variable `format.prefix` was added as an “escape
> hatch”, and “it’s unlikely that anybody really wants format.
> noprefix=true in the first place.”[1] Based on that there doesn’t
> seem to be a need to widely advertise this configuration variable.
> 
> But in any case: the documentation for this option should not claim
> that it overrides a config that is always ignored.
> 
> † 1: 8d5213de (format-patch: add format.noprefix option, 2023-03-09)
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     v2:
>     Change commit message. Don’t use “because”: the two quotes are not causally
>     linked like that.
>     
>     v1:
>     `--default-prefix` does override `format.noprefix`. See test `format-patch
>     --default-prefix overrides format.noprefix`.
> 
>  Documentation/diff-options.adoc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
> index 9cdad6f72a0..8f632d5fe1a 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -860,7 +860,9 @@ endif::git-format-patch[]
>  
>  `--default-prefix`::
>  	Use the default source and destination prefixes ("a/" and "b/").
> -	This overrides configuration variables such as `diff.noprefix`,
> +	This overrides configuration variables such as
> +ifndef::git-format-patch[`diff.noprefix`,]
> +ifdef::git-format-patch[`format.noprefix`,]
>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>  	(see linkgit:git-config[1]).
>  

Hello,

This kind of sentence assembly does not fit well with translations. Each
hunk of the sentence is processed separately and it is a difficulty for
translators as they need to understand the surrounding context of a
segment when translating it.

It is safer to just write the whole paragraph, or at least a sentence in
the ifdef/ifndef sections.

Thanks


