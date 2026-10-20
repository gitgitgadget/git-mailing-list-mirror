Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489159;
	b=smyg8sAi5yN51EF+S3WWXccKDMWu/grCOb881SsNuQKh3XHAq4dxU+XeDIAZWaA7oq6F
	 mTKjSjukolHkc15umFbkTnLPpfgmgUiyt7scF4NaXO3TxKO49/4Wj8Bnj+9GQG831iQHV
	 GS+coW65tyBiIAnA9NEcYtAiWxdUZlI7Z2oLn0eW3QWbNmT8RKqiBLaj3TFnATZvZVz03
	 DrRBRZJNx5zp72LAMq02E/+ZWcU1pSeu3uG/SnDHEwnsaLtSqhg3++AT3brmCbi1Dpmcu
	 umVeLbJnn9oJmYZWFWRSHvViy+g2T0EArZbyJ7Bu5QE34ghEigjZVuXlKHLTn/g3++A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ttQjHMzW2k4hWkEElcaWI/Rv/77RzwhZ1xYDyKnFbSk=;
	b=bT6iaFr+wp1K8qu+yqMkD3jKzpiCMD14d0jw/PLv2gogDPRRiHEm+6b4pe2hX1TjkCvd
	 AvgNivB2vdRQ5am45RtFbk1G97sLUPjSmn/BhfaAA6HXZ+LTByNZDY6jRBxRdTKlwAIgJ
	 3bJXlR4HQCiFgKAeJvmd0uR4GDCIxpyD17gasQ76pDt1u8sUw9uJmrbWTLcTTqhobu2O9
	 gNhmt4YMBLOCCkAGrYLzae4nB94x7OywlKFNyKH5EMIN7yq4zifP3C1IfuiJOb4U05JC9
	 JY9w1wOll632cSo9GmFe8kFpaw6SfmM3cX+SNhrhBfPmEAYSdoP174UPWaurGBt6KEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DSVHAYUe;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607F60A260A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E607F60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DSVHAYUe
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1df146015so17623605e9.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792489157; x=1793093957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ttQjHMzW2k4hWkEElcaWI/Rv/77RzwhZ1xYDyKnFbSk=;
        b=DSVHAYUeWh2nzxKrM+faK92zPtjjz3pDB/avLY/Dx3F2qKzgJzOa4EZEPVDwaNe79N
         93eE72CPET2dKfqxJf6gG4GXEXHu1rvSjYT++rqMyJxkO2zzCr9bX5A/FVtarKngVLZt
         3cry+rRZQyAyNCDikCD5gnfvuEBh9ANZFEIz6yl57/cp0NwmeGTI/kaOo1mdipArRY9h
         ug2/h8zqvogSA8GwjADV7GhnAeNx/URBvi0PyD4n3SSWvLwFWjYmU/1plmLpi5lAcTO/
         SFwP7hWsguGu/ZBDijAMGcVvXQ67SFRExBC4enYmU0OWOBIx68gL94MdO5KaScWG5qOW
         cZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489157; x=1793093957;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttQjHMzW2k4hWkEElcaWI/Rv/77RzwhZ1xYDyKnFbSk=;
        b=fe/HWhCVwDNL34hzSEDQeOFdTLGgyoD3S+Ox6GeonumGQbwrI1F7cx//8CEzTp+x1k
         pLPWnGh+5UDw3ZpbgomvSXB3lGD0+3BzN2418B5prOhMfePgqNAQ0il6KVvFbp5eJiqL
         YWp5wWuIuNddBIfSitd/GjXG31a6Neg0PkpNzNzYAF9tPBAB/vDP3rHE533ntE56yLGV
         5VwtTTTwGkwo2C9E2tuAq1L7q8bh5phzfV7No9Mdy04xACOfG46tMXiOAGlEvvi1W1xV
         9me4rwApIpu2VTvTUJADPGQzJyGWhI4V81SVMi71Fir6DquJEdy6Gn449LWYNAu8K5Pv
         qVWg==
X-Forwarded-Encrypted: i=1; AKwUvBycJxngZKDXOykiAEgx2o4XyJvvU1wNIY19YNHs8eEnRCiP4kNWQqmXQw5ysyYKvNXzdDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO0MPgfWTsftgvIYafK8y/kfUot6GnySiUfAxpEx4AZ5Jnf6v9
	aNbN/VMbvTnAY29IZZPlCN5IYOm4n0GAd9OviY6UIddrS9N0N52YzeQN1mwJqQ==
