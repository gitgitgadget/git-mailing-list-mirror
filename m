Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509AF1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeBVAJJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:09:09 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:35180 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBVAJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:09:08 -0500
Received: by mail-pl0-f43.google.com with SMTP id bb3so1894302plb.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJfEDpxcc1HIsKelUhQx5gbNoZcMRl9JOjFxjAoFoo8=;
        b=K08ioa6xYXyLo7wVDSb7OGGLAkPxiPaXt6xW1C853Wf8qNVtofOct66UvzLNl7Y8wh
         zI8GUMpFpJvsogTB48AQK20+nY2I+Opu5ki7tsdRtmYDy0GdXy5mC3ZqneO8phtoFySi
         rU7wQXneodytLxs7yr2WpsbmsWTb62bc1M738FOKKsaA76uBmQVgyTv+LsDwKv6OceuK
         K4JThsDA7tgyPXdHg14eOxX0ZveF6LeyWkiYnrfv0czf32YmaO4gdG3sX6aNbqDxluf/
         Dg2QqLYrTVVFd5k/y1X2dr9SGEtZYgJ0JKWhAhsfuINpeqUEVURj2OBio65RXjQLDEG4
         8zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJfEDpxcc1HIsKelUhQx5gbNoZcMRl9JOjFxjAoFoo8=;
        b=HgTDAM+IXiX9fqakqVGviq8W50V5sZfTisFs2NM56DhX6AINi173QLINwPM67XMxhz
         ShwEW+yv1nalET5TD0/Ku8cRoWq9B03oMCu6aFfKJ9jCf23jBRiiv510+MPGugld3Vzq
         bq3bx9S1EGz0jWAfpdk3an3kdaHF1SwBt0Q4qb0BZHBhxjUjmC4pDBO7t8g0wXv2r39l
         ameDD+91G0rCcL3e6s0orUhHbO4biL+0eC3NyyLKcTqqltejcB0BWREBuTDwHvS4Mt+4
         fvLQrL+7b9NXYd6C74e3WlAgPhGutxezFvL9MJxNBQMruQuC8jkXd0MK/Rt1eHqwDn6D
         Vxdw==
X-Gm-Message-State: APf1xPAWiQRxrmJq3RliE1U0+XtCgwpxDvuowmo0Wbr/tOsfE3/WyIA9
        T1nusVe71bAsEuwgSuo3n/o+Dw==
X-Google-Smtp-Source: AH8x226yw2t2jeena/3kX8NgqpAtEEVQ6ljabCx/qJZ4Z9IxSznEh1K79TAm29hzfv19JZ2RmTTc0w==
X-Received: by 2002:a17:902:a50b:: with SMTP id s11-v6mr4666699plq.440.1519258147935;
        Wed, 21 Feb 2018 16:09:07 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u85sm44635450pfi.80.2018.02.21.16.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:09:06 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:09:05 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 32/35] http: allow providing extra headers for http
 requests
Message-Id: <20180221160905.5772106219ded5f16919de46@google.com>
In-Reply-To: <20180207011312.189834-33-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-33-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:09 -0800
Brandon Williams <bmwill@google.com> wrote:

> @@ -172,6 +172,8 @@ struct http_get_options {
>  	 * for details.
>  	 */
>  	struct strbuf *base_url;
> +
> +	struct string_list *extra_headers;

Document this? For example:

  If not NULL, additional HTTP headers to be sent with the request. The
  strings in the list must not be freed until after the request.
