Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CEA1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 06:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIFKoa (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 06:44:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33995 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIFKoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 06:44:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so4467292plo.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NiC39RiNGz1/opldl1pLx6xcyXjxb4Mk/J29n38YYTY=;
        b=t0An8RCWgFQvXZFYDiqdrqPtAtp10eMMP4fYyODtjZ98e6WUCK1xR4oohCN66+weS/
         Xsn8YEssTOuX6/9J+jdeE8xOdaEJuyh4LReFgOb06NVZ8VzzG8DRL1qt3bDbNYYJZMCd
         RU3azQWRQjHjFmnu3dViHnsm7QCQBzxOlT9sTAkUc3le6XXz3VosLfX8Ok2u4RfJoz5D
         IX1tU1XBWDK4hwCLEv4BRZ1FtvTs4Cv5kZH0VmNDwT15t99wLX7gffYJcfLLMpDnavv6
         l4z/VQYaotaAAyOS52th1D0g6+R+Whfuz2FLmbp56PWspA71ppb1tAs0kQ6S+beKiAy/
         nM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NiC39RiNGz1/opldl1pLx6xcyXjxb4Mk/J29n38YYTY=;
        b=OGvFjEQSSpCZRcsLKM1hYVANSJMvLZOvSSw/N46XhrpZXIq9V0UQYq09V3qO/6yWsU
         tDqBarCYjElaYIiUtqZdZnl4ffrXLiB52//+dAUrLfaXa4L251pLVLFN26+rr6VFwm3m
         CwP6JCkYN84FrWz8JEiXXVFJrde0Eoan4Q1JA7eBVTQjRa6Z858VfORPxkJh6xx26vPj
         prwaoUFCPwb8azFRb4jnJ5OQTDnYQe2/Rs2iJckihARGswi4W8lWR4OhE4LkL0sLYfch
         QS0jtDpjK9M/Mp8rv1oUaUJztdSKr1H3F83cigceS1BmGQw+oMz7G0UmzdHOwJ3wG/Bh
         NMJQ==
X-Gm-Message-State: APzg51DX10KmErjglP4lGTXjX7KXwz9sLFFYe5E2VPNu8upysb17z9+r
        t/UPxVezIXXud89LPB/IpOrJctC1
X-Google-Smtp-Source: ANB0VdZz431Z1Z91B/LOVsUu11uTA0iqnSbACBwHqFEHVC/8LKzsYNUphBgQZQ12Q8fXawPOeUvDBg==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr1223478plb.298.1536214240730;
        Wed, 05 Sep 2018 23:10:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m15-v6sm6161681pfk.149.2018.09.05.23.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 23:10:40 -0700 (PDT)
Date:   Wed, 5 Sep 2018 23:10:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>
Cc:     git@vger.kernel.org, Max Kirillov <max@max630.net>
Subject: Re: CONTENT_LENGTH can no longer be empty
Message-ID: <20180906061038.GA94045@aiede.svl.corp.google.com>
References: <f12bc1d7-6acb-6ad9-2917-fbb09105f87a@debian.org>
 <20180905202613.GA20473@blodeuwedd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180905202613.GA20473@blodeuwedd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jelmer Vernooĳ wrote[1]:

> Git's http-backend has become slightly stricter about the content
> of the CONTENT_LENGTH variable. Previously, Dulwich would leave this
> variable empty but git now expects it to be set to 0 for GET requests
> without a body.
>
> I'm uploading a fixed version of dulwich.

Thanks for tracking it down!  This is likely due to v2.19.0-rc0~45^2~2
(http-backend: respect CONTENT_LENGTH as specified by rfc3875,
2018-06-10).

Max, RFC 3875 appears to allow a CONTENT_LENGTH of "" when no data is
attached to the request.  Should we check for this case (e.g. inserting
a *str check in

	if (str && !git_parse_ssize_t(str, &val))
		die("failed to parse CONTENT_LENGTH: %s", str);

?

Thanks,
Jonathan

[1] https://bugs.debian.org/907587
