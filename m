Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5793A1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbdDRIpG (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 04:45:06 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34601 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbdDRIoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 04:44:07 -0400
Received: by mail-wm0-f49.google.com with SMTP id r190so8774073wme.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f/A4h3mrERgZ13BtTIsUYEK5WIF4GHI+W/N9Y/QGTMY=;
        b=gqSRERaTtkxQjfnPYQwRTEOcvjsFuIIV0M8v3LXDhh6qG6vZJezQKkE4bp4X/iyD7W
         3qvOagawjwECsGylzAJlZgy47++6QjkAAk6biGMLfaVTOj7IuK/uuNAYb79dTbq62m0W
         HjNnXvmiPp8StwPVRfT518hlKbCEg08olyWXHwcUKTFKeWDIMi1n78BjflgoMpogUS2G
         lx5HZDcDn3H6SEFXOVy2+wqrKbDekCB0COF/s60jmk4109UuN5GJsP1/KxQPdbRe1L47
         6VLBW0Txarf8e5AIDYC9140iIpl9ORyGkib3Ryj+MoIm+oUt99xuF2WiP6N9mwTfLxYB
         nm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f/A4h3mrERgZ13BtTIsUYEK5WIF4GHI+W/N9Y/QGTMY=;
        b=jMXD0xR240QImchQX7K8BW4upsXH83tkfBeE9W87mPfE4lBp1yIro2pOPfj/L90Xtt
         1p+wZv5RH38Ae01jsKqA12lX2UDfvJOTIfaeaeK20LNM1LaLAgRePcbbmSdW3s7fSjXZ
         lnDETjUkjL2MN5JxOhVFEYhpjtz+5WTaruAKhwjWL+Lr9pcwFM3PgcNH3Pz9rS0k1djZ
         e2ceIpl0lM7+d0K1J03jZndeDjJdsOS2rLRMX3/P5j3nTARQ5Lj4/fo83bI7r0Vm9UQA
         YFWxQUfq69E10Dro03XHUi0pBSz70RgdL7PhQYvscZ8tbhkj99NH6vI7i/iZBHU13zdt
         KGaQ==
X-Gm-Message-State: AN3rC/5YMhJKx6B2t5H1HKIZmwOSJiOrgz6QbaLX6yhq0v/M/cFP6WYz
        mFHNie5ZFHBnhu1//8nPsFaTJyR1kA==
X-Received: by 10.28.197.135 with SMTP id v129mr12728592wmf.55.1492505045166;
 Tue, 18 Apr 2017 01:44:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.142.26 with HTTP; Tue, 18 Apr 2017 01:44:04 -0700 (PDT)
In-Reply-To: <xmqq60i2im72.fsf@gitster.mtv.corp.google.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com> <xmqq60i2im72.fsf@gitster.mtv.corp.google.com>
From:   "Fred .Flintstone" <eldmannen@gmail.com>
Date:   Tue, 18 Apr 2017 10:44:04 +0200
Message-ID: <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well the easiest way to work with that would be JSON.
So the best would be if Git could output the data I want in JSON format.
Then it would be easy for me to work with data.

With git rev-list and git-cat file, its not so easy to reliably parse
that output.

On Tue, Apr 18, 2017 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Fred .Flintstone" <eldmannen@gmail.com> writes:
>
>> So I would either have to do:
>> git rev-list --all
>> Then iterate over each line and do git-cat-file commit <commit-id>.
>>
>> Or do:
>> git rev-list --all | git cat-file --batch
>>
>> If I do it in a batch, then it will be tricky to reliably parse since
>> I don't know when the message body ends and when the next commit
>> starts.
>>
>> JSON output would have been very handy.
>
> I am somewhat puzzled.  I thought that you were trying to come up
> with a way to produce JSON output and people are trying to help you
> by pointing out tools that you can use for that.