X-Gm-Gg: AYBFou28ouFQmPB1+wkXVPvCYtA9ZPmAn35AQNsVkxe8Zj8CZ/pkbdYQadQrArMAfNJ
	g8txgCwv+xTandpujvhgxGuhzcRyq2sYQHJZIr010C2qu3RhmgzanLkTtlTkg9wcgVtry5c9GPP
	d+3eq+CM+DagBpX+dg4xP5bVEQ34zOHUdg5Tb/3yM8EkAhEIDdqQt42bQl271iNzfTteRKQ5dks
	sqqAiHGITt8sZYD68S9SUxTayr75k5JF7+iL4CSyZ3hwtxLXYx/jqFzzgjICYqfhxaori5kcbRy
	TPf8hB2zCJWTT1gGRoDcacs6kueA4CSFbgaCrN7kXEfq7ZuTkOMRq/YQCmMxRLsoxiDCKE9cQjw
	7leuYEsMxyxzKcvuIfSzkC0fweTLxpDLyauV+x2rizN2LIzzz+gVY26Mnv9htBC9EX0bZm9wl/m
	rLjt7rDwRFxUmeFT9aiyByZDtrfrLZjQ4KrMMOz8AK3/o2VUUpKqdhPr4CkzpLCMBhVBLhY/MBN
	rWlvzjC3ce/aZR/AU7PNorkajBaphBkT3OYvsea5b1qNK0MIF6F
X-Received: by 2002:a05:600c:4e8a:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a1d7630cf8mr229143285e9.33.1792489157068;
        Tue, 20 Oct 2026 02:39:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d569d4sm59572665e9.10.2026.10.20.02.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:39:16 -0700 (PDT)
Message-ID: <2a7654ba-bed4-40b6-86ec-cf4014648d31@gmail.com>
Date: Tue, 20 Oct 2026 10:39:13 +0100
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] doc: git-rebase: Update incompatible options
To: Omri Sarig <omri.sarig13@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>,
 Li Chen <me@linux.beauty>
References: <20261019143546.207295-1-omri.sarig13@gmail.com>
Content-Language: en-US
In-Reply-To: <20261019143546.207295-1-omri.sarig13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Omri

Thanks for re-rolling - I don't have anything to add to Junios comments 
on this version

Thanks

Phillip

On 19/10/2026 15:35, Omri Sarig wrote:
> Several options in the rebase man page link to the "INCOMPATIBLE
> OPTIONS" section when the option is no-longer incompatible with any
> other option.
> 
> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>    incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>    the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>    section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>    2021-09-07) removed the `--preserve-merges` option from rebase, which
>    removes all incompatbiilty references to `--ignore-date,
>    --reset-author-date` and `--signoff`.
> 
> Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
> though it is incompatible with `--keep-base`.
> 
> Update the description of these option, to have correct references to
> the INCOMPATIBLE OPTIONS section.
> 
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
> 
> Changes in V2:
> - Update commit message per the review comments from Phillip (Thanks for the
>    review!).
> - Add `--onto` to INCOMPATIEBLE OPTIONS.
> 
> I was not sure if both adding INCOMPATIBLE OPTIONS (--onto) and removing them
> (the other flags) belong in the same commit, or in 2 separate commits. These
> changes felt small enough to me to not require a second commit, but please let
> me know if it's preferred. I'll happily send a new patch where these changes
> are split across different commits.
> 
>   Documentation/git-rebase.adoc | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 6536ebdc90..6363b1a096 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -218,6 +218,8 @@ OPTIONS
>   As a special case, you may use "A\...B" as a shortcut for the
>   merge base of A and B if there is exactly one merge base. You can
>   leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   See <<TRANSPLANTING,TRANSPLANTING A TOPIC BRANCH WITH --ONTO>>
>   above for examples.
> @@ -334,8 +336,6 @@ See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   	and this option would override that behavior, allowing commits
>   	with empty messages to be rebased.  Now commits with an empty
>   	message do not cause rebasing to halt.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   -m::
>   --merge::
> @@ -489,15 +489,11 @@ applying (in terms of the author date).
>   	Instead of using the author date of the original commit, use
>   	the current time as the	author date of the rebased commit.  This
>   	option implies `--force-rebase`.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   --signoff::
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   --trailer=<trailer>::
>   	Append the given trailer to every rebased commit message, processed
> 
> Range-diff against v1:
> 1:  27c94f5ff4 = 1:  27c94f5ff4 doc: git-rebase: Update incompatible options

