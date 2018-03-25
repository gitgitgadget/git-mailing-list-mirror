Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759C41F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeCYSrf (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:47:35 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45945 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeCYSre (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:47:34 -0400
Received: by mail-qk0-f196.google.com with SMTP id s9so17951549qke.12
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=inDmZO/N1FoSVeaS5zGbm6IYKJu6qrHzboLDWW+ngk0=;
        b=DeKda4bSHtzuDvjB6El23OHPWIq+/AnLoy8MY294x/m+zzXkQ+yqB5DYjz7KZ5TBbx
         KluRpgACzBINfZBKsUlLCrlT/lhDTtO91nnEtxgSnK+RLBX/JHM65EpRZgt1oVx4QEbV
         K46k0OCXxEgZuWWyn4jwrYCTiHAYaqbM+cbpHw/xn78ie1/FS8n37STzgYmwYFbopt+k
         D9NohbqMcHLVs+4nT39soYwshEp0No3dLMR6g+BUe/ZmZYqRoa8fZs6VVlDvFlfP5NHU
         R4HuPOAxq9TYnfVaL5cyRL9bPDLX/dlkpVBqyrzN7faXISKr7xQgCZmYHuiYae7uPC1I
         QuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=inDmZO/N1FoSVeaS5zGbm6IYKJu6qrHzboLDWW+ngk0=;
        b=kwoRRFzsPx5x0rmZkJnZQ97R+rBpkk7k/pzlTvwbN+WRZajPn0pkZQdcGijdOrqxPy
         TI57lJXFzrjDy5AshAnM0gjDqKsfGlUU/QdTEfZd5dHKucXXLRmv04nGZ1n+Eu6an9x2
         U2s/dLtGngRAV5GIDJDvwkq1RWP8wh7e2wtGQYNMC2pth4Myrn00PXx64W83jxYl3bUp
         gcZZ7diu0Vc4Sn2em4R1iZZgdGKkZ8S6sSYNmms6aspu9pRvnZ28trNR0sFl4dz+B3vD
         51erBAcwLg1Pu4zdsJHePoyeA2Kaw4g42Wn5y1raRuIRVNyi8VIa3Qc05p0wXSZwAnlx
         D7Mw==
X-Gm-Message-State: AElRT7Glody3DozhD5tHEni2aI+7by+TMm/DXTNSVNAvI6FNwmZyEKdH
        h//66qP00rRSE5QXulk78rs=
X-Google-Smtp-Source: AG47ELtfxi2pBOmCU4t6nbaZJgJaXX0+cUjPqdxrt5pi4JRfVn07DwuiRVEar9klC/4F6hPJE2pqBA==
X-Received: by 10.55.115.67 with SMTP id o64mr50916849qkc.144.1522003654158;
        Sun, 25 Mar 2018 11:47:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p54sm10606181qtj.29.2018.03.25.11.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:47:33 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Takuto Ikuta <tikuta@chromium.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
 <87k1u2y8pg.fsf@evledraar.gmail.com>
 <e2d0a2e2-44a1-9aa6-9c52-e341b44c18f4@gmail.com>
 <87a7uwxai4.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c3d41848-f15d-99af-22fb-d6de2859bd93@gmail.com>
Date:   Sun, 25 Mar 2018 14:47:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87a7uwxai4.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2018 2:42 PM, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Mar 25 2018, Derrick Stolee wrote:
>
>> On 3/23/2018 1:59 PM, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Mar 21 2018, Junio C. Hamano wrote:
>>>
>>>> A release candidate Git v2.17.0-rc1 is now available for testing
>>>> at the usual places.  It is comprised of 493 non-merge commits
>>>> since v2.16.0, contributed by 62 people, 19 of which are new faces.
>>> I have this deployed on some tens of K machines who all use git in one
>>> way or another (from automated pulls, to users interactively), and rc0
>>> before that, with a few patches on top from me + Takato + Duy + Derrick
>>> since rc0 was released (and since today based on top of rc1). No issues
>>> so far.
>>>
>>> The specific in-house version I have is at:
>>> https://github.com/git/git/compare/v2.17.0-rc1...bookingcom:booking-git-v2018-03-23-1
>> Thanks for testing the commit-graph feature, Ævar! I'm guessing you
>> have some mechanisms to ensure the 'git commit-graph write' command is
>> run on these machines and 'core.commitGraph' is set to true in the
>> config? I would love to hear how this benefits your org.
> I haven't deployed any actual use of it at a wider scale, but I've done
> some ad-hoc benchmarking with our internal version which has your
> patches, and the results are very promising so far on the isolated test
> cases where it helps (that you know about, e.g. rev-list --all).
>
> So sorry, I don't have any meaningful testing of this, I just wanted an
> easy way to ad-hoc test it & make sure it doesn't break other stuff for
> now.
>
> I also threw out most of the manual git maintenance stuff we had and
> just rely on gc --auto now, so as soon as you have something to
> integrate with that, along with those perf changes Peff suggested I'm
> much more likely to play with it in some real way.

Thanks. Integration with 'gc --auto' is a high priority for me after the 
patch lands.

The version on GitHub [1] is slightly ahead of v6 as I wait to reroll on 
v2.17.0. It includes Peff's improvements to inspecting pack-indexes [2].

[1] https://github.com/derrickstolee/git/pull/2
[2] 
https://github.com/derrickstolee/git/pull/2/commits/cb86817ee5c5127b32c93a22ef130f0db6207970
