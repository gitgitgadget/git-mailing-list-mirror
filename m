Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF471F516
	for <e@80x24.org>; Sun, 24 Jun 2018 13:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeFXNdJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 09:33:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37225 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeFXNdI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 09:33:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so7172540wmg.2
        for <git@vger.kernel.org>; Sun, 24 Jun 2018 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qgLxFnG/rv2B6INTWe8U6oQHFcMdalMgzufUwZ1eU0o=;
        b=u2PsTiezlt/R794Kyx6wGz+KKLpAza//6KSkyoZl2PeenUSnbmKopJmxcx3psty9B1
         zd71F7N9R4dieDrV4rI9acdkOkFBgm6frg9YK/i0X2BMCSTZYHXfta1MB5mZiMHJTsDL
         kayPL6NSXmwk97BWgkuotHBDJXddOrxk4Ln9cTsulMm2yz3VGG/5G2pr6ASKAiVa7EiP
         h+QagPNRJWe6ifqqasXQcaQDdn1pUKe43wMPois6lM2YAFHxH4XPTR05lxWh2l2nionK
         Wn/k8qFITsDffNyz5OR707bkEHO4hwfKXVhOB3pa9XQbJ82JNVs8oiT90X54ufziwMqm
         LNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgLxFnG/rv2B6INTWe8U6oQHFcMdalMgzufUwZ1eU0o=;
        b=Tgk/gZYC6ATn/y2eCenT+ps2On8INrBQuCCb+Srzbi7YNpOOUQqOXH4EibPO8b7MH2
         MaHIHsdhQAtEee3UNT8rQk/09JWKf9B35BGot/KnOwymRWP1ydikXa8Z29flwYvieYVo
         KGGVSC8aP16bVES3yW9H5G9ANBQPyteUyDnF/v4puqCyoc4At21z5j34ZmNkoM4BmKzk
         RcuZoGkvEWkqrdNkwnRC2X8rvGKrlvCk5JcUbpHbzK+XySiZs5T81ABtNbYsS1lP7fbG
         BYIIrX1GQ8j5ztiOzHLa8r7DXDuRNI8fcSVVpdW7VKu5IkSrh4P0QgwC47Ye6sk/z7aH
         l7MA==
X-Gm-Message-State: APt69E1F6+o+AcNwd5L3iDAFIAO+UTDbOImKpV+xnCPB1GQR5TWIgt8T
        Nq6BC4OMteWkXvS1GfabkP6owN2q
X-Google-Smtp-Source: AAOMgpd2uB27e03oTJeyo8uxawzsi82d06GrEzbN+IZdpA/61M2a7zHz1044PqphvQVdMm2zqkpQFw==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr6328898wmo.11.1529847187014;
        Sun, 24 Jun 2018 06:33:07 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id n17-v6sm10292236wmd.14.2018.06.24.06.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 06:33:06 -0700 (PDT)
Subject: Re: Incorrect unified diff when run with "--find-copies-harder"
To:     Daniel Penkin <dpenkin@gmail.com>, git@vger.kernel.org
References: <CAL78Jw0mQWxO4xkzFBoG0Oe4wjomUGj=dP5ufdUrE5Ku0GGEtg@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <6d5d2536-0f69-544d-23c7-351e8618ba94@gmail.com>
Date:   Sun, 24 Jun 2018 15:33:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL78Jw0mQWxO4xkzFBoG0Oe4wjomUGj=dP5ufdUrE5Ku0GGEtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-06-24 12:36, Daniel Penkin wrote:
> Hello,
> 

Hi,

> I believe I found a bug in how Git represents a diff when invoked with
> "--find-copies-harder" parameter.
> Specifically, the unified diff header of a hunk contains an extra
> piece of text which appears to be a line from the context (i.e.
> unchanged line), something like this:
> 
>     > git diff --find-copies-harder d00ca3f 20fb313
>     diff --git a/test.txt b/copy.txt
>     similarity index 81%
>     copy from test.txt
>     copy to copy.txt
>     index 734156d..43a3f9d 100644
>     --- a/test.txt
>     +++ b/copy.txt
>     @@ -2,6 +2,7 @@ line 1
>      line 2
>      line 3
>      line 4
>     +added line
>      line 5
>      line 6
>      line 7
> 
> Note "line 1" after the standard unified diff header.
> 

This text after @@ is usually a function name in a programming language or
some other relevant part of hunk context, to help user navigate the diff more
easily.  What you are getting is the default version of it, as it is just
comparing txt files.  You can read more about it in the documentation of 
gitattributes:

https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header

> I prepared a sample repository with a minimal file I can reproduce
> this problem with:
> https://bitbucket.org/dpenkin/find-copies-harder-bug
> 
> I'm running Git 2.18.0 on a macOS, but I also tried with Git 2.15.0
> and 2.8.6 running on Alpine Linux and was able to reproduce the same
> problem.
> 
> Please advise whether this is expected output or is indeed a bug.
> 

This is expected output.

> Thank you.
> 
> Kind regards,
> Daniil Penkin
> 

--
Best regards, Andrei R.
