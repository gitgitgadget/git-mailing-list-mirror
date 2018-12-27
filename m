Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD58E211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 23:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeL0Xza (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 18:55:30 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41433 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeL0Xza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 18:55:30 -0500
Received: by mail-pl1-f174.google.com with SMTP id u6so9308628plm.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 15:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCaKMXnic4a3DYPhYSSSFgYm9b4Lq8JwyiSavkiZjPw=;
        b=iGLCwkXebCR/QjaJGnwYSqRQxGpnho9DybzLVBaJnmE8HrRG6xTEQ0w3E5M8/d/YwH
         /cRJAvGAkS2PL12Rll0woSr8+85gSp8GG6PAvF42uGeNq51v6TEp496Jtj7w8DOXzWrV
         hYzz3/gX4BLCOBbTjld2v+tN6LHAPfjLxNzern1uiex97PWhVuoQnQUQtwNkDaz5dXGw
         ZgsgMw97zGg0DHm3HzoZ6Xeszk/F3XlQj0UBQqP5kQ7oQTYm9d2w0SpbbJJHxQ710Wtm
         07MzOGHN38tOqDerQYVkmtdr3IA/wPWjrnboPLSv/LdU6RQWosdCblRTc8xR8yrXVKoW
         SWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCaKMXnic4a3DYPhYSSSFgYm9b4Lq8JwyiSavkiZjPw=;
        b=tvBy6HYKfHK5TRKoYVdpDMkCB5KMwe7hI/9L9zAce8/FQyXNWJVvGKB6jFB6ZSLHkI
         yPbeptUy2cCOTlrdy4LwhwbD3Oki1qLgLFuKUN/oKt4eCdEQL0ToRMkutt5B8V+sunyS
         il7ZGSyPT7YYVOqeH2q7AxhHp8tdC71jYs0Y9Mx44Er/S6r5+XnBtJshEFD0pih2Z9G0
         Vf+cJR3L/uui95NEJsjttAlRC2o8dT0kY0a+/8qyJXKSq28A2fTLvZqDYwUDyqejIsSE
         hB/3U4n8lJZ1Jb1be1dXr8ECTJn+tRzNqU4BAqGUHkLsFJfCpGcnbMehjAow2363SUJV
         C/IQ==
X-Gm-Message-State: AJcUukfarqu1dcUx7YHf8CY6x8GCn6lCSzZEmhCmZyaoOo/Tg6Hhctgs
        QqOJK47+/pEKt1+QxknO3wrxEyGD
X-Google-Smtp-Source: ALg8bN4XIZCm5L3ctZr9H418RBbg41s+pPvGFAGQXD8by5/XLBuJrXVRD497tT0w4At4F4t/M+b7cg==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3mr25467947plb.83.1545954928108;
        Thu, 27 Dec 2018 15:55:28 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k191sm45864522pgd.9.2018.12.27.15.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:55:27 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:55:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     git@vger.kernel.org
Subject: Re: RFE: version-controlled merge rules
Message-ID: <20181227235526.GF146609@google.com>
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

H. Peter Anvin wrote:

> [merge "version"]
>         name = Version file merge driver
>         driver = sort -V -r %O %A %B | head -1 > %A.tmp.1 && mv -f %A.tmp.1 %A
[...]
> However, I can't even put this in .gitattributes, because doing so would break
> any user who *doesn't* have the previous rule defined locally. Even worse, if
> this rule needs to change, propagating it to all new users has to be done
> manually... never mind if it needs to vary by branch!
>
> The simplest way to address this would presumably be to let the
> repository/working directory contain a .gitconfig file that can contain rules
> like that.  (Allowing it to be in the repository proper is probably a
> requirement for merges to be handled correctly on bare repositories; I'm not
> sure how .gitattributes is handled for that.)

The main issue I see is that this would make it a little *too* easy to
run arbitrary code on the user's machine.  Build systems often already
lead to that, but users are more familiar with the risks for build
than for version control.

See [1] for some related discussion.

That said, using the include.path feature (see git-config(1)), it's
possible to do something similar:

	[include]
		path = ../.gitconfig

Thanks and hope that helps,
Jonathan

[1] https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
