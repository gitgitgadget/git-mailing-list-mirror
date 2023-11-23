Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="obefEJFo"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34091AB
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 19:56:53 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a095fbe27so253516d6.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 19:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1700711813; x=1701316613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO5uRjRlM4RnFk1N4boEpUVcuEi9fOmz2Yt6lJhilAc=;
        b=obefEJFoQ0lF0B3NxKjFGo7rqhqrB4w+F/IE/3wKUyYq9rHsqlippgSVxLK3PzJSJy
         GLqcS7qQS2JByHNEaO+OBbyeBX9T5TW42u6jo9johIq6gNNIbY7KN1bLd3503MCq8qGI
         Auq7nglL1f4ficjvMpTqF+N8zYy2trLQJVcSU7a3omzZs3ONz+WjmOhJWnNhClzKdtvY
         JSz3PRboet3lhi0gbvKXKiUAVEgwKUul85CcCbJQd5hB1HbVskXnohgCPpcWovcnkvjG
         6dEm2kAomwbKRL4nq5NdHasB63fJeKreMDNA1EigHJGM5xsELOykPWjAdoMpnHgkOegD
         7Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700711813; x=1701316613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO5uRjRlM4RnFk1N4boEpUVcuEi9fOmz2Yt6lJhilAc=;
        b=njvQ0J8Nw9njGKipsUnbagjIrQUXVsL7rw/uxc3DouHRDREzqUgpYnClUf9q7biftm
         ZST+xsaJwtjehE/0exnS3UPa5i+Xg/y90DJz6S8PwEC0188QkYLpcIIoijk24Kwt9muv
         7EJjU1KiRjsjAmnSN65AKr6pcgjGATfUJqskHhewjptsaB8hlWeoBavHtJKoW1j2HLcu
         SWWsEZjvaSzd3xa4oHYISRQCa2kvx/c1n7n4XTl1cQDv7GQme9uS7evBlMdfEKsARR+V
         W+myrndtxSMO0sp1vFKkd3687LOBRl6BGpx5yx3Y7m0b9Ui1irDcchXHwyALHb3eRrEr
         YCNw==
X-Gm-Message-State: AOJu0YyRM/2nUY/Ix/OKQ/sYiiHVenvhamDaDQIy/Ms0zkefEbj47WZl
	j2Qa5Ue6vfYv8lnwNm3OiVSHnMrEPeD8+0DxaNBrtw==
X-Google-Smtp-Source: AGHT+IGli/eGaDCNXIgdULUEPwct90uYJRTGpdUV2+I3OVz/ZWQh9HyHtedHqBN1Xj3pKIL2ws0V+w==
X-Received: by 2002:ad4:4049:0:b0:679:2f90:d02 with SMTP id r9-20020ad44049000000b006792f900d02mr2286829qvp.26.1700711812856;
        Wed, 22 Nov 2023 19:56:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cf1d0000000b00679d8235a60sm154969qvl.135.2023.11.22.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 19:56:52 -0800 (PST)
Date: Wed, 22 Nov 2023 22:56:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: ryenus <ryenus@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [commit-graph] v2.43.0 segfault with fetch.writeCommitGraph
 enabled when fetch
Message-ID: <ZV7Ng29MReKGjrgi@nand.local>
References: <CAKkAvayLrYS1GQ_-Z7kWM=k4pCnNv1Q=NvYcvT8+wqYPkePVcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkAvayLrYS1GQ_-Z7kWM=k4pCnNv1Q=NvYcvT8+wqYPkePVcw@mail.gmail.com>

On Wed, Nov 22, 2023 at 12:05:02PM +0800, ryenus wrote:
> The issue appeared after updating to git v2.43.0, now git fetch would cause
> segmentation fault when commit graph is enabled. Though I only observed this
> issue in a repo with two submodules, regardless of whether the submodules are
> checked out or not. Meanwhile most other repos without submodules worked fine.
>
> > 15:57:10.660377 run-command.c:726                 child_start[2] git maintenance run --auto --no-quiet
> > 15:57:10.665870 common-main.c:55                  version 2.43.0
> > 15:57:10.666265 common-main.c:56                  start /opt/homebrew/opt/git/libexec/git-core/git maintenance run --auto --no-quiet
> > 15:57:10.666469 repository.c:143                  worktree /path/to/repo/sub/module2
> > 15:57:10.666649 git.c:464                         cmd_name maintenance (_run_dashed_/_run_git_alias_/pull/fetch/fetch/maintenance)
> > 15:57:10.668232 git.c:723                         exit elapsed:0.003405 code:0
> > 15:57:10.668241 trace2/tr2_tgt_normal.c:127       atexit elapsed:0.003415 code:0
> > 15:57:10.668611 run-command.c:979                 child_exit[2] pid:46018 code:0 elapsed:0.008227
> > 15:57:10.668635 git.c:723                         exit elapsed:1.837179 code:0
> > 15:57:10.668639 trace2/tr2_tgt_normal.c:127       atexit elapsed:1.837182 code:0
> > 15:57:10.669007 run-command.c:979                 child_exit[3] pid:46006 code:0 elapsed:1.843739
> > 15:57:10.671522 usage.c:80                        error fetch died of signal 11
> > error: fetch died of signal 11
> > 15:57:10.671645 run-command.c:979                 child_exit[1] pid:45980 code:139 elapsed:5.292927
> > 15:57:10.671658 git.c:723                         exit elapsed:5.337363 code:1
> > 15:57:10.671663 trace2/tr2_tgt_normal.c:127       atexit elapsed:5.337368 code:1
> > 15:57:10.672048 run-command.c:979                 child_exit[1] pid:45978 code:1 elapsed:5.345050
> > 15:57:10.672099 git.c:819                         exit elapsed:5.355644 code:1
> > 15:57:10.672105 trace2/tr2_tgt_normal.c:127       atexit elapsed:5.355649 code:1

I couldn't seem to find an easy reproduction for this bug. Would you
mind sharing a copy of your repository and/or a script that reproduces
this issue? Thanks.

Thanks,
Taylor
