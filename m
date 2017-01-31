Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2DE1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 17:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdAaRNf (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 12:13:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35281 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdAaRNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 12:13:33 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so28823035pfa.2
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mPe+CIS+mqCQTETO/AYLPibtZy0MILL3qt0yU81b/MA=;
        b=tsyPclkKCX6n7T2Ji/H0TfS+9I1oZ1lV3UoV/QBH1tDFfGRtjM77JoPErDAZLZ8sIy
         /XGnw5/3EQyY/Pe/YnpTTCyRsgtaNrAcSBPK8eAat2i0ki3J8mR4UBxLgLwY/6uJEHMx
         G+Tatx4QA0gqG63TBX/oay50cB5V7LMVF6MqqPwdQsqjoMs+9tzP3xigxKtB1kaEECfl
         QiHCdm3VNb1rAoYxxJ39EbpGOW7bukOzbkmWX1Vsdw5YN4F7P9VqhsKwDucZtvxmqtyd
         ZqBLJ6dlzTCrllotoREstoBeOWLnXbA7/+G5QCvrWB9cbxThAwfiwLHlfHlWZaupxV78
         i0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mPe+CIS+mqCQTETO/AYLPibtZy0MILL3qt0yU81b/MA=;
        b=pSXsDBP7tz+sutt+8yb40KYbbuKAq13kvesjxNw2G6XonqJgljXEqVzGUPSmG8mu3z
         9ayz9Be4tNoVTj6Q/xKVus+MpXidJ2JdVouLdXgk7bQQ9Xbcmbjez0xkKHY85r5TOlIc
         xk8P03Q92tM0MmkLfyDG4NTFC0l/jnTEnFgpFovlrIC7X9NG+aDzmceiw4JU45e0FkUN
         58C+ermrZgBlVCOET6OkPV5hDNfScSjPIOvpQQaKF35fNWDjFYIxROT1QpnxygFWZhLI
         NO2IHmhQ7jnHlAfLPstnwvaiaTPpn10yQKFm4mRC1sT2HfdDKxmd6DN8e6EMLSkYtrjf
         Ml/w==
X-Gm-Message-State: AIkVDXKQG4szYPfwxVf9j6UIsHQ2wuTbok2XZ1rdrn2A9ZXXWNDH45eAsD+lpeIrZKUlrA==
X-Received: by 10.99.142.65 with SMTP id k62mr31027433pge.157.1485882813080;
        Tue, 31 Jan 2017 09:13:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id w25sm42926679pge.9.2017.01.31.09.13.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 09:13:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t0001: don't let a default ACL interfere with the umask test
References: <1485636766.2482.3.camel@mattmccutchen.net>
Date:   Tue, 31 Jan 2017 09:13:31 -0800
In-Reply-To: <1485636766.2482.3.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sat, 28 Jan 2017 15:25:48 -0500")
Message-ID: <xmqq37fzrw3o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> The "init creates a new deep directory (umask vs. shared)" test expects
> the permissions of newly created files to be based on the umask, which
> fails if a default ACL is inherited from the working tree for git.  So
> attempt to remove a default ACL if there is one.  Same idea as
> 8ed0a740dd42bd0724aebed6e3b07c4ea2a2d5e8.  (I guess I'm the only one who
> ever runs the test suite with a default ACL set.)

Thanks--people with such a configuration who run tests are valuable ;-)
