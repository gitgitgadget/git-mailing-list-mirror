Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493E220248
	for <e@80x24.org>; Tue, 19 Mar 2019 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfCSJf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:35:59 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33288 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:35:58 -0400
Received: by mail-ed1-f42.google.com with SMTP id q3so9333038edg.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=F3D80MK1o1hhHgfuclGBzkrq888gvJHCH9Wl5o53gNo=;
        b=Kd4K/2LbSqkzqRSeYiI7ru4icoMCOxtWPbo6OyLHxL8d6YJ1JclSWhJny3/dAYE8TP
         O0+88ykO2032P+5IPBBVQYj4bsTL4NTRR2iVVuXOxg6wvsQV9q4yWgDIcP/i7WwwSrF7
         vk0nmuCYA9WpN7EU5lAFYUrlHFQd8/HtytwuPnXNZG3v/uy92i/qb1sSopU7JTcaUiTR
         poerryoAGx8esddJBrpaDeRI66WMVwXgo1tI6UpfrDjz64pylY9Dv2pOYJR1lmhIq+de
         AqyJHADmKD/BIHaJfCiFdxjQ1yVBr54vWkfqZvnP6jJfPQzxHwdU84yreNS3P1slsvcB
         v64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=F3D80MK1o1hhHgfuclGBzkrq888gvJHCH9Wl5o53gNo=;
        b=UTCzu+jTyJuOait1g8ZGY+QsKM0mtwU5rMpFhFual5vzRp2if7o+Q1crEk5u41WvrK
         n8QFLD34C0cvZPU+S9dSQS1vZoXAcR3CCtzO3FZQl5hrus95GAYSjh8HPpaCSlBez3xW
         uDVnoKXm41CfCKZnkEiBZqkGQOJQSDvaC4o67QjGbKrrNjW+egbaKC+bSjeS3MWH+3e5
         f7lalSj5eRgm1tYOMpVOK2vup8Vi/R+lxiZ86TXhpB7SO1teJvbrW3TJsAeWMRniU205
         J8OvDx7tti5AWEpzsVDp5vIzpPcsbJrWXRhDOKxaubQe9MfXkQfoUrGEKXhXzYa8Wdoj
         7Hag==
X-Gm-Message-State: APjAAAVf4jGVTFR8+TVpn1TXPYoG4TXYB4f6P+FPGkxPu2/4rlJT5Ygw
        deGtsQWJMdjZivEb1KeqtI3/Z9AUeHk=
X-Google-Smtp-Source: APXvYqwcmb3FA2/aWZCb4YRBR8fOh7oduZDyK8U8wtq/MPMPB9bXEH1PxzPzqPYxnepLNmZMXUTJWA==
X-Received: by 2002:a50:a390:: with SMTP id s16mr9899945edb.69.1552988157008;
        Tue, 19 Mar 2019 02:35:57 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id f1sm98680edv.53.2019.03.19.02.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 02:35:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how can i "gc" or "prune" objects related to a deleted remote?
References: <alpine.LFD.2.21.1903081029510.25426@localhost.localdomain> <20190319063904.GC31801@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190319063904.GC31801@sigill.intra.peff.net>
Date:   Tue, 19 Mar 2019 10:35:54 +0100
Message-ID: <878sxbdx51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Jeff King wrote:

> On Fri, Mar 08, 2019 at 10:36:44AM -0500, Robert P. J. Day wrote:
>
>>   as an example, i cloned the linux kernel source tree, then added
>> the linux-next repo as a remote -- the end result was two pack files
>> (the smaller one i'm assuming being for linux-next):
>>
>> $ ls -l .git/objects/pack
>> total 2723632
>> -r--r--r--. 1 rpjday rpjday    1215376 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.idx
>> -r--r--r--. 1 rpjday rpjday   38402840 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.pack
>> -r--r--r--. 1 rpjday rpjday  204032716 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.idx
>> -r--r--r--. 1 rpjday rpjday 2545333327 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.pac
>> $
>>
>>   after playing with a couple branches from the new remote, i deleted
>> the remote, then also did things like clear the reflog, delete any
>> local tracking branches related to the deleted remote, and so on, but
>> i can't seem to prune the objects that should no longer be reachable
>> now that i deleted that remote.
>
> After arriving at a similar state, I did:
>
>   git remote rm linux-next
>   git tag -d next-20190319
>   git gc --prune=now
>
> My guess is you forgot the tag? There's not a general solution there,
> because the tags all get intermingled. Git has no idea which ones came
> from which remote. However, if you have the commit id of an object you
> expect to be going away, you can use:
>
>   git for-each-ref --contains=$that_commit

Not a general solution, but if you know you have one remote left, and
you don't have unpushed locally created tags, you can do a:

    git fetch origin --prune --prune-tags

> to see what's still pointing to it (even indirectly).
>
> Expiring the HEAD reflog is another frequently-forgotten thing, but in
> my case I had never actually checked out any branches. You should be
> able to do "git reflog expire --expire-unreachable=now --all" for that.
>
>>   what am i overlooking? is it because those objects are in a separate
>> pack file? do i need to repack first? what is hanging onto those
>> objects in that second pack file such that they can't be garbage
>> collected?
>
> The two packs shouldn't matter. The gc process works by repacking what's
> reachable, not including what's not, and then deleting the old packs.
>
> -Peff
