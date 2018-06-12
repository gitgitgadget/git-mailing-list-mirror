Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DD71F403
	for <e@80x24.org>; Tue, 12 Jun 2018 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFLIvt (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 04:51:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36999 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933487AbeFLIvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 04:51:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so23168717wro.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DU6iypZMssUW2L/SD+JFlxToJLYqusHvoJWBDseOnB0=;
        b=Hb2PF8Wl0ace9AyQxw7hjO/tWpI8avqOy4F+x7aTaC9VDOYB/7MEe2h5XexrlrojBE
         2EukVZYO875vKU9+p9QHOFrKOVtgbPneQGEESXIe0ddI3IYWGRWPy0HQ2bIUpGUEuCI+
         SnoeB0bVrYbYyO2vt6YS4ubTU8AmzWIJcAfRSSyzqFcxTDIfy5FuBRmX7+L4LY6fFtFn
         /bqffNLVXOsz+77fc+iAB7CbJ0uaNpuPbytd3nSyJytYpkNPUxwpyvxt4/ctgaHsUDVo
         0AcQGroY8IIFhgPGLaImZfuVrfOsC3//7tfhYzRG5z31pP1ZGOx9Kx2uNGmoI4jDXnXD
         r1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DU6iypZMssUW2L/SD+JFlxToJLYqusHvoJWBDseOnB0=;
        b=U7HTxXyKTM/tXVJLsrg0AkOGp3MehDykh+nVmpR7CwaxVehsmgYRCW7CUI+MuZ1+yx
         BmfBo9dFYVPeddRukYSopNdwRrOba4XNrD8FMvXyQy1vDQb+s1dGk89fQ6GsVA+JsdAP
         7cWIlEG8fvjcgK/vzLjL3DRK3GyxKS440DMv/cSdjPfKWxf2c+DH0cAQHLizPfXaIJY3
         9tqBpX8uNyEPYqviBlmmO6ND5R9fvTVdUiTPbVZWPsaxHDsHQ4Fbp5gG3Qb2BLR8fH5V
         W6L1DK3rur6sPjLWn1ZsPt63Ur5UR+nFY/9wkpxMAAPBGekOIxFaZ359KrIYuRJN6Ij4
         NOzQ==
X-Gm-Message-State: APt69E204RLXsfRPgNXRAaLPYjPI8JDoWEaxX9xDyLyKXdC+8+4y2LNV
        skWVUR6N24sWRa99L+Bml+6MXeaMnQY=
X-Google-Smtp-Source: ADUXVKIpMf70s+jxhRlroljS4UCT9DlckUCEhhLduq8zQQsltdgz1csAYk5cRqq5lR6abVrq92ufyA==
X-Received: by 2002:adf:9383:: with SMTP id 3-v6mr1863253wrp.220.1528793489987;
        Tue, 12 Jun 2018 01:51:29 -0700 (PDT)
Received: from aaaa10152750 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id u15-v6sm1069251wma.37.2018.06.12.01.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 01:51:29 -0700 (PDT)
Date:   Tue, 12 Jun 2018 08:51:19 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     drizzd@gmx.net, git <git@vger.kernel.org>
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180612085119.GA5@aaaa10152750>
References: <20180610194444.GA1913@Sonnenschein.localdomain>
 <20180611203541.GA6@606faba9ba17>
 <20180611205704.GA1399@Sonnenschein.localdomain>
 <CAGHpTBJFwToEwnk4P17AJ+z-55Nzc04OBbTvsbFRrkXJpfXAkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHpTBJFwToEwnk4P17AJ+z-55Nzc04OBbTvsbFRrkXJpfXAkQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 09:13:54AM +0300, Orgad Shaneh wrote:
> Some of my colleagues use an ancient version of Source Insight, which also
> locks files for write.

If that application is locking files for writing (that is to say, it did
not specify the `FILE_SHARE_WRITE` bit in the sharing modes during
`CreateFile`) then this patch would not help.

Applications, generally speaking, should be locking files for write.
It's the default in Win32 and .NET's file open APIs because few
applications are prepared to detect and support a file changing out from
underneath them in the middle of a read.

> It's less important than it was before those fixes, but it is still needed
> for users of Qt Creator 4.6 (previous versions just avoided mmap, 4.7 uses
> mmap only for system headers). Other tools on Windows might as well
> misbehave.

I don't understand what mmap'ing via `CreateFileMapping` has to do with
this.  It takes an existing `HANDLE` that was opened with `CreateFile`,
which is where the sharing mode was supplied.

I would be surprised if there are other tools on Windows that have
specified `FILE_SHARE_WRITE` but not `FILE_SHARE_DELETE`.  Generally
speaking, if you don't care about another process changing a file
underneath you then you should specify both.  If you do then you should
specify neither.

I'm not saying that git shouldn't work around a bug in QT Creator -
that's not my call, though I would be loathe to support this
configuration option in libgit2.  But I am saying that it seems like
this patch doesn't have broad applicability beyond that particular tool.

-ed
