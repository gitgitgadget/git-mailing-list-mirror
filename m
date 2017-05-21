Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC30201A7
	for <e@80x24.org>; Sun, 21 May 2017 06:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbdEUGYU (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 02:24:20 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38469 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdEUGYT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 02:24:19 -0400
Received: by mail-it0-f54.google.com with SMTP id r63so8893559itc.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1tNuSeJAGxjVI8+0sEwpWb99jfA8GEQIACvF+biJ2mA=;
        b=BtPs5IFIg1b3xIxXEEmY5CUVdUHrhYj9unMtuT4E+G6sC/8XgLyGMjgRy4hLtzJLos
         HBE5eh6siGH2nq/MkWH9CrWeZ1ccRqxcYADOKTHga/zn/2LIff3UWxIiE/qEYNeF4Ws1
         5kf5p9Vqkrg+dnvf/GjbBnaHOQqNpBj/BofNWUSUT+JdjN+TL78eLKhmC5FLQzbK5UAb
         C0f/Q1kgcEez8yUK/TsyJM8hj8HrUlATogNMBkdP1f0kT4w2sSUFuJZMs2DHF4U45L2d
         crIORDksZ7s/GlhLKXoI9dyGe9jtLuuOUQIraqagDbMYq6c42UVIy2WXUTcikz9QPybe
         nq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1tNuSeJAGxjVI8+0sEwpWb99jfA8GEQIACvF+biJ2mA=;
        b=S17NY8iDZjvFNEJHVu2dKFRLUv8lYP/hxA6HCH63BHNDGb+5mFgNSDhzPOxl/K8MQA
         YPZjRoREieasCMtR79kvQnVpzBaeo0JZfOMQmsfNZ8GZf+ecAsDuFkgUtoeRUXmZTiCz
         nj7HzjsolhNNWozHey86iHLnA5oXz1cRUkYiCyWxpaFQhwvri8VSz2tFtlGcb0V3mv+y
         KuqsFQp9R7zeeu3NcfqnQ9Nm2C5sUsWcZHaXe+dE2Ih4HH3vRiq1ODKyzPdZVPA3m9ua
         SwjbiuPKezt78CVFq+m0Luo1QWsmkta0NrfAfCp+lLHpIGHg446rYX6UQRImWr1xBVlf
         ia/g==
X-Gm-Message-State: AODbwcDqlgjSWUqzd+3RClppTMvXpkZAVjogbY70x0ieZVjOCiZ5A+5n
        MJhxVcWQBFKt3G8sVOWr/bJJTVla+1U9
X-Received: by 10.36.89.207 with SMTP id p198mr34255284itb.71.1495347858227;
 Sat, 20 May 2017 23:24:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 20 May 2017 23:23:57 -0700 (PDT)
In-Reply-To: <xmqqefvjqe9f.fsf@gitster.mtv.corp.google.com>
References: <20170520214233.7183-1-avarab@gmail.com> <20170520214233.7183-16-avarab@gmail.com>
 <xmqqefvjqe9f.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 21 May 2017 08:23:57 +0200
Message-ID: <CACBZZX5mmhQzhJPbE0wwXY8T6+i7NynmdBFXr6Ym1U=6tCtPwQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/30] perf: add a GIT_PERF_MAKE_COMMAND for when
 *_MAKE_OPTS won't do
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/t/perf/README b/t/perf/README
>> index 49ea4349be..b3d95042a8 100644
>> --- a/t/perf/README
>> +++ b/t/perf/README
>> @@ -60,8 +60,23 @@ You can set the following variables (also in your con=
fig.mak):
>>
>>      GIT_PERF_MAKE_OPTS
>>       Options to use when automatically building a git tree for
>> -     performance testing.  E.g., -j6 would be useful.
>> -
>> +...
>> +     any of that, that's an implementation detail that might change
>> +     in the future.
>> +
>
> I'll remove the trailing whitespace on this otherwise blank line
> while queuing (no need to resend only to fix this one).
>
> Thanks.

Thanks, forgot about diff --check on the whole series with all the
other checks I was doing.

>>      GIT_PERF_REPO
>>      GIT_PERF_LARGE_REPO
>>       Repositories to copy for the performance tests.  The normal
>> diff --git a/t/perf/run b/t/perf/run
>> index c788d713ae..b61024a830 100755
>> --- a/t/perf/run
>> +++ b/t/perf/run
>> @@ -37,8 +37,15 @@ build_git_rev () {
>>                       cp "../../$config" "build/$rev/"
>>               fi
>>       done
>> -     (cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
>> -     die "failed to build revision '$mydir'"
>> +     (
>> +             cd build/$rev &&
>> +             if test -n "$GIT_PERF_MAKE_COMMAND"
>> +             then
>> +                     sh -c "$GIT_PERF_MAKE_COMMAND"
>> +             else
>> +                     make $GIT_PERF_MAKE_OPTS
>> +             fi
>> +     ) || die "failed to build revision '$mydir'"
>>  }
>>
>>  run_dirs_helper () {
