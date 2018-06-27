Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C961F516
	for <e@80x24.org>; Wed, 27 Jun 2018 14:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeF0OzC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 10:55:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42975 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeF0OzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 10:55:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so2359756wrs.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1H6kB+HM6yWsSuh89QPk9hduX67Ol0z2MeVdazrFjE=;
        b=N2TFuMYuKGaJNJdIR+XfNbHoSgCwkOu6SNAXy1OYqiVzifcMlfE8RlH2W1u/uifIS1
         oAQPTRPwyzqMwN5J2lsAiS8m0FzC6FvN/sg3ELNuxbpVTL3Yq/wkTrEyT3U4vv+jpJUb
         j2WaI+8Dcn3O0V6/+71xHWuVowcQeSyOwh0tl349GMzwKttvLgl8QyNjmsMjqHiF7hx2
         DS+xwHQymcTTm5MD7ODXuEftw9aylGOGyBaGYh97RQaWAyObmCbETq3z05j6E1HpYaw0
         Yosx7eOh82R02tN7Dq6Hxktted44d1a7QfirZ+GLl9fzo9kCg/2XutCMC3pKQdCuCxE1
         DnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1H6kB+HM6yWsSuh89QPk9hduX67Ol0z2MeVdazrFjE=;
        b=m/PivTd75U9XA8RPZs09969FGoqqai1+xlp1vcnNRM9z0vak+vBGUPjfEZgCBO1DKB
         hIlPrzxXrbSsXZLmPMnVBqW0ZpEU4zT9ckW9ovOgXUxpo8cKsNvtd9Y0GR5wwDsuFcHz
         s986gzzT0Enu9+nPNkBc6349rh3rO9gcO65GdXCXNyuMSAAgBgZpJHX0NKknbImB+MZ9
         /xSVSWiEkLwICbDTX6Cfok88orgqH9RqHzJItfL+RR9m6nCssQFUGnVK4M5/WL4RVLQt
         Dr9pFXJGRpCNLkiAVBwGi20xl4aFYU6ItqU5UA7kk9dcJfns4y/EKH8aAmpNT1OcTjbb
         jhDw==
X-Gm-Message-State: APt69E2QPminl+FPZheE5oHoFUPqcNZfHpswFtD+KF5FoRXFw8K03r8N
        GAhsg8jLHOaQVTYHnheQ6Ok=
X-Google-Smtp-Source: AAOMgpctprrWzMay8aRDrRCuRRYhIhVsZ0KEgqGbcdlKvGJlhIjgVjc7a/VG1YAJm8cbvxgCzV7kjg==
X-Received: by 2002:a5d:4608:: with SMTP id t8-v6mr4064317wrq.52.1530111300873;
        Wed, 27 Jun 2018 07:55:00 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.gmail.com with ESMTPSA id e74-v6sm7913839wma.44.2018.06.27.07.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:54:59 -0700 (PDT)
Subject: Re: [GSoC][PATCH v4 0/2] rebase -i: rewrite append_todo_help() in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
References: <20180607103012.22981-1-alban.gruin@gmail.com>
 <20180626161643.31152-1-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.1806262336310.21419@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8b5038e7-05c4-9824-c585-963243160897@gmail.com>
Date:   Wed, 27 Jun 2018 16:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806262336310.21419@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 26/06/2018 à 23:37, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Tue, 26 Jun 2018, Alban Gruin wrote:
> 
>> This patch rewrites append_todo_help() from shell to C. The C version
>> covers a bit more than the old shell version. To achieve that, some
>> parameters were added to rebase--helper.
>>
>> This also introduce a new source file, rebase-interactive.c.
>>
>> This is part of the effort to rewrite interactive rebase in C.
>>
>> This is based on next, as of 2018-06-26.
> 
> Out of curiosity: which commits that are not yet in `master` are required?
> 

None, actually.

Cheers,
Alban

