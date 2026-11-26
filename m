Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699703;
	b=UJeTPwlZzvk4AAuYf4X9Fqvvmr4VUub+ItNWzsFSRr7k4Tbqx2aGMSlrZoZCuRlKvHfh
	 nD3i8z34AfgxAeO62GeKiTcmASM/kWs4Tcr+DfZHbROgk0gQriOoN8HhIB+J/5/zTvd99
	 jo3R3ddHi/76mN9IL0m07mXyHTMH4ocCnPyPRRxWPRinOLH1Ey6shNMol7uz9UDc+2Iwi
	 OqJac5nw6yN7mEUOzTpbEoHX9uZCSHnnrQ/Xeb12NDbnAIl8LPcnBKLtg1PzX7xljIYxY
	 oYI/Yqak6h3fyq0oQLygcnCWti3xNLnOhBW+q2+t7Ol9jWLhQm71YN8uNz+Ol6scsLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sOhvgngDKvXDQF81FS/iPqrImn56gtd2l/tMvtccvTY=;
	b=FHb1zxhtYSyZiJBxGvDooynZu3W0Ci7Ln1itwSVbvGif7h+Vvvwfo8fBumkun8TeSIWs
	 1t2DYpiKp7x+ZOSFd/NvN9RrsrgyANjKQT/wWON1KfnvRNXEA4RTszpXxLs/euPG+PDR2
	 KzrdFjUKbYhiZv1Bntrh4IrZdhiUpH5Z4TA+o5r7hQ97MKfl3zkk8Bj3s1OGZkj1mExyL
	 Zb7HXZr7vv1VVMm4JGIllvkB5sMVNwZH4NUNGxnth5XDwgDGov7uHIrPXkuriwvSD2faF
	 NxQ/xuH2XuWqwpRU+FGrbPIP7BHHNofXOmS6QtSrnN7HIICFX+FmEde45f0jbBLh4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTEwjSEw;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA28606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA28606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTEwjSEw
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso3694314c88.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699702; x=1796304502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOhvgngDKvXDQF81FS/iPqrImn56gtd2l/tMvtccvTY=;
        b=NTEwjSEwjx2bAmapoFG6d0205lotHO6a89ZY/KI/h8E7o9bPy79d3eDAhBzB5BZVle
         024+7cYCYrSkaftaAAPtLUHttKqIrE3Y1ux3B8gJoIS6/b9pm6UC3P1YdZUFfKd3Hylp
         sHRJsvDStmqTLFowJlWGAN2N2iesXwwxBcAflvRox+jY3cl2cYgw5RJOa8SaoqQ6S1yJ
         TJ9cm8gz/pkdBS7KFs7JMuL+VwVHUpkmJhwECTAoC5ZkTpsgHZhVY8FaoHOsoZ2FPfY3
         r6PUsLc6xqv0ui3CHVJKCgiJN03AYvxpR2o/F0Tp9UUpuLRDnYn6PSbo2PKySxTcvhf7
         e2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699702; x=1796304502;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOhvgngDKvXDQF81FS/iPqrImn56gtd2l/tMvtccvTY=;
        b=Fmg5y+rgVRWeEtac5yR1Aq416g2jM3wMG/q5gjaRfR3N6ucBFfLlzil40+HqrdjBQR
         N76Y95j4umFwe/mtSd8m1sR0x9eEpTcAbVZKy52b/eVzwfOA4SpAYNATvx2k42wgc+tL
         vd5hLiBiASRTpNHOuVnEjTwP0neoqEKRyWm2BMK8Tw/Bd1pWSuWVud1pbhvHrDLBz96v
         TIGtgbnvFgqZysWh0yhmXftNY3jTt1QqhLO2ySCMDMczASaUxECy2Cc/ECYOFpwFxrVI
         Wz0HViactza62Azk0Dk+ESJ5WFna9I2xc7T30Y4+awUI8l84SVMpbeG5pCVyIqqUVDvu
         9IRg==
