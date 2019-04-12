Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E8320248
	for <e@80x24.org>; Fri, 12 Apr 2019 05:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfDLFOk (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 01:14:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52568 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLFOj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 01:14:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so9509580wma.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X3Y5pVIaBKgUV53T9PdptnYX472PaH0TBda3c7jPeLM=;
        b=gkxWiB5zxgEm8q+ONbDmLRvEX5rg3SjmovCKRREMD63lE898T+V1KGsjPruyhwlskZ
         POZseeqbGeZiZq9PhoQ8D9pHj2/iT3yiOi0hwDhQ5KNxTQqSY0PxJEvNxbj8JNI7aZzX
         7/fcDkLiiOD17aEUZDEgFYLeJU8azzg8CVlhaZaMNuosxqyrpzWnMguSjJ1IHqBBIgtA
         uZ54VJkz5VTupNhNpzYnZIgaynLkViCLT+Fq8kIMsvihbArH5h9WCWfjJ/3gLu3UCz9W
         m4lG8xITBTTIUhc3/4weCbsn0AwNvFKPp3ron1rOIBs8EszWJO3AJJ3yZ6q/SNJZkhTM
         YuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=X3Y5pVIaBKgUV53T9PdptnYX472PaH0TBda3c7jPeLM=;
        b=h0WkGFb2J5nmjCpCABB99S4oqQYLeF/Lfkuf/t0Bpyl5CY9stPa9E+PlxPWLRHmUUB
         sKP0pw4DgkgxwWkxOvp9z+kabwNxo/t4GF54C8Urm0HEjJYpDgGU8H/0X2pb4albAdoH
         n00+zHvpibErW5FQQ8khP6qII4lfvn3Ta92wnkqL0OFBg+tDQyYzso4owGDn4/YA7yLP
         O7J1UxXCJDRBQ0vxaifMGf5QadPaAzp1m/1x8Ed0u2DX+PRNLY+pkxQJbSdC4quYqV6A
         C44D8HabvvKaBFVQGzNzur31Xs3M57MV5RWCG5efLGN6lVbEbGou8pBe+zvH1J6ZNdup
         Ybgg==
X-Gm-Message-State: APjAAAXi5foEPSC8Co55ykkN//TlZcRJ1WEDBNlhaXxRI6Oe4aQEqWRt
        279V2x7p1+v2c4971/RNzvZzMeLqnUY=
X-Google-Smtp-Source: APXvYqyc4RTGFKLrgLOY7Cg8RQ6owYwd05dgKGq1OarV83LclSgQME2/YTbQmkDjdmLBFwLNFMmYmA==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr8471329wmf.56.1555046077905;
        Thu, 11 Apr 2019 22:14:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f11sm52341019wrm.30.2019.04.11.22.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 22:14:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190411131218.19195-1-pclouds@gmail.com>
Date:   Fri, 12 Apr 2019 14:14:36 +0900
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 11 Apr 2019 20:12:02 +0700")
Message-ID: <xmqq4l73ztxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v2 should address all the comments from v1. I still haven't done that
> --intent-to-add thing yet even though I'd like to make it default
> behavior too. Anyway changes are
>
> - --index is renamed to --staged to avoid conflict with --index from
>   git-apply, which has different meaning.

I think this is a reasonable compromise.  Documentation/gitcli.txt
needs to be updated for this new addition, where it currently only
talks about the distinction between "--cached" and "--index".

> - git-rm learns about --staged as an alias of --cached (in fact it's
>   more the other way around). This is to keep suggestions consistent
>   because we tell people to do "git foo --staged" everywhere.

I am not sure 100% about this one.  If "--staged" is only about
updating the index without touching the working tree, then existing
"--cached" is already serving its purpose and there is no need to
add yet another.  Why did we need it for "restore-paths" in the
first place?  Is it because the target of restoring can be one of
the three (index+working-tree, index-only, or working-tree only),
not just the traditional two (index+working-tree that is signalled
by "--index", and index-only that is signalled by "--cached")?

I think it would make sense to introduce --staged to "git rm", if we
teach the third target (i.e. "working-tree only") to the command,
but otherwise, I am not sure if it would help reducing conflusion.
