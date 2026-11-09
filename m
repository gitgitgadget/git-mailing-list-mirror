Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245019;
	b=Q5T0qSRRtrLvyua3Y3tyvI0qkVyq7Y0f+aNh/SkLkQ+NINQroAaz7vFXgAv2QTUrnciP
	 i1N2p4pu/4ieOlqsfEXgsVQlK+iTBoOo8MydDNmww0Sla+mtoPgbwUSEXExAUC6Inf8K7
	 mfOazuxqVeupHuwD/i/pGRIWRNv9gdUZHyNffi7KVH3xyOmc9IuxprxRb8n9b+ypWIaA5
	 /N0abMPuDTpN09swyqL2uOp/O7SbIM24mUDQ3HMSUhVrMOKtTegSgqMyA5fkrkBs6Ce3r
	 5UvRisZMYhihPVphGDNIe2bZ7NzpQXZX/ETpv/zb9305X6xRuHocPTXXS13OaT5JfWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hzwri+YsmKt/+GmdZE8xV6rGD9pcDprjVmbj1CCJxk8=;
	b=5OSCoGBhxJ7NC+HULRL66GzZTnoBvpqop3CCsWQwuy1tdayE/osExi9YlUik29o/65mC
	 4gamEoVsTTkukf0CoEgHeIUIzP4elUokD0QzpG28kOtCn18+j8LFCDfpsYKgrRSNS1TiV
	 FdXaV+PhOfrK3FfdTGXQFt4qI8Pc6CfnKLfziKpuOX6IBVoGuTBirB6mLTYswpJocQLGe
	 YWIq1yb2LMrUhfyPDU3mqP/kpHZ9E5u1P6ylJ6tR9fnPsN39U/9qxBw8fRw6TyNlcbdyA
	 VeoIMPRp/yfOJx5zBhDB/CYYFArqgH7bzAQ6Mm2rcW/9rzFDaulkg2+rJ5pEX+LlRDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5fDZeTC;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55449606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55449606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5fDZeTC
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d581da0aaso116768666b.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 09:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794245018; x=1794849818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzwri+YsmKt/+GmdZE8xV6rGD9pcDprjVmbj1CCJxk8=;
        b=z5fDZeTCrnQ+bpXl2PKUasDfZAbLOrWkWKh9U/iE/kIkh48cZmAcxsJDX2rKEet2vD
         ZxbIkDMrCKc+dAfMfdneXxyr6fSCPizi3Mw/KOfJfuw9AUFG+p1AZH2HgziQP9fOdzho
         Vb/joJ05XG1ApUlsOgP/czX1tFCQ46XCW/RlGfLVZ05iQLPGW6DC6arHs/7YgUZK7oCg
         34yTE1mByTwFgqfmo/1ZChweu9HRbImeD8bM8FtDu4VwOh1La3SxTzYWj4ULzrPnzzht
         zJQB5sH4ouf6DYcp5wVo+A7zU/UMbYcDjJufQ+sNPmdRxcp0CBeqApx9UmfzoLGdkNGZ
         mQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794245018; x=1794849818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzwri+YsmKt/+GmdZE8xV6rGD9pcDprjVmbj1CCJxk8=;
        b=RvRb9d8UZU4/eFs8xP5cBHzwQUf+vKX3Q7kWm267qNc3Ye3Ss8XOXqh1MAy7s9Tngl
         vfVc/KOvtQdBjGYnDbZ6myW4fKqstGY5SgOgDb5TmKsEjtiLglbYzU/hCrGMTSIoypLY
         xbzTV9Et5slc/aqozMuTkeZqm5yUvxBaUBEFSmN6oIeb/KLCiUOgPXeFRf1/8zvUSxuK
         x8vqF40rDTRED/0Wt2BUJr7gewI00SDi6qPSPUAxunns8fAXSmX4mfVsUjI0P07fdpeY
         sJkqY8RCZSr5x6J6LI594Gxi6+gPHw3Drq6qUrIPMJkbKtqkLCR10TeF+MU0eJRv/+lU
         ac3g==
X-Forwarded-Encrypted: i=1; AL+hErGS+GapU1g1yksjKPkTC4KYCERjTOajGWlfj70mGbUdkQhAudkwRRexyzKMTD0z3/f/c4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h++6s/0ORuoJY5v/QR8R+BPJZtF6/E/PCEoroU5j3gHYUwWdU
	W8KtcPiH/HgvgIqNIksH1Ga/VgS1ydo/ezbUPWGuaLuIFFCx+SizmDou
