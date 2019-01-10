Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434331F803
	for <e@80x24.org>; Thu, 10 Jan 2019 11:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfAJL5K (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 06:57:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfAJL5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 06:57:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so10976048wmj.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=81FeWEtwBQ/e/szoTFsOXz9o0RdnipxZnWhJmryu5RA=;
        b=kok32z07h+34JpTSePQTi0yRAni3SWt8KFgZ0dWhggBEoklBc/Ey44n23Ye1nmqN7V
         Eg8C7wiwLJjI5efsEFACXtma1/bpxMowXyyTwRiYbs8iwDHiuZdYJP1FPo8XkE2doAAq
         PQpmiax+i9fG0cu/EJ8/hWsSQivLXK2c4ELic4TK/LZAZXEZwRr/ZGRHkTk4DdwT/7Zi
         o7Om3FvtYepCfTAMaG8FKBssEfKeCMSpVyZVM4oCranRzA2B1cn39WbxOZneNrxJlmZ5
         iJstKS6oCfFyXxHwaiM5bH7zkgMoD11xxuo1U0VMC/H4ShBEA1kU6v21aepNCFtTTh5f
         78+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=81FeWEtwBQ/e/szoTFsOXz9o0RdnipxZnWhJmryu5RA=;
        b=H2DGTRQPV+BZG/3DtDV43A+QmHdbna2RAH6eDDFLMKgoA8Ql9Z+18AlWkgIV2UtJsV
         I0u2Zn4UPKW9nyIa7yiH7cgV02nDZvz+ESxhJ6dNY70+18tPm5i9Z5cizy04/zV7nwYF
         LvP/HTuvaXni+FRAqCmzXzppD2I133tLIXtBSXmpmx+W6WCkRq9hSMbVZH2Q30pVLAti
         1U0PqNHjUITSUegWMEMAetyvWEtEuniMaTELVd/fZzDYPftDX4cFuuWm0bHVPc9Ak2Vn
         9hsXCkozOCNqA8naQmb69NlSa3L0tdFU7ssovnUGoKlZCHVJa390G0ohETAf5Q19QChQ
         NWDw==
X-Gm-Message-State: AJcUukcDK2uGGw+exaGhPZtbT+mITmDyZJlFq2KvuimE7uAGA7IwC4o+
        W+GmjFLFZsy+gII3l0KKv9M=
X-Google-Smtp-Source: ALg8bN4Q6Ea8oPIVt7xdfvI6sTdjJ0ixAT3rThQH3H4MHrozWEgqIuQs0OnGpINw88Xd0RacN5y7eQ==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr9636031wmc.35.1547121427725;
        Thu, 10 Jan 2019 03:57:07 -0800 (PST)
Received: from szeder.dev (x4d0cf90e.dyn.telefonica.de. [77.12.249.14])
        by smtp.gmail.com with ESMTPSA id p12sm21321049wmi.5.2019.01.10.03.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 03:57:06 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:57:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
Message-ID: <20190110115704.GL4673@szeder.dev>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com>
 <20190109125628.GG4673@szeder.dev>
 <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 11:28:34AM +0800, Jiang Xin wrote:
> SZEDER Gábor <szeder.dev@gmail.com> 于2019年1月9日周三 下午8:56写道：
> > > +             sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
> >
> > This sed command doesn't seem to work on macOS (on Travis CI), and
> > causes the test to fail with:
> >
> 
> It works if rewrite as follows:
> 
>     git pack-redundant --all >out &&
>     sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
> 
> Without `-E`, MasOS has to write two seperate sed commands, such as:
> 
>     git pack-redundant --all >out &&
>     sed -e "s#.*/pack-\(.*\)\.idx#\1#" out | \
>     sed -e "s#.*/pack-\(.*\)\.pack#\1#"
> 
> Option '-E' is an alias for -r in GNU sed 4.2  (added in 4.2, not documented
> unti 4.3), released on May 11 2009.  I prefer the `-E` version.

Is 'sed -E' portable enough, e.g. to the various BSDs, Solaris, and
whatnot?  I don't know, but POSIX doesn't mention it, there is not a
single instance of it in our current codebase, and it appears that
we've never used it before, either.  OTOH,
't/check-non-portable-shell.pl' doesn't catch it as non-portable
construct...


