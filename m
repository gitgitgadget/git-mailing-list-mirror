Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0F81FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758395AbeAISl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:41:28 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:42572 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758354AbeAISl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:41:27 -0500
Received: by mail-pg0-f42.google.com with SMTP id q67so8565321pga.9
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiojifUx8RUcXIrLlVfjj4K9ks0WlJQOq5aPoOjdZ38=;
        b=CE5Ot14Z+F/prkx1OzKwSRJpzWZZDSbQZQx9lALu5A1XlYvZ2nXYceULMD8oX8YE6x
         OhtExA/jThUk7ud87IMdm44ONkco8GxqTXrICZN6Ix/9kY7jyInO6lR4st7ZAF2FxGxX
         YgeqOia7GsK6FWg9dZYMtsFkBzaAhdlZ5kR9icnOOlR2tPXMgbue292bNFzUlOtlIbTt
         F0iHmRZ6erno2+CtF+eOp0JGS4dRocxBbKhLibHgRZtPG3vaMLLfu7RDVBV4idGYyi5Y
         W2GVF5yehld/hybT2SYWVBOrn5sZ2kGMkN6FOoFZRUOs0LkLoPJIsOOymAsFrqfYbjXs
         gbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiojifUx8RUcXIrLlVfjj4K9ks0WlJQOq5aPoOjdZ38=;
        b=PPWSaiBr+pggoDRLICYL0Cg8+5SFKENGrLQ0AJjBf6NinluMJ8kCzH29a6nqCl+KEo
         niQMyvfS5bgIBCDosDQYkyFC6V/8He9+cgxBHwymEIu/2r1BfFt6ze4sLmUEpjfdM4e0
         jmT9FjadhWgC0K56yifXjIp7Hb5+DJRE3epnGTE/1VPLmco5tREv5e0g7XetkDqRESHQ
         IgBxKtAowamkmeMuaWckNPEuVuT3MMJT9wRavBpkCLKQW+iO/7nvXY/TtB4/33P6BANZ
         +O4BZqr62CqSlaJ6YF6STup/Tndwc7W1Hobg4N8nzQtO9Zmrg9E/XVrLdR6FIotir4vt
         IfOw==
X-Gm-Message-State: AKGB3mJckPIp4U3dVBAKjaAmeldljxn9TYhZy8H2G5Pyu+8QugznLwhf
        mTAWANV4qB5Iz5DuXEshfay6tg==
X-Google-Smtp-Source: ACJfBovCG3IcyxYbhSH7h68KMRBNeGcAZEvJKVIsQ8Sr0sjnk5G4otPNRGSwF1oX05Jicc4fpnm+ow==
X-Received: by 10.99.47.67 with SMTP id v64mr13134900pgv.150.1515523286694;
        Tue, 09 Jan 2018 10:41:26 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id s81sm33859889pfg.60.2018.01.09.10.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 10:41:26 -0800 (PST)
Date:   Tue, 9 Jan 2018 10:41:25 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 09/26] transport: store protocol version
Message-Id: <20180109104125.4cb1a3e545cfe354862e4b8e@google.com>
In-Reply-To: <20180103001828.205012-10-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-10-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:11 -0800
Brandon Williams <bmwill@google.com> wrote:

> diff --git a/transport.c b/transport.c
> index 63c3dbab9..2378dcb38 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -118,6 +118,7 @@ struct git_transport_data {
>  	struct child_process *conn;
>  	int fd[2];
>  	unsigned got_remote_heads : 1;
> +	enum protocol_version version;

Should this be initialized to protocol_unknown_version? Right now, as
far as I can tell, it is zero-initialized, which means protocol_v0.
