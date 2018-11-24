Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ADE1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeKYHoG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 02:44:06 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46259 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeKYHoG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 02:44:06 -0500
Received: by mail-ed1-f44.google.com with SMTP id o10so12735747edt.13
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LDu+xVGsKpV0zdL4OFKD6d54EgwlprUk5I9Wifz1AY0=;
        b=q7MssaXsYfCoM9BVRfQOfIq1Cm+3toW8HbUs4DHygwSn9s3eDhsMzcfb91gcMjwHil
         6ouzIEmwddeQP0RfY2iXPV64I2hbOo1D9SkA810+GC8YH7WriNdNr7NwIk7xTD4CW4sb
         068PDvxSBCWKvQLx7NdceejcW2RH1Ghy8dgOx/JeZapJ4GmhHh1ghYmNAAVygCjdND1b
         A40iZj7lhg7im9tTOZshRUT2rkavUYeEnmvvVpniDrpQP/gKDTgsrIH4sm0thh3IWhOf
         P0IYZUSVqWPOiWFCwPiYvzAwEHLHRc/19tIn7B9GP2cnK8RLA+/Uy1whqTnNJOKIKjTx
         /ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LDu+xVGsKpV0zdL4OFKD6d54EgwlprUk5I9Wifz1AY0=;
        b=S4+2/BbimhnVOWvwiuDEPPcBuiSEx4PIzq/5tzJVr+L7sR2jlGHHBmJRu4d4ki9kqf
         LcZCKuVaUChzS5m/8slQJIB0LqKynRhHc/3QeobY0AsVp1y79YPb3YyEHed/VOVQHcwf
         Z604xz9mWPmX2UAOsTKuaTw11FRVJhyftvWsCJ42sl4cXQmMtejBEvV2fOlKyruELvG6
         UYaVuJbyiA3So+KjJ7Ra3aXXC/pUj/i/Q1vYy6ibCFXXT8lYRYcKV7EiCGF/gE1zE0MH
         S7YIFdhrafiph8tE8jT1GaI8zq0dGS1noWDs+dF39P1Guscujnev3CP9GLKeYaiHWHeu
         +hUQ==
X-Gm-Message-State: AGRZ1gLBmSVSrTwA4o10o7kv9I1nLo2+GydMmmVYAIQye3ajl3Fo4TLr
        8F39MBpejNxa72HWevdqCGMrU9Tk
X-Google-Smtp-Source: AJdET5eLaMen+4dfs7EQQs8Lz0dqMx3GAC0WffWAupV0QzE7+bSu1gwcB4ZC4H1b6pge4F+kOwRlcg==
X-Received: by 2002:a17:906:7b97:: with SMTP id s23-v6mr15565323ejo.57.1543092888342;
        Sat, 24 Nov 2018 12:54:48 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e26-v6sm5818184ejb.29.2018.11.24.12.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 12:54:47 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Nov 2018 21:54:46 +0100
Message-ID: <877eh219ih.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 21 2018, Junio C Hamano wrote:

>  * "git rebase" and "git rebase -i" have been reimplemented in C.

Here's another regression in the C version (and rc1), note: the
sha1collisiondetection is just a stand in for "some repo":

    (
        rm -rf /tmp/repo &&
        git init /tmp/repo &&
        cd /tmp/repo &&
        for c in 1 2
        do
            touch $c &&
            git add $c &&
            git commit -m"add $c"
        done &&
        git remote add origin https://github.com/cr-marcstevens/sha1collisiondetection.git &&
        git fetch &&
        git branch --set-upstream-to origin/master &&
        git rebase -i
    )

The C version will die with "fatal: unable to read tree
0000000000000000000000000000000000000000". Running this with
rebase.useBuiltin=false does the right thing and rebases as of the merge
base of the two (which here is the root of the history).

I wasn't trying to stress test rebase. I was just wanting to rebase a
history I was about to force-push after cleaning it up, hardly an
obscure use-case. So [repeat last transmission in
https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/ ]
