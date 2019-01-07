Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11591F803
	for <e@80x24.org>; Mon,  7 Jan 2019 21:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAGVQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 16:16:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33346 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 16:16:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so757801plo.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 13:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PaJXxoNKggQ7i+g7pBQn6lKpX8fVHustAMwkauM12Gs=;
        b=VVWcmivfmBiQdTwxsGE+RppuiPiCnD/m/bP+2RWfdK4OYlrPsKappdv5wGKJoNXa3/
         OYeiupiEyQIg/d0Qd14zu5AJ4dDdTma9+1bCiUyq2AX4B7Pu1m2jyKQGlsPVaw8gCFa6
         EZEd9iFHs0BGU5x4qlRzISMEQ5jQk43CzadMyPnIIQpVB8y9FmO3eMcNH123Dr9EaWpY
         4+j46qbcl3eh7PUdLTCg9VjYSl0z5N/ubkEY9ghcbDk8Rm7bi6i37rrJxr/2fhzxYGT+
         QVcm+ViHERd+QkmHFPTmGytamBuG45fF7rfvZn6e9afQHLfV8DouS5gyG8l/hP7U/VUc
         2aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PaJXxoNKggQ7i+g7pBQn6lKpX8fVHustAMwkauM12Gs=;
        b=bLm/Rx3AIko3fnBw/4gLcDLURrlqw+Vy6JmS0BY6wpFf9brRvRj995Hw+d84MTp2Hn
         ld38y0JOmXdK/s9cJiCfaj3npYHP+iWHwuDo1bseIYgSw6iJHiYj0ky4fYbtgAjzoXm1
         UHide+tToUnqsnr2TDLpt25Ck8cXD7FvaOvutN/NzliMljj03vKJGMcrsL/tTt6Cr9dB
         /J1dbJR8P5qX4CD0puYpvbj1GmHFt2jd0Cyk0Y305xA1nsx/bJXBDRUNeA4+9mK+z4zK
         oeVh4H0PTWEN8F3O6B0D9HdN13Sg60u0elD+sLI3tbX5PeylLA3lpENRXd/2CXmuB9N6
         aQag==
X-Gm-Message-State: AJcUukdrnFYdrLUJyActF7sQ9htDjC0F4Zo13G3vvBf8hgXoTZmLqnIt
        kgNPxyOPEVWTsrQJ1y+psLQ=
X-Google-Smtp-Source: ALg8bN7sZR9ajMNoUyMSAg4LlkYwPLvsEz2ih0qM8qCIAYVOZm0l09cHodG4uso7vC8p6Rdg36YGIA==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr62103805plz.260.1546895818202;
        Mon, 07 Jan 2019 13:16:58 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t24sm89651627pfh.21.2019.01.07.13.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:16:57 -0800 (PST)
Date:   Mon, 7 Jan 2019 13:16:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20190107211655.GA192553@google.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
 <20181012191531.GA22611@hank.intra.tgummerer.com>
 <20181227185900.GE146609@google.com>
 <xmqqa7khisue.fsf@gitster-ct.c.googlers.com>
 <20190106181758.GF25639@hank.intra.tgummerer.com>
 <xmqqtvik9z69.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvik9z69.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:

>>> From: Thomas Gummerer <t.gummerer@gmail.com>
>>> Date: Fri, 12 Oct 2018 19:40:37 +0100
>>> Subject: [PATCH] config.mak.dev: add -Wformat
>
> Thanks.  I noticed, before merging the topic to 'next', that I
> needed to retitle this further.  I'd use something like this.
>
> Subject: config.mak.dev: add -Wall to help autoconf users

With that change, it would still be
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

:)

Thanks.
