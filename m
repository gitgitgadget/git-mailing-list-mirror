Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D6720373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbdCMV3x (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:29:53 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:33409 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdCMV3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:29:50 -0400
Received: by mail-it0-f46.google.com with SMTP id w124so8513701itb.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5UFyF2qCQwvh6sA5EtD6g67Fc9KuItVXWgWMAG9LS8c=;
        b=b/+5ouGEhd854Td5U3TuDn5v7m5OwimdGmBgj9o2tSOZjJGzJXLkPX+CgYdrFu5pPs
         FEFY3dgfZjhomQsCQHsaKP48PUPGjeKBQLmULYH1kRqHAY46M7oueJvcqTCZbH/JVFyh
         g5XF6UFf8NDPFqCBGWKREtEj8U0fiPmG6h1ZI8Pg7+G49ew3qwzHJIJz+WKswrSzGWT4
         jN7vN9haZgZiOD5UyNN3rtFmZjNdVy/GWvMuucfe8wxC3fJ3b/sff3sExiJ6W9bCQZhW
         q53N/Cn9GAuWrjdvVqWON6uBYT/z65CmmVOvFXgqh0oRgtJoSlAyn65m/vSKDQn03bqN
         6SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5UFyF2qCQwvh6sA5EtD6g67Fc9KuItVXWgWMAG9LS8c=;
        b=llwYxnObLMPWlQehKHlgEq1adjZPYCrnPTWLHFX10FnhTh4mYkcxm/VY1WDPdCz4RY
         BhW5yL81DcADbzndQMcldvVtGocuI6DVU2QVaHBvlFmwJRpzB/dF0hjXzdcakJLu3Uwq
         nZdRTDSbd6T9woV0j6cb3Yr4WxE0ywZix+7AO7tCddKN/uMJAiiEqow9pdZvhI1u1iv3
         8KsHrm9UrzwkvUY2WTMvW3YGASSzxf1lBf+zzPg8XvWR56DM7DbJSwhaVSvjOCwCQOUi
         IOMrP+xCSNR29/DZeH0cdrV0ay2t1oc6ezmMEdwcKXJjgyBuy/OXspjuC7BwBrCfKVIb
         cOsg==
X-Gm-Message-State: AFeK/H2k4MJ3cLUdBN8nBimtDPpUHWzELKX+JFu1OXTynlKkYy+Kpdlhkzjgayor6oY81Wuuz8xMxWOvRrijVQ==
X-Received: by 10.36.169.69 with SMTP id x5mr11942415iti.37.1489440588788;
 Mon, 13 Mar 2017 14:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.19.75 with HTTP; Mon, 13 Mar 2017 14:29:28 -0700 (PDT)
In-Reply-To: <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
References: <20170313201104.GA32821@workstation> <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 13 Mar 2017 14:29:28 -0700
X-Google-Sender-Auth: R0s4rnnESuktj3Uw_rp-ZfNJ4Ts
Message-ID: <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
Subject: Re: Possible git blame bug?
To:     Domagoj Stolfa <domagoj.stolfa@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Domagoj Stolfa <domagoj.stolfa@gmail.com> writes:
>
>> The question is whether this is a bug or not, as --since=<year> might not be a
>> valid filter.
>
> I do not think blame ever was designed to work with --since, so that
> is indeed the case.

Actually, I do see that we had a cut-off based on rev->max_age since we
introduced it at cee7f245 ("git-pickaxe: blame rewritten.", 2006-10-19).

I do not know offhand if --since=2000 _means_ --since=2000-01-01 or something
completely different, though.
