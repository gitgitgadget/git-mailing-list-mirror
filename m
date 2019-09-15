Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B741F463
	for <e@80x24.org>; Sun, 15 Sep 2019 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfIOKAI (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 06:00:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41414 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOKAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 06:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so34938473wrw.8
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fz3PJ3nnyQ4+LwWZnIfsoj+ytkKwr5eiQUcfFbZkw3Q=;
        b=UdPDu5/9GrSwotrgfSZhDNfJSVQQnKWW+eEoZuSSfq4pLLovktvizSDI5cWDkDEb8m
         55pR/UVE9gSvf7/IyJ0aZtEBVeCa1ruMrr30zk8UG8wQjr2FHLPW5USj+3lx6dX5DMlS
         PwYgyMt4z/gbmOhCLxCvLzJr3fiCmFpKMg2W8WuP510HLzrrKL9D61ckswt1+/2l9ebM
         EA0s7iwnatY5GNQTEQ1vtSrNq6RnN8UMmRdDT3kLjkj6wD3xXm7UJt16CoaApUzlWgTY
         /v+C8BZ96kINWOAyXzjDJJEUzaQ4ToMycJ2mPT5JDb70bQm+l2eptOGou0BwTC0vGWgS
         ryWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fz3PJ3nnyQ4+LwWZnIfsoj+ytkKwr5eiQUcfFbZkw3Q=;
        b=fKS8NZiFfq0YUKhtqo7ZeUQsSLNnXnrSPvnHfzYaqlrWeCPlPVAhy4H1n+jcZ1sWwh
         JZCtfczLAp8mKPR4GkuFbqg6NGkHIUCB7tMn+XmvINMehSQc1XP0xfHFfa/O/C3l0UZL
         gIMqB4QTsTw5iSIExls44XSwpTj1LPRWYECXR6ASdXHKZYTdLZ9hlGuedoj8Dn8NQWuq
         vDiAA7eAkN0T1SREKS2CH4oJkPLG7/A/9v8TmU//7i5Owt66AvdLq/IKWeN8vzc0zvTD
         FEPjU3Wetrnnr9N7BHtZFi6UeEPAhBB5OuBbB2I4GMvDHRpalDTJSNXyVoWWgAv11kRf
         nMWA==
X-Gm-Message-State: APjAAAXPhfz5awzERIUVvtFp5d591Y/e/H+t6KWlEeNjNa05i6juXcGZ
        TBXnM4loZ0ZHMdPg812mi/4=
X-Google-Smtp-Source: APXvYqygck5D70MEDIdGml6FLKxcRJxHIN9Qp0jfnjt3tWKQveWopoMU6DGdrk/E7lEY8LArXxU/ZA==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr14825386wrr.110.1568541605076;
        Sun, 15 Sep 2019 03:00:05 -0700 (PDT)
Received: from szeder.dev (x4dbd3c27.dyn.telefonica.de. [77.189.60.39])
        by smtp.gmail.com with ESMTPSA id c6sm56857178wrb.60.2019.09.15.03.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 03:00:04 -0700 (PDT)
Date:   Sun, 15 Sep 2019 11:59:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: fix build with Asciidoctor 2
Message-ID: <20190915095952.GA6190@szeder.dev>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190914194919.748935-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914194919.748935-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 14, 2019 at 07:49:19PM +0000, brian m. carlson wrote:
> Our documentation toolchain has traditionally been built around DocBook
> 4.5.  This version of DocBook is the last DTD-based version of DocBook.
> In 2009, DocBook 5 was introduced using namespaces and its syntax is
> expressed in RELAX NG, which is more expressive and allows a wider
> variety of syntax forms.
> 
> Asciidoctor, one of the alternatives for building our documentation,
> moved support for DocBook 4.5 out of core in its recent 2.0 release and
> now only supports DocBook 5 in the main release.  The DocBoook 4.5
> converter is still available as a separate component, but this is not
> available in most distro packages.  This would not be a problem but for
> the fact that we use xmlto, which is still stuck in the DocBook 4.5 era.
> 
> xmlto performs DTD validation as part of the build process.  This is not
> problematic for DocBook 4.5, which has a valid DTD, but it clearly
> cannot work for DocBook 5, since no DTD can adequately express its full
> syntax.  In addition, even if xmlto did support RELAX NG validation,
> that wouldn't be sufficient because it uses the libxml2-based xmllint to
> do so, which has known problems with validating interleaves in RELAX NG.
> 
> Fortunately, there's an easy way forward: ask Asciidoctor to use its
> DocBook 5 backend and tell xmlto to skip validation.  Asciidoctor has
> supported DocBook 5 since v0.1.4 in 2013 and xmlto has supported
> skipping validation for probably longer than that.
> 
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
> 
> Finally, we need to filter out some messages from other stylesheets that
> occur when invoking dblatex in the CI job.  This tool strips namespaces
> much like the unnamespaced DocBook stylesheets and prints similar
> messages.  If we permit these messages to be printed to standard error,
> our documentation CI job will fail because we check standard error for
> unexpected output.  Due to dblatex's reliance on Python 2, we may need
> to revisit its use in the future, in which case this problem may go
> away, but this can be delayed until a future patch.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

>  Documentation/Makefile     | 4 +++-
>  Documentation/manpage.xsl  | 3 +++
>  azure-pipelines.yml        | 2 +-
>  ci/install-dependencies.sh | 2 +-
>  ci/test-documentation.sh   | 2 ++
>  5 files changed, 10 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/manpage.xsl
> 
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
> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> index c329b7218b..34031b182a 100644
> --- a/azure-pipelines.yml
> +++ b/azure-pipelines.yml
> @@ -374,7 +374,7 @@ jobs:
>         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
>  
>         sudo apt-get update &&
> -       sudo apt-get install -y asciidoc xmlto asciidoctor &&
> +       sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns &&
>  
>         export ALREADY_HAVE_ASCIIDOCTOR=yes. &&
>         export jobname=Documentation &&
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 8cc72503cb..a76f348484 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -53,7 +53,7 @@ StaticAnalysis)
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install asciidoc xmlto
> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns

Ok, with this package installed the build passed on Travis CI.

>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	gem install --version 1.5.8 asciidoctor

So, since the documentation can now be built with Asciidoctor v2, is
it already time to remove this '--version 1.5.8'?

> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index d49089832d..b3e76ef863 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -8,6 +8,8 @@
>  filter_log () {
>  	sed -e '/^GIT_VERSION = /d' \
>  	    -e '/^    \* new asciidoc flags$/d' \
> +	    -e '/stripped namespace before processing/d' \
> +	    -e '/Attributed.*IDs for element/d' \

I haven't seen this latter message in the CI builds, neither with
Asciidoctor v1.5.8 nor with v2.  Do we really need this filter, then?
Where does this message come from?

>  	    "$1"
>  }
>  
