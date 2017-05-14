Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD774201A7
	for <e@80x24.org>; Sun, 14 May 2017 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdENIeD (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 04:34:03 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36680 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdENIeC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 04:34:02 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so48694533pfg.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xShyip1lpeyepXAWQwz0DsBTHKj24vkrhDHR79IhDs=;
        b=Lg5PDVTsjFGo/xmFnAXRy11wVaouP2wkJ/pHuk3hOjhAmdZiGoTeoVyg7+rmJzNF9g
         zyw81r5wYgSZtsuq7uOMdt2+FnG2R5CpxxxP3iyUeHso5HEl+H1V6LphEnjWhSQWVdth
         VvRcpB2sMxaxw+jTjbq6tuoY/xLEhEJnnZYfp/XzKPbeQpRj09if6cacilPcDutyFjPr
         2BXwOPWBHDZ+4CkIRyWFdXg27m2/m4wK393GJXXl/q9QOpBhqO6JptXmtTzVd8C3Ak4H
         j3Ya+NnQuRCR3uqH0P/EnWgdoqNx8FoZ4Jko9nB0pHHo/ApHSsqs1eW8MQfEIxTLwaQf
         F+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xShyip1lpeyepXAWQwz0DsBTHKj24vkrhDHR79IhDs=;
        b=dYppNXhFnIpu3LuYJUnS6oWR8wQhUgfM/8605w3sdRmUkcQjfoH/W7qBVb1Lc2GjmA
         b1qra6l6/NMxY/0X0JJwVxPIg2l9w+IZakwqkJILUIfFlbO9RgAoWfvlf+zxXgW+5tV2
         Mx5AJnligfHB6LAp2AAsWyOLDd29F765LQ42yxfpO89jlL6oeGczGkXWkgBl1f93ROAz
         YRxK0daA9s5JaEW2hyL3lKXy1IIRkAfXsq0nYhXWOuTJLK2tG/SdBHpZfEjA6KKTKJ+8
         3CcKJpiSd2J0fGf+ErC2JfQwIoY+lzmUtiqPoL1r9MhS5Vle4xrwc+fssfwIa27gYPmN
         6PzQ==
X-Gm-Message-State: AODbwcDA9T97JKxrkWH6C9+w4tZsSXGH1GTx8VoQPTagjzynrVTfhnon
        Wtc8IA+0eh4rhA==
X-Received: by 10.98.223.28 with SMTP id u28mr418598pfg.97.1494750841673;
        Sun, 14 May 2017 01:34:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:54fd:6c32:8438:4e94])
        by smtp.gmail.com with ESMTPSA id q27sm13290057pfk.4.2017.05.14.01.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 May 2017 01:33:59 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     peff@peff.net
Cc:     bmalehorn@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
Date:   Sun, 14 May 2017 01:33:48 -0700
Message-Id: <20170514083349.24979-1-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
References: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> One, we'd usually use "\EOF" here unless you
> really do want to interpolate inside the here document.

Fixed, and I learned something new.

> And two, we usually indent the contents to the same level as the outer
> cat/EOF pair

Fixed.

I was indenting the same as the other tests in that file. But if the way
you described is the preferred way, then sure.

> Another way to think of it is still as a truncation. Our strip_suffix()
> helper behaves quite similarly to this (not actually writing into the
> buffer, but returning the new length). Perhaps something like
> "wt_status_strip_scissors" would work.

I agree the name was pretty awkward. I was trying to avoid using the
word "truncate" or "strip", since it doesn't make any change to the
buffer. But if strip_suffix() is already around it shouldn't be to
surprising.

I've now renamed it to "wt_status_strip_scissors".