X-Gm-Message-State: APuU4Z+lbooSfYaCAMsTfYfMh8xgXGXOlMX/nQ8JpTx8bAXordSZHeKp
	AzNxFE50o7nZszpYyRZW/fyxBiHVX1WFXETjlgz3kwdGf6s4Zop+L/Yf
X-Gm-Gg: AZFdTZeK5IYXARa1V4ldLFvPSFvVT28ZnAM9/3Cjjv1srBeC9yTCtsUUQiE7ixD1uWQ
	xlh2OcJHAt3eqX7IjLiwqkTPFnLw1f3T0PLj1mdoXVmpQ5tvCb8QHE7omPFz6tycbRfV4OeEYOA
	SN8gO3y943QwS9ShhGDaSdtFwX/iSrNuzfnxun8W9PO8iWUFHiofX2HMkGHuLcQtnToVuoyMLCo
	4fnFcBnSstIq0Eh40EP2O1gsdRjcNuWrl6I9HrVmEFs9hC8MseDoVEh0DPVdupsY7KDPB0cuC8P
	l4lfx+bPMmKGmQDvL2GzzZ3DrUhi6gi/czRt5acAap+V8falvzNBORzNvdaxo+b4Q4bkQumxGPq
	30b73CUHSml4v5E91dAqnesyL7q7yX8gLwFtsEid5jk5grM9N/VHj03f46rY6kBaHodEy18FnIM
	sWinY5+3WXTYKhGnFTtVweQoYDIaQ5zrJy5HLzZRHg87llGkbDmo7qxMq7kBe34mvwtU844kbn9
	toCJF+gcX6jHRi70zWjHU+lkA83e5Ok21zZtsu55hGdI2Cmb9GE7DxWK2c6fID9Y4WH9GL5gIdj
	IOd2mEPbyxhBJjEX4Wqr4KwikkzL/0Pc2XUScdZQbknLoMVazm/S5GqKLv3v1QwaJQ==
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id a92af1059eb24-1b5524b591cmr19039395c88.13.1795699701864;
        Thu, 26 Nov 2026 05:28:21 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm58967873c88.5.2026.11.26.05.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:28:21 -0800 (PST)
Message-ID: <8420f6d5-ae59-4bdc-b795-7187fc29784c@gmail.com>
Date: Thu, 26 Nov 2026 18:58:17 +0530
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
Subject: Re: [PATCH v2 01/13] loose: allow looking up in object map with
 source
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-2-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261023072559.3204273-2-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:55, Christian Couder wrote:
> 
> diff --git a/loose.c b/loose.c
> index d6a2bb5ba3..fe8f540979 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -225,27 +225,44 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
>   	return 0;
>   }
>   
> +int source_loose_object_map_oid(struct odb_source_loose *loose,
> +				const struct object_id *src,
> +				const struct git_hash_algo *to,
> +				struct object_id *dest)
> +{
> +	kh_oid_map_t *map;
> +	khiter_t pos;
> +	struct loose_object_map *loose_map = loose->map;
> +	struct repository *repo = loose->base.odb->repo;
> +

The most significant difference I noticed in this code move is the way 
in which the repo is derived. It seems to match how 'repo' is accessed 
given a 'struct odb_source_loose' in general. So, it is fine.

>   int repo_loose_object_map_oid(struct repository *repo,
>   			      const struct object_id *src,
>   			      const struct git_hash_algo *to,
>   			      struct object_id *dest)
>   {
>   	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
> -	kh_oid_map_t *map;
> -	khiter_t pos;
>   
>   	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> -		struct loose_object_map *loose_map = dir->loose->map;
> -		if (!loose_map)
> +		int ret;
> +
> +		if (!dir->loose)
>   			continue;

I'm not sure why we all of a sudden have this additional check ensuring 
dir->loose is non-NULL. I think we could as well loose it. Or are there 
any cases expected where this may be NULL owing to some future patches 
in this series? If so, it may  be worth a word in the commit message.

-- 
Sivaraam

