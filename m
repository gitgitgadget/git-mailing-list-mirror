Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310F81F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbeBTTpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:45:01 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34250 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBTTpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:45:00 -0500
Received: by mail-yw0-f181.google.com with SMTP id c193so2382426ywb.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+KXAuHYnqL6OaLvpLpb60YJE9frammgeHL2V+CSTfcU=;
        b=PQQkj04utzPqX8flqRYOfKh2AHb2zN5BdE7iQUxdUeNETf0pY+2o/DL0YSsy8Bp4HO
         yFaMDq9StNk8EqnSJof8ZvvkVayPpo9NGLuWlllk4duEL9Mcm8NielDUKJK5TJWrrFE2
         vFJR7fcQENhbvAtrxgiYGXtsw0hMrAnLqNB5pUbdilk8YFY+R5pRAuWmKuRpA/kofx6U
         Q1llC0Yb09Wag1voqmKXcwEC5VLamsoESF2I+O7YeKE++svBWFIaDz0z94aYjCv43dRS
         xE6CZyn9lhCVADkMB2DiKBGf4IAe7hHsIMLbVXpfY5TkoEop0dFVj61mF3K5f2cE635/
         NkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+KXAuHYnqL6OaLvpLpb60YJE9frammgeHL2V+CSTfcU=;
        b=X9apwViAvoH9CFtUr2j0DCtsG4WWFA6AE0RU7AyUSXlZ3laZTcRVZN5sLf72jzhS4v
         cNVT6TYjXaF2E+t7YOOGSvji5fjJFnzL0A+E58AEFluzMRO0lmvoJeeyOPGGprgar89z
         Eofhj5qUSptxWFF2o4tfgyeNGcIAhL/uchB+8yWAfmb24mmg2Wf4uA4NxkrUDpElZ180
         ZXUlfl1K0dLLztQUCYQ8PnkDGIPeHY0F6uCSEMSyJMNz7snoCOsdKGQFtcHOd9bFP6bW
         NfIoqsfIXjL9PP3n5NmB04CafnP5MLtQLLeIZEvq6cIA3+eta+t8DYI26tjjJFatLGpV
         CprA==
X-Gm-Message-State: APf1xPA3nTsrF+cM+AfsD46AVnrE4GGkQWYOVnB9jhyU/aiAj70jDZA8
        vHQEWgr7j/KV737l6ZEt2yDysjS7UfSXVk2WWLzfBugw
X-Google-Smtp-Source: AH8x225NsHv6eaU5SOYMWQ4GfYpIdwvKz99KsNuUzlkEeNth0361zJi02HYdRFCR0tIyV3xQwXcG9FzoqnxlE8teWVI=
X-Received: by 10.129.73.80 with SMTP id w77mr647502ywa.421.1519155899143;
 Tue, 20 Feb 2018 11:44:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 11:44:58
 -0800 (PST)
In-Reply-To: <b4e6f89b-fc20-7244-ad23-548697f9764e@gmail.com>
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
 <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
 <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com> <b4e6f89b-fc20-7244-ad23-548697f9764e@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 11:44:58 -0800
Message-ID: <CAGZ79kZf6hm9jU2oBUsxp2X33B=_RQps0y9JOc2-j2zm1k4cDw@mail.gmail.com>
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     marmot1123 <marmot.motoki@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 11:36 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Hi,
>
> On Wednesday 21 February 2018 12:20 AM, Stefan Beller wrote:
>> Kaartic was the last to touch that file,
>> (as found via git log origin/master -- Documentation/gitsubmodules.txt),
>> sorry I did not find this in the review.
>>
>
> "Non-ASCII characters" made me dig into to this a little deeper as I
> generally don't use them particularly for text files.
>
> "git blame" points at d48034551 (submodules: overhaul documentation,
> 2017-06-22) as the offending comment.

Hah, good catch! Sorry for my assumptions there.
