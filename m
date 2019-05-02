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
	by dcvr.yhbt.net (Postfix) with ESMTP id 570831F453
	for <e@80x24.org>; Thu,  2 May 2019 00:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEBAE1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 20:04:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 20:04:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so657158wrq.10
        for <git@vger.kernel.org>; Wed, 01 May 2019 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/yixyYu0ft9xRZYqr8E0II8Un+ksJVV4X7saw6xlSZ4=;
        b=KHlnZhETubxoIVhcY3AJeDMXSpkCaxO8z6urOQ74taZ1QvGVQjqj8ha/B6PbfmxAdk
         as1uGt/gA9/8IztH0L7z2dmF91/QFEMPbNHYfNIcbeachAIn0PXok78+YeWEvJGcPVqM
         Punp2LW0Dym0aAFw1irAZ1I+WGnusGyGohrU0diXDVEpYL4J+B+nesG8Th11no8GdhYM
         gXu+f9uof4PoP+kIJ1hqU/dk+cPZAs+OdC16pM/v3m91I6UDX5mHiQqBnLfsdu053ZvS
         rv/NRNQ2PjflsfvGilPBdkCrm8LjqYVLsJpiYdwproGwW7fwJ3/fKpXI/FtaOt89TDX/
         dQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/yixyYu0ft9xRZYqr8E0II8Un+ksJVV4X7saw6xlSZ4=;
        b=cY+8A6DrIPPk6D4y0aRt5pjNHfgLYhA4xopk7lOg0+WGxQPoJMPCkeVxxghDnMcjLq
         axzqnBLr2qCZS7GQrTwGxf7HXqbIEXbCkQtONbvZ0ksqeMgzZ6WyBhTscpfj/PN7HKr+
         h1SuhK2BE3tiOrEiv6PuqZYw/lRzxP7SS6tuB98uiyuEINPDjp5FwZk9dovU6pbuhSYY
         i4Y2qU0rcyWqPdWA3RXRsL+Q2q1hnxUF2RCybDFC5Ce//ltMIafqxrZXmtvBjEkwgczx
         VFaiD226uVvZwBZBezkaHg8Xq38laUlqLBroPhJWFYKbt9OBf9VcTr5lJtxx5+xfEsLX
         bqKA==
X-Gm-Message-State: APjAAAX/I0CRviMvkWQsQldnfghfqw26LrtrMYV+QTkjDGb/fgSE3UMy
        F1KrRa9AWHu0PFe3QfcGfCE=
X-Google-Smtp-Source: APXvYqxy3WVPhgQfatxyKROjp8M0evU+SWCZzEO3XmEhVOItT7H6xv+XhLilOp4d7LnjImaoPjb/AA==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr458238wre.310.1556755465497;
        Wed, 01 May 2019 17:04:25 -0700 (PDT)
Received: from szeder.dev (x4db31769.dyn.telefonica.de. [77.179.23.105])
        by smtp.gmail.com with ESMTPSA id a20sm6886348wrf.37.2019.05.01.17.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:04:24 -0700 (PDT)
Date:   Thu, 2 May 2019 02:04:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190502000422.GF14763@szeder.dev>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501100108.GA8954@archbookpro.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 06:01:08AM -0400, Denton Liu wrote:
> > Is it not possible to exclude certain directories for certain semantic
> > patches?
> > 
> > I guess we could also simply declare that *all* Coccinelle patches should
> > leave `compat/` alone, on the basis that those files are likely coming
> > from some sort of upstream. But then, `compat/mingw.c` and `compat/win32/`
> > seem not to fall into that category...
> > 
> > Ciao,
> > Dscho
> 
> Deciding whether this is a good idea is above my paygrade ;)
>
> However, if this is a good idea, we could use this patch to make it
> happen:
> 
> -- >8 --
> Subject: [PATCH] Makefile: filter out compat/ from coccicheck
> 
> Since most files in compat/ are pulled from external sources, ensure
> that they do not get modified when we run coccicheck because we do not
> want them to differ from upstream as much as possible.
> 
> Make exceptions for mingw.c and win32/*.c as these are files that we
> have created and not pulled from upstream.

I'm not sure that we really need these exceptions.

C_SOURCES comes from C_OBJ, i.e. it is basically all '*.c' source
files that we compile, taking the platform and Makefile knobs into
account.  On Linux we don't compile 'compat/mingw.c' and
'compat/win32/*.c', so when running 'make coccicheck' on Linux it
won't look into these source files anyway, so we don't need these
exceptions.  On Windows, however...  well, is it even possible to
build and run Coccinelle on Windows in the first place, with all its
OCaml dependencies?!  If not, then these exceptions won't do any good.

Anyway, if we do want these exceptions, then what about
'compat/win32mmap.c' and 'compat/winansi.c'?  They look like "ours" as
well.


FWIW, out of curiosity I've run 'make coccicheck' on Linux with
'compat/mingw.c' and its friends explicitly added to C_SOURCES, and it
seems to work...  it even found two places in 'mingw.c' where
COPY_ARRAY could replace memcpy() :)


> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 9f1b6e8926..b083c038c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2782,11 +2782,14 @@ check: command-list.h
>  	fi
>  
>  C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
> +COCCI_COMPAT_SOURCES = $(addprefix compat/,mingw.c win32/%)


>  ifdef DC_SHA1_SUBMODULE
> -COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> +COCCI_SOURCES := $(filter-out sha1collisiondetection/%,$(C_SOURCES))
>  else
> -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> +COCCI_SOURCES := $(filter-out sha1dc/%,$(C_SOURCES))
>  endif
> +COCCI_SOURCES := $(filter-out compat/%,$(COCCI_SOURCES))
> +COCCI_SOURCES += $(filter $(COCCI_COMPAT_SOURCES),$(C_SOURCES))
>  
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
> -- 
> 2.21.0.1033.g0e8cc1100c
> 
