Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D05A1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbcICMZZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 08:25:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36371 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbcICMZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 08:25:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so6314489wmf.3
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=3sLm25jIQSk7rDswJ7nm7MzjIjpQ5GTpDt2LVp0DOeM=;
        b=k9QuDyByDxZ/IUbIh/iJFKLa0mOsfW8gAVTkqfOeWg5/VmuuSFEG+5VQEd4fRWSqsA
         iAfJ3EoPl0WJWGwuSFGh48Pp9B+c7rxqix7/N1f9TSj7Kz03DFxRJsZE8ganeYjWcMWP
         TovvFWg6jR5lOHQlBzVhFEv2rM92TT9K7Yi68Gu6tZB3o9zL0xAeX/SDjJqiU8voDOnZ
         hmGceVeZzb5fkiQtySpEwcS0X6rUrnsnLRzmddO7btYf1gWE6dh0XGQUb3I7XWVRRlk3
         PApqJ9/9g5tnYlUVgx1yX3YIb0gFbhcdIXiQpKbzlInj59AbnuLesVhCX57Iq634i1BH
         gXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3sLm25jIQSk7rDswJ7nm7MzjIjpQ5GTpDt2LVp0DOeM=;
        b=E8SN0JbGBxMSkBgtNTKY2eyHZDajQ9Z4I2NCMQrBkWdQDNoaY8ZVsqk1hRyaxLcmhn
         LkMfYAUCpRZEoRwUA5JdlV0Z3G9vKOKYOCck+MQGBIa2ZoUP5x1iQ66N7vksIVAaQlvT
         y1mEhY5hxIUkAa8kQFn/rnTJWrL0IGGfaHmNanpW9NJxpSKXb/u8zcZWEdfEH8UJMjrq
         n0Gje798anc5dd6NZ1PQ9fHXMeHuF+RDLQoy+19OQCHxKNz1PUKuF8+RDdHHOFseaGH3
         ayEwVijy43efXkzIXKF/N9HzODaKC0f2ltAYfdXeSMPGhcmTMj23h4cKNKW8jpHNWIFh
         Gs3w==
X-Gm-Message-State: AE9vXwPsP3WC37auHjITPwgqencOLn361EjjZ1h9IxGkMpf2lC78ncwkX58XCx9kcEbKbw==
X-Received: by 10.194.80.34 with SMTP id o2mr19201456wjx.61.1472905516108;
        Sat, 03 Sep 2016 05:25:16 -0700 (PDT)
Received: from [192.168.1.26] (ewi71.neoplus.adsl.tpnet.pl. [83.20.232.71])
        by smtp.googlemail.com with ESMTPSA id id1sm15199451wjb.21.2016.09.03.05.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Sep 2016 05:25:15 -0700 (PDT)
Subject: Re: [RFC/PATCH 2/2] WIP xdiff: markup duplicates differently
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20160903033120.20511-1-sbeller@google.com>
 <20160903033120.20511-3-sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com>
Date:   Sat, 3 Sep 2016 14:25:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160903033120.20511-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.09.2016 o 05:31, Stefan Beller pisze:

> When moving code (e.g. a function is moved to another part of the file or
> to a different file), the review process is different than reviewing new
> code. When reviewing moved code we are only interested in the diff as
> where there are differences in the moved code, e.g. namespace changes.
> 
> However the inner part of these moved texts should not change.
> To aid a developer reviewing such code, emit it with a different prefix
> than the usual +,- to indicate it is overlapping code.

What would be this different prefix?


Side note: I wonder if the cousin of unified diff, namely context diff[1],
is something that we can and should support.

[1]: https://www.gnu.org/software/diffutils/manual/html_node/Context-Format.html
     https://www.gnu.org/software/diffutils/manual/html_node/Detailed-Context.html

*** lao	2002-02-21 23:30:39.942229878 -0800
--- tzu	2002-02-21 23:30:50.442260588 -0800
***************
*** 1,7 ****
- The Way that can be told of is not the eternal Way;
- The name that can be named is not the eternal name.
  The Nameless is the origin of Heaven and Earth;
! The Named is the mother of all things.
  Therefore let there always be non-being,
    so we may see their subtlety,
  And let there always be being,
--- 1,6 ----
  The Nameless is the origin of Heaven and Earth;
! The named is the mother of all things.
! 
  Therefore let there always be non-being,
    so we may see their subtlety,
  And let there always be being,
***************
*** 9,11 ****
--- 8,13 ----
  The two are the same,
  But after they are produced,
    they have different names.
+ They both may be called deep and profound.
+ Deeper and more profound,
+ The door of all subtleties!
