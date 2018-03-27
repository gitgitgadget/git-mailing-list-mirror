Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C221F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeC0QUX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:20:23 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:44242 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeC0QUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:20:21 -0400
Received: by mail-yw0-f173.google.com with SMTP id z21so7487268ywg.11
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xITkgzbFK3CS6WVygaDZ8IVfAEYBxjn+jNwLUTr0jDg=;
        b=cleeOtsqdsUbBkRRKY/Ae2ZqCigLEyxmR2P7bGiqcP9I5pDJZ5t9AZur/nBCyJFg+p
         NKA2jKSAXCDeGScPjqzVSMujrBliqNriDt5JVok/Kdxuq03h2461pJmmG47CRQFV2YH1
         023aUDzcPNCJTzAl68aky4Vw7L1qmGrRarqDxJr5OZAr446u9uRfJGImaQEcT0E4QYbu
         6dUwCFLTP7H69PXUwUYFOg9awzS7/T8l3i/uof0EG+jswd7tiWBysLyRQCmM7IbRcPPv
         JRTcJ6rlTHZYM4KWGF2+XKyy61PRMsSd3QO3PntZpySQ5wRXshZeZvjZA7mXgQjNz+z5
         Iwag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xITkgzbFK3CS6WVygaDZ8IVfAEYBxjn+jNwLUTr0jDg=;
        b=zCTGnrWlDPQ+BkpVGYttEsYg9sTsAE1ZccC30fRGZpr929QWssCbKSfLoSG1zmqDRk
         3R8b088/NVM1GJrRG4oJdfFQe7P6iWe1OG5XJEBrMJAW//KrMdYgZ/ka7nHoDEZbCOmF
         FF2wIJPm2j+VS3NLYfiEZeW5VqCd/6id/sMES6QcwvjDKf0mjA6FLFNujBIXIHsRdjIG
         VTnbZfQBjraDNGP5p+pfXEKgHbFWzztMgU6fKeaURTR+58nm4NorDpoHfIVkZar2hTZs
         UTVrVoJFEZv7jEHVEHwbnRdM4CmfiJWb/yqfy8kkk1BuXMJzsViUSpkKYHcy67LZzmiv
         FxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xITkgzbFK3CS6WVygaDZ8IVfAEYBxjn+jNwLUTr0jDg=;
        b=Py6Uwh+AvBz/3+c/iHuHHJh+LkEUP8bY0bgTj6BUhshVwkcC7+XgoCShFCSoi7HWkH
         1NpQ4E/sm5zQt1YkwVYn0EwsFDrcEl4cnipe7FWfJBMkIrNKmqX4xSdCqR57t+ABNoX9
         RsOJGlpQG5kO45baoUuT/3ycmvgg3Nk2byqGYUt6dQtCzwFCPY5Jz3vl82YClHSq3iTh
         nZWkUoTvkK3tul0Kq34DIq+8QcC8uvFyLuo1cdAfVfqUzlkmObAwNhTteegDiKl8LMKp
         0XBJPuUdeu17QlH/igaDryYYr3JjKd3KwpxZvF7ZBu28l5Xf87GPQ8JzABtmvggyoMbG
         jZ8g==
X-Gm-Message-State: AElRT7E6TkmXjzl3tjGHyku8c0qX6BK5aiGDZAIXm93XksI5Yi+aGhfu
        JBXrd5bCVGG4hYQkAfn0IBQnIof8iIF89fa3pnQ=
X-Google-Smtp-Source: AIpwx48Xzl7HQtjhImQv3baqlsBqbhF/GDtvFXxS/fXYJnM6D2yE0Z1A/yBYsTF7ES6gUxqYfVuv7r/Q6IqJyV2bmUg=
X-Received: by 10.129.236.12 with SMTP id j12mr1496ywm.356.1522167621167; Tue,
 27 Mar 2018 09:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3804:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 09:20:00
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803271744370.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180327054432.26419-1-joel@teichroeb.net> <20180327054432.26419-3-joel@teichroeb.net>
 <nycvar.QRO.7.76.6.1803271744370.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Tue, 27 Mar 2018 09:20:00 -0700
X-Google-Sender-Auth: QsRriXN_doMFsNw7k3qY4DiKWv4
Message-ID: <CA+CzEk8wUbV1mbcejyBuJ1fC87XvQPHWBNzF7qGQmLcDyytWyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] stash: convert apply to builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 9:02 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Joel,
>
> [...]
>> +
>> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
>> +{
>> +     struct merge_options o;
>> +     struct object_id c_tree;
>> +     struct object_id index_tree;
>> +     const struct object_id *bases[1];
>> +     int bases_count = 1;
>> +     struct commit *result;
>> +     int ret;
>> +     int has_index = index;
>> +
>> +     read_cache_preload(NULL);
>> +     if (refresh_cache(REFRESH_QUIET))
>> +             return -1;
>> +
>> +     if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
>
> When applied on top of current `master`, I need to replace the &c_tree by
> c_tree.hash.
>
> Likewise...
>

I based this revision off next because of the object_id changes. I
probably should have mentioned in my cover-letter.

>> [...]
>> +
>> +     index_file = get_index_file();
>> +     xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%d", index_file, pid);
>
> Since `pid_t` is `unsigned long long` on Windows, I changed the %d" to
> %"PRIuMAX and cast `pid` to `(uintmax_t)`.

Thanks for testing on windows! I'll have that fixed in the next revision.
