Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CB11F463
	for <e@80x24.org>; Sat, 14 Sep 2019 07:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfINHxI (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 03:53:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfINHxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 03:53:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so34078045wrm.9
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmbJ9WJPCsSYyUiqPvZp4q6Mm1Soj/tJtLTPzT19BwM=;
        b=MSiN96EXubkGaYvILcpw6Ay7Vy2pZpbEx6qYpNwNvz1aT5cE6QuQRlc/eNPnnzuRWX
         lSJnKDViEIpqhasIm2TJmTYYtBN2NZ1WgC+4Cn0gKfiRS4vGZOVT3H9hbqktKNn6JJ5m
         XXxeH4fWJ0COqweIM0zG0st2xnHwaNF/mhsNfLDfEVo8aP37+1zxajivOt0fSGbcMmbi
         fClWJvFDz2m76z/CZ5ZVAvM0tgCQnQrx9u4+cRepIgwaZvwTrILVSVWPWb/+Q4I/wcZ6
         8dJIXBDWpcN8aqjY8ByMcKOBuE/sUmMaya0uiZ7aDyC/t2h9oCptxk2Myd8ORjjAAfdW
         mIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmbJ9WJPCsSYyUiqPvZp4q6Mm1Soj/tJtLTPzT19BwM=;
        b=JtewqpqcVh4qv4cLRxisR60hrgnMkdxP6HKXKXTwSM3pd3ktjPcsma59EGP7CbpYXi
         I+nEvdfDwqGhHvX6OlGlcFCmOueIwKfQ4nyqUg8lLIZA+anSm2S3SyPWTYVmf0A5VoCT
         dhnxFm4iDdqzMt5G13wkjBXyHHDH4U9tGBpvik8AbwrKsGVcWbHb5+cK4dcIyQaBrbZI
         +SNqHgxhxVacwYAyJMRQU9rnBoa6Y7gLeuT0E4oI0sOBEjZsdjt4SqCFAPM99D4MIoEt
         AqxdDoeBtKE5CDeUgVH16duMEBAoAQ8XNLBeO2e1dL4KTAcQgSvtjMYrxDWVCmR5/Bb8
         tdOw==
X-Gm-Message-State: APjAAAX31vHb/TJuPlr6Bz+bS/qjDhmZ14p6xmn8zUHaiEaMm7hVXbyS
        /gnZZfORwPLVcuXFd7QZbjw=
X-Google-Smtp-Source: APXvYqw3PvNXOEJ0L7GkkP4DQjfDNi+lLBjWwg70RuhzI4d+e3UXG/CttlDAfC4tY8F2IL6ogtURQA==
X-Received: by 2002:adf:828d:: with SMTP id 13mr30111309wrc.115.1568447586012;
        Sat, 14 Sep 2019 00:53:06 -0700 (PDT)
Received: from szeder.dev (x4db52fd3.dyn.telefonica.de. [77.181.47.211])
        by smtp.gmail.com with ESMTPSA id x6sm5723411wmf.35.2019.09.14.00.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 00:53:05 -0700 (PDT)
Date:   Sat, 14 Sep 2019 09:53:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
Message-ID: <20190914075301.GR32087@szeder.dev>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190913015240.686522-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913015240.686522-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 01:52:40AM +0000, brian m. carlson wrote:

> We also need to teach xmlto how to use the namespaced DocBook XSLT
> stylesheets instead of the non-namespaced ones it usually uses.
> Normally these stylesheets are interchangeable, but the non-namespaced
> ones have a bug that causes them not to strip whitespace automatically
> from certain elements when namespaces are in use.  This results in
> additional whitespace at the beginning of list elements, which is
> jarring and unsightly.
> 
> We can do this by passing a custom stylesheet with the -x option that
> simply imports the namespaced stylesheets via a URL.  Any system with
> support for XML catalogs will automatically look this URL up and
> reference a local copy instead without us having to know where this
> local copy is located.  We know that anyone using xmlto will already
> have catalogs set up properly since the DocBook 4.5 DTD used during
> validation is also looked up via catalogs.  All major Linux
> distributions distribute the necessary stylesheets and have built-in
> catalog support, and Homebrew does as well, albeit with a requirement to
> set an environment variable to enable catalog support.
> 
> On the off chance that someone lacks support for catalogs, it is
> possible for xmlto (via xmllint) to download the stylesheets from the
> URLs in question, although this will likely perform poorly enough to
> attract attention.  People still have the option of using the prebuilt
> documentation that we ship, so happily this should not be an impediment.


> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 76f2ecfc1b..d94f47c5c9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -197,11 +197,13 @@ ifdef USE_ASCIIDOCTOR
>  ASCIIDOC = asciidoctor
>  ASCIIDOC_CONF =
>  ASCIIDOC_HTML = xhtml5
> -ASCIIDOC_DOCBOOK = docbook45
> +ASCIIDOC_DOCBOOK = docbook5
>  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
>  ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =
> +XMLTO_EXTRA += --skip-validation
> +XMLTO_EXTRA += -x manpage.xsl
>  endif
>  
>  SHELL_PATH ?= $(SHELL)
> diff --git a/Documentation/manpage.xsl b/Documentation/manpage.xsl
> new file mode 100644
> index 0000000000..ef64bab17a
> --- /dev/null
> +++ b/Documentation/manpage.xsl
> @@ -0,0 +1,3 @@
> +<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
> +	<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl" />
> +</xsl:stylesheet>

Unfortunately, five out of five CI builds failed with the following:

      XMLTO git-revert.1
  I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
  warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl"
  compilation error: file /home/travis/build/git/git/Documentation/manpage.xsl line 2 element import
  xsl:import : unable to load http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
  Makefile:375: recipe for target 'git-revert.1' failed

https://travis-ci.org/git/git/jobs/584794387#L1552

