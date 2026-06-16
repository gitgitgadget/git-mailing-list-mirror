Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF33A7F4B
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650309; cv=none; b=KrSao9rmQM99f3LFPw0H7V3nXmSEhIqCoE9hsM6DB+85TxcDelJ9QDgzPYON4SyTOPTz/Fg3343XNZLohauknQnObpuXklIPDx/7op79tK3hEerr75M1Mvsuo8SYd0aZpfrYHI19WMnWeejfsT3961AXTgYXPPfk30NkGrF/H+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650309; c=relaxed/simple;
	bh=OU6E3j+d504LCrhE4njbwUwDpPHTL4sQ0ZeC7cW8Ouo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYmoyWuwz0YutqJ2QXyDVK/g5SW3BfSnxyQ90aelY62q31rDJE+cr4fqb4STsaBwFFzuB7ipxDXOLaaopaJ8hnxjzdkKHTyhvhRH+LE6qPtZr8zF9ndeCefbPwTOIXXtXgnNPgC3m0nhQmXJop4Npl4+qF9shmrrupwj5O1s99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpcg7TxP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpcg7TxP"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6dcc22cbcso4338807a34.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781650307; x=1782255107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IssmbunB5mA7g9PHb325ITbmoW4h9E8U8XDV8fNW4BE=;
        b=Hpcg7TxPXf1U1CrgEameScXkbOtTThEsi4Ok6t8Vs8wXLrZFGWNezq5v+Ww8wR5uQS
         Nr5UJ9cgHV0p02x2qjIMTpdYFBEGDKMjYWGgjT5y8iTSS83a080bTC0w1C7W3wFUP9pw
         9vyuh1C/rJ1PPlF52dTMdUHP7QsZTWCtEcB5KfOm9viSzIr3m4LQN8guQx/M/XGanMma
         bH7T5z0a7rXjIgAIKN9UCcemWN28p4TCV1XxjXiqM1zAgRnx1ClG/a1ZVxLSVGosuj1T
         WgKZzljAoviZURiLjZk2dy6kZ6p2SLa5DS/03xhOFspgp4R3NH2dD3V16yczcqcAFYZ0
         lEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781650307; x=1782255107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IssmbunB5mA7g9PHb325ITbmoW4h9E8U8XDV8fNW4BE=;
        b=gj8qcJwvV+h+/u12MM3om0WTwKIo9H085LNCgh120eEVa2LFsyX5KsJXWlXLgXOcEj
         Ctoy47y+MM/1gzv5z9GKgkO8LP2z98G2EZgPj4nI/TvWsTEn8WtJ0h4l9XKKMNFHExPh
         Am+rl9b+0+XsUIY7nlCUumtBb2hV8aZvqi4q9wmyTeyCxvnBNkMV2L9SDiNBIe5H9k5p
         r2AobojFqADvT7AXxwE2oNMpOfyRlvZIbML6MlRKXLkPykUTYIiU8DOlVmBXNHf59Nri
         A0fU71901D/xglvuEYD3HuksLexzxvJGBpY/v8QSXZ/QD56fwR34yU9qQrn5yR9jW23h
         LFrw==
X-Gm-Message-State: AOJu0YyRd2rA6S5zZDN0NLURFMJpjnkT7dJ4+EcYoBq3ifWwHpn5JGSx
	E3dQ5na6H2f46JYXQ2pCO13psF9GDCH11hkX4T8V/ydyqZr4r1lMKzN75EAl8Q==
X-Gm-Gg: Acq92OHT+n6t976NCFaa45sdbl17LES9A2sXiLyEqaLjHV+z9UB1prk9smLnIVRxu8j
	bzcr8CXYVGlze8HahZt1N71o2ForHydp+kDCCpMcKtZnaXGLp35B67udVCrn7iNQ1LMZ872/nfs
	szjh8dIt6/YDURQ6BHF0P0GQifGgUM1nbHxuYvEp0sun/9I+b1ZGLxQFuHLNbmapnTDhhztYl80
	+w6Fn+2B73RendxZOwmERcHRFVvMjuKrZEDb0mNGziPJ5ekYkDLvEWG0hSNPvC2IbngJ3O1oRuF
	HQ33RYdyDtO8DtkxxfktaTpcM2E1H/bquek+LLNbbmS+kuDl5ovOTDP0U7w/yT4FjyEA40bM0fR
	NhBit2yD759A8gipqZ96mbEHVkVI3ZRRvK1a20BZaWBepsANBUYixSRuXxuyxnAz96+SZbXiVWR
	aql2Mi50AWIVIpErvUhg9K7pvoDjw=
X-Received: by 2002:a05:6808:2205:b0:464:3d5d:d9d4 with SMTP id 5614622812f47-48942a24d6amr1219552b6e.39.1781650307141;
        Tue, 16 Jun 2026 15:51:47 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm5225954b6e.1.2026.06.16.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:51:46 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:51:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 17/17] odb/source-packed: drop pointer to "files"
 parent source
Message-ID: <ajHRkrsvNtcBMFx2@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-17-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-17-839089132c8b@pks.im>

On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> Over the last commits we have turned the packfile store into a proper
> object database source that can be used as a standalone backend. As
> such, it is no longer necessary to have it coupled to the "files" parent
> source.
> 
> Remove the pointer to the owning "files" source so that the "packed"
> source can be used as a standalone entity.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -626,7 +625,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
>  }
>  
> -static void prepare_packed_git_one(struct odb_source *source)
> +static void prepare_packed_git_one(struct odb_source_packed *source)

At first I was a bit confused to see this change here, but IIUC
previously this function was passed the "base" source of the "files"
ODB. Now that we have a proper "packed" source we can use that directly
instead.

[snip]
> -struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
> +struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
> +						const char *path,
> +						bool local)

Since we no longer depend on the parent source the function signature is
updated accordingly. This also matches the "loose" ODB source.

[snip]
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index 9d4796261a..88994098c1 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -10,7 +10,6 @@
>   */
>  struct odb_source_packed {
>  	struct odb_source base;
> -	struct odb_source_files *files;

Nice. :)

-Justin
