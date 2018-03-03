Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D51A1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965230AbeCCCyr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:54:47 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:47070 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965220AbeCCCyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:54:46 -0500
Received: by mail-oi0-f48.google.com with SMTP id x12so8440315oie.13
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z/sXqsLfCugUtYVE10HWjho6TVpiOYaN5tMoCRBQIck=;
        b=lyqKbNKRWn8B+m0Q0OjtWoYWBlZTmHvzEwWL1s53dTXTKuhe7IPPFXUrRneQoSmkf2
         6g6gEh5CbP1W3Xsx+kb4BBTGBlyhqtf0UBb64hW7eU2SeGgNNFeI0Zh42vp1w8+lN4qy
         QSceMU+cQsdEzafaUIge/xSRCjp5mniZP/xzUBwezpFek997ZGbJrUcAVEUur/i1gHAu
         1q3JZGy9mrOHVr91wVzadIgFiPsUoamvCnwtOkElablgzMVsXaA8uQQ/exxFCGj77iBS
         9xQI9418LW8g/RDwoWD5nYf+BclWGJTpihL8ch9YYv/L/cpkbTQ6hOVtTVkiKUl8YYcp
         uW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z/sXqsLfCugUtYVE10HWjho6TVpiOYaN5tMoCRBQIck=;
        b=Kj/1l2dB82F9zoYAnE9ZyGm4sH8wnb3Rkl1lkNRdl4Pjg29ZG+sMiioDeKcrCAd79f
         d9iqWYIlKCeAzgB4jcC/l6XXCfGoE55RJzYVUkLwCfZeRyksbo0MiUIkIix45CIgud0M
         DRXitwJPlDEQ/vzlB/PTSnO29xo8MWrOkoyZ7l6DmoLoGwrzZB5JIByupR30azXkg47O
         tLrI4wCzHRhFLFxViKpmJxfRd5YCAziJdBZmgWlfE+yL6USg9pGlfU20vBOIjiKSqqfN
         MPIG+w/eJDui0ECK+Ghth5oqro6NCzYp8c1LfPKIs3HPIyhepyBJXSiqaqZztGJsmNtE
         5B5A==
X-Gm-Message-State: APf1xPCNESgvdUHFS8nBQ/knzsEAyqVVgADVtzcnlG8fkbpppk90pNKe
        JAlF46baQJ1pFt7C7q6MJcCyArqp4S8mZdm7e/8=
X-Google-Smtp-Source: AG47ELuN4aqjwcKVOz/m24oBJ+mG6LqQzi/hHJVH49ziYY6FVAeeUTujX5zK2xUCyNk5lnYnBZBwVLoHFv75pngwcL8=
X-Received: by 10.202.64.85 with SMTP id n82mr5094291oia.30.1520045685903;
 Fri, 02 Mar 2018 18:54:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 18:54:15 -0800 (PST)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Mar 2018 09:54:15 +0700
Message-ID: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Feb 28, 2018 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> Looking at the full-series diff though, it makes me wonder if we
>>>> should keep prepare_packed_git() private (i.e. how we initialize the
>>>> object store, packfile included, is a private matter). How about
>>>> something like this on top?
>>>
>>> Yup, that looks cleaner.
>>
>> I agree that it looks cleaner. So we plan on just putting
>> it on top of that series?
>
> We tend to avoid "oops, that was wrong and here is a band aid on
> top" for things that are still mushy, so it would be preferrable to
> get it fixed inline, especially if there are more changes to the
> other parts of the series coming.

I agree with this. Stefan, if you're getting bored with rerolling
refactor patches, I can update this series and send out v2.
-- 
Duy
