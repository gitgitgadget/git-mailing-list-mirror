Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1966C20281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969477AbdIZWU1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:20:27 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:57307 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967151AbdIZWUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:20:25 -0400
Received: by mail-pg0-f49.google.com with SMTP id 7so6658127pgd.13
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAgGkzCnRk4m1XQtpQv374rzTrkidqV4mVpSDbu0E5c=;
        b=PICm4wS/5ljZFU1YoDVksysVqFD8TG3SfmXDeHCNymNX5TP7aNTQNPxC51ysg809Dj
         n6OT4xBFR0T7ZJ0sCUauooRpCc85OFfI279kTFDGo1FuTqY4T2cqzCwuJjdsiaV7NuHI
         +EDbNF+c7NO32vbopveiG4u9g3BL6Zgd5Z/aeIWpw3h3Fe44bjD4bX4AWmVNer6T6gkY
         g1tuxOUjvwGo1B5u/fq/+KyGU2BWxQQqlxycDH4TGR932IeDmMvhcnz2yo+Jx4Eo3TXq
         s/e6AiGjJjLHglJx9j73GzoX1oiwxxfCvgI9tW7tzaY565bn4bQcYjgIsUBt50+Yo/4T
         BnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAgGkzCnRk4m1XQtpQv374rzTrkidqV4mVpSDbu0E5c=;
        b=fsbtWU9W6L3lLHIoD4mKD+3bvFcdMUc82Anfzlncl/rcWFYmvULUgKeaaAJZu++FzB
         zQqi9JEdvwzcjbpwYFmdddq1OH3byHIwkDG6Uk99xsghHD0yJFSPSucN9GzIYnBDHFdv
         sBtRDlFu7ASCFZPS1qOmntyhD6hPMMlyGxxHiMcCkWM4WKHsqbRLoJ/SQ5mQ9v3RUgkU
         KYMQn2iQX16ZM1eoULezIby2oY2ClUlqol1k+vy6eJwdAvZI2UaPltwqwRlCb8va8qKM
         pBOSO78mZnDNffgrtkDjc7F8R3H9Wf30Z89C5XYQoLrWZpzYHrY8ZWEEfmsG0quL1D3Q
         1x5w==
X-Gm-Message-State: AHPjjUjnc1HjcDa5hWKXhtHYBH/zTkGk1z5m5O3uhe/AsmjuyrV4cWjv
        4iKWD+M3yq1MYCxY/RjigCZoSQ==
X-Google-Smtp-Source: AOwi7QCCtndTpXKi+2p8ERi66uftsS0C3El5EsZfxkI/F8QvOOEmkEgohIjnvYYIv/CgSiJUb5h4fw==
X-Received: by 10.84.229.6 with SMTP id b6mr11866007plk.401.1506464424409;
        Tue, 26 Sep 2017 15:20:24 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:51cf:598a:e16a:8a0b])
        by smtp.gmail.com with ESMTPSA id r11sm18229298pfg.180.2017.09.26.15.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 15:20:23 -0700 (PDT)
Date:   Tue, 26 Sep 2017 15:20:22 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
Subject: Re: [PATCH 02/13] oidset2: create oidset subclass with object
 length and pathname
Message-Id: <20170926152022.67d3d6bcc93d862aa1066207@google.com>
In-Reply-To: <20170922202632.53714-3-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
        <20170922202632.53714-3-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 20:26:21 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create subclass of oidset where each entry has a
> field to store the length of the object's content
> and an optional pathname.
> 
> This will be used in a future commit to build a
> manifest of omitted objects in a partial/narrow
> clone/fetch.

As Brandon mentioned, I think "oidmap" should be the new data structure
of choice (with "oidset" modified to use it).

> +struct oidset2_entry {
> +	struct hashmap_entry hash;
> +	struct object_id oid;
> +
> +	enum object_type type;
> +	int64_t object_length;	/* This is SIGNED. Use -1 when unknown. */
> +	char *pathname;
> +};

object_length is defined to be "unsigned long" in Git code, I think.
When is object_length not known, and in those cases, would it be better
to use a separate data structure to store what we need?
