Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F9320401
	for <e@80x24.org>; Thu, 22 Jun 2017 01:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdFVBlf (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 21:41:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34404 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbdFVBk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 21:40:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so441870pge.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 18:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ozHc9ZRQOAcuveBKUXxpCXpkbouly7rcVqFyyc1/8Sc=;
        b=ppQya31ROOX4gI5fDXqVe3nd9z7nHYQ8m3rozLJf+iOcfJ1ZeBhfq0GdBKHraAQ8wY
         YzSywoRCM/dnf3kB0/yamgv+Hq7FO7JpDWkfQCVDu8HJK6c7YTpF9WzjGGUtFMvILb3K
         dBYk+51ZF0rCKHqmaUH0noaov5gl6qMXgjIv/VNkTUx+KsRS1I3rBD09yc2NzNauJu7c
         LJ4iL9WzUuLyYQbRMyNUoZYHrp/eMX1JdI3DCRwDkDTg0dk0fcOuP5LYPquZ0yp4fL3X
         d1WoSgzllOb7wry8zDtsc2QlKO8WLcOsh+B4MZ1sDCEbNooeh3R1K6IoLzXFVH+JnIhF
         VmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ozHc9ZRQOAcuveBKUXxpCXpkbouly7rcVqFyyc1/8Sc=;
        b=Bou9YOHMFYeiuOzxxQFLH1mBxYNSr1h33G4nJS8Ooop3Mknx/UzajfAQPpJGYpiy21
         e9FB3b695LXUZ9x7Ln8o/bbMA7Wk9lBWD+FcvhXxFNDZeqPTDcZaZl9r81Vnil+Tltqp
         4uqg6VtAbso+BdwhHmJ0OKzhSmi3MPfCL5Rc6L368yyZtkKJSMson1jfOoKitY0aKqLv
         qQ9ofCvD3k1Dobjsh4VKfzYz+eo54/VL6BmBOuzJ4gIIWIIeBbB9GWJt2dUIzorCklU4
         dJTVQu09FY33D2PO1PIpBYmlQYpU2+n/nBFC626VBClRBZvvdDdnJUaxO93v+nYAMBzp
         xEvQ==
X-Gm-Message-State: AKS2vOwvNdV1HPpZygHgnfQrLz0sjLd3loKOppFtixQ73ZnWwmmKgxrB
        VkIy4rYY1+cmJQ==
X-Received: by 10.98.70.4 with SMTP id t4mr144779pfa.92.1498095656572;
        Wed, 21 Jun 2017 18:40:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id o2sm68130pgq.44.2017.06.21.18.40.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 18:40:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/8] Improvements to sha1_file
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1498091579.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 18:40:55 -0700
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 21 Jun 2017 17:40:16 -0700")
Message-ID: <xmqq8tkkn6jc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> After some more thought, I think I came up with a better solution -
> allow sha1_object_info_extended() to take a NULL struct object_info
> pointer,...

That is an excellent way to tell the machinery "I care about NO
details of the object" ;-)



