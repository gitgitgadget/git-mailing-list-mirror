Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FD11F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBVAge (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:36:34 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44369 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBVAgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:36:33 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so1386531pfw.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=um6hE79GVFzjzSGBTx25iCOnf8fhiStAgAbesv/HUB0=;
        b=Tv0E6VlevXQDY3pCUC5zS5y2KzxRu9rBncIRR7HrUlak1b+ChgD/gg3jqao8dPfUIh
         af4twWnWJDe5NoLdVha+/YlCxeaoRTtHozFGw4mV5xJlW7LLTYIc7NdiX6aAaQYCGBYh
         ynkG0QEx4WsCygCVWjfrJdh2TzijGIEmf1dOwNo2PW4dpp03/gu0o6dJXBQ9898lM1ng
         UZPLANr5YhxVMD3hU3p+lWWAdz+IUE1iUHG1KMtf8lTtsJ0K0leM2dnWZ8MKwgD1sNRJ
         2WN7/AgY3Gy0FOoTDQAr7AIE9ZXT6lD3LbAi7b2PP8DwXpIEWgHNXoBs39XGA+vYz79D
         0SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=um6hE79GVFzjzSGBTx25iCOnf8fhiStAgAbesv/HUB0=;
        b=FCcN/+/GQru/jDoL3pfEXapulpragh2Auylw7IvK0VEss1qiecYe4PtjjQCbPcCe4y
         dNdWjulr5z7GOk82WRb7mshQHhLEiT3a6R1KJ7cP9NbjY32+Fn7UN5pO/uiQg14VJgNR
         px4C8X6r5elJiRCMZKH6WszaI+NfJ1Hd5guWyahXzN23+rupuh5gytMLI9+oje8bGbrN
         dVvt6jOk4HqMFtr7qdyzw1mS2vX6CYkkEE26WsWAyXO15z8B3wmHueqUp3XY/2KrF/Nt
         VmRnuflSj9/WTbHlciVLiK0/ZlTAkfOWkj3iQuWcFN+7lj0NmRt2B/RW19PYDIenHbj/
         ydeQ==
X-Gm-Message-State: APf1xPC62S2ORwl12lqipH7+UbTjdVXZriFBztKFvx9sxXp9gQvOjfm7
        njp5y83+vJGHa8Rn+SaxPVxg8+JB+BQ=
X-Google-Smtp-Source: AH8x226kCB7ZOE2shgcbfvXcxbCW5xobyX3BOEcD2qjqwk0G2kowwq9ynDq19jLP6YXjMxqIaCCVbA==
X-Received: by 10.99.170.10 with SMTP id e10mr3990566pgf.92.1519259793046;
        Wed, 21 Feb 2018 16:36:33 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t126sm57465080pgb.85.2018.02.21.16.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:36:31 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:36:30 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 19/27] sha1_file: add repository argument to
 map_sha1_file_1
Message-Id: <20180221163630.a69b33acadf774753cf747ba@google.com>
In-Reply-To: <20180221015430.96054-20-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-20-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:22 -0800
Stefan Beller <sbeller@google.com> wrote:

> Add a repository argument to allow the map_sha1_file_1 caller to be
> more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
> 
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
