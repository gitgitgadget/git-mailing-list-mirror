Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665FE2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbdBOWyw (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:54:52 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35785 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbdBOWyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:54:51 -0500
Received: by mail-pg0-f50.google.com with SMTP id t188so231237pgt.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xZqFkUyKcMNXlArLIpMp1oRucq+fJ2DcBn7Mcdf/eD0=;
        b=kxK9GuoK3Ezb6Es4m5D9Y5xSpSgAOX1iay1OIFO192OJG3tAWm7GqCk32U5btcmBGD
         YdF5qgLezJVfQvQMtoCNxjU+At/u1m+XChLRnVXcW+mnxefWAC9Iz3C5Z2uBXn1gY+0C
         QqADNUP4pCiDEDGhXGKiT9l+Ht4tKItAK52bm+0KSILCJe4V55m6VUqwRftW2gUM58G9
         7Dfgpjr1MS2R4pbexjeVUikDaLaaFJzaqPiwUbZOgRYE3AHaKcFXLcu5Jl1UDiGXd7Vk
         g+rJYTn+QoUITBu9QfEJs8HfXY5XV91n2B/L7asKlS9kDU0TFXphcZ1GRKSSaZMzSuAU
         cZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xZqFkUyKcMNXlArLIpMp1oRucq+fJ2DcBn7Mcdf/eD0=;
        b=qjHoPXT4W399sa5uuf+0+R8c33hX6V2QFa3ggiDyAgzZZ04fid1iZlJ/NW53ZW+ZAo
         h1v4BpuBBdlR86XEyWL7rD7QpK/RcX3gfMtxRpII6cnu2TKHAzInmNJX8/ZKRuGCP3nR
         SVz1Mvl/h89ZM8ZfRhLYrwctXoqPMC/XrCXD2gr2JtA5LgR5ab2T9qCuHUwnNwQHTkEm
         Hn6sA45Psj/v52BUFIyFYOKNpZqRbjiU+0iHp5c43CLQmOzRQcnoAPFj4XMEEo5zqU6n
         0/feywyZN0fd5U3LR3quW8wIiOAo5cJXfenmp5ISZEOsWZ8SPqMLrXhPehL4zePntsE9
         cyrw==
X-Gm-Message-State: AMke39nk7QB9wUuPT9Q/kovMiOfUAZBeEbUq9XlpYGWAaUF65gBsjWUWYJNPVJ7ufOD4kqTt
X-Received: by 10.98.61.207 with SMTP id x76mr39873579pfj.152.1487199290041;
        Wed, 15 Feb 2017 14:54:50 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:458b:2f1f:f100:cb93])
        by smtp.gmail.com with ESMTPSA id s26sm9421604pge.33.2017.02.15.14.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2017 14:54:49 -0800 (PST)
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
Date:   Wed, 15 Feb 2017 14:54:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15/2017 10:53 AM, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> It looks like as if submodule configs ("submodule.*") for submodules
>> with upper case names are ignored.
>
> This observation is surprising, as the second level in three-level
> names like "<section>.<name>.<variable>" is designed to be case
> sensitive.  A code that uses the config API needs to do extra things
> to cause the behaviour you showed, i.e. to get submodule.U.update
> ignored while submodule.l.update to be honoured.  Perhaps somebody
> downcases things too aggressively before comparing?
>
> This is worth making it work as expected, needless to say ;-)

I had some time to look into this, and yes, command-line parameters are 
too aggressively downcased ("git_config_parse_parameter" calls 
"strbuf_tolower" on the entire key part in config.c). Updating the 
original patch to use "test_global_config" makes the test pass, and 
commenting out the "strbuf_tolower" line in config.c also makes the test 
pass.

I'll see if I can fix this.
