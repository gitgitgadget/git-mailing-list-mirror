Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0A3202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 22:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbdKWW2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 17:28:35 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35182 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdKWW2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 17:28:34 -0500
Received: by mail-vk0-f67.google.com with SMTP id n63so12569798vkf.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 14:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uU/BTA6aSeWKUvqW+bu3NgHZULcgjO/IE8FBf71PMug=;
        b=nT0YHqMUSMDhJrOPqmpftcYIcPFyfIxsNkU6w+KpHeLL0ScqRVO1L97xxw+ajxKyJf
         o7Ej8CX1fjqi5omytj3BgUWLXl7APAQKeN4PKTZdorpSRjSpanYGPlu6HXJfLPIxU1h3
         pBT6mtPPr7D/Zhm00/l0bhFEY5dKiz3t/Ts+1T3O9i4t6G8SvXScS/y/W+BDLc24p20r
         4LgLC9uzejr6Q+0++hlmW2zWeKmWL8YA2KnS4c0xL375xmZOZexvSkXjas5T1FuL+5AZ
         IP8LDXnRlQ4gapySPk6LSe3Aj9Y7K3WuisyX0K8z+0wslbGICRxtTekJlJUWhjiLwQ/h
         2VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uU/BTA6aSeWKUvqW+bu3NgHZULcgjO/IE8FBf71PMug=;
        b=n+zuzkZHkLgL8Yjk0vTQMtumAl8KqA0DI57OOgtyV1W3IM9t9s8Bscyd82DnoGRmU8
         yODiiZV7IPI8qK6DicQFhBdx0XRcR91zoIXp45E2kwtMhl5D9TMY0Q15lOLeflG4dRq/
         a0yqPKWVRDQSrZOj7q/SQORExjFm9lr2LXNdp+H/cz0K7t365zz5769P5RrzkDXezFt9
         4aHAgqd3osI/V8e4EHubh8LQ9MhS3DRE0x7GoY4bSen8ijykIhc69ZKndAXo9PODjCa4
         /eLLLwvvHtqSSDWtyvKBRyHuYPMe7/qCOVrPV1++0jmQhJLsUeXBL9hVbp9mumRe/VKb
         5/vQ==
X-Gm-Message-State: AJaThX6PYr8ZUxraxDrH88KxGz5bFkM/guZvD7kSmlINwDK3gC46Igif
        1nepTfxaEdgg3YwhGFUk2ixj/x8bjwrj52sv9VI=
X-Google-Smtp-Source: AGs4zMa69iLJIXLOARlGSTEnyhoRYhL4qm/eWmcmZseYIB+KXI0Y0uMOzDXFgzLRfL2uZsFQoEvTiqsJEjELsGF5Mus=
X-Received: by 10.31.176.133 with SMTP id z127mr18808991vke.183.1511476113873;
 Thu, 23 Nov 2017 14:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Thu, 23 Nov 2017 14:28:33 -0800 (PST)
In-Reply-To: <20171123115246.GV20681@dinwoodie.org>
References: <20171121080059.32304-1-newren@gmail.com> <20171123115246.GV20681@dinwoodie.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Nov 2017 14:28:33 -0800
Message-ID: <CABPp-BE5-MCUfUAdOBv4zYRJxqAiGdv-JGrrzQoo9SUiQwWKYA@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 3:52 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> On Tuesday 21 November 2017 at 12:00 am -0800, Elijah Newren wrote:
>> <snip>
>>
>>  merge-recursive.c                   | 1243 +++++++++++-
>>  merge-recursive.h                   |   17 +
>>  t/t3501-revert-cherry-pick.sh       |    5 +-
>>  t/t6043-merge-rename-directories.sh | 3821 +++++++++++++++++++++++++++++++++++
>>  t/t7607-merge-overwrite.sh          |    7 +-
>>  unpack-trees.c                      |    4 +-
>>  unpack-trees.h                      |    4 +
>>  7 files changed, 4985 insertions(+), 116 deletions(-)
>>  create mode 100755 t/t6043-merge-rename-directories.sh
>
> The new t6043.44 introduced in this branch is failing on my Cygwin
> system.  I can't immeditely see what's causing the failure, but I've
> copied the relevant verbose + shell tracing output below in the hope it
> makes more sense to you:

Thanks for reporting.  Unfortunately, I have been unable to locate or
create a cygwin system on which to replicate the testing.  Valgrind is
running clean for me, and I find it interesting that the output shows
it did detect the rename/rename(2to1) conflict on y/d for you, and the
index has all the right values, but somehow the 'test ! -f y/d' line
isn't passing for you.

Out of curiosity:
  * What is in the y/ directory in that test?  (That is, the y/
directory within the 7b/ directory)
  * What are the full contents of the 'out' file?  (again, within the
7b/ directory)
  * What commit have you actually built and run with (maybe I'm trying
with something slightly different?)
