Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7578920209
	for <e@80x24.org>; Fri, 30 Jun 2017 08:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdF3IWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 04:22:22 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35079 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdF3IWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 04:22:21 -0400
Received: by mail-qk0-f179.google.com with SMTP id 16so95434812qkg.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+sjpuLMzGRvjRgz9YT3qQgtcD6mGIT3MMCHVRX1clgc=;
        b=QW3S00NBVSl5qiRGibmQhgaY65ldRMHn7AunvCPMGfWoEkRM/ZBrEwgNkA9hxIBvnD
         wOGjvUXkATGnIvEzxwOiHgGyaZSugWlu9hmNmuQ4EpKQ/5KfxRCPxgiIMCghD5TTe3AQ
         a/6ClYrCcbaA7M10mh5ppYnKrK6ye3JNzOA28FXLUd3VNrmEPSPJDHOAbxuw3QNdpll2
         SSv7PtcyxovP9cHYoAWzaoGpUMbMCZTb0pkJon8lI0iTsDMqno2ZXo6OzR6P7BUK3z1R
         QG9XT4RrcusP2DzHUqGxjGC/L4CW4dY7NUzJwDev41zfoHiHDb4Kr7XHxLtiTq5uktBy
         9ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+sjpuLMzGRvjRgz9YT3qQgtcD6mGIT3MMCHVRX1clgc=;
        b=skzYB85P1Mhof149yv98wdVod9vR/jLLjDzsLowp9iBCsY2ZcnXREP8axrKPaBCyJ9
         JsAbV2OY5QTyqAlIIGgXqh0wTmbtA6yllb9ZbySzSVRtKELdhBXWBCaVNsiO25ILoHzL
         oF6aVZNG/XQKrRsHNOSCntIZ2nLpgJOQctZTGPMIzvvHjtUDXOGWeCnw2R491BvWQxib
         vCpVV54Ilxc/iargNqcaGvf87w6zCpVWf4Bnko/mJGiaDcydIy8xScvlPVfF5qy3cKft
         i6T+XFNeC/fzIa+gfytWGrItOgweog/0l8KQKTt08pa3YJebG+bzmMFspAM+Ra5hkjcR
         DKEw==
X-Gm-Message-State: AKS2vOzeJegZKcOXe2Bx51NWwlsAurDswWP+LGJgrL3ZNtRrJ2eaylWV
        Szv9ZRxIml3VaHcl4DTGUrT2y+MPUw==
X-Received: by 10.55.22.88 with SMTP id g85mr22995408qkh.131.1498810940367;
 Fri, 30 Jun 2017 01:22:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Fri, 30 Jun 2017 01:22:19 -0700 (PDT)
In-Reply-To: <CAE5ih7-go9PampG3Ltbx2-vYUezbN4QDHEVEHwpfXkpvUfLCaQ@mail.gmail.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
 <20170627191704.4446-1-miguel.torroja@gmail.com> <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
 <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
 <CAKYtbVaLkt6_rFgehgSsrLzo-oO3sEVoMLBtS5XX59ymYYS7=w@mail.gmail.com>
 <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
 <CAKYtbVaZ85LAvgz4+p29Q_n7wN0s0ocnXO4LtLDzjS7pnNmZXw@mail.gmail.com> <CAE5ih7-go9PampG3Ltbx2-vYUezbN4QDHEVEHwpfXkpvUfLCaQ@mail.gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Fri, 30 Jun 2017 10:22:19 +0200
X-Google-Sender-Auth: e1FlPNZMmgBCd8a3eovNo3dS85Q
Message-ID: <CAKYtbVajVpJomKOHG5ex7ib9Mtm8z+=mvQOrR1ws6wnASt9LFw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Latest patch I sent was already the squashed version with the fix
to pass the tests.

Thanks,

On Fri, Jun 30, 2017 at 9:56 AM, Luke Diamand <luke@diamand.org> wrote:
> On 29 June 2017 at 23:41, miguel torroja <miguel.torroja@gmail.com> wrote:
>> On Thu, Jun 29, 2017 at 8:59 AM, Luke Diamand <luke@diamand.org> wrote:
>>> On 28 June 2017 at 14:14, miguel torroja <miguel.torroja@gmail.com> wrote:
>>>> Thanks Luke,
>>>>
>>>> regarding the error in t9800 (not ok 18 - unresolvable host in P4PORT
>>>> should display error), for me it's very weird too as it doesn't seem
>>>> to be related to this particular change, as the patch changes are not
>>>> exercised with that test.
>>>
>>> I had a look at this. The problem is that the old code uses
>>> p4_read_pipe_lines() which calls sys.exit() if the subprocess fails.
>>>
>>> But the new code calls p4CmdList() which has does error handling by
>>> setting "p4ExitCode" to a non-zero value in the returned dictionary.
>>>
>>> I think if you just check for that case, the test will then pass
>>
>> Thank you for debugging this,  I did as you suggested and it passed that test!
>>
>>>>
>>>> The test 21 in t9807 was precisely the new test added to test the
>>>> change (it was passing with local setup), the test log is truncated
>>>> before the output of test 21 in t9807 but I'm afraid I'm not very
>>>> familiar with Travis, so maybe I'm missing something. Is there a way
>>>> to have the full logs or they are always truncated after some number
>>>> of lines?
>>>
>>> For me, t9807 is working fine.
>>>
>>>>
>>>> I think you get an error with git diff --check because I added spaces
>>>> after a tab, but those spaces are intentional, the tabs are for the
>>>> "<<-EOF" and spaces are for the "p4 triggers" specificiation.
>>>
>>> OK.
>>>
>>
>> In the end, ,the reason t9807 was not passing was precisely the tabs
>> and spaces of the patch. the original patch had:
>> <tab><tab><spaces>....., as I explained, the tabs were supposed to be
>> ignored by "<<-EOF" and the spaces were supposed to be sent to stdin
>> of p4 triggers, but when the patch was applied to upstream the
>> <spaces> were substituted by tabs what led to a malformed  "p4
>> trigger" description. I just collapsed the description in one single
>> line and now it's passing
>>>
>>> Luke
>>
>>
>> I'm sending a new patch with the two changes I just mentioned.
>
> Looks good to me, Ack. Can we squash the two changes together?
>
> Luke
