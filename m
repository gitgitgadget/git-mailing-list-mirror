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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FA71F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfBHUfq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:35:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51431 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfBHUfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:35:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5435317wmj.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 12:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9Xange0qWviuloHWmTgcu+KSGGT91NbAFoDoG5tcB5A=;
        b=ZyrC/qpBu4rmv46eMOsZRJNlDnEMy27W5ZTQ1WojMQJMbdO+gamNY/dXoMRLESwnws
         a7cL3E8woQjdf3DARZEelENojeWMwapHjRRBv9nX3YhPNEcjF4IM947jS007Peavs3wR
         noDi88nCWwEUtWyYnsVextpD5NR1F/UkBmt7tCBPkdWdybaGPlcwqaVzhCEOnvVS6bju
         wWYDi3RoTsVmCn2MnGW9NiIt6lqNrpk26Z2A1TceuO9ujj+gTZSsl+RbSa/DXtXR7b/n
         VwJYmHER8ALDGNlNO2kRIt3sReFwf0kJojiob7eqNmcQyJtc+rWxuXQMJx/o0ToFffQx
         KZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9Xange0qWviuloHWmTgcu+KSGGT91NbAFoDoG5tcB5A=;
        b=UuouKW/jPfB5d57rAXYmobXarhTCZI1aPd0JSo/Ed5L/AlbeKXCCb+BSp0Hj2E9S9M
         7PrGTdD+U2RJcKoPzGtd5NCBrf0frjHF6iXOL7lT6FcIofLHHH5X7mEuOnMvxSqBBXjX
         tQBElp5NG8b77Oq1FZ3u8ij3kMfkzyjrm1rPsdSTvw3MC0PsxK0JYQ+NdYQ8x/vxtQIz
         rzdbpfWy7D7Fy2E5/4xX+xyNWAqqGjMZ2flLPqYkghUwvQf9dI+TFtCI80N3DiAQy8gM
         7ReDgffka3I3tLh8fNEN1VR1kOIXKz1cNvs0xzt+cw2PKTfrLrMPvBw6WQCsON/rQgXf
         V1dA==
X-Gm-Message-State: AHQUAuYcsLn2nZkln9nSZxd8Ro/hxDwHQ1ENdmJmrU0JmEw9AcZfWyW5
        fWIJtoY+MH9ObNDjnYp0oBo=
X-Google-Smtp-Source: AHgI3IY5VsAbe/OnEZOwp+kapZkZGZ4EXXzTFMEq9Rl4ELdhWyuh5EbkmWTwIvYWsRPItpd+Lw1QxQ==
X-Received: by 2002:a1c:494:: with SMTP id 142mr232653wme.111.1549658144747;
        Fri, 08 Feb 2019 12:35:44 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id m4sm4596039wrq.6.2019.02.08.12.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:35:43 -0800 (PST)
Date:   Fri, 8 Feb 2019 21:35:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
Message-ID: <20190208203542.GD10587@szeder.dev>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190208031746.22683-2-tmz@pobox.com>
 <20190208201105.GA10587@szeder.dev>
 <20190208202505.GE30548@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208202505.GE30548@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 03:25:05PM -0500, Todd Zullinger wrote:
> SZEDER Gábor wrote:
> > On Thu, Feb 07, 2019 at 10:17:45PM -0500, Todd Zullinger wrote:
> >> When gpgsm is installed, lib-gpg.sh attempts to update trustlist.txt to
> >> relax the checking of some root certificate requirements.  The path to
> >> "${GNUPGHOME}" contains spaces which cause an "ambiguous redirect"
> >> warning when bash is used to run the tests:
> > 
> > s/error/warning/
> 
> Did you mean s/warning/error/ so the sentence reads:
> 
>     The path to "${GNUPGHOME}" contains spaces which cause
>     an "ambiguous redirect" error when bash is used to run
>     the tests

Oh, wow.  Indeed that's what I meant.

> Is it worth a resend before Junio queues it?

I remember Junio taking care of minor touchups to commit messages like
this, so maybe not.

