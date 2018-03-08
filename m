Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4071F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeCHWii (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:38:38 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:38487 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHWih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:38:37 -0500
Received: by mail-vk0-f42.google.com with SMTP id s1so958563vke.5
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=STlJNWoAOXtSTOYizW+uj+kFT39DRG1PmqNpPvPKZjs=;
        b=XS63KIY2CiX7pQOn9XHKFHDCaC1yvsQNyRvnA/X9K8djZMNPAGvoCEu+n5ZhMIm+cL
         2SoM+rDA49UbGsqjJBQs4CFgnFshwh5d0//Jvuq3RxV9iOIOAqieFvQf6dOiVglOSaxc
         VHLr/DIoiFitKbJYFaDQK+ub7Jtg5nTOno1rSaGiZJWv8ZhyQw3/mQflmlxChVb8YzHv
         9+JYDKWerpjuw25MeOl3bp7FY1pOmdkbPRsPugsLvww9oK/iUIM6vAJIEkgg1Am2h0sJ
         1XlvWRsHUW+CJ2rVO49FjTInVndP35cKqwiNOrHTCTJoqDrmJ1shUiqGpAiRwaI5vUdH
         JZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=STlJNWoAOXtSTOYizW+uj+kFT39DRG1PmqNpPvPKZjs=;
        b=L3Ku34h4UWIsp3+qjnLOu3jgfw1ChawAbSQT3uHlrjaWqOhPTnFi6gNFafrn3FG6fA
         k7MTCYZjT74iU6/oypmIliMUkptf1oQ1k2tX7y5awsneMUB/j1V8CzVL29KR9uXoFSJA
         2ATUv9sA55skZ+uwJbzsCgnrBUOS8n9UX+2kOXu8FfQ3BCNL66JxL/AzVqF/zvzGEM0n
         P7gsEtijii+ilkgT194BZiuBUVvfrbo95LM8pHSq8Bhj5HCostOSA5maVldQANQlpQ05
         4npcWNom5opnktSFsfcYgZhS6Yy4Kx01dj/4kDueneVtRcZfuHJQ95sQ76/nq/aub5fo
         Bshw==
X-Gm-Message-State: APf1xPBVKTgcIdl6VVgHK7Ot/XZbQWuVzh4YseIE5RSN8AgJJbIxKQ3o
        vDi1gYnBzSn2Y6Oh/hLm3h80pZMc25B4C3bTFhc=
X-Google-Smtp-Source: AG47ELuWUOW6WncUzEi/S2u+L7WU5SkKWbiqUTiaWGBTRKb2Yc2NL2YhPrQIopYENZQrSCLGwYq8yAALAS2eZRvh1O4=
X-Received: by 10.31.223.135 with SMTP id w129mr21248567vkg.48.1520548716316;
 Thu, 08 Mar 2018 14:38:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Thu, 8 Mar 2018 14:38:35 -0800 (PST)
In-Reply-To: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com> <20180308123844.15163-2-szeder.dev@gmail.com>
 <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com>
 <CAM0VKjmKcFVOLA-fFnSm=tVapa5qgUoU3Sa7RjSrqoHp5qXZiw@mail.gmail.com> <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 8 Mar 2018 23:38:35 +0100
Message-ID: <CAM0VKjkreUoefAmmNm-OqbCO01vaceb2ehNcVj9jVF_wNoH7XA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output
 of 'test_cmp'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 11:01 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Thu, Mar 8, 2018 at 4:49 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> On Thu, Mar 8, 2018 at 7:51 PM, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>> An alternative approach used elsewhere in the test suite[1] would be
>>> simply to 'exit' if test_cmp fails:
>>>
>>>     for i in merge no-lf empty really-empty; do
>>>         GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
>>>         test_cmp $i.out ../$i || exit 1
>>>     done &&

> Sorry for the confusion. I meant "return 1" as used elsewhere in the
> test suite[1].

Oh, I see, that's indeed better.  Thanks.
