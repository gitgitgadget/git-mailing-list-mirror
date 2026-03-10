Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F212868B5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153251; cv=none; b=BXmUmv4WdKrsAYbBFih3AKtDNTOe3PCK7++/Yl4UqwvcPxpN2gscsOBH+/pFEWMJh+b1uy29arQiLe8DpKYmrzvqz9JjNpAbs5agIrLwPsoyt5hzC7g0BqCLoYinDhN2qqrSVi9YO2VG5z4djwqVKGJ/VWvpPZMLamCy8FFUg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153251; c=relaxed/simple;
	bh=xtnYzkv2tfCtcH7/frE2SFxxS+CeYy5FSsk1Uth9AHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHqxz9JoFYyiHjWlNUIorWqQlD2XduTFdzXZzPuBmKiYgGhlCU/e+lWaQ6ZWlLbMO+BQe0C1B4YRKacfy1xQ+knmNTy8jjstv4wG66GoiNAmZHf6vnV8lj98bFmc/0dXz+VQPD/0IwaVQ50TVmD6EVc0ubk8RyQgdj6ShV/XnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SueMSEzK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SueMSEzK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9431300833so620937466b.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153248; x=1773758048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GjLLvSCU/j/B1uoExeevWM/b/xw1lH7JIWlKFvhAZKc=;
        b=SueMSEzKO1zDcP3JuiG2sTIPmXwrK/6pcBKa8r1HbS91Iz+Rdi4QxTFkb5K8kXD49O
         s6cw0ssqOPenx7sVZulTMsZMrkfS2xowrON0xaXrOAusjghZbueb860Im4SNUCTb4dmz
         KPu0RxQzpdbO1ynRZpsX7rUBHtEr06FlpVkUVZnDrLZa3xU9BoqWel9mXIQd15Q4wIpd
         fu6vCgKZfoE95G0xZkvh0EOiwf/b2botunDh8F7rS9Diw2gb10ESZ95pxg2zD4TcPwiQ
         K2j+gOcbFY0DecwS8PH/KubyBHkfqb0eHt9z9I9cfTx8w6zqbI4ezMAO0rKbK8fuQ/LV
         WmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153248; x=1773758048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjLLvSCU/j/B1uoExeevWM/b/xw1lH7JIWlKFvhAZKc=;
        b=d1BtvL6LERdf5Ovt3X+5JRVwHiLD1dqf+EABqLrd72TOOEHfPm8MpjOeXc+j9o45xL
         imjBB1GZFJ+Lomj+TFoGhYQq2GQgaotHIsFn2VlhGon8PMtenU8ZfLnlGKNfRGoo75x+
         he4nvg1t4sdI7ZOv+pOMYmBnaOC3t0JFWiM4RmxIDAUZz8+rcQMgduUUim/4Fb2bOMEn
         1XNGA7g70zOj3Zx7VYau6xMDaXj5Vt7M7W1846hMhNTvbMCS2YOMMjFQnYnFiESCNEtJ
         Gsww94Gz1exDAvqL9R0tGmPQoNIWVmEHRCMcbHfDfXdKvbN2TgMzz5qis7+fcDvQ7dI8
         SXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVFwd1V98NJEiNDCjO+pHGXbIvTJYgGXCe8BcS8gPKtxh/YElROGPaohKDGwMDsQLs0ASw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxd2HL6RcEoLV16DW7sbDSEIjQvT/GTfSZAtMbpqMP3jEYfMC
	waYBalAPTrKdbIEZ7IYJzxraPmxng9o6qK6gjgG74uAi+3KkcKE5z0VE
