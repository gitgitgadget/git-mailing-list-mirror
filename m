Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9515F211B5
	for <e@80x24.org>; Fri,  8 Feb 2019 20:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBHUaN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:30:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50553 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBHUaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:30:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id z5so5395706wmf.0;
        Fri, 08 Feb 2019 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N8XUDnBxo6TDJIBtLxa2VIBRe9T4v5JpJbJfBFf48Ys=;
        b=InHoeKb56vcbVQJ3cxj6yCQwtCd5GkzuN+L9EiGCVwQBDCFfXTA19ikJhvESRXFdaF
         lfD1yHhbyBcY2nQ3v0w0pr8+0BENxwqjFQiyd3H61zXeSaSl0UgANzER8KziLx7RpkD/
         RzPbl107pN59x1a6Ry05u8dckOnIj8MXUQNU5mmYNFz+SwntUvudqg6xXmO0CzGkvIox
         JXn2nTuOKoPtRU5tPAJZvo1U4FSgvrOA+RLoqsw0/N7ZN7kW2+jG9HPIyHSG2Ms9lIQU
         g/B3p4YfGU2hkQ7WTQ8QDjRoq5CWRPYHM7Pdnck5UHT49IfP49g/CEr7ORJv8iw37xnm
         Fi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8XUDnBxo6TDJIBtLxa2VIBRe9T4v5JpJbJfBFf48Ys=;
        b=UKJZlgBF5MaChJGEUwR3hoeej04NI34h4lU13IBzF/SAON4GS/ZIzYGtWsryC3qFev
         T0f0MQ4JKhcqU7ytg6D0sbx39DI05no2HJlUZPN0lRlNAgH/hzNyfRzYz5s1K1iPgyju
         gwgwA0DUfK1xjUVa90cMjJoewnYYvGd82T5WPtrabhymn5V06IOFcnOoBYC6+MQOkK/4
         lISl2s32BR4+qBSz2Htg4rfxcHdA1o8lUN5oarweDmVKhBxRT4SAySZtrNg38gRlbLK0
         vFVguiHhB8eShanA8SKt2zuWBEIGVMYKy+lFOh0MqIo3NbwS57/2ziMr6FK6M8FOEvPN
         CjVw==
X-Gm-Message-State: AHQUAuaHyvcRdTYSOEgRKTEL2xpfi/OoIbEDcr8TRMqT9BolXXJEWOcG
        zCBdUmj3JcWv1aykblfYgpY=
X-Google-Smtp-Source: AHgI3IYBBtLisXqIoEqQz3kThybLdcp4I/67lJ6vDFWPzpA1U09Aj6SdVK4LN9UGZD34ZpNlNRLNIQ==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr208144wmj.147.1549657811728;
        Fri, 08 Feb 2019 12:30:11 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id x10sm1720120wmi.17.2019.02.08.12.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:30:11 -0800 (PST)
Date:   Fri, 8 Feb 2019 21:30:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Message-ID: <20190208203009.GC10587@szeder.dev>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
 <20190208111002.GU10587@szeder.dev>
 <20190208201128.GD30548@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208201128.GD30548@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 03:11:29PM -0500, Todd Zullinger wrote:
> It made me wonder how I had missed it in my own testing.
> This one requires SHELL_PATH to be bash, while I only set
> TEST_SHELL_PATH to bash for the improved -x tracing in the
> fedora builds.

Note that you don't need Bash to use '-x' tracing since a5bf824f3b (t:
prevent '-x' tracing from interfering with test helpers' stderr,
2018-02-25) and the followup commits, except for 't1510-repo-setup.sh'
(and even t1510 just falls back to ignore '-x' instead of causing
failures).

