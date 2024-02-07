Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DB76904
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311124; cv=none; b=dSWhqtLvPaMmOOrJ5KPs7ePAbFUaFGby4reZpUR6a4jSePtnuWuYEZ5aERzNUTpazf+Km6Qy/U+jRW6N7BLBBc+QeKQxoo7aX1BLVuXBSemEEz0znQKSVlQGjBFpfcs9pe1ypHgpL8NwlNv38AQ1Ehhklps91XXJCI7arxuFtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311124; c=relaxed/simple;
	bh=t6CSYnmMuvMau8bt5eAeSoDFQBsmHjXRq1R6liiNVsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NZnr9dosE1pJPNsMKinZM0R0fmNOtePyV68lnXEMLhSOBMYs9wIxBEit808FKKQqcQuS4WJVPbRQz+vMl88gb8BFJA5gQdOXmjdpLiVzTcvfFGAu2YVzE9ivKKYj+CMCwqHo6ttAkYny4FH2Q87xMlC3zMGt57Xxm/Z7KHI+waQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVdSG7us; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVdSG7us"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7baa8da5692so34244139f.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707311121; x=1707915921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Za2VrLfolFf4KLdaEqSul282kzICbH0jOwlpXZqwUhE=;
        b=fVdSG7usCKPGdMe218u/VQnyvTeGpwKIC6ZrE7fwKBmJoisgKmsdJ/Cwsk415C0IwX
         vAb/CLCbnqe3AGL1jSBsnoqFc7f6mTYYkg+y0crVWx5z8HLFPfkQoWS+S9BgdGaLSiLg
         2S4nGTzGcvmYmo/fBxrritNKsOHRUtzgCVQeHuGaeoJ1vDLJ+XnxvCWzx56BK0y9UKni
         5cxR54iMtImL/kkU1mJ2pNpODkXjfQ6KKYXJtc2THhlu8t/mQnmmZ99FxmA75Dilq1Sc
         /He034m/F7Gk4ZsohVSPJ9CTpkThS77KVUYCgJ9jZVmisZsefs3xsIVmnv3N2B42hUhN
         kgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311121; x=1707915921;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za2VrLfolFf4KLdaEqSul282kzICbH0jOwlpXZqwUhE=;
        b=JjJx76GLDyHaFBP0jlXqlB0DjvuwIbKMG9qpSjufZp7b3v/6SfO2F5PMdulj/phiyg
         6/oBlV7mxPnGY80GJBP4cy8S07KZI7xLXiI8Dnc5Dxnb/qn7IUxqqYkiEVjJXuK5vjZH
         rnPOY/N5+wfw7JNsRxoNZqTkeL8Gg4IwU1uhqklWQqrzY9u2IPBfYtzlWC02G+Avo0qh
         GWzhWycCKbgUODvST0TEEDJrZ+AeLN0gtBmqXo1VKSx7e4+DCRKJ81tnTUB8X6eleCAb
         Y/jOVXYn2jULn/Jguqn9PXkeyI4rWuISI5OGhd65bV4+/8+N2FUFfIh60xgkMnVN675T
         8W3Q==
X-Gm-Message-State: AOJu0YxOP7Fb0w1gDOSxnvNE7RpoC9ylQHb25Jp8JtJI7+Tjn1pPmU7t
	vF9stJVpmy/s345BM0mywQtnyiWeDgjk+aOsRe1QpqUo+P30R5iC
X-Google-Smtp-Source: AGHT+IFVYQQHVD8DRUUbuD6piGjUCEtSuUd/kbIQTMG7cxGp5RXqpMy0vpxIk4ELtnhUeq7h3DglZQ==
X-Received: by 2002:a05:6602:1243:b0:7bf:562f:8f86 with SMTP id o3-20020a056602124300b007bf562f8f86mr5661563iou.17.1707311121520;
        Wed, 07 Feb 2024 05:05:21 -0800 (PST)
Received: from five231003 ([2405:201:c006:31fd:bc0a:a683:7af0:2157])
        by smtp.gmail.com with ESMTPSA id s20-20020a63af54000000b005cf450e91d2sm1459382pgo.52.2024.02.07.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:05:21 -0800 (PST)
Date: Wed, 7 Feb 2024 18:35:17 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #03; Tue, 6)
Message-ID: <ZcOADbiXv81OzztB@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyt9dqgi.fsf@gitster.g>

Hi,

Junio C Hamano <gitster@pobox.com> wrote:

> * ak/color-decorate-symbols (2023-10-23) 7 commits
>  - log: add color.decorate.pseudoref config variable
>  - refs: exempt pseudorefs from pattern prefixing
>  - refs: add pseudorefs array and iteration functions
>  - log: add color.decorate.ref config variable
>  - log: add color.decorate.symbol config variable
>  - log: use designated inits for decoration_colors
>  - config: restructure color.decorate documentation
> 
>  A new config for coloring.
> 
>  Needs review.
>  source: <20231023221143.72489-1-andy.koppe@gmail.com>

These commits have a design conflict [1] with the series

> * kn/for-all-refs (2024-01-29) 4 commits
>   (merged to 'next' on 2024-01-30 at e7a9234a8b)
>  + for-each-ref: avoid filtering on empty pattern
>  + refs: introduce `refs_for_each_all_refs()`
>  + refs: extract out `loose_fill_ref_dir_regular_file()`
>  + refs: introduce `is_pseudoref()` and `is_headref()`
> 
>  "git for-each-ref" filters its output with prefixes given from the
>  command line, but it did not honor an empty string to mean "pass
>  everything", which has been corrected.
> 
>  Reverted out of 'next' to revamp its UI.
>  source: <20240129113527.607022-1-karthik.188@gmail.com

So maybe change "Needs review" to "Not ready to be reviewed yet"? as
people who read it might not be aware that it is kind of an "out-dated"
(not surprising since it was sent last October) implementation and
reviewing needs to be held off till a reroll is sent.

Thanks

[1] I have detailed the conflict out here:

	https://lore.kernel.org/git/ZcEvLwp0t8-rcyGn@five231003/
