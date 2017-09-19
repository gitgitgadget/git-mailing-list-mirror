Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74D320A29
	for <e@80x24.org>; Tue, 19 Sep 2017 09:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdISJdf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 05:33:35 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:55549 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdISJdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 05:33:31 -0400
Received: by mail-io0-f175.google.com with SMTP id z187so8493949ioz.12
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A7PthV0hN0C4EDa02C3nv2sK2akOLqhPyUJ0z3JAg2A=;
        b=PwxQTSwWU8wvdwMsOo6uS/GHqk4LQ8j4iarBT+IhOJkxuWnr+mblhqp0uPqpVaAoqt
         DlNWY5OcB94rWsZetFUjGhqOXhLA/DCWlGpO+U0vCqDqV1Ia5UMFyPG1hBiJs93sTwrk
         Nu2uLPpXER1yifCFBw4b+QSYRPEGVUqSzMV97fxRns1dxhnAZTDqhNlM4I2dPl4v/qpO
         2n3WVblZXQCzyOLpCRWqw/t2YCU7gejw96OxMVji5uhsZwSL+7Q1OXFQ3x2yOuU4Xsyz
         hKE2zC+P6Sj3VS7uifE1YBtW5b/J1Or2PW/u2Qb6w2QIRBt9RoNqoHj79QFirvWmrW87
         xXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A7PthV0hN0C4EDa02C3nv2sK2akOLqhPyUJ0z3JAg2A=;
        b=k08e4/SY4STcc8KetqmrjwWotHVllsOQsHAGtX6ShNyEoCyXogcDGgBIdGetMlN0V0
         Guk826Dokg35TVDkA8nx0fs7n5Y5k3WD7x+TQp6hb0DnFf1kxTG1lDYtmgRtqFOBQkDe
         qnXnyXP8zBGubnGNHTg530oRIuIkCuTVbEuQRdxzxA27hoy81J+uS+AIiA3Wi4/vSERi
         o5I/9udN4x1r59aKN+xbhNNORF0aL9JpaZSb96zlKxG3EDtI9nMCGdgtfurdbG6BMktV
         G0Lz9zS4ZkiyZbtcC5yldnqZBTYG0UcfQT/G94Th08uUHVal8SiSy3wQHibfwk8ZsqWc
         9dig==
X-Gm-Message-State: AHPjjUil4HAR+GxAX6/rJEJ6m/dltX79c+lSefOm0G99LL8gOT4YBGS6
        zIAwjlB3t720DsiVUFsM0vBSKvSg
X-Google-Smtp-Source: AOwi7QCgJ3E2+QDl/9YRJL4s8C5B3vBQQcC3ZvEN6ErC0LJPsK+cPFjTpgXdMzzmh1g5IcYzUH+87w==
X-Received: by 10.107.35.204 with SMTP id j195mr1006200ioj.241.1505813610701;
        Tue, 19 Sep 2017 02:33:30 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id w131sm3613226iow.37.2017.09.19.02.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 02:33:30 -0700 (PDT)
Subject: Re: [RFC SAMPLE] builtin/branch: give more useful error messages when
 renaming
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
 <da5038e1-4d45-881b-3791-746987112aa7@gmail.com>
Message-ID: <78e82320-2fbd-3382-c618-ccdc066bc77b@gmail.com>
Date:   Tue, 19 Sep 2017 15:03:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <da5038e1-4d45-881b-3791-746987112aa7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, the email client seems to have crapped up the formatting. In case
it looks difficult to follow, let me know so that I could send a better 
version.

---
Kaartic
