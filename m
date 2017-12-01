Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E29A20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbdLASSx (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:18:53 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32867 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdLASSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:18:52 -0500
Received: by mail-qk0-f172.google.com with SMTP id 63so14314111qke.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 10:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mtkRpokvPm7+aASxa+hUCDjg3hDlSkvh9QEzvshykhs=;
        b=TAhy5Ulp09aXdgHK0+ByLvYctHFFdFq8DvMczoHTMpMyA3TFmkH6tGIkoDLfmRepv7
         6lLVsDllNjSa97j0OvtejXWSn51TsyLwiYms9X3ROOW5BQrVCGgQ3gJK/4hlfSSpploZ
         z2HsMw8VBqePEUXK5+uBr6xvhRJ53rDYd1rwf83BwxAZjNG9HtM0Rmw3SNb+ygsSocRH
         sqeH2PrgGJZFJmWbJCl+9JxaAs89BVAqloEYRJCkuM3rosEC1P8pI61uAEmk9E0BX67+
         8OsgICIKUprHXJo2NSjyh/B/yHpYcxMyMouCwX9pK6JC2lWOgPLri/1wA/28bDAIobhP
         wSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mtkRpokvPm7+aASxa+hUCDjg3hDlSkvh9QEzvshykhs=;
        b=oLtlzaJS5AoaZDPLq7MqnbvZSf3t9CM9QPfnQj7vNLncNQMF3i7JEVqfBQufHvB5Hn
         xjy+UNRW0Aa71UuGBe6PotsB7K+Bz8jDYYl7+eTPI6x/8fveWoA21vC/kbSlrrxrCYji
         nWhcybR0NT0bjREdeMvrpW586cTG8dMAWkhZd0o+na07/8EnVEvlkNQd5sc9gTZkRhDO
         NhGcKsG9pL/2J/mZj08H5chva63KwEB68eOl40tjMXZyPDs4y1uMdhwjFa/UqMfPkVGk
         oX1yz/7XhlGfxQ/qUlA9U0WPlMn/cLsn3oMYT0VAbT6BA198kj8dUWqG36F0/IGPH4pu
         AWbw==
X-Gm-Message-State: AKGB3mIX6QELkpdSQG0oZtSzOOXg21cpjBFgRcw7L0UKXD+dMTdEH4ck
        KfX/PNQgS+vZUkhq4yZIxM43zg==
X-Google-Smtp-Source: AGs4zMZMGnr7pVAaNPuGL/VPPEtKZbY+Hod7Q0r96fwn6qOmXBsAl+FP+H31qIKWZtFFmzN3lFnKTA==
X-Received: by 10.55.27.219 with SMTP id m88mr9278141qkh.334.1512152331332;
        Fri, 01 Dec 2017 10:18:51 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id l52sm5156373qta.12.2017.12.01.10.18.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 10:18:50 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     j6t@kdbg.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, dnj@google.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
Date:   Fri,  1 Dec 2017 13:18:45 -0500
Message-Id: <20171201181845.8454-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
References: <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Dec 2017, Johannes Sixt wrote:

>>> This doesn't work, unfortunately. When $(pathsep) is ';', we get an
>>> incomplete sed expression because ';' is also a command separator in the sed language.
>>
>> Funny, I tried this also with ';' as pathsep, and it worked in the Git for
>> Windows SDK...
>
> My ancient sed vs. your modern sed, perhaps? I can check this on Monday.

If you wouldn't mind, that would be much appreciated. Did you actually observe
this issue, or is it just coming up in review?

I am not a `sed` wizard, but perhaps the tool is ignoring the semicolon because
it's in the middle of the "s" expression? The shell may similarly be ignoring it
because it's nested in between single-quotes?

-Dan
