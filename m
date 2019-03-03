Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AEB20248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfCCNcN (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:32:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfCCNcN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:32:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so2586468wrs.4
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xz0nyQ3uPFexcBgd1PZVPr6iqCT4J3UNisTUjmpabi4=;
        b=H8tpVzBOW5uMz5//Z/z+h2HJS2ZZmaNBx3wDLpZAE+M2rPfnmS5AEXe+2fbUyHZuEQ
         wPdw4N38mj+7+4rVxGopsyRmmSCaMXCw62liimp4PyZ99icrlyoDET9YHoQSKfz//PHH
         oycHz9LtA5BtIzwhlQTKBDVU5ZW/ulzSd+evGfOZ9tJW9mAfj9CvjCaaLowHRG9Gsz7j
         zF7UfsRGkNbaO2RXzvC4D9h9b5SEjTTwSFwH+pRGLwHeO1oxozxojPN1ynwt045AO7EI
         7fJmTPWZIWYA+xuEVs5t8kXJeczhaEO3QSZnTYG6h63gzTwxy+CHpN+NZS6kYj2IMMp1
         v+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xz0nyQ3uPFexcBgd1PZVPr6iqCT4J3UNisTUjmpabi4=;
        b=UfphuA71a82dozPlBq8tbo9mUHOliUgmnhMhd4ePoazNb/H9OEzlL2aCCVyzJCxHCR
         F+pCdyaugHKz67TbvD8u3ZEbqC1E8qr+5qdkQlc9xRhm8/YoGHQBJkM2LGSQh0YdJ9Lf
         SBdFb2xuvR7m9U2O9IIeRGnrQhGsdeD/eVQ9OvQOyotIySdluuWk61axCXVqtzXUMIk/
         wQjLPU1zr9ItY5+3YcAjHKUd2ggbHKo4jB70o3JxKsT6noE+VG6XxA2NbmLNqjNOoaH8
         8iwis4xFkliDj8FqW/3F/CwCoMoQItEqZsBraUPcv3glTzwDhPvEpOxgi8of5Fqf7nXP
         Yl7Q==
X-Gm-Message-State: APjAAAXDdHfuz/MYQ+BL/XIoof9ni7xauL1vhcyYAvQwh02TKp14DVkE
        EC3le5rq/0r8j8NolNSc20c=
X-Google-Smtp-Source: APXvYqweqjGA1Z6i1o5GTkNq3mmRf3GPevkzDbdqAo7blrrK6rz7jAMd1yo/5COZ5WLBSBT5afwQZw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr10194340wrv.126.1551619931297;
        Sun, 03 Mar 2019 05:32:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y20sm7778514wra.51.2019.03.03.05.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:32:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH 3/3] t3600: use helper functions from test-lib-functions
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190303122842.30380-4-rohit.ashiwal265@gmail.com>
Date:   Sun, 03 Mar 2019 22:32:10 +0900
In-Reply-To: <20190303122842.30380-4-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sun, 3 Mar 2019 17:58:42 +0530")
Message-ID: <xmqqsgw4ytgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Subject: Re: [PATCH 3/3] t3600: use helper functions from test-lib-functions

There are tons of helpers in that lib.

> Replace `test -(d|f|e|s)` calls in `t3600-rm.sh`.

This one gives more useful information than the patch title.

Perhaps

Subject: [PATCH 3/3] t3600: use helpers to replace test -d/f/e/s <path>
