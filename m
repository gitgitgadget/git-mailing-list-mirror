Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F748346A1D
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782576663; cv=none; b=Wkad+8BYF6sHKDYwJX41nC5S1fXj5zmXt8E3DEsASBPSGmtuCumuE/mH6k2R7gfuplh8NgZ+DH1F5KozV6VeYBLdMFFQ1m7FSeFXKxwQDQ298u3FgXlEr4fGxp053XJP8lfA/ZTJ9PwzUlZZGyTOj9PaEGjPp2NvurFTVkAv4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782576663; c=relaxed/simple;
	bh=qQ6OGGj0wn0uEs+bHNU7oykJdjFzKB2NIfIX+28RGhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK5ieHY5OmbbzjpBAAg35wNXdJT8yJocFjpqosP+7C4uALnguwcesamRK88WsII9kieE1wzDBlOUE59V5zMWDHN+xPsm08R62n8xwgMdeEV3Z1tblpYlod1Z/5nkXEwAQg31fanNTGMdCqm1gHJ7i0pz2yRb40X4FPQ6NuDXR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=L3ADef1R; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Oa5UdloX; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="L3ADef1R";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Oa5UdloX"
DKIM-Signature: a=rsa-sha256; b=L3ADef1Rv8HzxcxBYoCiNv4bircC9i+RW2LagkFiq2ZSn0qETX+QQ6f9SnsJP1nTftD7rw9ccI1SdQ/vw5wrPOClcYayBt3AOVSk8e/QxDqUKrk0+kFmSuZ2KsGnHtwy5HErXkM/XFwDsNK9KJxOMXTala1T3hMezSxJ3TS4f8fn579Jt6V9sr5V3iN9E7fqxZf1ApOoqN0RnMPfVatItsadbQ5CctrwFedIB0d1JyVx2NxF+yqSCxuJvV83fO35HV6AlTC5GLR/sxsNqkLAUzxDVO2yAYIG7q67Iq1jBMofy47PsPHsI+i/YfU2bd4xMXx0WEkzZdmwyfjib7voMw==; s=purelymail2; d=malon.dev; v=1; bh=qQ6OGGj0wn0uEs+bHNU7oykJdjFzKB2NIfIX+28RGhI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Oa5UdloXt5zToqaAV3+R5sj3kp/NVAcoUPxqtsxHcBy+0SyHr7iFdRTnmT4Lx6c8EU0UMkxeoLGQalJKxHwX+j8kXCi7SdtccMqNb89+bXuPKJ3/aQwFotSxP5xLsAzyAcRjeb+ACTB/sZXCoDIdZBoY1VjJo9hvFz4kft4OuzV5iqvgNkbklFM38tZqxJn4B71qwc/bw8eLrmCqSER+X8XHNnsuLCZU4d5qnlmYSaG8frNVl5meM22x/omhbpC8CBceyROxQ4IY7Sute6KlGCcXkAneQRHqeWvw/Z0o4dkHvpuB+l3l0lfkXXA71yp3WZMHEtrR7L87wUo3FOfYnw==; s=purelymail2; d=purelymail.com; v=1; bh=qQ6OGGj0wn0uEs+bHNU7oykJdjFzKB2NIfIX+28RGhI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1661015028;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 16:10:54 +0000 (UTC)
Message-ID: <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev>
Date: Sun, 28 Jun 2026 00:10:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260627160813.1074201-2-cat@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Apologies again for the duplicate...

On 6/28/26 00:08, Tian Yuchen wrote:

> +const char *repo_excludes_file(struct repository *repo)
> +{
> +	if (!repo || !repo->initialized)
> +		return NULL;
> +
> +	if (!repo_config_values(repo)->excludes_file)
> +		repo_config_values(repo)->excludes_file = xdg_config_home("ignore");
> +
> +	return repo_config_values(repo)->excludes_file;
> +}

One more thing:

I deliberately didn't write a comment for the getter because it will 
probably be merged with comments from the previous several patches in 
some form in the near future... I'm not sure if it would be more 
appropriate to write a separate patch to add the corresponding comments 
then.

Regards, yuchen
