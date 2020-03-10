Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45448C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7574222D9
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P25BY1Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCJT53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:57:29 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46148 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJT52 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:57:28 -0400
Received: by mail-pl1-f173.google.com with SMTP id w12so5855181pll.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YvDFmWvqciwaRhAx184n09to0IF6raovIh8jXKvQwQQ=;
        b=P25BY1FqqHXmp0+WtCzUVZdsQyP2IBvTKdWnVwmXPcp9v0mxhWMP5MLvcgIIgTAq+6
         W/YxgsjNRn1fGxq2IlKc3VOSh6tMguo2SSOe8Yhs8vO41B8o5cU0FUrGQrtpie2rKdQR
         6W4fGpC/luN92g+pofxgZhAZGMRapliUjbaVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YvDFmWvqciwaRhAx184n09to0IF6raovIh8jXKvQwQQ=;
        b=cymyxjJtw62mh9SJJXm0eo+pkX3yCCv2c+I8SUINMYllYJIwCDr/Rv+HsL56MaEZwr
         1QpGeFPOheRu9wRKk5S9VELQeCrhaRXZcJHNyOtWHeL0oWkxTpfCr6DeEwCEqP7KJH3d
         xJHRo9kbdsxjZU4wErLKnRZWNrKPPmbprZ9PMCpn80D+6ZC3XyeWCcGX2pgONUDNh6im
         0YgJ+EwFp9Nmg8uvLuH1tkks32pDI3D/MzIn20mlUhLecvPTvTlEPUFYm8u7HAfI54+8
         Oy3dNhqFuZxeDNu0BuOlcYlUzENCh3JeNHrrEN/OW1xBrsN9e/8ZjAxBv1XTA9cn/BG0
         evdw==
X-Gm-Message-State: ANhLgQ12Wd86hSLWDsBlPpoRBWYKwsi69w4Xz1bnFokNYmRFtKO3eTyk
        uDjVNGJXvTRPsGicmTDap3bWQDqDyCg=
X-Google-Smtp-Source: ADFU+vvf6U5hU4wj8S278HReAKOA8TyHoCb5cElkwfunJsi2CL6uMlOwKkcI/4fJNES/+cvgKAsoaQ==
X-Received: by 2002:a17:90b:438e:: with SMTP id in14mr1708759pjb.159.1583870247830;
        Tue, 10 Mar 2020 12:57:27 -0700 (PDT)
Received: from cork ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id z17sm5932pff.12.2020.03.10.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:57:27 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:57:24 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: new file mode 160000
Message-ID: <20200310195724.GE1443@cork>
References: <20200310184111.GD1443@cork>
 <xmqqsgighu2p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgighu2p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 12:46:06PM -0700, Junio C Hamano wrote:
> Jörn Engel <joern@purestorage.com> writes:
> 
> > Something weird happened to us and I have no idea how to reproduce it.
> > A developer managed to create a git commit with the following content:
> >
> > diff --git a/foo b/foo
> > new file mode 160000
> > index 000000000000..b7e7816c1266
> > --- /dev/null
> > +++ b/foo
> > @@ -0,0 +1 @@
> > +one line of content
> >
> > File name and content obfuscated, the rest is verbatim from the git
> > commit.
> >
> > Now, file mode 160000 doesn't make sense to me.
> 
> These are gitlinks, that are used to implement submodules.  I cannot
> tell if this is an expected behaviour and there is nothing to worry
> about, or you found a corner case bug, without looking at what the
> "one line of content" says, but if it says "Subproject commit "
> followed by 40-hex object name, then that is a perfectly normal
> behaviour.

That is indeed the content.  So no bug in git.  Thank you!

Given that we don't want to use submodules for this particular
project, can the git server be configured to refuse push requests that
would introduce submodules?

Jörn

--
This above all: to thine own self be true.
-- Shakespeare
