Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682001F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeBIWKd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:10:33 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33821 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeBIWKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:10:32 -0500
Received: by mail-wm0-f43.google.com with SMTP id j21so485850wmh.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o9VSfY9LT03S3er7TSBoDX3QRVDQpvyb6yNyQBfjxKs=;
        b=MTPG5fkqniM28kp3D1PWInIEoGQSM6wEghkFcjLYEmNnCHf+NAadZSyut3jZ55ObR1
         9mHDonbzGQYMvsW+2BTtLfMG82EkrcWviSg7U9s/jJzcZIcWPXpZmWknYX09iVCknNqk
         CLsYGSyjF4lFSuQ3gXi+aoCVBUqfENqLNUJ/Z8M5ioXMeyquQxMW7NTCk0DpMlds/Iw7
         zL57kz5bDSgNefg+I2CgiBMIxZlK6eftMVXieKSGvRhqtVlrwQMubTUxpuFuZ9FOq1Dl
         YPjU3ZmZJIc/76aMVjREyPKgQXJdx0Cp/cYouKI2xNTvBoUfT6sQAsP4KkrO5ZgApCVx
         zU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=o9VSfY9LT03S3er7TSBoDX3QRVDQpvyb6yNyQBfjxKs=;
        b=HwBZoSxAA9JTpoQvhOUGN8oldhfVfK33/Lx7ImrvwkdcWN6BCywL4KXImoCPSleBbz
         7r+9EbL0vGh0BqAIEKVvFMY1OpX6ey0yZ8p+PKECnoGRKLgHe2e46pAL/4t6pbX+z9gH
         i0NIFcDS8EtGgdYb3ddwL6F/XLLHNDrFB4giXNhGh34rufgDCYf6FrD9BHwE9hk5tv3P
         NbPuJQWmetCqb6f2pr/BVKiACMKBzgND/IS3W4Ri5rJOqfbYxv2aMXenan8NZKpPk4eP
         Tk4tmXXeGfJ05VIB8vVO7m7uiKyxEjL9H+dXH7839iFs7EEd5VqJreeJeuPIOS1mbP4i
         HLUA==
X-Gm-Message-State: APf1xPDUFAZ3PyeVvVDf/J+5MmeiAXPcwBtTPteubJYZDNjQ+MP432cs
        hKREXy/uZ/giafJilK+yzq2NWpgw
X-Google-Smtp-Source: AH8x227J93u04+UGKXI1kaP2UKnJb6dg3jJOwUttWIBt8bMEusCLIhSez+yDmbvf+WMNbncB5QJSUg==
X-Received: by 10.80.157.141 with SMTP id w13mr5482387ede.123.1518214231627;
        Fri, 09 Feb 2018 14:10:31 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c5sm1799511ede.30.2018.02.09.14.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:10:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] update-index doc: note new caveats in 2.17
References: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com> <20180209210431.409-1-avarab@gmail.com> <xmqq4lmpx2oa.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq4lmpx2oa.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 23:10:30 +0100
Message-ID: <87o9kxbyqx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> When users upgrade to 2.17 they're going to have git yelling at them
>> (as my users did) on existing checkouts, with no indication whatsoever
>> that it's due to the UC or how to fix it.
>
> Wait.  Are you saying that the new warning is "warning" against a
> condition that is not an error?

No I mean the warning itself gives you no indication what the solution
is, or why it might be happening, and because it's printed on every
occurrence we had "git status" invocations on some big repos where there
would be hundreds of lines of the same warning for different
now-nonexisting directories.

Deferring it and just printing "we had N cases of..." would be better,
but would make the logic a lot more complex, I'm not sure how common
this would be in the wild, but as noted happened on a large proportion
of our checkouts, so having something mentioning this in the docs is
good.

I only had that git version out for about an hour, but had some users rm
-rfing their checkouts and re-cloning because they couldn't figure out
how to fix it.

Is noting it in the docs going to help all those users? No, but at least
we'll have something Google-able they're likely to find.

>> ... doesn't it only warn under that mode? I.e.:
>>
>>     -"could not open directory '%s'")
>>     +"core.untrackedCache: could not open directory '%s'")
>
> For example, if it attempts to open a directory which does *not*
> have to exist, and sees an error from opendir() due to ENOENT, then
> I do not think it should be giving a warning.  If we positively know
> that a directory should exist there and we cannot open it, of course
> we should warn.  Also, if we know a directory should be readable
> when it exists, then we should be warning when we see an error other
> than ENOENT.

*nod*, so not UC-specific, even though I've only seen it in relation to
that.
