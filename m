Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042581F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbdL1Vni (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:43:38 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:42202 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbdL1Vni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:43:38 -0500
Received: by mail-qt0-f182.google.com with SMTP id g9so52516756qth.9
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OJ4++G1OPtAdjotGLfzIST4JBGXaOjdQIxcgMMS6g6U=;
        b=mnDBLP04yO3BZnIne44tlSpfahImVVGamDo55ZyePDFzmpmnDzEH9M2Ur0HqpC/m2u
         DufE6YVuq8sHAeBRfRz14OrlzKPGSQZs/UqVYK6iRskVR/6IfLewdgwaexODspkdvM0a
         WiQsuUN6lj9UhbjXk+HKrtrwDc5YdXdGeyc1sq/1aGXeJBK+6kYwIQU7p/A30A4RJkn3
         0WRmuVg0YnCMR9GAmy6Rhnv6hXxk3SQRW3Thi2kIQXKN0Byy7tfTAfXQwdNe9xpOakXz
         NutYMV/aPHt2qwHfpJoXPxxytExLJKWwAfmsaHJnSBOLJ4EHnD1nYcRSNSjA29cJA6V6
         on5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OJ4++G1OPtAdjotGLfzIST4JBGXaOjdQIxcgMMS6g6U=;
        b=FmBu5Irjzsyigl1up8u0QUs+LJEiBVj0/Kirhepxt9jsm3Wm2Gni72ONhHM7YxaQtB
         RzkCu3Gfm+1lEScjvUFAPge075282zK/OMzPvwoj/u/X4PF2l/X+AYOzBVXjX3FJNbpv
         eQeIzPhYhSDM3wA6P1Bw7nQ2s1JJ9sH4BKQi6GxfUKt5Eq4YckAfxmZXZYAt2oecgNMX
         Ieje+M6VeWFdipA3FXCDNcW00E8oH+nhTLVW/qZQB4HCRlHuGD+rUT1GD5oMfBNJCpIn
         QuiYmhATNrbsYn+tardQLWWeMS7CkQt9+9ci0XObFYV4WSx4nyFJiYpN6qy7McxchCat
         xVIQ==
X-Gm-Message-State: AKGB3mLtf2A8EA5PkS3QufBzLr2ABlsMwDFwOOO/jFCeTzD2WY5mnbH0
        KQbiWsi5VXcYRVA8KdyA18cta8U9ElWP8LcRyjVF6JnXddc=
X-Google-Smtp-Source: ACJfBouPMnLEUPVoS+4u7v99+QwF3voSM7e8beDp2f31LozFonOPC3XcNoEsYJFOIA5ixm96Nfgw77Sc+f4VeSATfu8=
X-Received: by 10.200.35.215 with SMTP id r23mr41867649qtr.174.1514497416986;
 Thu, 28 Dec 2017 13:43:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 28 Dec 2017 13:43:36 -0800 (PST)
In-Reply-To: <xmqqy3lmill0.fsf@gitster.mtv.corp.google.com>
References: <20171228000003.34539-1-sbeller@google.com> <20171228000003.34539-2-sbeller@google.com>
 <xmqqy3lmill0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Dec 2017 13:43:36 -0800
Message-ID: <CAGZ79kaB0G9zetF6QtC45+ZGLM3gOsYWV7e+gkCe2yKOhb0Ssg@mail.gmail.com>
Subject: Re: [PATCH 1/1] diffcore: add a pickaxe option to find a specific blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 1:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int parse_objfind_opt(struct diff_options *opt, const char *arg)
>> +{
>> +     struct object_id oid;
>> +
>> +     if (get_oid(arg, &oid))
>> +             return error("unable to resolve '%s'", arg);
>> +
>> +     if (!opt->objfind)
>> +             opt->objfind = xcalloc(1, sizeof(*opt->objfind));
>> +
>> +     opt->pickaxe = ""; /* trigger pickaxe */
>
> Hmmm.  This feels like an ugly hack to me.

Because it is.

$ git grep pickaxe diff.h
diff.h:94:      unsigned pickaxe_ignore_case:1;
diff.h:130:     const char *pickaxe;
diff.h:149:     int pickaxe_opts;
diff.h:361:"  --pickaxe-all\n" \

We could promote pickaxe_opts to be the important part
for pickaxing, currently we're using `pickaxe` in diff.c to
make a decision:

    if (options->pickaxe)
        diffcore_pickaxe(options);

So I think I'll cleanup the pickaxe_opts to be a real
unsigned flags field (such that pickaxe_ignore_case
could be part of it, too!) and put a new flag in
there in addition to DIFF_PICKAXE_KIND_{G, S}

> Do we declare that "git
> log -S''" never matches anything right now (if that is the case the
> I do not think there is any compatibility issues)?

Let's not go this route.


>
>> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
>> index 9476bd2108..0d0c697ae7 100644
>> --- a/diffcore-pickaxe.c
>> +++ b/diffcore-pickaxe.c
>> @@ -124,13 +124,21 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>>       mmfile_t mf1, mf2;
>>       int ret;
>>
>> -     if (!o->pickaxe[0])
>> -             return 0;
>> -
>>       /* ignore unmerged */
>>       if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
>>               return 0;
>>
>> +     if (o->objfind) {
>> +             if ((DIFF_FILE_VALID(p->one) &&
>> +                  oidset_contains(o->objfind, &p->one->oid)) ||
>> +                 (DIFF_FILE_VALID(p->two) &&
>> +                  oidset_contains(o->objfind, &p->two->oid)))
>> +                     return 1;
>> +     }
>> +
>> +     if (!o->pickaxe[0])
>> +             return 0;
>> +
>
> Very nice.  With just one place, the code covers both cases with and
> without pickaxe-all option in effect.

and this is already fixed regarding the ugly hack, too.

Thanks,
Stefan
