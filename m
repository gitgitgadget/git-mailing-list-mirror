Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0C51F453
	for <e@80x24.org>; Wed,  1 May 2019 19:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfEAT4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 15:56:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43760 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAT4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 15:56:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so21161693qtq.10
        for <git@vger.kernel.org>; Wed, 01 May 2019 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5RbkeeK16i6FoWlMoGsSlnUAbpMjPySJR5v285q1sZs=;
        b=arcQKGffVjUyn7WgSajk/JvrT9gyt1Rakpa4Oad4ohipZUZFsREw2vz7Kh1xydCgoW
         KZv8SAbGZewa6qUGpIljtjPLVKVEICok4HKHcqNxZO7RnzY7mymyg9YvH9gsYn/i7COv
         rjoOpkeTJq4DbIw+iX9YvwkUuOuurRzSD0YggX+mv/RYcrSMPogo8f9IHOndCkpqyyPm
         9kgwLowB4jxN9Mgm5dFt4LDiRXBIGJVYXJ5aWpeYpWAWeJUbebqf56mcYUqF1WSxd/Rd
         IRY9kRjBPhb5X1yejSKPpccHtoulZFF/34KEPNwJ/5XdTKTFjwMT0Bdde+XwPs6Foi/B
         P4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RbkeeK16i6FoWlMoGsSlnUAbpMjPySJR5v285q1sZs=;
        b=JEIKsroNruA3t6411gQPqOj2xg6AuYHtHAtwc+tSie3uOmZeIpiu/2k3tYiKwyXw77
         2JU7/yxdmhmouz+jilXjVsFqxnxaj3T+LrTlZYMFJAtpKxEHTHYxz4BTJL2cIgdkwfn8
         mVn7s0nFxTBrVNfxqtzf9gsakAxw0rXpfn0t5By4GwxNj/KGJtmAHVaVqSAoWLKs5qyP
         DxIpepqI60KcU0915Jg4Xpt6R9e3Sxyzj/OVqd+kurxdCQgBzYSJIFJen3cWmBBf96M3
         rJRM2GkFSA8Ac2Hc8MOkdYVOdjYwqTnOEgMZovJ5x2SnRuDH+7yFsdUvqd1X5sBT0Qmo
         2aWA==
X-Gm-Message-State: APjAAAXw7Ma014kXSJf8i2tfx5VgpgOBsJEZZuuL21tL8ZaSeqLuQuhK
        pq/yhLGPqjSzUdLOIf1AvyY=
X-Google-Smtp-Source: APXvYqylUr70DB+UH+R5mvNA41pT8h4t7eZ0zEGPz2wVvGAKhOJEfh7lI+aSpnVOQFWXbxtWMyY+mg==
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr24177qvs.67.1556740570699;
        Wed, 01 May 2019 12:56:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3012:809d:d5f7:8e4e? ([2001:4898:8010:2:1946:809d:d5f7:8e4e])
        by smtp.gmail.com with ESMTPSA id d55sm8507051qtb.59.2019.05.01.12.56.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:56:09 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] commit-graph: implement file format version 2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com>
 <cca8267dfeb382005ae3c5a4935f2281dabf26b4.1556716273.git.gitgitgadget@gmail.com>
 <87muk6q98k.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4cf34654-4b2d-ab5c-40ae-b47dc9502135@gmail.com>
Date:   Wed, 1 May 2019 15:56:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87muk6q98k.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2019 3:12 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> OK, let's try that then, on top of this series:
> 
>     diff --git a/commit-graph.c b/commit-graph.c
>     index 5eebba6a0f..36c8cdb950 100644
>     --- a/commit-graph.c
>     +++ b/commit-graph.c
>     @@ -1127,7 +1127,7 @@ int write_commit_graph(const char *obj_dir,
>             case 2:
>                     hashwrite_u8(f, num_chunks);
>                     hashwrite_u8(f, 1); /* reachability index version */
>     -               hashwrite_u8(f, 0); /* unused padding byte */
>     +               hashwrite_u8(f, 1); /* unused padding byte */
> 
> Then:
> 
>     $ ~/g/git/git --exec-path=$PWD commit-graph write --version=2; ~/g/git/git --exec-path=$PWD status
>     Expanding reachable commits in commit graph: 100% (201645/201645), done.
>     Computing commit graph generation numbers: 100% (200556/200556), done.
>     error: unsupported value in commit-graph header
>     HEAD detached at pr-112/derrickstolee/graph/v2-head-v3
> 
> So we'll error out in the same way as if "2.0" was changed to "3.0" with
> this "2.1" change, just with a more cryptic error message on this new v2
> code.
> 
> I don't see how this is meaningfully different from just bumping the
> version to "3". We abort parsing the graph just like with major version
> changes.

Having a non-zero value here doesn't really mean "2.1" or "3". But I understand
your apprehension.

I'm currently working on building the incremental file format, based on
this series. This "unused" byte will be used to say "how many base commit-graph
files does this graph have?" If non-zero, we do not currently understand
how to stitch these files together into a "combined" graph at run time,
so we should fail.

If we should never have an intermediate version of Git that doesn't
understand this byte, then this series can wait until that feature is ready.

Thanks,
-Stolee

