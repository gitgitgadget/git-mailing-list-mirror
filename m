Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740D42376D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209311; cv=none; b=V5ZJzWsGq2HV+Xw2sxcoUJXB2Xk5r/ahkBqDVfDlcow34nLkrHCkz4JEYnKfDo/yjpC1q6tIi94HXTQWg/CtBWAciXxeDTn6Cic3FI4s4lny81BEL//UZRDgvR1oRYBvqCbnQiQ5NarKUJ4QC74+RdwOUtjL+yqEM5FZXzWKPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209311; c=relaxed/simple;
	bh=z2kIVYHknYSUVftDsjxSRq4hOzLW0zf9WSLo70CBpFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VyT4y2DWnWKqnrfG4Q3jkGEcB80hTJcryzVj+jcciQqWh4SJOR+lYVwcs8UhayBoWxcbwnqSll0PTWiZfG5fieMznXvHsJWipKFSYspZlqQrjJYVZDBH/K8DIVszbDMg96SzliBPQ4hFJdcg0hcVFWJvULEc//LHeY9RuY64vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV7aTOTJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV7aTOTJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ba5b151dso439053166b.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784209308; x=1784814108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kiBN/XdT9CDNGLOz1Q8GvyWzKMIY3GNA7tFFs76Xvow=;
        b=PV7aTOTJ2xnHe9MQq1EOZMbAHErFRTcvgGgnSsa0sp1rT0Ppw8Y9Uww/vm92u3CLmv
         LWERCPbm7dcxEQSVV2Es9bKlxOysuQmePBNC+EAyzJLpQBGMonZtTT6/7mv9zOOYv3nI
         /qdSHNLyB0GIatmBlc2+i/nqnCCbj5AAdBusfSvsw1wA7IBy7GWfveB1mzNJ965b9ip4
         zf/4tDURPA2+Nld/OndqUPQ8//sQh0ctQR2F9HOEYNl+J04BNuCRfgrdk5y/7VHojvA3
         lOv8JagnVYZc53+B4nb7JTNXdvvmx92iuN+wg6Fsam2huYjKXq8Yyf7SjCNh5aYXWjBW
         us+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209308; x=1784814108;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiBN/XdT9CDNGLOz1Q8GvyWzKMIY3GNA7tFFs76Xvow=;
        b=AXEIOQwUmmk1wWhQXt6SoYN0cAYhHulg2qC/Po04v2v5LADHx7ESXNtjylVdp9kLYW
         N5rYAHB2x4e9+1vE0NqnKRsogv5tUeizcMR2tH76MI9HToektk0DuVcslOG8zcekHrn7
         mJK7oX2twGVQNd+cSnk7hUE7QfMeAlyRRgEpcnycrkg00SFq+fMUQr5mDUwdnf77vtNV
         Z6jYdIus8iuuJ6eliqnxcNWLc/FIvRUzGmUf8gTKanvkBtgphsrF4wJAKrOsN76/sLY4
         md6YNVva8zsSQ+hsmBQ7a8GGaASGfKIUQWY41Gziakk/KH5wNxhlNkAGLyDd5HXKcZ9K
         OJXw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/b6cyMNioLLC1oQcCMrkqXx3oktzA4Sfo4W6O1s4bJONmCgcOdT08RXRvSphW72CjLUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXQ4MiU6gqGmpEkKUoktTovvI50zU/VzMY7T1T/R43XZgLul4
	P4nHmmp7WPvnFB1b8U9+eXLj0C0nyq6dFvKnimXRs57dY1xAZl/sRoIENGAsfw==
