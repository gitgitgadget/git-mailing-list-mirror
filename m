Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36895243
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqNJeqHz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e69b3149fso21103035e9.3
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705255254; x=1705860054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqK4XDpUTgUs2E6rgVMeJXimChDUn7HUSeeLPltzQ/I=;
        b=BqNJeqHzLqZZIgOc70xwCTRc93KBziURB51DuL9X+GZLddBIAvUXA2ZfJD9Autqj0L
         H+NWvMsaCnLEp75rsCqiW4F9GHihw3Y8Ri2GHV63+tc9D8KoscZ/pscxYG3oTCuOugzD
         2V2EyZrQEyeYL5X81gshwrVNVXitV3GPdpBrpjv85OB068T6td6Jqq7yyV40xeV3wIMC
         9W3uWZgi2ClNTv5MuZTHN4CPa+TKiorlylsSUkcKPLCxUC2gYtp8aqgZKc3CHCpEmA1H
         FBUWaFLozScKD32xBcqP9wIG+NS5n8QTM/VwIZuUuzRPjK1yfmNyShVPaEKuoR5ycB0B
         jW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705255254; x=1705860054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqK4XDpUTgUs2E6rgVMeJXimChDUn7HUSeeLPltzQ/I=;
        b=jIeBiV3T4vL7xj5ruM6dezxMZ1/VJFzGKxjitrArLvwwGKmiwtEURkGTBMrWZbRUdZ
         BkvlgeePhgx5/dT07Va1FB3R9DsGysiiJpy4UDSZmYr2KdVzoghhZz/2hQjNlqlEcp/V
         vJ1WeFScm4UM62ENG3bukOI3p19oCvLdwRnMHU1QI5AWXA2pStcU2bK1Ue1N7bkBdfC6
         EU0A55kenjHvk/AyDeq6NdvMCMY+M7nZTdBmP6o2bE/UIuHOpgiO+ZKOO/We6P1z/VJ5
         DgtWZOLMHCUKyYtDVLkfIL+ftziFIma43c3nrkyw3PwyZ7YfiNEfAOw1ai39/VD7FFRd
         HzNA==
X-Gm-Message-State: AOJu0Yxwegh7ob7xZKfVJI5aR2q05ERvdAcJg8u1ATsn1cwT2AUTKYHD
	gDJaPxBs6NHokI+1Vk7Fo4KASG5KGeo=
X-Google-Smtp-Source: AGHT+IGuKATRormhyINipj3CO3lTdHEA5HpAer8cYQDlFYjY/sn0kA7e77UUcF39VFMU21vDN+t7Zw==
X-Received: by 2002:a05:600c:5108:b0:40e:43e5:7e8 with SMTP id o8-20020a05600c510800b0040e43e507e8mr2397302wms.153.1705255253552;
        Sun, 14 Jan 2024 10:00:53 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id j21-20020a5d6e55000000b0033672cfca96sm9695132wrz.89.2024.01.14.10.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 10:00:53 -0800 (PST)
Message-ID: <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com>
Date: Sun, 14 Jan 2024 18:00:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] clone: support cloning of filtered bundles
Content-Language: en-US
To: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Nikolay Edigaryev <edigaryev@gmail.com>
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nikolay

On 14/01/2024 11:16, Nikolay Edigaryev via GitGitGadget wrote:
> From: Nikolay Edigaryev <edigaryev@gmail.com>
> 
> f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
> incredibly useful ability to create filtered bundles, which advances
> the partial clone/promisor support in Git and allows for archiving
> large repositories to object storages like S3 in bundles that are:
> 
> * easy to manage
>    * bundle is just a single file, it's easier to guarantee atomic
>      replacements in object storages like S3 and they are faster to
>      fetch than a bare repository since there's only a single GET
>      request involved
> * incredibly tiny
>    * no indexes (which may be more than 10 MB for some repositories)
>      and other fluff, compared to cloning a bare repository
>    * bundle can be filtered to only contain the tips of refs neccessary
>      for e.g. code-analysis purposes
> 
> However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
> bundle, 2022-03-09) the cloning of such bundles was disabled, with a
> note that this behavior is not desired, and it the long-term this
> should be possible.
> 
> The commit above states that it's not possible to have this at the
> moment due to lack of remote and a repository-global config that
> specifies an object filter, yet it's unclear why a remote-specific
> config can't be used instead, which is what this change does.

As I understand it if you're cloning from a bundle file then then there 
is no remote so how can we set a remote-specific config?

I'm surprised that the proposed change does not require the user to pass 
"--filter" to "git clone" as I expected that we'd want to check that the 
filter on the command line was compatible with the filter used to create 
the bundle. Allowing "git clone" to create a partial clone without the 
user asking for it by passing the "--filter" option feels like is going 
to end up confusing users.

> +test_expect_success 'cloning from filtered bundle works' '
> +	git bundle create partial.bdl --all --filter=blob:none &&
> +	git clone --bare partial.bdl partial 2>err

The redirection hides any error message which will make debugging test 
failures harder. It would be nice to see this test check any config set 
when cloning and that git commands can run successfully in the repository.

Best Wishes

Phillip
