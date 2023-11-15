Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oh/cYyNv"
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270148F
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 13:28:55 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce291b5df9so60481a34.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700083734; x=1700688534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BikaYdo2KJqZl8rG05IWjj0nZDiyy8bw0KBM+LS89T4=;
        b=oh/cYyNv4ATryCF9Ho2AyNNhL2z9258VJEuJLROEMmKAKistnxd8L6ve6qPQ/zXVHw
         eQEi0f0I+1QjX9o1DKGq4Gp4w8BhAzTWo4GmR4LLh43ApvUHVhB5PNzO8IHCBkk0NYSU
         WvpwK/PVCTPqigq7F4psQuZmTViRZ+eOtXCe+8cdMq6hgguGmZl5PikQuVmxyIMqaika
         0ISfuwPYWoUiNjupmIiNbopJKwdT3Z/Ni1AF5vyv3xKAADGyR9vNJ/YbT24W6TsIT+tT
         81VsrBCwP7bq5J3j/uWs/wqFsS3/f/SRaC/H4ZmcrsQWLBhwa4JrJmdu/OhMfhcf/OO1
         RmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083734; x=1700688534;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BikaYdo2KJqZl8rG05IWjj0nZDiyy8bw0KBM+LS89T4=;
        b=Re9ehMzv0bVMs91L890qfRh6jTx3kanRZ8oBQRfXf+diGcc0uX7g0IaGaZjpluJ/b+
         /vSUmwy1Kg79seILq4HW4TOsIhdaDjMQYUgYcjY7TcF4QgJsyUgQ9eDgbfjOZU4Aixsa
         idl67RlyR0v+IFhObcw/Of8YoyY3BRo58mighR9M08VR7hJTrCTjaJlSYG+YYrPQvez/
         tQrJfKorhdWv9yudd+WSekC30vxuFN+OO+Qaaak1on7hO4rEXkOtoeMnHkr6QTfF1a+z
         s+Z2nCI4cBJDoDEnISY5PAvKq8ClqHCbJy2F7xxJIssIqfycQ6zwocPbmLSC+2ymeexZ
         J3JA==
X-Gm-Message-State: AOJu0YymW/zNuX7DmO1//Wp6aK/CxrFs5dlQQyLSbC2J68NcA9H9IQnr
	Ng2dqhhjtN+ZeMX5qzJTctKreA==
X-Google-Smtp-Source: AGHT+IGkOI8g4CpnQQ3cj6jIg7Zt518WoFNt22RQpJo/LGVgY6cIrzgcgFRBMOYp+iqkxmOvmOar9w==
X-Received: by 2002:a05:6830:1bd8:b0:6b7:4a86:f038 with SMTP id v24-20020a0568301bd800b006b74a86f038mr6669386ota.15.1700083734331;
        Wed, 15 Nov 2023 13:28:54 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:e895:6a84:b96a:8855])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b0059b782e8541sm1588876pgv.28.2023.11.15.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:28:53 -0800 (PST)
Date: Wed, 15 Nov 2023 13:28:49 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
Message-ID: <ZVU4EVcj0MDrSNcG@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
 <20231113184909.GB3838361@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113184909.GB3838361@coredump.intra.peff.net>

On 2023.11.13 13:49, Jeff King wrote:
> On Mon, Nov 13, 2023 at 05:00:37PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> > This is a late amendment of 19ec39aab54 (ci: stop linking the `prove`
> > cache, 2022-07-10), fixing a bug that had been hidden so far.
> 
> We don't seem to have that commit in Junio's tree; it is only in
> git-for-windows.
> 
> Not that we should not fix things if they are broken, but I am trying
> to understand if git/git is experiencing the same bug. It sounds like
> not yet, though from looking at 19ec39aab54, I would expect to get these
> doubled runs any time we store the prove state. But maybe without that
> commit our state-file symlink is going somewhere invalid, and prove
> fails to actually store anything?
> 
> > But starting with that commit, we run `prove` _twice_ in CI, and with
> > completely different sets of tests to run. Due to the bug, the second
> > invocation re-runs all of the tests that were already run as part of the
> > first invocation. This not only wastes build minutes, it also frequently
> > causes the `osx-*` jobs to fail because they already take a long time
> > and now are likely to run into a timeout.
> > 
> > The worst part about it is that there is actually no benefit to keep
> > running with `--state=slow,save`, ever since we decided no longer to
> > try to reuse the Prove cache between CI runs.
> > 
> > So let's just drop that Prove option and live happily ever after.
> 
> Yes, I think this is the right thing to do regardless. If we are not
> saving the state to use between two related runs, there is no point
> storing it in the first place.
> 
> I do have to wonder, though, as somebody who did not follow the
> unit-test topic closely: why are the unit tests totally separate from
> the rest of the suite? I would think we'd want them run from one or more
> t/t*.sh scripts. That would make bugs like this impossible, but also:
> 
>   1. They'd be run via "make test", so developers don't have to remember
>      to run them separately.
> 
>   2. They can be run in parallel with all of the other tests when using
>      "prove -j", etc.

The first part is easy, but I don't see a good way to get both shell
tests and unit tests executing under the same `prove` process. For shell
tests, we pass `--exec '$(TEST_SHELL_PATH_SQ)'` to prove, meaning that
we use the specified shell as an interpreter for the test files. That
will not work for unit test executables.

We could bundle all the unit tests into a single shell script, but then
we lose parallelization and add hoops to jump through to determine what
breaks. Or we could autogenerate a corresponding shell script to run
each individual unit test, but that seems gross. Of course, these are
hypothetical concerns for now, since we only have a single unit test at
the moment.

There's also the issue that the shell test arguments we pass on from
prove would be shared with the unit tests. That's fine for now, as
t-strbuf doesn't accept any runtime arguments, but it's possible that
either the framework or individual unit tests might grow to need
arguments, and it might not be convenient to stay compatible with the
shell tests.

Personally, I lean towards keeping things simple and just running a
second `prove` process as part of `make test`. If I was forced to pick a
way to get everything under one process, I'd lean towards autogenerating
individual shell script wrappers for each unit test. But I'm open to
discussion, especially if people have other approaches I haven't thought
of.
