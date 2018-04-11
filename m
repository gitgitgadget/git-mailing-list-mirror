Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A39C1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 10:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeDKKL5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 06:11:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50920 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeDKKL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 06:11:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id t67so3029408wmt.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAtoDTFiUQDwj38OBjtYJPkhdNwbbKkoOdmht1bmcQI=;
        b=iqOrVwUUOnqOGEfFI7T1jzK/AnhuNeVLAAbogsJXzRl7o6UcSrhUDRo2VVHehU12B/
         oy+L8wu3bMuHbuh1krLIS7EHKtrH17LugtlQ2ci/speTb1jdM9YVHIaETWQei5683XI/
         WrcjNZeq9oqoyM5JVi6W6oK9L6AElKejHfzujR6uxqttOms5kXnE7tuu3hcLCqJH9Iu0
         hJlVRe+9V3E6St7AZ/Rqqn49rqBT75oAjY6SCw63R+5RtTj5GWm3YJtsd4lfiLZxvhcT
         bH3r0Vd/0JAS1bMrte7ESxdAtr+knhWJUgmxNuUYiOAjtZFUSbu21lMsi4qpOWS75sXq
         MXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAtoDTFiUQDwj38OBjtYJPkhdNwbbKkoOdmht1bmcQI=;
        b=Z0tuM/rIBBkyL/xehJF0LYFUHkDQ1cY1hqhDZLuL+4wCY3yJwSS3umgETChlkPbZln
         nw1rR2z9NzZD+CQIUAhEZ4g5YfsswZr8Pl+l/WElT/HEk7sZWTW6K6t10sKhL+qHNklc
         reR063pGnhRnH3+51Oe9L2SR/zAb2/k+op6TmIg/72rujNwJU58uMAqfP8Cnh8RDunfP
         HndHc3anGAZ65I8UMB2EzfaSAYuuat1MMzSPX0AaC9MyFmkaTRrQnq6aDBChowqSSIpM
         zlO2ezpNPLJjbc0H9MJ+YMfqq8z7EYJ0WzHVPOSAOkl2l0G5XnIZDqDdILHg8KWpCwnO
         u4nA==
X-Gm-Message-State: ALQs6tB9TJ/Ro7Lm2Plrf2rmnUo9ZsuqpWyURKTggwBm2ZrgTtmFzJAC
        mQzVerFux/b+S3hOjejA2B8=
X-Google-Smtp-Source: AIpwx49KcXIoVfTNxfRFGC6+g6Wx8pbquiN3C/grC4Hrp0XSrDH9/pjM/dFgWaWUvJWE4R/DeTAQQg==
X-Received: by 10.28.160.11 with SMTP id j11mr2258744wme.24.1523441515033;
        Wed, 11 Apr 2018 03:11:55 -0700 (PDT)
Received: from localhost.localdomain (x590d2b94.dyn.telefonica.de. [89.13.43.148])
        by smtp.gmail.com with ESMTPSA id w18sm858513wra.25.2018.04.11.03.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Apr 2018 03:11:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Date:   Wed, 11 Apr 2018 12:11:41 +0200
Message-Id: <20180411101141.7292-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.364.g14609316b6
In-Reply-To: <20180409204129.43537-9-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/gpg-interface.h b/gpg-interface.h
> index a5e6517ae6..cee0dfe401 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -23,15 +23,27 @@ struct signature_check {
>  	char *key;
>  };
>  
> +struct signing_tool {
> +	char *name;
> +	char *program;
> +	struct string_list pemtype;
> +	struct signing_tool *next;
> +};
> +
>  void signature_check_clear(struct signature_check *sigc);
>  
>  /*
> - * Look at GPG signed content (e.g. a signed tag object), whose
> + * Look for signed content (e.g. a signed tag object), whose
>   * payload is followed by a detached signature on it.  Return the
>   * offset where the embedded detached signature begins, or the end of
>   * the data when there is no such signature.
> + *
> + * If out_tool is non-NULL and a signature is found, it will be
> + * pointed at the signing_tool that corresponds to the found
> + * signature type.
>   */
> -size_t parse_signature(const char *buf, size_t size);
> +size_t parse_signature(const char *buf, unsigned long size,
> +		       const struct signing_tool **out_tool);

This hunk changes the type of the 'size' argument from size_t to
unsigned long, but leaves the function's signature in
'gpg-interface.c' unchanged.  This breaks the build on 32 bit systems
(and Windows?), where unsigned long is only 32 bits, and I presume is
unintended, as it goes against the earlier patch 3/8 "gpg-interface:
use size_t for signature buffer size".

