Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215B36B910
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615804; cv=none; b=AAxA2tIR8gf8JJTpZ9sKpUezzJWcmDFsUjswpRZxK2bCetSFUUJhTWAvvkIk+/U+o4hyz+PNKVFqtlSEPdzm2aPj8fU5By7p11W5c6xn0Wta4uyz0TeQ7oLGsz3Y+ravdhJYQJpBVOKmZT1dDq83YRijDZo8cZgIIYgBNLV+PeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615804; c=relaxed/simple;
	bh=8SLwY5/ltDWxsAVe3QcxfjAx12+WSPx5J1hzN+uujHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tg5ZhuTN0j44FNUkLQpmAHE5z1wG04CmEkVT3ZE1tHt2R+Y10U+zOW3hRdyeXKyy6FGTT384ReIVDLO8yDV2h9/scSjfqg+K85PAdr3Wt5v5Yd/o8w92d5PFfewnCq6OYgUVgUVXgx3LtLB9mjJJ7tBWG+TV2PAmRINjfza3hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8wHUNPG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8wHUNPG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so24530585e9.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615801; x=1791220601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sgz0NiCCQdOFM5Vxjw1K0BrJuSWZBKKztvqfLGdC/O4=;
        b=R8wHUNPGy1UeOM+PUNYdRRd2NSPZhyPu/ycXUQVMR3VvJ+OqPV7xk7y8zI38ij2rSZ
         LC7LidtIOXQTX2M3czDhaKKvX0e2aVbWQAxHnrAUAF5c0zJKi1LXtSx0wz4Yp5zv/xnL
         5rvKcdtcpAYGqSA1FZ7XFufggWUdcuqq8R4+2YC3sttTAUqxKqackdACfaVD/90jvQiX
         cf8aHR7krPvlN4ffJI3uJI2oKRvQbYVqi8kg89pDDYnBCXxv+cA8mjSqrnl2IaBL7Nz1
         d95P4OfXHP4MYyxUqDSotL1Lo3QwL/UKfeBgA5aRwHaaadc5npBsrcoHa3vwZD6niaqZ
         8EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615801; x=1791220601;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sgz0NiCCQdOFM5Vxjw1K0BrJuSWZBKKztvqfLGdC/O4=;
        b=oaQH9pB9xB9T45xWm4VdQHpAo0iXfoqjng3DubQhFLSqMRtopDqEtfrcQMJhQ+1Qcr
         wGUJrIs9EHBALl5oxt6Pei229Lwy/X3RlrTjwh3IODLEYWNqDUFdpfC4BO/pvakXhNAk
         UtxStmo4KXfWs5MlhTsa09yi++obvjPGOk30jZDjoLy2V+qE64DfSuWkHjH2qRUR/vg3
         YpjsabyVHizN24UmNUNXAXqm401Xd2TeG7AIB+JfwYVPf4780l6fEJsSdcs/OYpaiVmf
         92aUNvwCM4ZbFRfnQxD7tF74wS1yf4UunVI/RUmIocfWT+H92bsEe61Ji7rMZNl8SjRR
         WmIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXa0lAByAsz40Bq6nUTOcoSNHMco1y5s9fgC1dIYvLm3nkIjiWsNXCn2eybxPofL8Z7BQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lpLX4fbw+Vh8JqfOgbC0T2+a6g/WKBRMLFczlWzbN/5RZDzSzI
	fzIuDRcRRGuvhY0CpZZ8oVUMp9iu1H7ZxShdlFEW7tXJ/xTOvH/L+ggi
X-Gm-Gg: AYBFou03zhhDGEGD3PtKUa1+0AiT56nZEIO0Hrz7V18HftaVVFbtMcVxld8gIFBsbU2
	5KoFgNg0zUEl6HNB7rKRWL9mN7fVn9Voe87iddxNYUkLZ7pyCiRvaCRRDAVfePzYJ842601MW80
	6acujEm9cIlgqEvMH1Mnr4mE7nyJlmwe5v2C9SFnBLrUSkxF4h5E05Vxcd+uFap6oGcYcaoonkv
	O1EnsJD1kWb/Ijj2+5ZS3XLbBHjCAdFf/ScI1vbtckVeCtYLb0+FCBy6J77nMYWwg7VaClq7sK1
	fAPe86UQWVfqX8mn295B6iwlqaeGVl/JQ2M6PLWhceNlF5QTGJMTNdk9EFqzHDBJgyryTNFn3v+
	sJeioQgj0aanMzOUyTn38l+7aeKXiCiiUK3rwx3bhC6BFirogks8DTFORuDHvOi99y2jSFtAyXA
	w9uUH+azifQeny9120CDo4M2uHkdyzgr5Z/u6S35Mo24IlmRJrIh2stAHgbIBDTdDeLj8=
