Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93911F407
	for <e@80x24.org>; Mon, 11 Dec 2017 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdLKBAM (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 20:00:12 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46869 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdLKBAL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 20:00:11 -0500
Received: by mail-lf0-f66.google.com with SMTP id r143so17334790lfe.13
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 17:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1OrS6LVhFlh1bBA/5G1A8OEF9r7s9qSEaiH110VKaLs=;
        b=SkN0tjBgiI0y0rWFWRAPcI/IOislBOSiq3NKUM+irkTpwukLB6utGaZnhFBOa6zO6p
         /zWlqIFqMpSFNBoC6zXM4WnfdOQ79TaowRkOd9pf34bvQOK6ojL57Lkej/mf1rnYiwU9
         4TGJBmr+9slHWf9lTDoKdOEgwBGuQ+Zn3FfT7/25OpKArl0HeNb/2MtssSL1k91yKiw8
         pG3YueOjqaZjnPkHqInlFtNvcNgOuxFz5ZMAvGgzDxG3casna5jsAy+CjZjerU68nJPq
         WpCcAFccc1b2fT1laPXxEe0fJe0c+9gvrahQ1DZRtjoICP94a+LCTJ4Vp0cmH0BnmqRa
         QxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1OrS6LVhFlh1bBA/5G1A8OEF9r7s9qSEaiH110VKaLs=;
        b=h72tAndxjpr/V+bmAPWT3nH4lVup8M0MfUKZdJnI7Lai9bmRivQJeRe5eZZl8rkrDP
         EV60ifSoVXMvKcuXO50dYzbyhiXiPf2mqturVKGdeqbZ4fFd55O/yFzjR3Y+pRf7KlRH
         VbjqETs84KCXhEEHI2a6qBw5pdQwSheS9VJfbLG1mE2+UUqTCUFINsj9iFoY1V4pMvZW
         rfu2ZrH2k1gojD/NHzmHdhKrX2MpPCcMyAGymVmg+X55p0fzoXTbeG0KAyZmqEoK2XHF
         nEDNBgZcKc2kE5jROy47Hbr76qMJ88NAX7AyW/xmu1IyYoO7B1I/R/bjd+a6fFiVy011
         SMew==
X-Gm-Message-State: AJaThX7+gQEMEWejBDoVCaGGH251nmbrerRD5l9yHQ3C3/Aeo+Ufg3+0
        pfY3o7pKLLDTqdtU+oe0Zto=
X-Google-Smtp-Source: AGs4zMbeJEmN3Nxx6gG6EUMfqG7tJL8KZPFvc4H8gVNvKkpeAbr0bW1N9KAo5cRP+Hb9fhNTO3pV0Q==
X-Received: by 10.25.163.17 with SMTP id m17mr17268838lfe.88.1512954010180;
        Sun, 10 Dec 2017 17:00:10 -0800 (PST)
Received: from [192.168.0.102] ([46.98.114.168])
        by smtp.gmail.com with ESMTPSA id i18sm2568160ljd.27.2017.12.10.17.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Dec 2017 17:00:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way
 merge,noworking tree file changes)
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
In-Reply-To: <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
Date:   Mon, 11 Dec 2017 03:00:07 +0200
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <EC2DA0F0-7DA2-412B-AB9E-5F8B0CD12F57@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
 <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
 <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
 <4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net>
 <da74fb2c-c452-4716-91d2-182f945b4254@gmail.com>
 <82da4317-6b50-f60d-6d8f-50fc47579c56@talktalk.net>
To:     phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 10, 2017, at 14:22, Phillip Wood wrote:
> 
> I've found conflicts arising from moving fixups can be quite common, so
> these days I tend to edit the commit to be fixed up directly. I have a
> script git-amend that does something like
> 
> target=$(git rev-parse --verify "$1") && GIT_SEQUENCE_EDITOR="sed -i
> s/^pick $target/edit $target/" rebase -ik $target^
> 
> so I can just type 'git amend <commit>' to make this easier

Hm... I just realized that using "edit" command during interactive rebase
should probably be the same as the strategy with a temporary branch and
rebase --onto I described earlier. I should fix my habits, I guess.
