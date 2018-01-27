Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE851F404
	for <e@80x24.org>; Sat, 27 Jan 2018 01:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeA0Bgv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 20:36:51 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:41015 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeA0Bgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 20:36:50 -0500
Received: by mail-ot0-f174.google.com with SMTP id r23so511182ote.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 17:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3onnBbboHG6oiAHtK61dYMCgc1S1xjLSkB1+itjdq6E=;
        b=iuDQFPCwQa6MdU6NgtBM4CsTQlsa1HrlWQJGERW/MrBsRoKd/3Nvz3WKTtFNeiZGbq
         2S4lrvh9+Qro67umk5uM/wi6/uBCKGv/HYizi/+fSUkkGfMW/6JhZwtrqQDdqt9NtUAn
         OQb9tcJFeYMpRfsC6BvymJ6eZPdBwpZz/FX5Pi/yKxxCs7qpHxBSsueWUly8c3+hTpEa
         yF2VhONLY4sEH6gtFOFSDFFL/YE3Lrfvv9OOelMPtVvK+4u0oTw7Tfkbw0Ss7YMBypod
         oV3u1Xx1lEWXqdV38e66wv62uYqvhywg/ZvSXJHPDXYWp/oiN1yfiuW/uJPcsODFIJ1t
         T4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3onnBbboHG6oiAHtK61dYMCgc1S1xjLSkB1+itjdq6E=;
        b=MKw/DFW2pFwu8LjcEhmYYFaj7m6yrHBFsLh18jLL7N8DjT3MFyXnFLGsD0zZ4mRj6p
         aWoJv4tYjM2/AnzoLXURAe51I1WW5XaqjZoc7FgeDiUlrHQfeOGA/IwfvpHhj2Geaizb
         NO5XWs5F75gGvSc1gYEs8/olQl/9u3+ei9UghV37vbqaGNPZmhsddmyl2yta8KIlaLdp
         HaGOCRpoolCozhcRRYHwStPWP/Uz/7sL61Y2Bi/yd62WAuD/B/LgaKm7XDne4heVP51H
         3Eyx2pIF6Nvt4ubHNjtRwu9udEZF/YBOofo65dt/PSOFUo8nNQvq0BBPeVSte2fGV154
         df3w==
X-Gm-Message-State: AKwxytfbe4TIYvbuKm2KhiXtpGV6MtyC4GTZpocb60Rp8Sqho1LKXpOO
        37ulOSJXnrv0lo7+4rqGeB410By9ZHCM5ggD//I=
X-Google-Smtp-Source: AH8x224OqlIIOSiDc8Tom3e7wv5tC0wBdWicIyHBmccFlTz6nwzV9NZDkmgLLe30V8XHosh697pOgMRU4uuKdTRWF2A=
X-Received: by 10.157.87.133 with SMTP id q5mr17091611oth.106.1517017009838;
 Fri, 26 Jan 2018 17:36:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.8.133 with HTTP; Fri, 26 Jan 2018 17:36:19 -0800 (PST)
In-Reply-To: <87efmcw3fa.fsf@evledraar.gmail.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Jan 2018 08:36:19 +0700
Message-ID: <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
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

On Sat, Jan 27, 2018 at 7:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> 3) A lot of time spend reading the index (or something..)

I'm resending a patch from my old index-helper series. It should
measure all big time consuming blocks in git. Maybe we should get it
merged...

> While the hook itself takes ~20ms (and watchman itself 1/4 of that)
> status as a whole takes much longer. gprof reveals:
>
>     Each sample counts as 0.01 seconds.
>       %   cumulative   self              self     total
>      time   seconds   seconds    calls  ms/call  ms/call  name
>      15.38      0.02     0.02   221690     0.00     0.00  memihash

This sounds like name-hash to me.

>      15.38      0.04     0.02   221689     0.00     0.00  create_from_dis=
k
>       7.69      0.05     0.01  2216897     0.00     0.00  git_bswap32
>       7.69      0.06     0.01   222661     0.00     0.00  ce_path_match
>       7.69      0.07     0.01   221769     0.00     0.00  hashmap_add
>       7.69      0.08     0.01    39941     0.00     0.00  prep_exclude
>       7.69      0.09     0.01    39940     0.00     0.00  strbuf_addch
>       7.69      0.10     0.01        1    10.00    10.00  read_one
>       7.69      0.11     0.01        1    10.00    10.00  refresh_index
>       7.69      0.12     0.01        1    10.00    10.00  tweak_fsmonitor
>       7.69      0.13     0.01                             preload_thread
>
> The index is 24M in this case, I guess it's unpacking it, but I wonder
> if this couldn't be much faster if we saved away the result of the last
> "status" in something that's quick to access, and then if nothing

No we could do better, we could cache parsed index content so
everybody benefits. I demonstrated it with my "index v254" patch a
while back:

https://public-inbox.org/git/1399980019-8706-1-git-send-email-pclouds@gmail=
.com/

With the patch I'm sending soon, we can see how much time reading an
index take out of that ~140-150ms (and we probably can cut down index
read time to like 10-20% when cached).

> changed we just report that, and no need to re-write the index (or just
> write the "it was clean at this time" part).

Hmm.. does an index write increase that much time?
--=20
Duy
