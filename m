Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2252720259
	for <e@80x24.org>; Wed, 23 Nov 2016 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964992AbcKWOvq (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 09:51:46 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:32925 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936229AbcKWOvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 09:51:36 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so1221081wjc.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2H3vwVGVmk6b3oQJLrhAgv/qRDLSkIpIFlCftHwghw=;
        b=Vk0qyUhU7vr4M5cYlQfl3vFdJ7Env3B+3kZnbyk5GxYdCA7taxkrIiooKMdeuG/fmY
         FsvbrICrIEwISJPNUWwQhka6Lxsj954OWgiuwHeXiN7zPnfocFMNW73K653f976+CPCn
         IDZwl8EeYl5Th/3SrETXfH4QpOVghumFBmEveGOKsT21OUVu22y02bK+0OXFYUmHkM3s
         GiNI0YyCMaNuibPigav9h54RNvSC/fdUwkl35TQnaHJ5C8dpZAxYNEqCna5VJiPGwGRe
         7c22FDYa1axPucRgnVFg3lX8m/7Z1ZDqdiXBe09mpuUeoMSoFrqOfHM97XT2fjAzZyM5
         R8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2H3vwVGVmk6b3oQJLrhAgv/qRDLSkIpIFlCftHwghw=;
        b=Abwtsjp8yO0WKzD9POfxsyCZatshtbbv/8TNbk3RpO5SPZsN4Q03tBTCSd6fV82mQN
         aUIZahHCkPTf7CXBlu9dY9Ol8d4gJ8xxq8D2U03GggbZS1/WUswKk5ypNBCNOwVKWzya
         rCAhK/M/RinO6AhlWQ0RyYFyfgZ1255p27FlghLFmPbK8S5O/eG5GLNizpvVbftUlj2Z
         OssMZgtEtMwsakzcrs/a0ob/1UM23UlZHA/inKdtlTl7xXAyZiPxj2/CIBlNGAyV5eAp
         Fg2WIkE8d1GcJyh7Eb07BoKo5yk7G8HUDY21bPGo6slDAg5QkNS9Uq0CKewvTpBgVU6+
         lz2w==
X-Gm-Message-State: AKaTC00gdN8PB/wDG/kuY1h641D3pZd+j3KgDqEUOAmlmmE1nfFdTEEhhbO9uZSlfXfdwQ==
X-Received: by 10.194.103.100 with SMTP id fv4mr3629886wjb.102.1479912694481;
        Wed, 23 Nov 2016 06:51:34 -0800 (PST)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id f10sm36736869wjl.28.2016.11.23.06.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Nov 2016 06:51:33 -0800 (PST)
Message-ID: <1479912693.5181.27.camel@kaarsemaker.net>
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs
 scripted version
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 23 Nov 2016 15:51:33 +0100
In-Reply-To: <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
         <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-11-22 at 18:01 +0100, Johannes Schindelin wrote:
> The original idea was to use an environment variable
> GIT_USE_BUILTIN_DIFFTOOL, but the test suite resets those variables, and
> we do want to use that feature flag to run the tests with, and without,
> the feature flag.
> 
> Besides, the plan is to add an opt-in flag in Git for Windows'
> installer. If we implemented the feature flag as an environment
> variable, we would have to modify the user's environment, in order to
> make the builtin difftool the default when called from Git Bash, Git CMD
> or third-party tools.

Hi Johannes,

Why is this not a normal configuration variable (as in git config
difftool.builtin true or something)? It doesn't make much sense to me
to introduce a way of configuring git by introducing magic files, when
a normal configuration variable would do just fine, and the GfW
installer can also set such variables, like it does for the crlf config
I believe.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
