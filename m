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
	by dcvr.yhbt.net (Postfix) with ESMTP id 193E220248
	for <e@80x24.org>; Thu, 28 Mar 2019 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfC1UWj (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 16:22:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43768 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfC1UWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 16:22:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so121936ede.10
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=19Bq/Xf0zmYAcx5X3QjthbJGFLtLx8OGN7gJgtK+pPU=;
        b=aZU+E53oM9or3Riciyd4sD5naKFpOclJJxiobizQcJS4cbc2O2ijgPSAMUTzJPE7ZR
         202lJBhdU0fQjPhjSMIY7ImblyiiqknpE6DmcYi2xPPKNLYdvqwKan8/nR9NydDKBbhv
         9aRb7otg7sCY0bbf3HoLyS3BcgaVY7+FnQNZQfBYg2oO9hnQTuUqfxQVRsLr6VO2JYzO
         hGNOBve2H1tPecRNvJ9zT1Uad2//REgwXtYXR+xjyLbzS7wPB8RFfm63Y77b0dFilD8D
         54ga8U4dCUvC+AKGFsiw0l1fAaIz+imr/HaspCuCDupX3970EdIm/JG8OG33frad/OvL
         NfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=19Bq/Xf0zmYAcx5X3QjthbJGFLtLx8OGN7gJgtK+pPU=;
        b=ZIQf8ejOYSQDXYW83WyuwcEr9GuE+3Nt5lJJez2k9uffeHwLRD6Sgy8CZMraotbRzN
         V/p+jkb18vEM71jR1N5Nns9/ZCy0w2j+eevwg1FG0iIeOp/VaGsVzzpP/N/ROeEkh65q
         xqrCtYXF+VAOtzJ3oB0AxtGPiyZ2kV1tYvAtRYX9m3sRTHn8ejmy1bCdzUBe0iQL0RWp
         ljEPp5o64z3KK30S8qEyCKE3XlrSkquM253xpAAG4WM5na9jZPBg2kaZzcqtzgICvP56
         oFwsalAbPV9oDOSWkwISg3S1RvGU/b4vOeGLNE9Dc1OFwFS428BlPaG1Yd3lGaifXawO
         EyuQ==
X-Gm-Message-State: APjAAAVAvj17JWfx7EhDjQW0O1lzEyYARqiYNzQzTSrbs5A/NSg5J6tn
        U2eUe7WPso9jp8V2Iwv1TD0=
X-Google-Smtp-Source: APXvYqxhRP4Sv0lwbvWm5dJjO54/R7PmDdNbdN8GV7HL6GkQUf0Oto5wL6fV12v2z8jst4hIIOC1Jw==
X-Received: by 2002:a50:89fb:: with SMTP id h56mr28197724edh.176.1553804557711;
        Thu, 28 Mar 2019 13:22:37 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h50sm38316edh.47.2019.03.28.13.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:22:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t6050: redirect expected error output to /dev/null
References: <20190328171722.9753-1-chriscool@tuxfamily.org> <20190328171722.9753-2-chriscool@tuxfamily.org> <CAPig+cSj5WZeGy4nwgafGtBbz7y921M8H57eFbBXwRy2Bm-C+g@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cSj5WZeGy4nwgafGtBbz7y921M8H57eFbBXwRy2Bm-C+g@mail.gmail.com>
Date:   Thu, 28 Mar 2019 21:22:35 +0100
Message-ID: <87va02agvo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 28 2019, Eric Sunshine wrote:

> On Thu, Mar 28, 2019 at 1:17 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>> Otherwise the error from `git rev-parse` is uselessly
>> polluting the debug output.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> @@ -40,7 +40,7 @@ commit_peeling_shows_parents ()
>> -    test_must_fail git rev-parse --verify $_commit^$_parent_number
>> +    test_must_fail git rev-parse --verify $_commit^$_parent_number 2>/dev/null
>
> When I'm debugging test failures, I find it very helpful to see that a
> command which was expected to fail did indeed fail with the expected
> error message, so I don't consider such a message as "uselessly
> polluting the debug output". Consequently, I'm rather negative on this
> change.

I believe this instead should make both of you happy:

    diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
    index d638119750..2e3009f3cb 100755
    --- a/t/t6050-replace.sh
    +++ b/t/t6050-replace.sh
    @@ -40,7 +40,8 @@ commit_peeling_shows_parents ()
            test "$_found" = "$_parent" || return 1
            _parent_number=$(( $_parent_number + 1 ))
         done &&
    -    test_must_fail git rev-parse --verify $_commit^$_parent_number
    +    test_must_fail git rev-parse --verify $_commit^$_parent_number 2>err &&
    +    test_i18ngrep "Needed a single revision" err
     }

     commit_has_parents ()

Note that the file has existing 4-space-instead-of-tabs issues.
