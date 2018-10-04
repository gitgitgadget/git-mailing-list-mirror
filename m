Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACB11F453
	for <e@80x24.org>; Thu,  4 Oct 2018 21:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJEEk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 00:40:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36225 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeJEEkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 00:40:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so35462wmf.1
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CHFcHLzqXiR8P/rAOg3TZWUXaZUaCYjKpwIGoB9HKNs=;
        b=HbdQvJUh6kkhfWGqwWi1m42CxmEFAi9su7LKN9BLgersFK5NFilqo0vIVBSd4GQrDZ
         C3ygdTeKhhqpPU3KdCssKPpjq8f4rgMbUFsjAH1RQGvdW3mpoF6CVC0O4wEJHSa1AQFL
         pXl/fRiqJshxeXS0LemZY7RDwglX9mgItUKe7nU9Mc0LBMnmRpqlpNd0pf3Hz9enQdb/
         mImEffWVhfb/LMh1ctLTzB63MboQDYC2IjPfgbXdX0v8wTFB2b8L6wIZtgkVUFP1ip29
         kVM5j0Y5fTtGwDAnoCiEW8O0MQmxswmFUHqCnhEP9gm6up9JaJeMy4LWvCd10Jh7Nd5o
         HNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHFcHLzqXiR8P/rAOg3TZWUXaZUaCYjKpwIGoB9HKNs=;
        b=GM2sj30YVW8MlIoB0L0xhEpMxvt8aU56gRju1BJ8e9NfAhOuch5wb5j9zlLulzbAqy
         T4HdNH/sl/PQXn1ocB9jAb71zonxUyAp7HRESSlUkRV9ZGfRU2BC+ifB8XhEx7Z2xfDb
         /i4N/Uiw2AvBOMNlo9LzEge4jNsoHGraNYo8iCsp6Ym4EZ3DJjpNlHPP+R8ytnFPNtB/
         N/4+7OVFeE0DJ40PrZiiYiwkGJ9mzQI0pssSFdjNIhQ3c9B5lnsfLs52d4xHcwQSQK+p
         gpCdN5WZRI+H/hXyKuPaOuZEOLhHMX9WByuB7q+mzh824ASiE7zLIlH2LmKpZQYhcdPK
         SnTQ==
X-Gm-Message-State: ABuFfohQ/wRQXt0V6SkNwNGv6E22edrCfQXyzM7ARqH/PTbtDEsotk+s
        oW+rBDQizqxyxk+IPN7lZio=
X-Google-Smtp-Source: ACcGV61OfWohfke+K9VpItfaINqCKfpTl43puaQaft3Vf1oAGCCOcSueBlljVBFbM82qCk1sEIn8ig==
X-Received: by 2002:a1c:3581:: with SMTP id c123-v6mr5928542wma.50.1538689536379;
        Thu, 04 Oct 2018 14:45:36 -0700 (PDT)
Received: from localhost (x4dbe5b76.dyn.telefonica.de. [77.190.91.118])
        by smtp.gmail.com with ESMTPSA id j6-v6sm4257729wru.4.2018.10.04.14.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 14:45:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 23:45:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eneas Queiroz <cotequeiroz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Error while trying to git apply a patch; works with patch
 -p1
Message-ID: <20181004214533.GS23446@localhost>
References: <CAPxccB1VnDV5BjkcFcoPVmegJSg6iN_tD3o0e9G2XKXaM_=4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPxccB1VnDV5BjkcFcoPVmegJSg6iN_tD3o0e9G2XKXaM_=4KA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 06:01:11PM -0300, Eneas Queiroz wrote:
> I've sent this to the list 2 days ago, but I can't find it in the list
> archives, so I'm sending it again without files attached.  I apologize
> if this is a duplicate. One should be able to reproduce this with the
> current PR files, but if not, I can provide them.
> 
> I've hit a strange error while trying to apply a patch from github
> here: https://github.com/openwrt/openwrt/pull/965
> 
> 965.patch:452: trailing whitespace.
> 
> 965.patch:559: space before tab in indent.
>              -o $(SHLIBNAME_FULL) \
> 965.patch:560: space before tab in indent.
>              $$ALLSYMSFLAGS $$SHOBJECTS $$NOALLSYMSFLAGS $$LIBDEPS; \
> 965.patch:564: space before tab in indent.
>         -o $(SHLIBNAME_FULL) \
> 965.patch:2334: trailing whitespace.
> 
> error: package/libs/openssl/patches/100-Configure-afalg-support.patch:
> No such file or directory
> error: package/libs/openssl/patches/110-openwrt_targets.patch: No such
> file or directory
> error: package/libs/openssl/patches/120-fix_link_segfault.patch: No
> such file or directory
> error: package/libs/openssl/patches/1.1.0/100-Configure-afalg-support.patch:
> No such file or directory
> error: package/libs/openssl/patches/1.1.0/110-openwrt_targets.patch:
> No such file or directory
> 
> If you get the patch file from
> https://github.com/openwrt/openwrt/pull/965.patch and apply it with
> git apply, it fails.  If I apply the same file with patch -p1, it
> works fine.  I've tried it with git 2.16.4 and 2.19, and they both
> fail with the same error, and at least 2 more people have confirmed
> it.
> 
> git apply fails even when using git format-patch -13 --stdout as a
> source, so it is not github doing something weird.
> 
> The file is a series of 13 patches.  If I split the series after the

So this is no _a_ patch, then, but a mailbox of patches.  'git apply'
is supposed to apply a single a patch; apparently 'patch' is more
lenient.

Have you tried 'git am'?

> 3rd patch, it works.
> Also, if I use https://github.com/openwrt/openwrt/pull/965.diff, it also works.
> 
> I'm not subscribed to the list, so please CC me.
> 
> Cheers,
> 
> Eneas
