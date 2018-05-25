Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2941F51C
	for <e@80x24.org>; Fri, 25 May 2018 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966351AbeEYLVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 07:21:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33413 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966302AbeEYLVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 07:21:06 -0400
Received: by mail-io0-f194.google.com with SMTP id o185-v6so5996765iod.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2kMmf4U6BqQmOLLFbwwmQM/lbcyDFDwdllS9r7CdY2A=;
        b=EF8TDFJC2l8/7jni/guBwooXc6hmpn15WFZDapAMEDx79hZomXpQGAte8BCP3Ntm3e
         XkdTpzEpCa2Myuw0nZs2JJiw/kurbpIdw9iVz5S/yT0Er9ot2tS/AweMSHw+WsmQDpQM
         6bhd4IjFijGU3I/ifey22IchobOA27rLmBq9RE3s3nUr7RRYf5WPti9CrNZVwNblsD2Z
         d/IHOnRuO8zQes0QEjOtFr9Qv9FQdMQHUpT7BosL/LkcYNszMrHfn7gQ99giVmLqaikt
         Jeuq+9x+tUmVbOcjFqMIYF+380cLq9vmVr+qw9G2bNRbR61qrDuLJu+AaW0WnENCX0ru
         j2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2kMmf4U6BqQmOLLFbwwmQM/lbcyDFDwdllS9r7CdY2A=;
        b=Ii0EnjNoV7j+O5k5B8Vx3xzLPH+4nUy9p2ovKLJLjGVrK4AS9FHuGfiQgPyqaHTABx
         aODhjOUCiJhnz9uyI6/qv0k/gDydSAueBBS7AzkkwlHStoRzlkS+cALeiC4HsEFbpBoQ
         B3+obW8CrSgu1Fj80YFGpM4KiWFUslAHQdJNXVJgOuZfNcPHu7/3xo+lUVtaFnL+6jDF
         1Ut4WuMgslBSPQT4ZYro3HNmQ7SMZjx8xXVD3V8McTVHFLN55BbmiuocermBuC3wnpsg
         j7ZzpPUTOHqLLF8fQpBALdDZEzOleZsVuwSnkqGLnOSvVStEGf5HOSfUfWcJLR355bK5
         mP/w==
X-Gm-Message-State: ALKqPwdAm8a/oK6J3zfVIlWMOIHram7BN/t212anuY27ry8Sr6QGDGE3
        P3TKls9NpRCzSvileMrAKP3slsJkfeZovoyFbEc=
X-Google-Smtp-Source: ADUXVKK3MwjsBvAi5VZNw0JmclW0WZw0a+QtagOiFkJUlmfJNNILO1utKBSi3Pmu/JPSs0YaIdU6o3//ts6qlPbVOP0=
X-Received: by 2002:a6b:1604:: with SMTP id 4-v6mr1748101iow.147.1527247266120;
 Fri, 25 May 2018 04:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Fri, 25 May 2018 04:21:05
 -0700 (PDT)
In-Reply-To: <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu>
References: <20180523052517.4443-1-chriscool@tuxfamily.org> <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 May 2018 13:21:05 +0200
Message-ID: <CAP8UFD3hqQ_F0yafS6v6GWvN7zYomM-=fsZKotP9r-9Xc4qJ+g@mail.gmail.com>
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 10:48 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/23/2018 07:25 AM, Christian Couder wrote:
>>
>> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
>> index 9e782a8122..a4ebb0b65f 100755
>> --- a/t/t1401-symbolic-ref.sh
>> +++ b/t/t1401-symbolic-ref.sh
>> @@ -65,7 +65,7 @@ reset_to_sane
>>  test_expect_success 'symbolic-ref fails to delete real ref' '
>>       echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
>>       test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
>> -     test_path_is_file .git/refs/heads/foo &&
>> +     git rev-parse --verify refs/heads/foo &&
>>       test_cmp expect actual
>>  '
>>  reset_to_sane
>
> Should t1401 be considered a backend-agnostic test, or is it needed to
> ensure that symbolic refs are written correctly in the files backend?

I don't know. And I am ok to go either way. Another possibility would
be to split in two parts.
