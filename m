Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643BD20281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031361AbdIZWpA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:45:00 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:56138 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031328AbdIZWo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:44:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id r71so6244528pfe.12
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjjDxbhGdT/yNpVWqaMCkJAS4lpKXWVCF40NqiBlruY=;
        b=b7cgUmjYFrMYXtCA1JS+WbvCNjeHCgs2M8ykb5PsIogiYH5MaZzBz0Z9O+cswnMNTB
         pXXr7B066QjHWPeWa8bUIAQ3PyiEdwnjIm8WPSfknuID2OkYQ4fY637bfN/b4qa8f1jM
         4DKssMH40dDloLtd5J/PcyLWELOjRDK40/SyZHfwkcrDnMgh1M+r29aJHOe1QqEHy+HM
         1c9mhB7F5IIyGdNA9Ka3webr5nI8v9JRK6Z5zW+zmyvxPsDee5IQIJhe0ufDNnGC5s8b
         raFcSl9Y2SABKaZSIASDZTGVgY1Cj6FjD1uM76FcmSRIUTfbnX1eKleL7X0kwi4EgNYy
         2HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjjDxbhGdT/yNpVWqaMCkJAS4lpKXWVCF40NqiBlruY=;
        b=dKlgJjvjiKDdMS6bdaXZVhJhxeFlOp84pluVegy3KFcJ2lGvi7uBA2OCWxTeJU1+Er
         TJrU2fk+vFhZ4Xqm/SvVS10f7PyqG8jY9k1Uw3/aC0DPFj/GrM0XlUK9dDfankS8JrKo
         XTAMc8Gaf+jYSQHEYhwpUuwqqF9qcPue2fCnI9FVaTXM1823bvSJ6B5I9D+FC5rgY6iK
         wjbEZ/dqFhWHXacOcY63U9S7K2HwjX7UbMHfhqMJxeUi/GT8ehwe+m/XXwhxTUt7mTo4
         Qq3jdPWxuZukgHVTP5VBH/lR1vITgGWpSCgRFZDgOS2LhRK0JU40OLpGkKSgTcHngsu3
         CHNQ==
X-Gm-Message-State: AHPjjUiXRrDQII/pezM/WIl24yCYBihERAILx1Ug8nlAQeutRTcEdfue
        p3fdvbowjZT35k+lrudd9v9ydCi4bfE=
X-Google-Smtp-Source: AOwi7QDPw5WqoC3PxaNKnA17gIJEKDAgJ47bNVC5YXX7LIauRQ1wJJ919lNT/bkkjhOLgyxMBL27dw==
X-Received: by 10.99.113.93 with SMTP id b29mr12643119pgn.422.1506465899233;
        Tue, 26 Sep 2017 15:44:59 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:51cf:598a:e16a:8a0b])
        by smtp.gmail.com with ESMTPSA id g5sm17063729pgo.66.2017.09.26.15.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 15:44:58 -0700 (PDT)
Date:   Tue, 26 Sep 2017 15:44:57 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 09/13] rev-list: add object filtering support
Message-Id: <20170926154457.51f4da732122f00381d646e1@google.com>
In-Reply-To: <20170922203017.53986-10-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
        <20170922203017.53986-10-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 20:30:13 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> +		if (filter_options.relax) {

Add some documentation about how this differs from ignore_missing_links
in struct rev_info.
