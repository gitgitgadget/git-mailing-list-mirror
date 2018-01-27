Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC8B1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeA0Mj7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 07:39:59 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35938 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeA0Mj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 07:39:58 -0500
Received: by mail-ot0-f174.google.com with SMTP id f100so2701271otf.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aRcAdodyiJgHMbLI7lvUFBoYyHXIJk45VKAcbsfD+kE=;
        b=OaWIHOQ6xhRk9fXNp5iz6DxBHRYNE04qamawVWOtpX6GwJom0l1ZdH5Bx8a7El1wze
         JIsEpfI04rkQl1xArbUhUU03bj1hJG/16XnTpRGWoGxTD3yC8QNHTnImXjDga7wXlACC
         0MyhLJCZd6ILI4QpyoTD6JInbIisYZUu6b58yQpS3l13/+UqtgoUKWNEQ2STF0ObDQJj
         v+D/cW+wEBTYtpYiRc+YPt5P1+hH3CY/CbrpAVzBwEh211pOBfWuZloFPt5pC86achwm
         OOm+r5HZc+w6SjMcTSsoG/T1rZAVyqWG2R3x0dSg99w87YRGAxBb/JzYmDsTLaf02p96
         2Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRcAdodyiJgHMbLI7lvUFBoYyHXIJk45VKAcbsfD+kE=;
        b=RMj591k1wig7UR3eAKctPJvRFKvJo+V2B9qyUSx+JQIoVXhfkDJWJ3vs29fgk4ztwV
         jOZbkqoeXx36rS128qdZ5SuVgQFvw3tfEkAsSbIZ30Dg/7K/UCAHRZPHVfvKWpn79v/E
         nMd/z8n5ziQAGXqGyJ0ELlxhWpj4SaCAxhZ8NHYO4wMkeiIRzdpeefEFeazzwJI8IzyJ
         HZHho4mRZXaoQAzGQMWP9ZtgZLUHeB3bHkOVtKe35DbTKLFBYAzRpsADGx3MHgtFdsmF
         S6Tvs1KrV+dvuLuNeKrMvl2Uk/9cfVxieD9Pqv7AHkdHlSbsaEC6mJld6QWnJxoQjM1b
         EY0w==
X-Gm-Message-State: AKwxytepHPeVR4J1uDKGwTMwqw6xYV2NgW+B/byOCnKEv2upMP19503o
        Gj8TR1oSEJSHjP8yoMalbB8g0cD6EIgoRW4Bq9s=
X-Google-Smtp-Source: AH8x227wd4QwPMR3VPWqqFi+jbNvDInBJZXGMNiSzM8aKAddU2/XuvJgUpKjGInWn8/vSAKPXIhq0EF+OxmPGYSOc6Y=
X-Received: by 10.157.14.65 with SMTP id n1mr16515151otd.337.1517056798336;
 Sat, 27 Jan 2018 04:39:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 27 Jan 2018 04:39:27 -0800 (PST)
In-Reply-To: <87bmhfwmqa.fsf@evledraar.gmail.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com> <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Jan 2018 19:39:27 +0700
Message-ID: <CACsJy8CJtW3LZ+4Z_06uM4rJO88FXsNvcw+zzVqdFpsQUKrvrg@mail.gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 6:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> a) no fsmonitor
>
>     $ time GIT_TRACE_PERFORMANCE=3D1 ~/g/git/git-status
>     12:32:44.947651 read-cache.c:1890       performance: 0.053153609 s: r=
ead cache .git/index
>     12:32:44.967943 preload-index.c:112     performance: 0.020161093 s: p=
reload index
>     12:32:44.974217 read-cache.c:1446       performance: 0.006230611 s: r=
efresh index
>
> ...
>
> b) with fsmonitor
>
>     $ time GIT_TRACE_PERFORMANCE=3D1 ~/g/git/git-status
>     12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: r=
ead cache .git/index
>     12:34:23.838622 preload-index.c:112     performance: 0.001221197 s: p=
reload index
>     12:34:23.858723 fsmonitor.c:170         performance: 0.020059647 s: f=
smonitor process '.git/hooks/fsmonitor-watchman'
>     12:34:23.871532 read-cache.c:1446       performance: 0.032870818 s: r=
efresh index

Hmm.. why does refresh take longer with fsmonitor/watchman? With the
help from watchman, we know what files are modified. We don't need
manual stat()'ing and this line should be lower than the "no
fsmonitor" case, which is 0.006230611s.

>     12:34:23.876427 diff-lib.c:250          performance: 0.004731427 s: d=
iff-files
>     12:34:23.880669 diff-lib.c:527          performance: 0.003944422 s: d=
iff-index
>     12:34:23.899225 dir.c:2290              performance: 0.018509066 s: r=
ead directory
>     12:34:23.901914 trace.c:417             performance: 0.118250995 s: g=
it command: '/home/aearnfjord/g/git/git-status'

I don't see any "write index" line here, which is interesting since
your case c) is about "don't write index".

> c) with fsmonitor + don't write index
--=20
Duy
