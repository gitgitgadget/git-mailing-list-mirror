Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180E3C465
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203034; cv=none; b=IdWqE3m0algYZhPAQrjNAGTyU1FWsfqDBCPj/m6bAaT1geC9W688Qken5bqSg9bhZXvHgYjnxc0mWfK69cS7Nw9rzW/ftsMqipnBAv7kGs1kj5NaNPw1OsZbXqoNla4IK81G2JWAXChat9q94ZSIX9v/uEfPGu7xbC2MHC+EBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203034; c=relaxed/simple;
	bh=aD/J0hGYlcqcApwoJIBr49ELVuah6EetFPM+5JUN1UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfC3e21KYyobIH/Vzylre9GZXeRWVm+owZ77O81uWy5S5fpIByQsPBcOV0Aa4+lvtAy3nNtqhXpKorjiV1V+h7nKBb+612BEoALqNkTgjTlj8fk+HYgoSGtwqNrLphDs/fTP6tD9MGMQesCJAzPTIgybbWo9KpOTPt/P85wlu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb1LKCGO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb1LKCGO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b166fa41bso2785997e87.0
        for <git@vger.kernel.org>; Fri, 02 May 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746203030; x=1746807830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aD/J0hGYlcqcApwoJIBr49ELVuah6EetFPM+5JUN1UA=;
        b=lb1LKCGOM++XdSbRtOd9HuN8wJOqJQ8q7ld0YphL6/ZkAgZZ0Gqr0SmZPg1/5lzO7q
         XB+KjCliRITxww09gkXjrw2YxjmZPmeYb3JGMZzDo6tLsUncUprQcYRrb2GWlsX38+xu
         YbETa2O1cidH+eGCUe+VqKJjnTjD9XiBNnJbmKX1KEP3VkZFKIKk+u2QcMvvu50uSJ83
         n52asYSJ4xc/ikV15cq2WgXXg9sni+urS8i0aooyHziZ+jJWpEysswtB0VvG6K+LJyZ8
         sNEUsnKse2HiK/te3LKWSm4EAx9uVUxUxePc447pRHEXnb0bKlJTEKztR1vNULQDGKNQ
         bTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746203030; x=1746807830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aD/J0hGYlcqcApwoJIBr49ELVuah6EetFPM+5JUN1UA=;
        b=oCh0VT1qK7bXgeq1rtMsmbKwT33g8XFgx+gHerDFH0SPo1x2uspjbI2C1GtHdlj2Qz
         P5GQV2ejPuyynIzFsK8i0mTCZ4zpUQ+LfWlKBV6YGQ2DGPfZGCCDWgpHPikL91F/dTyL
         cFE9LuWmIuh/PG+1lACI+NstXVdx5yH6Rwzo6jiXlsx0/6PHB6s6/9jVymldWMiZLkIu
         Uo9ZauqjVUYPs5Q+w8Bj3cd92AkILf2PFKkifeKsTIr7Bgi3UPa3dbiBTInPVzRRxBQE
         HWrIjRModw+h8DI9iEOC5pK3JxAaSjSLT4n6btPCc1118cqPrqSXL1IcTplzqf8TpuZ3
         bSWQ==
X-Gm-Message-State: AOJu0YzrtICqaueseVMoCnYL5rixDCgnD5P0cUZCrD9X4ZWQPr+Kzuh0
	e1iZhpfwimFc3Gf5sxWPZVk6I5J/AC0Lb/wWB4V1Nsde6N45dG+o+X1+y0dwJvcIt/pbAREQos6
	nhOFvCuFcv3cNmyj8T8v+Y5AaaYiaspodHKI0NA==
X-Gm-Gg: ASbGncvnB0OundHhEfgwfhN8DrXF2s4BQcGKuqDAQcecwnApcPE2kzRBIzB/H9DM4sD
	LXScnNq8dHLplQflt5gDNmIi32KYV2bNeePW0JGyTWR8K30H/S7CfqGzOrFkT5Im+X1i4FpmrIR
	Vm1WKM5x1acnfzH/NoVVoCCA6HUC/RhBUGgXrqrzhNJpD3yXEGFqhgZ6Ykka2afCg=
X-Google-Smtp-Source: AGHT+IElxPVQ6UySiCv9KmcgRnJazNciWXjn/7c5AYvhHyU3mHu3I9ndmEG5dVIxX2uZqbqGb+rNz3hEDtAWQ5H9LQE=
X-Received: by 2002:a05:6512:318e:b0:545:f0a:bf50 with SMTP id
 2adb3069b0e04-54eac233140mr938728e87.35.1746203030229; Fri, 02 May 2025
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
 <bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com> <CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
In-Reply-To: <CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Fri, 2 May 2025 17:23:39 +0100
X-Gm-Features: ATxdqUETihvpJML7HRBPgeF_4O9c2U7H_ZD__kSfd61vXBidNdt-JES1h-nwKYk
Message-ID: <CAP9jKjFEFNFK_dRCAFj224=AE=5k4RsJhspVUFhzQJia8GOdwg@mail.gmail.com>
Subject: Re: Discussion for interactive --patch commands to get --unified support
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Correction to my above message, I meant to reference
`repo_diff_setup`, not `git_diff_ui_config` as that lets you
initialise a struct with the default context value that diff uses
(assuming I have understood correctly)

On Fri, 2 May 2025 at 17:14, Leon Michalak <leonmichalak6@gmail.com> wrote:
>
> Inheriting the diff.context setting is what scratches my itch the most, although
> also being able to set the context in the command list of `add -i`
> sounds interesting too. Personally, I don't think I would use the
> command line overrides too much myself as most of the time (like with
> diff) I'd like to set the option and forget it but it does have a
> certain consistency to it.
>
> Slightly off-topic to the discussion, but does anyone have advice on
> how to deal with providing a sentinel value for something like
> context? I'd expect to pass `--unified` to the underlying diff command
> *only* if the user specifically has overridden it via command line
> option or a diff.context config, just like diff.algorithm has done,
> however diff.algorithm is a `char *` so the value can be NULL which is
> a good sentinel value. My thinking is then the underlying command can
> just deal with the value as it sees it, such as giving a default if
> not provided or making sure it's a minimum of 0 etc. Otherwise the
> level above has to deal with it which then probably involves
> `git_diff_ui_config` and other validations which I don't even think is
> it's responsibility and would probably duplicate logic unncessarily?
>
> I may be completely off in my assumptions here being new to the
> codebase, so if anyone has any thoughts I'd greatly appreciate any
> comments!
>
> On Fri, 2 May 2025 at 15:39, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 29/04/2025 10:16, Leon Michalak wrote:
> > >
> > > (https://stackoverflow.com/questions/6711670/git-show-more-context-when-using-git-add-i-or-git-add-e)
> > > which mentions you can do `GIT_DIFF_OPTS=-u<number> git add -p` which
> > > does work however isn't very user friendly or convenient.
> > This is a question for others on the list rather than Leon - is it
> > intentional that the plumbing diff commands respect GIT_DIFF_OPTS? If a
> > script that wants to create a diff with a certain number of context
> > lines runs `git diff-index -U <context>` is it helpful for that to be
> > overridden if GIT_DIFF_OPTS happens to be set in the environment?
> > Looking at the history it seems that environment variable used to be the
> > only way to override the default context setting but that's not the case
> > now.
> >
> > Best Wishes
> >
> > Phillip
