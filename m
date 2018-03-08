Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F101F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeCHWHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:07:47 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:46523 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeCHWHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:07:46 -0500
Received: by mail-qk0-f181.google.com with SMTP id 130so1479024qkd.13
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6C2PzMlIQ+9y/IK325m3hIaiq3DYooqfMVL79pCRAVw=;
        b=DBrSG9u19KsrLlmzWmb5hw0bqPCmcFyr5ivgssKt29A1yVOnEA/6zcEkoSNCa0fxsk
         CYhkG4vDxlYz+TRU3Xyyev3NZz3DYzJWdysqNUMItCDkwddyfCmESnf0Mo6w3mbLe0E2
         gHGh+f4QnaqkYIZei9Nj6ZstWfQ8EFw64bDW/r6zZjMuV5gyvdkcIPMrcb3EliE+Srrn
         Id5vqo1WGKT967AM2EsVajjtGCykmAoZfngrK9wbG9nQbwYnteQKQP8iyQr6aONS9BxZ
         QlfUtdqz5lSDvQNJr4RDrJgbjeOGitNH9K3P+z9bjRDA5QUkX/9qVH/PINNXaM3GzVlr
         mnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6C2PzMlIQ+9y/IK325m3hIaiq3DYooqfMVL79pCRAVw=;
        b=HpEbZIjUvkuPgISz3UP8JDVNGy2CKh+sWFr5Cj1ceccAlOxOtVFDhcR1bZ4hhmESVL
         7TfntNlUxsYefH7fz33OwlTPv7hlTsBqGuLohMbl7iQtiSNUl+32rsb7k5rfdM53GZP6
         vlIc3VDfp6OEzz6913906IZoZt8M5bP1NBLW4iQwzlSFKF/l3RGTF/eq9qr6Hfh7hxrV
         06kD6wAU/7pwtsSib7xQtqMJNoF6I5frGNnJ4doFmfrZVzD0TcL2ntKLbCHp1vq8WD6c
         Pbhi1cpL/CDvO9TV2yhgf33sgRkGB1IVOqpaWsviAelIexO1FcpsAzCC2zbX4gbuJLDv
         d/fQ==
X-Gm-Message-State: AElRT7ECpKVew9lFn8Ma0a6pxXdnbhDDLWQ9kiSUbqOA9/ifaD3xyfK9
        /CUbKlGdgnTHZqVv43POGvfpT6WP3/ytA6iTdVI=
X-Google-Smtp-Source: AG47ELtkLhq9ipWkd0cjClT6EtvY5YDTsoxS8/LKVGR5LkgJQsJ/9lBkxydh33oVv1tODcOVWF4m3bPpfdljX6hESJ4=
X-Received: by 10.55.133.131 with SMTP id h125mr42262897qkd.79.1520546855766;
 Thu, 08 Mar 2018 14:07:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 8 Mar 2018 14:07:35 -0800 (PST)
In-Reply-To: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com> <20180308123844.15163-2-szeder.dev@gmail.com>
 <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com>
 <CAM0VKjmKcFVOLA-fFnSm=tVapa5qgUoU3Sa7RjSrqoHp5qXZiw@mail.gmail.com> <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Mar 2018 17:07:35 -0500
X-Google-Sender-Auth: 5pqR950TDI5dCVJNk3fVd47PeK4
Message-ID: <CAPig+cRA36YHu+kf3t8=zEOq6OHvgKbsHaV_mNQEKoGNpunHcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output
 of 'test_cmp'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 5:01 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Sorry for the confusion. I meant "return 1" as used elsewhere in the
> test suite[1].
> [1]: For example, the "setup" test of t4151-am-abort.sh.

Additional context: e6821d09e4 (t: fix some trivial cases of ignored
exit codes in loops, 2015-03-25)
