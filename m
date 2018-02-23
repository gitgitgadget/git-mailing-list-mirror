Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA9D1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeBWTh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:37:27 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34250 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754222AbeBWThZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:37:25 -0500
Received: by mail-pf0-f178.google.com with SMTP id j20so489047pfi.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wvq2Fqqh4oB/p7hyimizxTOAqIE1cX6qzuG7Rpn2rHg=;
        b=Lshd6+pHcHekVdCFiHsSejBUUMZy2pPfUYNEn/aLWGYzsxoYAGBfxakT3quzXsgJp6
         Cv6Tb60Fv/xL5BJFpsyrThZLZr1D3VCl3zPRiSFT5ZQCXvU8hhJt64lBsf2hNYYndab4
         rS9KvMFOmkGVuUzGzFEhyk9Qn1hDJ/IBOutPI+xhBsnneM6ap0E3JdQk4o1MA6jRlGZS
         UiubItoC+0ZYLSLuwAovvHkihMQLqaxE7lV4N8EfE5bNJha3FyzpUNH5Nt9glmC6i+8/
         lw4UXygVHrvCV8ZFpZEMTLwn6tOzOPKOl9hRqCVAdsL8YOOOa9X8eCRXKxoFfIPM7wOR
         vppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wvq2Fqqh4oB/p7hyimizxTOAqIE1cX6qzuG7Rpn2rHg=;
        b=Ga6ncc72PAAsgb3OK8b0Rsvd8oGDjWIlGrs6JnaucH7YBFrEbWE9OX509bhXktYBU8
         4q/ywwsnZXNHqguoCs/ZBJPDUXN8dtthaZ5/V+y8MG2FbCOxs1nRhEmbEuaGcFS0KKdA
         zo9wZj/wyZ0XoZdu3swslUBh/R0+GyZuT5npOm/XbXQxAyF7jt9pDE2DA/7G58Bclrjj
         RUDSUG01xgWIPgjYW1SpxoInvKLwq4QjzR6jj2U/mZ892VJsRlrbiRLmx0XjRRy0sLzH
         byueSM4SOVYj6i+6UB8kfzDxpbFn9aqNAAofS+s0+/2KKkjwm8gOd5oE4vgvTVheo0mp
         CoPA==
X-Gm-Message-State: APf1xPCklPggXvzeI1gqED+9yUdYnLfxcV3EdoXJkyTmpGRnuiyUyvHH
        f7NrmS64Q+e3gWEPx1SA61tXCAw4h88=
X-Google-Smtp-Source: AH8x227NZbWBU+li5WD2W6QMnbMGhgnZK0u/CylazoByf3iF0u6Cu+Iq/uQgFl2MrWzN+GdLfkJj9A==
X-Received: by 10.101.66.1 with SMTP id c1mr2243247pgq.137.1519414645014;
        Fri, 23 Feb 2018 11:37:25 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a87sm6359410pfj.13.2018.02.23.11.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:37:23 -0800 (PST)
Date:   Fri, 23 Feb 2018 11:37:22 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 23/35] fetch-pack: support shallow requests
Message-Id: <20180223113722.ac4a8d3ef18bec31f20e79f7@google.com>
In-Reply-To: <20180207011312.189834-24-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-24-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:00 -0800
Brandon Williams <bmwill@google.com> wrote:

> @@ -1090,6 +1110,10 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
>  	if (prefer_ofs_delta)
>  		packet_buf_write(&req_buf, "ofs-delta");
>  
> +	/* Add shallow-info and deepen request */
> +	if (server_supports_feature("fetch", "shallow", 1))
> +		add_shallow_requests(&req_buf, args);

One more thing I observed when trying to implement the server side in
JGit - the last argument should be 0, not 1, right? I don't think that
"shallow" should be required on the server unless we really need it.
