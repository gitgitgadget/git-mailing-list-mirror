Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C944C2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbdFWFbM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 01:31:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35299 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdFWFbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 01:31:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so4990765pgc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YgBF3OHRNvA3lpmGTl27MwLdGbLDDP6kHXt2WCrlWnk=;
        b=CIPYC6umRCPGEJ0C5r4n+zRJ86iI6B6vrG5XmlxCWhtu0MOxMMSJV4J4uU0OXahIDQ
         Ci8yoRuMsMOdXF7nuSNmee2u5bU0E+Kp2CCitvuALiG9qCZl9nFQn/rOeMF17MJvWATC
         hLhzhCQ0UT2m2HsCpL5+NWDVxcfojaLieRrWokEOXgSFh/dLqbQb4oeeKAwFxm89EepH
         vZJDvp3uaUyvHQ6co6aK3E2+O+1nkRWvj8idMkiLjSNpQk6zw5/DX+wFKdcdLWfTMcMt
         IYigVxocIcRtcsvDJqo4/TX+gUPMszIAM5O8NG/KXY/xjSF1qORzj7Aq6w+S+w4TG0W7
         FWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YgBF3OHRNvA3lpmGTl27MwLdGbLDDP6kHXt2WCrlWnk=;
        b=cWrSS4wq0evgrhTKz/Pd7NJWFugch0NKHHUA85S9VZrBmRqVQSnhiBj3X6MYG2FpUz
         3x9sA6LhwuWLk7xPXnbipRO+XmLtBSJxSFmW6MQ7VGYb95YB2hDC6DmA7jZiN8uk6JNL
         DFlUex7b+7wg6D2Ls5zMXNfuGybbbhDqu35ab/vC1K7Pj9wFIpCWhING8D58CxMB9r67
         7YKmH9WnWM8XxoyrMpOj/kRi6LXLl/mABJLjTEXkZTK1Lnz5s5Bbbgw+6JvkJn7Q+tG2
         gAfrx2jDXbcHDG8a53YckjiVnzrBBAVYXph9vew75xGoT2ycfCHIwRJ4PoYfp1oEgjy0
         isRg==
X-Gm-Message-State: AKS2vOxHcfLNwsNUcgup3M9DN3bp7j50h0tYC7rX/GpCAQ3nLN9LVhZn
        GN48rHnEyotM6Q==
X-Received: by 10.84.229.13 with SMTP id b13mr7064693plk.1.1498195871342;
        Thu, 22 Jun 2017 22:31:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id q7sm7199966pfk.108.2017.06.22.22.31.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 22:31:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t1301: move movebits() to test-lib-functions.sh
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
        <20170622190158.13265-2-chriscool@tuxfamily.org>
        <xmqq4lv7kdfa.fsf@gitster.mtv.corp.google.com>
        <455cbce5-97eb-2fdc-6e38-b4feb4daaa6e@ramsayjones.plus.com>
Date:   Thu, 22 Jun 2017 22:31:09 -0700
In-Reply-To: <455cbce5-97eb-2fdc-6e38-b4feb4daaa6e@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 23 Jun 2017 00:09:59 +0100")
Message-ID: <xmqqk243fexu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 22/06/17 20:52, Junio C Hamano wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>> 
>>> As the movebits() function can be useful outside t1301,
>>> let's move it into test-lib-functions.sh, and while at
>>> it let's rename it test_movebits().
>> 
>> Good thinking, especially on the renaming.
>
> Err, except for the commit message! :-D
>
> Both the commit message subject and the commit message body
> refer to _move_bits() rather than _mode_bits() etc.
> (So, three instances of s/move/mode/).

Wow, I shouldn't give praising reviews too easily ;-)

Good eyes, thanks.
