Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE38B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbfKEP77 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:59:59 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:34001 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389843AbfKEP76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:59:58 -0500
Received: by mail-qt1-f178.google.com with SMTP id h2so16791041qto.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a22ckprE3+XGKb4ZD1vNrKCzPSLgjyOYCrxWGh37FKQ=;
        b=LAHc1cdDzHAJwDfl4VQtaHoZ02mvdfN0Nwa91fZhLvwhMc69FhGzgev3XystroqiPr
         hNUIflDV4MNa4cajWKFrxpy/2Nyu2fkYCbiftQGjkyGJcHeXcZ5oOlpU4HWJUdGBAntA
         NlNHgXnPAGlytPyPtMIXR6f6cufmc7uhJHU0J86iiraeXrgC9J5nUhBs0waurwae5Bc8
         qk7aggLZJ+1MfHYVa1alv8/LiilzXnnp1rhXNfnDp3fDA2UcTqoyjewqTHroDnholP+4
         XS7KAY7gwNoiYr9hPPU30EXVAhA4iwSAlNS6vOKDoeRKBixF17HHBJVtnXOxWz04q8fD
         e3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a22ckprE3+XGKb4ZD1vNrKCzPSLgjyOYCrxWGh37FKQ=;
        b=JyNw8vfdmBmJLk/WUs3J595+93+6eqUp8HyRvOy+eJ/nrAmStcSrGOxul/a05hL/RG
         MlKuPobHlWda7ClddDS0jPRJqUcCax4Uv0BHuL3i/TfJ35obZumO6wUxjGhsG4ZzEGlm
         g8f0EzRhuYT3q2y7Jt1dg5y6mm70hCrxEROTsa3EteYinsOxeQqUC0bLOCDO1mF37hxU
         SfrQBSFgSs/FjoOaNZL2NHdnWf9xuMevlV8+yVqBuYQP5FRPgnv1shV9c/WcU5x+atOL
         kviBqlCzMzJugkTANzXR9t/mpMmAsi3gJGwYEw1odm26poSmfj+GMkj8feCJgrIUoyWc
         ebjQ==
X-Gm-Message-State: APjAAAW5VHyQU+zAxOgKuGCbLs/hkC2xghx/W36/GLE9lgYNp4UzmWum
        t4e55wbK+g4pfohxrFEidixeRcLTM2w=
X-Google-Smtp-Source: APXvYqyZTRkfN7hdu2JlV3vmYqijBFHxSTdr4EC9Pz7ReEVoRs9NTCd/TCZU0gJgMFwtg7UFiDsnjw==
X-Received: by 2002:ac8:7655:: with SMTP id i21mr18585978qtr.53.1572969597398;
        Tue, 05 Nov 2019 07:59:57 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d78:3a28:e2ab:8193? ([2001:4898:a800:1010:4eae:3a28:e2ab:8193])
        by smtp.gmail.com with ESMTPSA id d39sm12695504qtc.23.2019.11.05.07.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:59:56 -0800 (PST)
Subject: Re: commit-graph: avoid message Computing commit graph generation
 numbers...
To:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
References: <CAKkAvaz=xpMpVqCxOMT+b-cUNKdcNdC_4FVkfAVTRhP1cODp0g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d28af6b-5c32-68f4-2fef-22e9972c818a@gmail.com>
Date:   Tue, 5 Nov 2019 10:59:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <CAKkAvaz=xpMpVqCxOMT+b-cUNKdcNdC_4FVkfAVTRhP1cODp0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/2019 10:40 AM, ryenus wrote:
> Hi,
> 
> After setting fetch.writeCommitGraph to true, the message
>> Computing commit graph generation numbers: 100% (2/2), done.
> is always printed.
> 
> IMHO this is internal to Git and probably NOT necessary to print by
> default, if really necessary, maybe an option can be provided
> to turn it on. Thoughts?

Thanks for the report! This is a relatively simple mistake, and it
has a very simple fix [1].

I've queued the GitGitGadget PR for submission, so look forward to
that soon.

Thanks!
-Stolee

[1] https://github.com/gitgitgadget/git/pull/450
