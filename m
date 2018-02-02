Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E0B1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeBBT7h (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:59:37 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39906 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754491AbeBBT7f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:59:35 -0500
Received: by mail-wr0-f193.google.com with SMTP id f6so22008641wra.6
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RXcoO7Jar4ApMbkpt9MbMefCQds2monqu96WY08KyYo=;
        b=E5DyB7oFjxLBUIbP+pU9S9nq7FJiBej5vwNGvbAo5DFBYAY0CuobQF0WUwffncZDOj
         Ye0WpQ1AghDZcFEb3/xheBHIfFKox5P3eYDBb7LpHG5V0tVt2VKFcA4/JTU5uKUxLB0l
         F0VqlDhJug92ucV1nXWYno2xLTfzGYUkKpl0crx9vvG5E/t3s7OLc5oMXSFQstod+pPO
         i/jgFus/G+64BNDH1dWspw4/YjyU11eP7BN+yisDaITYUxN856sW3Fw2FVVxqjX98029
         wdz5FcqMKVMBLu1tXn7JRQ13JPIgTB7p8aUWwjMjbQMxzKPKMkC0lpt0HZTOGKGmELYo
         0r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RXcoO7Jar4ApMbkpt9MbMefCQds2monqu96WY08KyYo=;
        b=aFljQhSKeoD7FsdGMf5WKnG+1pdCGVEZgU46RxQ1DTJE9NEvbuxPbQSmsTXMCge+S3
         klXrFBa9sXnFXCowvGzILugFRblR4b2pGgHicMEUtzfgm4Vba80VDdOmXMX/Lm5/CULo
         7c5POdPKzfwfbIHgK4EspJkhZiiTkB58QL9LBvCKtwVJmcgIVU1gLAj8WY2iaiBTchho
         WRIN77KoE+qy6MC7IgoJapzP++OsIcti3pGU77RU8lFkqV4SBWPk9rG7hd9zy7dV0OQU
         GfNK9BJYxKpUHHQ69pXgo/kNphpCmbZqWrpbIJxUv19457Lo/zjbw0vPeR5R46gFOnnT
         YNxA==
X-Gm-Message-State: AKwxytcE4Wg7E7BhITIbfYv0K6LbuFuN6YXZ3l4c8oHKMv3H5QBCE/Vl
        ctxuOSjKWUDztzQI7q0qLxc=
X-Google-Smtp-Source: AH8x225CrHjUfEFDU+c/pVWD0ml0NHjIXoDGq0r2+a25NE6egK0BKaybyjfEku06p7CqiPgWwA53bg==
X-Received: by 10.223.160.172 with SMTP id m41mr19596152wrm.32.1517601574011;
        Fri, 02 Feb 2018 11:59:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i4sm1277550wmf.3.2018.02.02.11.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:59:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
References: <20180201130221.15563-1-pclouds@gmail.com>
Date:   Fri, 02 Feb 2018 11:59:32 -0800
In-Reply-To: <20180201130221.15563-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 1 Feb 2018 20:02:19 +0700")
Message-ID: <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Changes since v2 [1]:
>
> - goes back to my original version (yay!) where the extra info
>   is appended after the path name. More is described in 2/2
> - --compact-summary is now renamed --stat-with-summary and implies
>   --stat
> - 1/2 is just a cleanup patch to make it easier to add 2/2

It may be just me and other old timers, but --X-with-Y naming means
quite different thing around these commands, and --stat-with-summary
would hint, at least to us, that it would behave as if the two
options "--stat --summary" are given at the same time.

And from that point of view, the new name is a bit confusing one.

The patches themselves look excellent.  Thanks.
