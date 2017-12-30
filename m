Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07B71F404
	for <e@80x24.org>; Sat, 30 Dec 2017 00:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdL3A0U (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 19:26:20 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39842 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdL3A0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 19:26:19 -0500
Received: by mail-oi0-f47.google.com with SMTP id r63so29588686oia.6
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 16:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=3WBEaEY63Awy8D/VAjp2Unuz/1Xjf2+CHfQF9JXSdd4=;
        b=QWw56AiekdvaK3H4sxkPPHgymBLfnU3R3XJYQK+v3rn73cnULfCz4J6SQjJcqsplTe
         RFijqTwMaY0Oj0kJJY8uVHJZoZBrhcWqk59z4OUYuQBMazFdc9snxQIJjGc4ROZyYryL
         HolCVBYBerd84xqXQG5Qk1VkTYpaSy/oEMtwdC3iMDGQRTckREjC3fCZfIMWY96VdJDg
         h/kbNsS6M2Fd+equVvP1PQMESLGJmSuK22STKwOEAQGgcD+MuWTC/Y+FTMPkfcPdnleL
         tT8jee5up9/5bEl4MbdvLZsgYQristgp8d0bUkudlyWBHAIdLScqwFHIJPhlIuh3U9yD
         adYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=3WBEaEY63Awy8D/VAjp2Unuz/1Xjf2+CHfQF9JXSdd4=;
        b=bYB4Cf7KE4YBzYEBIzj7/zb/Jnw+BGz72DZ8V+XNNy/44VdN/8V8LFbavPLGcwsKPb
         RuHUbMp3FQStiiQWo0yO2BZFUwYZ7gXP7pD4GKoD0wzS0pk3ZjVir7+lgzAMUmxOqenV
         vNZl/N0m2VjRrU90A4NOw4abWJe2b0AtKmnUgJ0AtSKXHv1d+tnrbJ4xHBC+wNIcw4RE
         6w7Y7qQdWIQklDcT2b3sVhJF7cZjf0+Ht7LSXHAsBSdrsxgKO6DF6TIQcyb+xIIuml3H
         K8jfnx/UMgeCisGg7EAM5vgNbHRSf6iY4G6OBaqlFch0hWiYTGSb8SIAWUCLuaOVusmI
         j9pw==
X-Gm-Message-State: AKGB3mK0xpOpHR5ea905PW/j/0L7jaLHI10SgRFE8lIpdCEZP27z8R8u
        MCX5MnU7r7Dp2BAuEQ+UsCn9QoN4
X-Google-Smtp-Source: ACJfBotPJuR+l3SeDmUeHzMgc27tQDH0hf25DlKHd3k+3tAfQ9c6g9lJpJRrG6o0qV8XM3FDAIXLgg==
X-Received: by 10.202.236.205 with SMTP id k196mr24618620oih.6.1514593578853;
        Fri, 29 Dec 2017 16:26:18 -0800 (PST)
Received: from debian-lenovo ([2600:1700:b820:c510:8e70:5aff:fedf:a3c])
        by smtp.gmail.com with ESMTPSA id l66sm16155415oia.24.2017.12.29.16.26.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Dec 2017 16:26:18 -0800 (PST)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     git@vger.kernel.org
Subject: possible completion bug with --set-upstream-to=
Date:   Fri, 29 Dec 2017 16:26:17 -0800
Message-ID: <87bmih83iu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Whenever I type the last <TAB> to complete origin/master, as in below:

> git branch --set-upstream-to=orig<TAB>

what I get is:

> git branch origin/master

instead of the expected:

> git branch --set-upstream-to=origin/master

git version and OS:

>git version 2.1.4
>
>Distributor ID:	Debian
>Description:	Debian GNU/Linux 8.7 (jessie)
>Release:	8.7
>Codename:	jessie
>

Thanks,

Ernesto
