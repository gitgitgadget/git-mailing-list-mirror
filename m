Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D8C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfBHLKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:10:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33809 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:10:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so6528786wmd.1;
        Fri, 08 Feb 2019 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=61nXeU63Nqg+Ya2ts8zImuo9zIBJw0Z+EpETWMs99H4=;
        b=TqmNpgAWgbhi5G6TWDW/uaIo+YKC+/K05cd4OT+EZOTkon4LcWfgXUyASo+f9deBNB
         AHQq0dVYpoOTXGW7Tl+uzNHHQ1d+i/NWvGXowGw2w2tTsVHnBSbQ7UJiIff52uYlJOnC
         5S6spw6/H5ASmCkR33VkpQng0x/gEDkPlEiWhSVkNAcrj4cnPkvwM5P0fgQU0ZGj75wf
         RzxidMqDL/px9e1/CxeLhAvvc1NrgtcQYhXb+d9FyQczc7yABGTvJGya3eu3oTWq3V+6
         7Ld4su74ekkDN2vrn97+OhSo0mJ6RDJajrm2iLs2nIUFV/ukr6NfO6F+9OTj6ySOH0ae
         3abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=61nXeU63Nqg+Ya2ts8zImuo9zIBJw0Z+EpETWMs99H4=;
        b=kQOojLilG/WB01u7iiaw/sejW9W3DLcb9ve7+kpF5EdI14ASa7vAiKXoTy2XzG8iP9
         Q3txdcny1BeF26oV+VNTDlX5IN10avpDwSYukN0Y6F/fT++Ixpy/+NEVj7TsTysipwZ3
         ik5+CgMh5WnYjmM4yzhLSTzjVquGXMZzV9iBYAyxJt61o3bY39aUe+QdEM168KQNWICj
         UtpzZ/WaFheqeuqFC9Ua3YvgkKh/ebrn5JmqdTFYoBUlJu7bfsr8E30x3GcL9QpJKVjh
         nizLhWyripJeChaM8tPrCCvEaIXpILAI6I1ZH17FdqgNtJUIpteOYtyNHoIlta+M3Rx4
         ujBw==
X-Gm-Message-State: AHQUAubtrLNk5X2uHlBJTYc/adt9DzvCewVGqLcQ0iF7Y0r174JIKKmW
        titDWdqE6goTKT7YI558966AzS3r
X-Google-Smtp-Source: AHgI3IZAooC68GF5G2HuODu8gvHLRzVS5zSJxYuAF95A4P2PSLriMluyzO56H73xhgSAx3vgd7Ihmg==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr6589912wmc.69.1549624206351;
        Fri, 08 Feb 2019 03:10:06 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id i184sm3978938wmd.26.2019.02.08.03.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 03:10:05 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:10:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jeff King <peff@peff.net>, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Message-ID: <20190208111002.GU10587@szeder.dev>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 05:48:27AM -0500, Randall S. Becker wrote:
> We have a few new breakages on the NonStop port in 2.21.0-rc0. The first is in t5403, as below:
> 
> /home/git/git/t/trash directory.t5403-post-checkout-hook/clone3/.git/hooks/post-checkout: line 2: $GIT_DIR/post-checkout.args: ambiguous redirect
> not ok 8 - post-checkout hook is triggered by clone
> #
> #               mkdir -p templates/hooks &&
> #               write_script templates/hooks/post-checkout <<-\EOF &&
> #               echo "$@" >$GIT_DIR/post-checkout.args
> #               EOF
> #               git clone --template=templates . clone3 &&
> #               test -f clone3/.git/post-checkout.args
> #
> 
> The post-checkout hook is:
> #!/usr/local/bin/bash
> echo "$@" >$GIT_DIR/post-checkout.args
> 
> This looks like it is a "bash thing" and $GIT_DIR might have to be in quotes, and is not be specific to the platform. If I replace 
> 
> echo "$@" >$GIT_DIR/post-checkout.args
> 
> with
> 
> echo "$@" >"$GIT_DIR/post-checkout.args"
> 
> The test passes.

Wow, this is the second time this "redirection to a filename with
spaces under Bash" issue pops up today, see the other one here:

  https://public-inbox.org/git/20190208031746.22683-2-tmz@pobox.com/T/#u

In short, Bash (when invoked as bash) doesn't conform to POSIX in this
respect; for a (too detailed) explanation see:

  https://public-inbox.org/git/20180926121107.GH27036@localhost/

Even our CodingGuidelines suggest the use of quotes around the
redirection's target.

> I wonder I should provide this patch or whether the author would like to do so.

Well, since you didn't Cc the author, he might very well overlook this
issue, so I think you should ;)

