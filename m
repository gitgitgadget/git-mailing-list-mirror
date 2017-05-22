Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE932023D
	for <e@80x24.org>; Mon, 22 May 2017 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760726AbdEVRmN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 13:42:13 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36692 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757895AbdEVRmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 13:42:11 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so88914310pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XySGmJ0ZS5hPuaHFm0eMS6ukoULIDew9fe5tJBwcpEA=;
        b=n9EMqZqx8wAemNjqLNnZsa/kZhexuZv9uraIBw5SlWuBqwjgx5G/6/llp+L3vNBYbW
         p6Kt9Bx+x1j3/tMoL+HMGBccMgmqbPv8Iz0QzEtSELSyqjuW3j26MJIk4vyTdd6FqYL3
         uqhwIqOYwrzTvWbZfPnliWWwP7tooo/9Qm2CBu0g1piIzWfuXpoqkZBPAFYTKngVp9lN
         qXIef5OV8StDt+SBcB9iXQBKovhIgYgot9qlgeE9d35wj2CMZdbq4UuJWJcsa9nHw1s1
         hMmNwwdGwwfZaEQYUzMhej8saXUoHjACxufjaji/BkUW471ofZb/O5F9EmC84D8crtQW
         zPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XySGmJ0ZS5hPuaHFm0eMS6ukoULIDew9fe5tJBwcpEA=;
        b=A+fSi4mMR8Cxq4TVoDp2eweZPZkdmvQaYdawmYXVsXx9CTZ3jzE3bHAbC0Wclv/Inc
         6TNMWSYCP5Ydw+eHk4uMvG6ZyZAj5xyzobn/YYOl27OLQUPnR3AjN2pjaU4mEK07ePdf
         0YXS6rdLAOb2vrogYPTNwkOpz+1u7E8hNVt/SBvdjSF4m7IEomyoQuuWdTDN8GjyYiFs
         wnYh4J0JP7LyqYu0/zJihhG1jovdenhbVR2vdoqAD7Df4DMsvMiM0gCWum3j4es4VsRK
         CJij8QVF+4oU22Og0ULaEPFb1lkIFlkycR4DcoztSV57cq6mKKD7OeFHKU+E+iH+pgRL
         rhKw==
X-Gm-Message-State: AODbwcAjElJ1nek0Qe+xjGD38ATUoYPEMXfn7iN2Be0AvQKQNy+N91DO
        wNriVTiuKdp5AA==
X-Received: by 10.99.63.141 with SMTP id m135mr26687092pga.195.1495474930906;
        Mon, 22 May 2017 10:42:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:557c:4659:8965:b134])
        by smtp.gmail.com with ESMTPSA id z3sm31734378pfk.99.2017.05.22.10.42.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 10:42:10 -0700 (PDT)
Date:   Mon, 22 May 2017 10:42:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
Message-ID: <20170522174208.GB17710@aiede.svl.corp.google.com>
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> * bw/forking-and-threading (2017-05-15) 14 commits
>  - usage.c: drop set_error_handle()
>  - run-command: restrict PATH search to executable files
>  - run-command: expose is_executable function
>  - run-command: block signals between fork and execve
>  - run-command: add note about forking and threading
>  - run-command: handle dup2 and close errors in child
>  - run-command: eliminate calls to error handling functions in child
>  - run-command: don't die in child when duping /dev/null
>  - run-command: prepare child environment before forking
>  - string-list: add string_list_remove function
>  - run-command: use the async-signal-safe execv instead of execvp
>  - run-command: prepare command before forking
>  - t0061: run_command executes scripts without a #! line
>  - t5550: use write_script to generate post-update hook
>
>  The "run-command" API implementation has been made more robust
>  against dead-locking in a threaded environment.
>
>  Will merge to 'next'.

What's holding this up?  The deadlock it fixed was a real,
non-theoretical issue.

Thanks,
Jonathan
