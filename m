Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B731F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeAPScT (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:32:19 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41080 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeAPScS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:32:18 -0500
Received: by mail-pl0-f50.google.com with SMTP id q3so6804517plr.8
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dXwgXPpkvIF5yxyHNlCM91R3WOnQPYZ5gh61IPDVlFM=;
        b=JGTfmWbkTxbNUgp6FlvkDpRzdQfvDQdwuW89k58sS19J1HNmfn3LgjGZ7oMnl62H17
         jKI3f5e8p6T7qI2erhFHkVJvklzGQILLk6i4uNbxRR5rctHy3WMH0Fo3UCDK7w71QstX
         6RVGqI6Hx3SBBkVbBYc0mvNEZbamHuqoRprLfxfy3TVxmYkyxhrH1XRyVkRNdsDggRnq
         3HeCRf7gsVvpNVnaqiI64W0Lst6SyesVVW/2ZDepF5aWMqlkYvFFAmH6LjFcEvybtuSG
         HsGEK4rU3VHnM9wak0evahQ2ohcxVakcO9tUvRgkgLe3lgMRMfbjk3l+vpuQVHvh0kkb
         29Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dXwgXPpkvIF5yxyHNlCM91R3WOnQPYZ5gh61IPDVlFM=;
        b=rmbCA5p0YhIBftkvBa39h1e4pbiV+DLFgsij2aW3Jd3/jbaJSpSgyJa7+eLgiax/zm
         pEIAfhkyNlG/kmTPtaSCdNmJoE5y5dgF9sJ6IMNi6w+wMnK4XzDqUdLQmYeUPfevX81l
         IOouAPjFLoiK1a3Ql/ITn9Evrk05cOsAPjyuWRzdHKYb1Ra26Ft0YoQSMmWbaegdd807
         Dx0gj96a+8Vf8XSuCEfbb257DUnCynT97l1rAaXu5gc1+XwEXWT3ukl/VqG4B6V5lmg1
         JMeTb2IiHc4p7Xa1GlC4sVPIxoY/tgGxEKDMBbdUHT920DbJhFck3A8A8sQx4Vy/6Ldg
         telw==
X-Gm-Message-State: AKwxytfRlQibRw6xg0JRsbaB88hDlKNLKy3KsHV7Qr2OKanwxG7zOQSe
        SePiWi/0M1/HVhcV8s+W0CM/rQ==
X-Google-Smtp-Source: ACJfBou5klWmw13XBnJs5Gk82yabX7purbjbAvPYMvtAY1/lZNZjaBacmh7M+mwlYXyv3KBRFVIQfA==
X-Received: by 10.159.205.133 with SMTP id v5mr15340966plo.37.1516127537938;
        Tue, 16 Jan 2018 10:32:17 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f523:b526:bbca:bb86])
        by smtp.gmail.com with ESMTPSA id l88sm5887474pfb.149.2018.01.16.10.32.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Jan 2018 10:32:16 -0800 (PST)
Date:   Tue, 16 Jan 2018 10:32:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 6/7] trace.c: print env vars in trace_run_command()
Message-ID: <20180116183215.GB135179@google.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
 <20180115105949.18328-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180115105949.18328-7-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, Nguyễn Thái Ngọc Duy wrote:
> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes it
> hard to tell that it's not really executed on this repository.
> 
> Print the env delta (compared to parent environment) in this case.
> 

Code looks clean and very readable.  Also matches the last one wins
semantics in prep_childenv.

-- 
Brandon Williams
