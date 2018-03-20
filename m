Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6715C1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeCTTMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 15:12:37 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:42614 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTTMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 15:12:36 -0400
Received: by mail-ot0-f179.google.com with SMTP id v23-v6so2987637oth.9
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qVuYUZuDlzRMlb2zDnYrAAPukfY92ny6bVsSigtZ0XQ=;
        b=iII5lZgrFEui+WgRW/C7NJst2FWuhd7qDVwP4jYOKqthoTLsUg791ogNiGums/SdxJ
         k43XFUw3ipG5yLOrQe+A44acCS40ML5poUooNmPtbpluTQy23VeLBaytZgWF+X+Opa+7
         EkXgavfgLjWogdq/j5SazPG+xTnUKa8nzTIGcMgqlArppep3hgedkTxK/hFuuqkvHVBU
         vwJ1EYiPEDpvoLpRWA7V7z5LG0v/NX2t3DgHkG0Kiin8RDajYsWlccTS0TDf56bKvjdW
         38x9MyO9fljJif3RuPqqjc4/fFVPUm4SjRdZvCQYPmgRAk0CSzmpS0G/quQMe+/giNn/
         WUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qVuYUZuDlzRMlb2zDnYrAAPukfY92ny6bVsSigtZ0XQ=;
        b=E7Xz9mNdadPpm44Bkuis0yW1V618G5wdHIB4qCZicojGO7rjbRmGdLCzy2FZ7DPWxh
         lL9FKRjx12jah2b6oHHAd0DWiORIr2R1UrLyict1qbdngeONJljw/PEgsLgbKDVHg0MA
         zMgUhUQwIQ9At0x1V5pFRhKohZaydKJC7dpe6mV/hYj+xOGqM8zzo7AngaYlKTcXYGww
         6pSTH/XM1O5k2HzuyWiUzfbj5/ByR8QK3hqCNJ6mVAp/Y8AisxOy3XcYyP1eX8bBFDl3
         kqRkRbUtBzw5Tge2fAx2wDM3FlZCOnZ6ZtXibWAqYDwQDC1zVjVJZ3p3cs5gdZ8OylZA
         7IEA==
X-Gm-Message-State: AElRT7E3gQL+6F2fg/P3WkStvy8FcTw2cNsykecpaI0nZkm+3pMVBi0y
        W+U/yeeZDsGj2jU5f+2ZGoVA6duC87nssvmi2iI=
X-Google-Smtp-Source: AG47ELt85lKvH60qKshLb/Vh1kIUGzOCph9plzzzBj47PRWSc3giELYSguEMCDZRhKq2nqGZCl5AtJLDb3rNNp2pCnU=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr11827806otq.75.1521573155856;
 Tue, 20 Mar 2018 12:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Tue, 20 Mar 2018 12:12:05 -0700 (PDT)
In-Reply-To: <751c0493-435c-4a98-4d1c-e3d6677c62d8@arlut.utexas.edu>
References: <f301d093-af93-016b-79b9-3102475260cf@arlut.utexas.edu>
 <CACsJy8ABgZy=eJ7niUysb2XZ3qUr3J+jmh_5YWZ1ZDiFCrb0tA@mail.gmail.com> <751c0493-435c-4a98-4d1c-e3d6677c62d8@arlut.utexas.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Mar 2018 20:12:05 +0100
Message-ID: <CACsJy8ChV5sXV7N0+N0y9ehO56UCJ8fuqjFbHbbnez35P5af4g@mail.gmail.com>
Subject: Re: Understanding Binary Deltas within Packfile
To:     Luke Robison <robison@arlut.utexas.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 7:34 PM, Luke Robison <robison@arlut.utexas.edu> wrote:
> On 3/20/2018 11:03 AM, Duy Nguyen wrote:
>>
>> On Tue, Mar 20, 2018 at 4:43 PM, Luke Robison <robison@arlut.utexas.edu>
>> wrote:
>>>
>>> Is there any documentation of the contents of the binary delta datain a
>>> packfile, and how to interpret them?  I found
>>>
>>> https://github.com/git/git/blob/master/Documentation/technical/pack-format.txt
>>> documenting the packfile itself, but the "compressed delta data" seems
>>> largely undocumented.  The source code of
>>> https://github.com/git/git/blob/master/diff-delta.c is pretty dense.
>>
>> The output is consumed by patch_delta()  in patch-delta.c if I'm not
>> mistaken. This function is less than 100 lines, probably much easier
>> to see the delta format.
>
> Thank you, that was much easier to read, and I've got my prototype working
> now.  I also found this site to be quite helpful:
> http://stefan.saasen.me/articles/git-clone-in-haskell-from-the-bottom-up/#delta_encoding

By the way, I forgot to add, if you want to improve pack-format.txt
(since you study it anyway), patches are always welcome.
-- 
Duy
