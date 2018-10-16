Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74FA1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 10:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJPRyX (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:54:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45914 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:54:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so20693030edq.12
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7kf6h9ZTVlCw+rIwXWxINqbKS1d3d2WFYFaiUePFLw=;
        b=mp3nZKlrHb2BlSRq6WafYHMkFIV5gSdkDmfW9sV5EPm5eosnK+JcdpwNNBGpKR4F7E
         572sQ0kfP6JVWNLNo/B+FNCWxWUGF0N4Agf8Use9mj6xFSnyKHmzyNpbanCk8DNq6oKs
         H3NcV8DycS1+uN+UOZE/Jdk3nz/LifC/AEIA0dJnvG81pAKkcyaAAkw+x90JXzRui51Z
         OoW9DIpicfeeYcH052I2VkKD1Q+5W1CdtogmahpBAZrf4CGf4BY7HfKeR4pOVGccxMjT
         Mq4btDA6xWHgE089CrNwPrkXNA8jTQVnH2jxs428FXoWJCQhd/wRD7P58KIVhZUTIlp2
         FwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7kf6h9ZTVlCw+rIwXWxINqbKS1d3d2WFYFaiUePFLw=;
        b=ijfSdGqecgdlfxbHNP/TZ3h4aNnAMes8dTtDG2yvDSfR8eiS57p7u/tzcdKdB35t6C
         8v0931ATIv6wo7s3bgzMPNi+NrepNov3xPTg03hxubdAkyFqTFciAA96H6LSWosl48ez
         BUYzFW6ipJkhWGqmJGgtR+hIXn6cnMES4g8nTHCcuuPlahndHiSZxIrC+LBcaNaSWYhj
         yTwy5lhwsbAhrOE/FwdOZpnO0hgaC1JrgfDpHaWKGyE0Cqiwy3e8TIxKNK83Ngr6imJ0
         Dgq1RSzO1cqCKXQlA60eQ5ZgzHbGSuhDWbCT2qrp7uGX/byk973oJJrU6N3AhsQ3BR8N
         7MKg==
X-Gm-Message-State: ABuFfojsqetqfX6fDY7EzP1FPSHrKJTWKrODTeoVJHzzsbjjapwIhe9R
        OKzdpACs0Ftrtgv8gQYMyTg=
X-Google-Smtp-Source: ACcGV62WJX7jiTli1/IQpgqWcjqSVy3hhLyycEr8zw1vM0a5gB93PumxfyKY+Saes8GQy1ADlRzSVQ==
X-Received: by 2002:a50:b3cf:: with SMTP id t15-v6mr30322294edd.181.1539684281152;
        Tue, 16 Oct 2018 03:04:41 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id k13-v6sm5580293edb.89.2018.10.16.03.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 03:04:40 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:04:38 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/13] tests: include detailed trace logs with
 --write-junit-xml upon failure
Message-ID: <20181016100438.GK19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:12AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The JUnit XML format lends itself to be presented in a powerful UI,
> where you can drill down to the information you are interested in very
> quickly.
> 
> For test failures, this usually means that you want to see the detailed
> trace of the failing tests.
> 
> With Travis CI, we passed the `--verbose-log` option to get those
> traces. However, that seems excessive, as we do not need/use the logs in

As someone who has dug into a few occasional failures found by Travis
CI, I'd say that the output of '--verbose-log -x' is not excessive,
but downright essential.

> almost all of those cases: only when a test fails do we have a way to
> include the trace.
> 
> So let's do something different when using Azure DevOps: let's run all
> the tests with `--quiet` first, and only if a failure is encountered,
> try to trace the commands as they are executed.
> 
> Of course, we cannot turn on `--verbose-log` after the fact. So let's
> just re-run the test with all the same options, adding `--verbose-log`.
> And then munging the output file into the JUnit XML on the fly.
> 
> Note: there is an off chance that re-running the test in verbose mode
> "fixes" the failures (and this does happen from time to time!). That is
> a possibility we should be able to live with.

Any CI system worth its salt should provide as much information about
any failures as possible, especially when it was lucky enough to
stumble upon a rare and hard to reproduce non-deterministic failure.

> Ideally, we would label
> this as "Passed upon rerun", and Azure Pipelines even know about that
> outcome, but it is not available when using the JUnit XML format for
> now:
> https://github.com/Microsoft/azure-pipelines-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