X-Gm-Gg: AYBFou3dX12LokZ/M6ZglUdN5H/VS3le8FdAsjzUk2MuyIF+zHLj44nI5fLrZjyBRT6
	DWtU1KtBNmU0M19lyCOsFng/n9wH5/Cy6/wwUiAdZHkdbx8ZMAJ0K5N2W8yvZUmPmWs/Uw5s+EW
	8A+8qrJraI681TDqoEpawtf7Fo0zorH9YzfGnZEHs29A6pNeNE+RfcqBhIU1RuiGxcWpKH6oaOS
	yHW/sCn6om1Or0iAMxbneWI9oJxBD5CQ52afSeF15WhD3v4uwQQFwXFYLYqUbPwbO3IFJzFk7u1
	C1/3QbNdVHgcsAIz4Qh45zOZQdpngh0qW/7gsEN+aS4rvRaoR9HfRVphwqpPkS2IGfzt2WQw+eE
	4P/DCsCSCtMhG7+qQ82WLUhvGrzx5/QlxiryZTFGSkxxNGAzQ1gwPQOb+YTWGUJUucUDiVGV1et
	RYkVEuSWXO7tqa4osjM89EGd4NPTXdLd2jxZmD2fMORgbOn9IDFIZ7RWvINcnMFE8QxbHXfz4yQ
	E9mI8+G7Fls5WPiI9p0v3jaKdQQP/tnUFaAr6Guh5qABtxtq35lRb8LNqd4PWgVUR9jTBWrvwqs
	gAdiNcG2X5RBiTR30+mUyw/UOgA112iThTKxzE8IotJujVkZKPgSlQ==
X-Received: by 2002:a17:907:d716:b0:c43:ae92:9ad with SMTP id a640c23a62f3a-c504951d359mr4308266b.17.1794245017493;
        Mon, 09 Nov 2026 09:23:37 -0800 (PST)
Received: from [192.168.0.172] ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9789a6sm199816466b.66.2026.11.09.09.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 09:23:36 -0800 (PST)
Message-ID: <258741fc-5dbe-4268-948a-9ae298ddc83d@gmail.com>
Date: Mon, 9 Nov 2026 18:23:35 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] doc: git-rebase: update incompatible options
To: gitster@pobox.com, taahol@utu.fi, git@vger.kernel.org
Cc: julia@jvns.ca, me@linux.beauty, phillip.wood@dunelm.org.uk
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261101082230.141688-1-omri.sarig13@gmail.com>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <20261101082230.141688-1-omri.sarig13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2026 09.22, Omri Sarig wrote:
> A few options in the rebase manual page link to the "INCOMPATIBLE
> OPTIONS" section, but they are no longer incompatible with any other
> option:
> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>    incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>    the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>    section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>    2021-09-07) removed the `--preserve-merges` option which was the
>    only one at odds with `--ignore-date`, `--reset-author-date` and
>    `--signoff`.
>
> Additionally, since 414d924beb (rebase: teach rebase --keep-base,
> 2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
> doesn't link to the INCOMPATIBLE OPTIONS section.
>
> Update the description of these options, to have correct references to
> the INCOMPATIBLE OPTIONS section.
>
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
>
> Thank you for the review!
>
> Changes in V2:
> - Update commit message per the review comments from Phillip (Thanks for the
>    review!).
> - Add `--onto` to INCOMPATIBLE OPTIONS.
>
> Changes in V3:
> - Downcase "Update" in commit title
>
> Changes in V4:
> - Update the commit message per review comments.
> - Rebase the patch to be compatible with the maint branch.
>
> Changes in V5:
> - Update commit message, making it clear that the `--onto` option was only
>    missing the INCOMPATIBLE OPTIONS link.
>
> Changes in V6:
> - Update the commit message per the review comments, making it clearer.
>
>   Documentation/git-rebase.adoc | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..f1f675d311 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -217,6 +217,8 @@ OPTIONS
>   As a special case, you may use "A\...B" as a shortcut for the
>   merge base of A and B if there is exactly one merge base. You can
>   leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
>   
> @@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
>   	and this option would override that behavior, allowing commits
>   	with empty messages to be rebased.  Now commits with an empty
>   	message do not cause rebasing to halt.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   -m::
>   --merge::
> @@ -487,15 +487,11 @@ applying (in terms of the author date).
>   	Instead of using the author date of the original commit, use
>   	the current time as the	author date of the rebased commit.  This
>   	option implies `--force-rebase`.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   --signoff::
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>   
>   --trailer=<trailer>::
>   	Append the given trailer to every rebased commit message, processed

Hi,

This patch has been sitting around for some time without a review.

Anyone that is interested in reviewing it?
Anything more I can do from my side to help this process?

Thanks!
Omri

