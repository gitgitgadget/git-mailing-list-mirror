Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18211F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDSUWh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:22:37 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43366 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDSUWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:22:36 -0400
Received: by mail-vk0-f67.google.com with SMTP id v134so3962458vkd.10
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k6tNxVuWw3Iblar9ny6rT/J+pNfJhK30kI/z3RFSMSA=;
        b=DNTMRC/HYQDiOq1M+9MtEzMpFMd+HdfmHPXks4TqkZwxDB8+cOqYBWdtTgN+DCkeHo
         WwXwl6a9eHkwhnUyIZGHum47zI3BhXBxR68Hr8JX144e4YwHBO2icEaiQaqf5DVGFUg3
         Aa3CGIiu3YC/ljAn6Jx+G/vgwD9rCKS6CId7/5dcSNzW74NidwRkgVlvt0c9xdMfx27x
         spZEmuimUEwiBriUTibNrkxXG57VrhM7EF3hwep5KOeDELqB9pxDCIGsu36X0PL3MfF6
         B8EUKoMA5rpgt/nOnHF8GCSpOBg7L30T2jnx4GLV5O6RDSi1+TNfLDGwjPdKqtNT1M1y
         CraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k6tNxVuWw3Iblar9ny6rT/J+pNfJhK30kI/z3RFSMSA=;
        b=SVBEqc0xIr5yjjCkkCCtEVmDXbmXjvlnW8hZgodiv/VFOevn1WwOwyu2UKazC958/0
         1yvwLXEnuu2mOZUn7KUbRhvgk40f/YVtRzNK0FZy75a5Exv/Eju037N2pMRwQp0ix1LY
         TjZduWurowux9TY7HVkbU7AVkGyu8NWp+HlOAPBfyWSxbqMaA8n2xiKp3H5YZDPOX7YA
         mrboliUrx9Jni/US6E655HgjNjVbKjBKFgfPXIBls42h2XwTbDEF46ZPJ2aGSUC8Pvst
         c0bj0ILu7/WLhLdbwtzbH7E4xEFk/g0mqdWS267E1C6/dosjU6RqLroygC/jwkiaZzLx
         c9gg==
X-Gm-Message-State: ALQs6tDYyq3NK7PfqfTnujfI2pxeJ2ysRgXgYGRky/b+4CvSCcezNDVl
        Le8T0D03EEtIwvvLg7rkNbqs9ZFdNjBfBHKYMUo=
X-Google-Smtp-Source: AIpwx48dp9LOjGtPeov57PBJFswqdr3SVGTfoIEPqVUwat2MiqAaNUwebfve3oLOVKeH3rHGfNU9qXKZhyw6d8mOeKc=
X-Received: by 10.31.193.85 with SMTP id r82mr5405572vkf.76.1524169355736;
 Thu, 19 Apr 2018 13:22:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 13:22:34 -0700 (PDT)
In-Reply-To: <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 13:22:34 -0700
Message-ID: <CABPp-BFFLHwdgrcg0K=j2Q_oGhQPwVdRJf72zbxB_5U2aAqgoQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 11:35 AM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
>> This series is a reboot of the directory rename detection series that was
>> merged to master and then reverted due to the final patch having a buggy
>> can-skip-update check, as noted at
>>   https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>> This series based on top of master.
>
> ...and merges cleanly to next but apparently has some minor conflicts
> with both ds/lazy-load-trees and ps/test-chmtime-get from pu.
>
> What's the preferred way to resolve this?  Rebase and resubmit my
> series on pu, or something else?

Sorry, user error; there are no conflicts with my series.

(I accidentally included Junio's interim round of my own series and
while trying to spot problems I saw commits from these other series
touching relevant files in what looked like nearby areas.  Directly
merging with these other two series or even merging all of pu before
en/rename-directory-detection-reboot followed by individually merging
later series has no conflicts with any of my changes.)