X-Gm-Gg: ATEYQzzN1p0QK8SlJlrRUzckjKjni+x4bNjIAh6YXvAMci0WCaB+7VCX3IYNUghpEAP
	oydIs7YcgAhIQ64kH6y+nQjaXM8c6AVpZp8NsQSzmyBYX7zpP7N3dhdFQA76iekFpAN3otKJAs/
	hHdtIMqJGwRSZSsjq3FIhdyRfa2UwGwzwLuNN7abopYpYN/Klf32q4t6a++kqHKk/G7OypZ9EnO
	MjJPJdwecKV2IKx57CLLO19TiRFACnDMf+RjpImSxi6IMFU14cOA18bvvbTtZh+Rsg4JPOBtkOP
	pllRATY+lj/3rke/Rwq8S8ymv680ZHcQgefN8yZbWUGojZ6GhdHOa4JCTvh4kwJ+7S8R2+DeFuf
	Yta+WP0lwV7d0Vu9ml2ycg2MrcttnJI6qN3sucyuTYswmsVNFsdS3vrWRxczXm9Z4vmkxIe8n0M
	zaR+oeBSq42EOaVKti0nLyKWqDwoxbKhoHvquPOKSBE/ZcTNY2XA21Iw5RCr+q3yDmgFMVN/KdM
	uA3qg==
X-Received: by 2002:a17:907:2daa:b0:b86:f3d2:efae with SMTP id a640c23a62f3a-b942df80fe0mr829749466b.35.1773153247923;
        Tue, 10 Mar 2026 07:34:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b943cca3c0asm439877466b.34.2026.03.10.07.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:34:07 -0700 (PDT)
Message-ID: <976684fc-c44c-4cd3-b015-d35043013e39@gmail.com>
Date: Tue, 10 Mar 2026 14:34:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/5] docs: add usage for the cover-letter fmt feature
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <be7197aef5a7bc3de06216054fee6ee67e65cc33.1772839973.git.mroik@delayed.space>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <be7197aef5a7bc3de06216054fee6ee67e65cc33.1772839973.git.mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 23:34, Mirko Faina wrote:
> Document the new "--cover-letter-format" option in format-patch and its
> related configuration variable "format.commitListFormat".
> 
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>   Documentation/config/format.adoc    |  5 +++++
>   Documentation/git-format-patch.adoc | 13 +++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
> index ab0710e86a..ea5ec5df7a 100644
> --- a/Documentation/config/format.adoc
> +++ b/Documentation/config/format.adoc
> @@ -101,6 +101,11 @@ format.coverLetter::
>   	generate a cover-letter only when there's more than one patch.
>   	Default is false.
>   
> +format.commitListFormat::
> +	When the `--cover-letter-format` option is not given, `format-patch`
> +	uses the value of this variable to decide how to format the title of
> +	each commit. Default to `shortlog`.

Being able to set a default format like this is useful. It would be 
helpful to document what the expected format is. This should be added to 
patch 4 which adds support for the config variable.

> +
>   format.outputDirectory::
>   	Set a custom directory to store the resulting files instead of the
>   	current working directory. All directory components will be created.
> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 9a7807ca71..668330a015 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -24,6 +24,7 @@ SYNOPSIS
>   		   [(--reroll-count|-v) <n>]
>   		   [--to=<email>] [--cc=<email>]
>   		   [--[no-]cover-letter] [--quiet]
> +		   [--cover-letter-format=<format-spec>]
>   		   [--[no-]encode-email-headers]
>   		   [--no-notes | --notes[=<ref>]]
>   		   [--interdiff=<previous>]
> @@ -321,6 +322,17 @@ feeding the result to `git send-email`.
>   	containing the branch description, shortlog and the overall diffstat.  You can
>   	fill in a description in the file before sending it out.
>   
> +--cover-letter-format=<format-spec>::
> +	Specify the format in which to generate the commit list of the
> +	patch series. This option is available if the user wants to use
> +	an alternative to the default `shortlog` format. The accepted
> +	values for format-spec are "shortlog" or a format string
> +	prefixed with `log:`.
> +	e.g. `log: %s (%an)`
> +	If defined, defaults to the `format.commitListFormat` configuration
> +	variable.
> +	This option is relevant only if a cover letter is generated.

This should be added in patch 3 which adds the --cover-letter-format option.

Thanks

Phillip

>   --encode-email-headers::
>   --no-encode-email-headers::
>   	Encode email headers that have non-ASCII characters with
> @@ -452,6 +464,7 @@ with configuration variables.
>   	signOff = true
>   	outputDirectory = <directory>
>   	coverLetter = auto
> +	commitListFormat = shortlog
>   	coverFromDescription = auto
>   ------------
>   

