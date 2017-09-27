Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF52202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdI0GaZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:30:25 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:48148 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdI0GaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:30:24 -0400
Received: by mail-qk0-f173.google.com with SMTP id a128so12348110qkc.5
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GsaygJuHGbxgpJ9TWBBFEJHayuBJeKp6vqt683Lvvo0=;
        b=SdH5KiBoUcXR5nw9w1phss1xPw9s4WXDe1eiZppvuzikM5rDNdOubpkDxDJGpBN2/7
         ac+GlviCblkktHfH6GJU/yRkB6u/ma0UTkJYKgh24u81dWjAjHcEwh5Ykebox3h/oJI6
         mJT3LpINJP4TrY2tdOtTVepKGu90/Nkdobx4Axh9jRJEj3iypcEwuNuqWEA5s1mS3soV
         YGfYdG8ay+Xc8ZUpXl3tVRtYTpDiZqKTq8S9srY/lEcWDGjH+FuceP5c0EIG+vvN6wpT
         Iy07/covtzghdqbjinV0K/HyKt3us8WIk+Pcvrn5kv8c3au5VnjssO2dp621esd6r44Q
         v9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GsaygJuHGbxgpJ9TWBBFEJHayuBJeKp6vqt683Lvvo0=;
        b=lO8w/jXDsBaZ+6a4ebD3TJIIqy94P/3FfjT5VPpP2n3UHrF5ilDk7b1Q43tZ6Dlmq1
         07cc2RNy+OAFUUdfM/enJzfYH73c+8PYZ0cPoanGaAfkAKEgmXPr87S5nx1JVT+unXsB
         VxIyQe+M1obdrOF1UbIKjbyB+q7i2xGLaHg2Giq5WGJ758LvWxyjUD5vJZK5DO0QxdIW
         uAj3GDi3YJydkTh4i2soLcmBZmJ7DzvQtvskDK4I4rGo9XMkWt8/Dae9bKGrYEKvVLQL
         PudVkLQ5vBUV5niZ/r8Yws8HTCxceyGxPjj99cbBP83p2sxPEwaC502O60exhap+NfsZ
         1mig==
X-Gm-Message-State: AHPjjUjjLj42a2x1l8FqDvuxLAetFaz+WwrcKLwmh4EudDItQRJve9d1
        bxrZSaMqpxkX4O91AAZLj4R4CUYOdH5ZiLy5p2K6wQ==
X-Google-Smtp-Source: AOwi7QDX+0XhKZ5ofghSXov3/bVOxlu/LtCTYs5d1iknRQhY/fNsJvQxIv9hOc9YZFDFo1ftSfwXzGS5PhaeNt6wd8o=
X-Received: by 10.55.90.199 with SMTP id o190mr1047150qkb.180.1506493823277;
 Tue, 26 Sep 2017 23:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Tue, 26 Sep 2017 23:30:22 -0700 (PDT)
In-Reply-To: <20170926235627.79606-4-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com> <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 26 Sep 2017 23:30:22 -0700
Message-ID: <CAGZ79kZxOr3ug7V40kv77e2_kF9MBviCu99-6rcXy76tg2YVGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +extern enum protocol_version get_protocol_version_config(void);
> +extern enum protocol_version determine_protocol_version_server(void);
> +extern enum protocol_version determine_protocol_version_client(const char *server_response);

It would be cool to have some documentation here.