X-Gm-Gg: AfdE7claPN0KwsWIikLBY1UbWhG+ux5iXmVmXdQ7sj8A7zx22H3c9CM6Wr4T+LNjMTb
	OykZF7zRAo+BTOwKimBjiHxkLK6ig7j96738jTzmb1GhY8MNAPYZ7CW9Q14VLtFrKGQUimOFQ/0
	/HVgXlEB6In8F3dc1AS00oxGZtXSU4jJQZGP4fjFkZJ2mP5RCxSE5VPR9a6xkLa5BgYfSpOLywL
	wfv8r0dRiXzAq7B70EH8cyBych0ojibT/8DtpGBrlAP4YPoUsi5qFjAtBGx9B8CGrVzYFPp7G5s
	ILjvbsBlQy9NsE6a4phk8pHpE+ykl5Tmw3kS5gQcVkWXMsuo9k07HlG4q8+v8LYkPOxUZpf9AKV
	UPp8tKSkpRT4oiegY8Z3gWI0RYuZ0IuObuguWbqQnbArM+qsVbWgEBYsMFmPNuMpJ2/E1r6CK1+
	goqeDwqa/KWd6eFpkHIQlHcvo48vq3+nnpQ/Ip0fm2Pc7ltKgU+7Et0Ksv
X-Received: by 2002:a17:906:6847:b0:bf1:118b:d5e2 with SMTP id a640c23a62f3a-c161f3df364mr821863166b.46.1784209307870;
        Thu, 16 Jul 2026 06:41:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16874a27f7sm209646566b.57.2026.07.16.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 06:41:47 -0700 (PDT)
Message-ID: <27d4d72f-1ab5-4dc3-8cf6-1a9b6883a631@gmail.com>
Date: Thu, 16 Jul 2026 14:41:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] copy: drop dependency on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/07/2026 10:56, Patrick Steinhardt wrote:
> When copying a file we need to potentially adapt permissions of the new
> file based on whether or not "core.shared" is enabled. Parsing this
> configuration makes us implicitly depend on `the_repository`.
> 
> Refactor the code to instead require the caller to pass in a repository
> so that we can remove `USE_THE_REPOSITORY_VARIABLE`.

Sounds sensible
> diff --git a/sequencer.c b/sequencer.c
> index 1355a99a09..c9ede9c02d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2419,7 +2419,7 @@ static int do_pick_commit(struct repository *r,
>   		} else {
>   			const char *dest = git_path_squash_msg(r);
>   			unlink(dest);
> -			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
> +			if (copy_file(the_repository, dest, rebase_path_squash_msg(), 0666)) {

The path for "dest" is obtained using a local repository instance "r", 
but we're using "the_repository" to set the permissions on that path. 
While that matches the current behavior it is clearly better to use the 
same repository instance to obtain both the path and and permissions for 
that path. In the hunk below we even have "the_repository" and "r" on 
the same line which seems confusing. This patch uses a local repository 
instance in refs/files-backend.c and setup.c, lets do the same here.

Thanks

Phillip

>   				res = error(_("could not copy '%s' to '%s'"),
>   					    rebase_path_squash_msg(), dest);
>   				goto leave;
> @@ -3864,11 +3864,11 @@ static int error_failed_squash(struct repository *r,
>   			       int subject_len,
>   			       const char *subject)
>   {
> -	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
> +	if (copy_file(the_repository, rebase_path_message(), rebase_path_squash_msg(), 0666))
>   		return error(_("could not copy '%s' to '%s'"),
>   			rebase_path_squash_msg(), rebase_path_message());
>   	unlink(git_path_merge_msg(r));
> -	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
> +	if (copy_file(the_repository, git_path_merge_msg(r), rebase_path_message(), 0666))
>   		return error(_("could not copy '%s' to '%s'"),
>   			     rebase_path_message(),
>   			     git_path_merge_msg(r));
> diff --git a/setup.c b/setup.c
> index 0de56a074f..91d61a5939 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2331,7 +2331,7 @@ static void copy_templates_1(struct repository *repo,
>   			strbuf_release(&lnk);
>   		}
>   		else if (S_ISREG(st_template.st_mode)) {
> -			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
> +			if (copy_file(repo, path->buf, template_path->buf, st_template.st_mode))
>   				die_errno(_("cannot copy '%s' to '%s'"),
>   					  template_path->buf, path->buf);
>   		}
> 
> ---
> base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
> change-id: 20260716-pks-copy-wo-the-repository-aa01ccdbed76
> 
> 

