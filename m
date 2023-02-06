Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42502C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBFWoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFWo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CF3028C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q9so9262070pgq.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BUPGCpZB9vi2+FL+9CxEe+qnHqAg50LGnpQojh5y1A=;
        b=G6ryzTHbbHqy+wvo9652fXceysFlbbqrrzlPDP0/23YQDJ9upGqsSzE3meDlKpEfOw
         TSnZ6rh9yIlz75qRIcmD+yM7LqoHwd3wIisEytQPa0UCi90E+nM4XmoqeKGitCcpPGuD
         vL/IjXo4VjGmsVLlunIXj/3oxCHTTPwQkdOy4fKMZB3aQvOR/GhykPmHqxSQzOJxTRo1
         SL/mWRqQVveVFmLQMAvvtsBAmpBU1PBgeqSSnw8/LbxaGqGXVZc0e7HQLGcUP04AT1Xg
         h1hq+H/vIIutQbEl/eRuhhwPdWhbXhZS+q+CmlsGq1hN/DcTBeGsk6JLUlVlICKVEnWO
         zzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BUPGCpZB9vi2+FL+9CxEe+qnHqAg50LGnpQojh5y1A=;
        b=jMnBiU4oApckXeiLfP46hbeSr4AWINBwP77NUUZU0ElBCX7qw7SAFFSA5e/0zpQttU
         Nnqofzo6oEq8YkGHHbp/HE6DQmlt8vQ2z1ug4tmnGVM3Cfd3LqDr+tuZXNlCK4ThOf/p
         UbDSctfebheKQQiutIQucpl1pRFFBP2Pw6IDiqN6ZxVTUndaGMq20JS/uShgC/WxV1s5
         VvupAFKlpDTYHuPjE+oXfMKvlk5rCF158uwdLc8B8iBOLXRSjsHcstaCBHOIrCMuSo1f
         OJykb/Yd8qZIetWrergOIocLteCBiLSt8c4raxQgY2PO3pagkAd5z5qRADnbsevMKE2R
         Khgw==
X-Gm-Message-State: AO0yUKWFaydP12sSr0jkhal6eLnICb7Z1sIpEyRKtV2dBbpUvbHwiBw/
        MxKrS5NDJA1IG0PJGQXLBcZ4zl+gLoE=
X-Google-Smtp-Source: AK7set+gHLgq024ftTKiBA3CoNjf5BBaR4mLWw+YkyKCLP1clJGzXMdONnHavE6zwsNbLPuprP2g5w==
X-Received: by 2002:a62:8412:0:b0:58d:c1ca:9360 with SMTP id k18-20020a628412000000b0058dc1ca9360mr1245972pfd.17.1675723467989;
        Mon, 06 Feb 2023 14:44:27 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id o185-20020a62cdc2000000b005815017d348sm7891947pfg.179.2023.02.06.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
        <20230206211823.8651-1-cheskaqiqi@gmail.com>
        <20230206211823.8651-4-cheskaqiqi@gmail.com>
Date:   Mon, 06 Feb 2023 14:44:26 -0800
In-Reply-To: <20230206211823.8651-4-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Mon, 6 Feb 2023 16:18:23 -0500")
Message-ID: <xmqqlela2z3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> -cat >test-patch <<\EOF
> -diff --git a/file b/file
> ---- a/file
> -+++ b/file
> -@@ -1,2 +1,3 @@
> - a
> - b
> -+c
> -EOF
> -
> -echo 'a' >file
> -echo 'b' >>file
> -echo 'c' >>file

Have you run the resulting test?

>  test_expect_success setup '
> +	cat >test-patch <<-\EOF
> +	diff --git a/file b/file
> +	--- a/file
> +	+++ b/file
> +	@@ -1,2 +1,3 @@
> +	a
> +	b
> +	+c
> +	EOF

This creates a "test-patch" file with lines 'a' and 'b' that are
common context lines without any whitespace before them, no?  The
original left the necessary single space in front of them (see the
line removed above).
