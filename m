Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34CC2F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516822; cv=none; b=V2TOXzvP1FFVP26H0oPNadjNi5K/bzX/ukFl0XcLxy76zQxDXCKg51eNMjICXYOKdi0TZtlur8HxxIy+j6kSeT3GIdNPM3uNbPhmM8VujpLq8Xd6SKn757j4jtFEwKWqSwykXrowj3FtHEC0xkJnAQrcXCx+GjwX7HaiuupcRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516822; c=relaxed/simple;
	bh=iajr0hOeB+wF9/M9NRQE3zVYzrtcAT6tTRcqGCA8SN0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=guEdD4iO55qFcZJiawjfLdvxHmU4ZwVSaqKkWj+c6Hg0AzOaoQFkf16W8Wal5wgqrhZajuRdH0s5IZwJdZxaWXyK9ndhfCjt0CAyEs1bVEeDtCBmOTZa37pWKQApNSqSX3YULZiueYNwRFLov0RXp/4tZ9OXE26Wlzf08cK9xi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj1OtBxC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj1OtBxC"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c03a466c96aso23576366b.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516818; x=1782121618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5+S1R8T+wdy2G0o3M3/EwwLZn/GRBhi2AnpvH+G6C4=;
        b=Yj1OtBxC8H5vVbN/F+KZQBBgjoiz/450tuzZCmMcdaHkpZrXwN54xiwQBLzEb7GwUg
         I9PjkL9Y810NhixprEWwm1VhVaWndySROqjZ+qdGTPKAfUYGSlhmRSGF1QdIKIhIjxY5
         t0tljFaAhntOeeeHo8EkvWvRBz9iYL+tryPQyUboiYO+n6jlE0AFFtpxxYLsbAw/5QFA
         FFb6Yw6WsuwGEI4wgArjep07sD5JDvIICjMbGT9Xjq35TjPBF9JuQXFDwOJR+JNxNmVP
         IJeXbiAtI+63VFvgrHzOsXiEURslihsnA5P2ZmARDsBpQ+CysNHMFOgXGMFo0jHivHRl
         9cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516818; x=1782121618;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5+S1R8T+wdy2G0o3M3/EwwLZn/GRBhi2AnpvH+G6C4=;
        b=WsUFtGc/coU1hhnqhfbL28hD7TjKf1JhdT3BfwJfwSPJjcEJ5mnkRs6Sb+FcHV8c7F
         cH4En2X9zzOQKYZi1TDbEh4SjZSDwtybKpzrNx6iy/p0ymtqjDBgRz6BwkakcvS0MbPy
         vpuwyeYwrhp6n2obWNRHJigKgHD/pS9X1hIYXILGnmnh0rpP+JeB443MVbHUOBOrZ5ZC
         /ZdpPVoF0uqwaAQThFvpkdUcSwMejZzIlcnwZ8Byzlbj2lBoiWmI2ViBN0+Tvr7N24ie
         CVXTU1VA7arUToka+VKQLoaLxeMA06TyRz7E/FXdcrPUUgvpACpA0dk7jLSkIH/rS6zB
         BWug==
X-Forwarded-Encrypted: i=1; AFNElJ9/SU/AuMnbv4HUW5JuU+HGdVIGrNXRdQTbf54RnvJiz0v7YhZnHvoJedw210VHChOMZ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6ZkxBKP8Katht2S1UTsprIRHWsiQO1QRfMnEc8wkhvRCpCAs
	hTFupql/f8hU5xZ0MY5lHh2ssf6wGt8Okg77f1jJK9520MO9JBMlj5ew
X-Gm-Gg: Acq92OGKFEHsg69JdokiPv+Wh/W9Ci9mAzPONWEOg4XKd0yx8V+MmOgsE99Qdb1xBpj
	RwnDY7xmfq5iRcrNmcIAPap0M30DsKLzYcCVs+/7j9Vx7ixf8YNzo+Qh1dYhaRsTCH1LiENlJh0
	bUVFqVIsSIQ0OKpkqAbMkpBadXbXgv+Ea62/59daY1YfrcaC9dTWlmytoipOOlYlivBqnjkFPjZ
	Qq0EyEyY7puejyCwxuE8rN+z0Z9Jqr8BMIClDjobNuKT9usuDfhbAKADGS9X4EPYiuMr21gvfI1
	NmHcbheovkwVqgLYRdTQgGpsELQWrWrJzCHYbHcXn4Sa1bhBT8lFiLa3/MUCKeD/2ZFdv32/8JA
	wpE46UQV9YmZ+FFD6VlRxQuuqEWBuMzmFy1VOC0PqehiERQ1voPjbWc+FOGbBsahclADe6aklbR
	Byaht4PjIBBIy+gMe/mn5sTsMcpHoO3K6qtpfLs8bZoUUraqqfpjU3JEBNA+JFsMBUhnVtFsueQ
	PDN5tFvJgs=
X-Received: by 2002:a17:907:762f:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bfe2b3ea941mr454527666b.49.1781516818203;
        Mon, 15 Jun 2026 02:46:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:786c:b99d:5866:4e92? ([2a0a:ef40:69a:b801:786c:b99d:5866:4e92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8341840sm443541766b.43.2026.06.15.02.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:46:56 -0700 (PDT)
Message-ID: <3b04055c-846d-4aaa-99bb-5da932172f75@gmail.com>
Date: Mon, 15 Jun 2026 10:47:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 3/6] branch: prepare delete_branches for a bulk caller
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <259113e304c4085c2bd90cce3a40c965744d5a00.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <259113e304c4085c2bd90cce3a40c965744d5a00.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
>
> @@ -240,7 +245,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
>   	int i;
>   	int ret = 0;
>   	int remote_branch = 0;
> -	int force, quiet;
> +	int force, quiet, dry_run, no_head_fallback;

As with the previous patch it would be safer to initialize the new 
variables where they are declared.

>   	for_each_string_list_item(item, &refs_to_delete) {
>   		char *describe_ref = item->util;
>   		char *name = item->string;
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
> +		if (dry_run) {
> +			if (!quiet)
> +				printf(remote_branch
> +					? _("Would delete remote-tracking branch %s (was %s).\n")
> +					: _("Would delete branch %s (was %s).\n"),

I wondered what the "was %s" was about but it prints the symref target 
or oid of the ref.

Thanks

Phillip

> +					name + branch_name_pos, describe_ref);
> +		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
>   			char *refname = name + branch_name_pos;
>   			if (!quiet)
>   				printf(remote_branch