X-Received: by 2002:a05:600c:198a:b0:49f:fbf1:3f7e with SMTP id 5b1f17b1804b1-49ffbf13ffbmr112745065e9.9.1790615800896;
        Mon, 28 Sep 2026 10:16:40 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.41.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm28582732f8f.0.2026.09.28.10.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:16:40 -0700 (PDT)
Message-ID: <a745126c-7e40-47e9-afa4-7ebea0640bf6@gmail.com>
Date: Mon, 28 Sep 2026 18:16:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] doc: clarify --follow's single-file limitation
To: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Junio C Hamano <gitster@pobox.com>, Miklos Vajna <vmiklos@collabora.com>
References: <20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
 <20260926-document-log-no-follow-v5-1-d04efeca7551@gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260926-document-log-no-follow-v5-1-d04efeca7551@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2026 12:56, Tamir Duberstein wrote:
> Saying that --follow works only for a single file leaves open whether
> other inputs are rejected or ignored. In particular, log.follow enables
> following for a directory argument, although that use is unsupported.
>
> Distinguish errors for an explicit --follow with no paths or multiple
> paths from the configured default, which has no effect in those cases.
> State that results for directory arguments and accepted wildcard
> patterns are unspecified, and document --no-follow to disable the mode.
nit: "document --no-follow disabling the mode"?
>
> Assisted-by: LLM
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

LGTM FWIW (looking at this part of the code right now considering 
possible improvements). Handing of --follow has a few more other 
limitations that can be documented, but fixing them is probably more 
interesting. Disclaimer: I just joined and did not follow this thread 
from the beginning.

Acked-by: Marat Khalili <qm2k21@gmail.com>

// snip

> ---
>   Documentation/config/log.adoc | 10 +++++++---
>   Documentation/git-log.adoc    | 10 ++++++++--
>   2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
> index f7dfce69b5..4efdd4f61b 100644
> --- a/Documentation/config/log.adoc
> +++ b/Documentation/config/log.adoc
> @@ -51,9 +51,13 @@ This is the same as the `--decorate` option of the `git log`.
>   	details. Defaults to `separate`.
>   
>   `log.follow`::
> -	If `true`, `git log` will act as if the `--follow` option was used when
> -	a single <path> is given.  This has the same limitations as `--follow`,
> -	i.e. it cannot be used to follow multiple files.
> +	If `true`, `git log` enables `--follow` when a single <path> is
> +	given. With no paths, multiple paths, or pathspec magic unsupported
> +	by `--follow`, this setting has no effect.
> ++
> +A single directory argument or an accepted wildcard pattern still
> +enables `--follow`, with unspecified results. Use `--no-follow` to
> +override this setting.
>   
>   `log.graphColors`::
>   	A list of colors, separated by commas, that can be used to draw
> diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
> index fb3ac11283..a40b3d1c05 100644
> --- a/Documentation/git-log.adoc
> +++ b/Documentation/git-log.adoc
> @@ -28,8 +28,14 @@ OPTIONS
>   -------
>   
>   `--follow`::
> -	Continue listing the history of a file beyond renames
> -	(works only for a single file).
> +`--no-follow`::
> +	Continue listing the history of a single file beyond renames.
> +	An explicit `--follow` requires exactly one path argument; Git
> +	reports an error if none or more than one is given.
> ++
> +A directory argument is accepted and enables `--follow`, but results
> +for directories and accepted wildcard patterns are unspecified.
> +Use `--no-follow` for directory history or wildcard matching.
>   
>   `--no-decorate`::
>   `--decorate[=(short|full|auto|no)]`::
>
> ---
> base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
> change-id: 20260507-document-log-no-follow-72c33dc15017
