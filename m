Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8E01F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBHSOB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:14:01 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:35543 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHSOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:14:01 -0500
Received: by mail-pl0-f49.google.com with SMTP id j19so232650pll.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69HJUPUm6kz7/LX+PJQ8w6NC4haorphVIcbFmkqojsk=;
        b=d11dFpjoUwk20j8pvSYndTkUYmLfkFsAf6uOSQYy3yAy9NQ0ukmjNKihBl4pvKzahA
         jIeAnm9v9hdNwCCtpXVS4aRvBomHe5SXHdYfkEnSLewz+H+irq6/NvjeFmov2sBO0eR5
         rOYtr510ISkbYAigiA2bV0tG88bEwVCxqioPHNhg5lh5YJFw8UShMwYcIXoLRxYCbisO
         iOvb1uy6geDxGMMS5cfoHMOvGh3poR75lP0SH8OO0ZERzSV9m8WU1sPUFhUwtvMxkPZ6
         xFGSmkbk6DJ9Spi2fZSNcEkNosYxIuDQR5uF3jRPzpUHiMFi/e6P78DKhZNXyVIChi49
         PL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69HJUPUm6kz7/LX+PJQ8w6NC4haorphVIcbFmkqojsk=;
        b=KTls31B3CroOys87RHVyFZhu8OGzuw8VDFF/RnpyoSkYq+YfwqSasgCrtAa9/PqRBO
         kRoWUvOUvXjoW36jMGrR5ed2A04Io1+eFfhiunnXG1e6nbBwHiJdxVbjgk1mOHr7HQDL
         NWLuYdK/W3//1kE/K3Db8ccLdLIzxL5Ip533bdtAglpY29/XXf1D8IHDCwm/LDDUYmWb
         zYft63IIskFWkvei6l/vdW2n/dK65czc22EIEiWabSw5BFV6xai5ikXVgtuIREy3MoWj
         /TQaeDBUWIGfvzlNH/APsXyv1w0NjvEPm9M8F7HdtfUfHx6IW8oec/Zqcz2iqg9cVeOq
         C6IA==
X-Gm-Message-State: APf1xPD0o62ohiqO68QlXIFJealq4WhDTbk9f3LSnIgY7cLZ4cJ/ZLjA
        ANqN1lFre9vRIzrPyjB5xU9stuQ6uko=
X-Google-Smtp-Source: AH8x224jA72q1aT3+Csc8B0wgaYoB48dEVcrKe1imEowxPi4cKegpynUKLmhvHJYRVQVhHbUrhe15A==
X-Received: by 2002:a17:902:1e5:: with SMTP id b92-v6mr18872plb.144.1518113640555;
        Thu, 08 Feb 2018 10:14:00 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s5sm1624939pfg.29.2018.02.08.10.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 10:13:59 -0800 (PST)
Date:   Thu, 8 Feb 2018 10:13:58 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] docs/interpret-trailers: fix agreement error
Message-Id: <20180208101358.af4ecca9865dca4f04431bce@google.com>
In-Reply-To: <20180208025614.872885-1-sandals@crustytoothpaste.net>
References: <20180208025614.872885-1-sandals@crustytoothpaste.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Feb 2018 02:56:14 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

>  Existing trailers are extracted from the input message by looking for
> -a group of one or more lines that (i) are all trailers, or (ii) contains at
> -least one Git-generated or user-configured trailer and consists of at
> +a group of one or more lines that (i) are all trailers, or (ii) contain at
> +least one Git-generated or user-configured trailer and consist of at
>  least 25% trailers.
>  The group must be preceded by one or more empty (or whitespace-only) lines.
>  The group must either be at the end of the message or be the last

Ah, good catch. Maybe "a group of one or more lines that (i) consists of all
trailers, or (ii) contains ..."?

I'm also OK with the patch as-is.
