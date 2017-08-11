Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722C620899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbdHKRjK (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:39:10 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36103 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753381AbdHKRjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:39:09 -0400
Received: by mail-pg0-f49.google.com with SMTP id v77so18037399pgb.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOTPGP4sozHmeGdicQllS94mZzgqaOJFDfNS9pE/9dA=;
        b=kdZa1RF4wjIeRdN7hM4YjEY4Bid4mTQFMW3I9Lp6E7DTuZDeTxHqDb47oEyhZ1y500
         ky14BeaJqh9X04CHwf0az2N4HowaBoE/W8yZrM3dNg6Xe+Q0io8A7Xo5TnbFRd84aVkH
         SVRPOE1eqzBaVwscjZC7b1BOfCg0FsUIEMxfAzYhTZ8IWKKe6B+oEX3MJrXid5DuUR3I
         0BQxM/UKk2QsQVFfgNga2MJdhzSBqBV+ql5GnQWDRRIVi6Mjf3efANWdRdpCPsfWQ65I
         PiCPujoU4APPtL18PKcqy+wsyr2al4VZ60G8JqqGbeG52BzxgzTRyDwY6UDUlMHCpDwq
         up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOTPGP4sozHmeGdicQllS94mZzgqaOJFDfNS9pE/9dA=;
        b=XJjwNCB4b5/6eHlMB/oCqWNLtuWC3CUrMVMeDiMPYnli27Xb3ijMlMMrbaO8mqD6Ug
         F3FM3F/klFpSjkFIEnZQVzR7+/0bsunVHnI0UQusPyjywALLVq0gHZWY0fvz3MTBfc9z
         0ZJ3PVjYlGZ9Mo4XVKXkq5xvrYVtDShHn8JEOXnbggf1JMHS5IhzIePRfm/FS1Hip+1s
         UnVL1VHY4OnQJTfcz4XuTzJpMkWwbPG7ERtE2UikC8d4d1voOxS7DkXFDNwq/i1vzMPk
         BCnDz35NRdOHzI4gJoHhhQ+QLxUKu4bqzCFI+HqHJZAoU/+ALFLkEbMoYXdM8w39UNAE
         +GlQ==
X-Gm-Message-State: AHYfb5h5+Hljtag4wnmY6sbZKfV16rj8YdUafHOt10MB9J04EFYnt8LM
        cXIIgF3ExWuFLNbf
X-Received: by 10.98.32.195 with SMTP id m64mr16848091pfj.66.1502473148526;
        Fri, 11 Aug 2017 10:39:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bd89:8abb:3c45:bf8a])
        by smtp.gmail.com with ESMTPSA id p77sm2739411pfi.153.2017.08.11.10.39.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 10:39:06 -0700 (PDT)
Date:   Fri, 11 Aug 2017 10:39:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     git@vger.kernel.org, sxlijin@gmail.com, gitster@pobox.com,
        peff@peff.net, Jameson Miller <jamill@microsoft.com>
Subject: Re: [PATCH v1 1/1] dir: teach status to show ignored directories
Message-ID: <20170811173905.GA59325@google.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
 <20170810184936.239542-2-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170810184936.239542-2-jamill@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10, Jameson Miller wrote:
> Teach Git to optionally show ignored directories when showing all
> untracked files. The git status command exposes the options to report
> ignored and/or untracked files. However, when reporting all untracked
> files (--untracked-files=all), all individual ignored files are reported
> as well. It is not currently possible to get the reporting behavior of
> the --ignored flag, while also reporting all untracked files. This
> change exposes a flag to report all untracked files while not showing
> individual files in ignored directories.
> 
> Motivation:
> Our application (Visual Studio) needs all untracked files listed
> individually, but does not need all ignored files listed individually.
> Reporting all ignored files can affect the time it takes for status
> to run. For a representative repository, here are some measurements
> showing a large perf improvement for this scenario:
> 
> | Command | Reported ignored entries | Time (s) |
> | ------- | ------------------------ | -------- |
> | 1       | 0                        | 1.3      |
> | 2       | 1024                     | 4.2      |
> | 3       | 174904                   | 7.5      |
> | 4       | 1046                     | 1.6      |
> 
> Commands:
>  1) status
>  2) status --ignored
>  3) status --ignored --untracked-files=all
>  4) status --ignored --untracked-files=all --show-ignored-directory
> 
> This changes exposes a --show-ignored-directory flag to the git status
> command. This flag is utilized when running git status with the
> --ignored and --untracked-files options to not list ignored individual
> ignored files contained in directories that match an ignore pattern.

I can't help feeling that there is a better way express this with a
better UI.  I'm not saying this is wrong, I'm just not sure how
--show-ignored-directory would work when not paired with --ignored and
--untracked-files.  Does it require --ignored to also be given?

> 
> Part of the perf improvement comes from the tweak to
> read_directory_recursive to stop scanning the file system after it
> encounters the first file. When a directory is ignored, all it needs to
> determine is if the directory is empty or not. The logic currently keeps
> scanning the file system until it finds an untracked file. However, as
> the directory is ignored, all the contained contents are also marked
> excluded. For ignored directories that contain a large number of files,
> this can take some time.
> 
> Signed-off-by: Jameson Miller <jamill@microsoft.com>

-- 
Brandon Williams
