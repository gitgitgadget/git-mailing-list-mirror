Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3171F404
	for <e@80x24.org>; Thu, 13 Sep 2018 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeINDHm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:07:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeINDHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:07:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so9284wme.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0IFJrJh5uKELb2nsilRC/OIjx86VZoUVqDE8Aw2wjSw=;
        b=cx/z/w+putHSOdg2r9AOk+y1Ivc16XAY9Qeccuc1fzKWT4CeEBmqyTwbx6yVTaeLgd
         pie7UB/MCUSyFcguZJHYEFkLL1mO0v8ZR+bzXdVBseJImxvepsOTxbzAZduheh1kz7Lh
         mieBSPE7tntuFqpV6KUvF+V+eMogFZOPtIHEsMH2lmhErANYZy1cTDiXk+g3U0HPsZZv
         NbpQE0kuYVcb/fJbPf23MQoLBBKJrB+AEPU9axUcOASGEJmk7jacd2B7YIgI5lXSU/84
         oSvJ3qK/90qPXBNQJYqdkqU7tWfqSNDJ7Y/DcywFsFyjfXCx/6ztD55sZlbvp2HcHdGF
         Cvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0IFJrJh5uKELb2nsilRC/OIjx86VZoUVqDE8Aw2wjSw=;
        b=Uj3qPGXFjs4v8pT9leJ89GccFgM8zXiZYqMMU8n9GihK7EhvJuj1vBi2hxcY3CdUje
         YQMtiBRVYN/SK5dbWUuvsx4+ctmJrfewwmNFUMNvlcBdUJxtPr00RANmKb1qwkgsDUad
         I2AbHMF6696TZybM3y+fd09IJvW0FoRLJuj5JVNTnr3KxuNityHhOoboyrK9DUG3Z0za
         1OOKEPfAfkJzyG5HB6bpLlEfTkQPzVoVXe/bSvncixt53fy1vFFoZrsz5ewoKQ37qJn2
         EAmBg98jwwoShVxaML1ZNT2Vj4IbkuIm3H3dMXS2aqqe9LGeaglCub+6VYJbF6d3Vib4
         1ngA==
X-Gm-Message-State: APzg51BLko7kQFWGguWKDCFFiSZHI2p17zd609bmYyi1lg390Lh6aMAm
        LS02v3Es+dheRWJWw32s6miK4C+O
X-Google-Smtp-Source: ANB0VdaeE2LmzONR2UgecR8E6q1i/iuM+zX108xpoKZYCMa8IzLaGAGg+X3sZQQuw4cbyjmjd3Uybw==
X-Received: by 2002:a1c:501:: with SMTP id 1-v6mr20117wmf.140.1536875777554;
        Thu, 13 Sep 2018 14:56:17 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id l12-v6sm4318363wrv.29.2018.09.13.14.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 14:56:16 -0700 (PDT)
Date:   Thu, 13 Sep 2018 22:56:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
Message-ID: <20180913215616.GD1719@hank.intra.tgummerer.com>
References: <20180912212544.33624-1-benpeart@microsoft.com>
 <20180912223101.GA1719@hank.intra.tgummerer.com>
 <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/13, Ben Peart wrote:
> 
> 
> On 9/12/2018 6:31 PM, Thomas Gummerer wrote:
> > On 09/12, Ben Peart wrote:
> > > Teach get_index_format_default() to support running the test suite
> > > with specific index versions.  In particular, this enables the test suite
> > > to be run using index version 4 which is not the default so gets less testing.
> > 
> > I found this commit message slightly misleading.  Running the test
> > suite with specific index versions is already supported, by defining
> > TEST_GIT_INDEX_VERSION in 'config.mak'.  What we're doing here is
> > introduce an additional environment variable that can also be used to
> > set the index format in tests.
> > 
> > Even setting TEST_GIT_INDEX_VERSION=4 in the environment does run the
> > test suite with index-v4.  Admittedly the name is a bit strange
> > compared to our usual GIT_TEST_* environment variable names, and it
> > should probably be documented better (it's only documented in the
> > Makefile currently), but I'm not sure we should introduce another
> > environment variable for this purpose?
> 
> TEST_GIT_INDEX_VERSION enables the testing I was looking for but you're
> right, it isn't well documented and the atypical naming and implementation
> don't help either.
> 
> I checked the documentation and code but didn't see any way to test the V4
> index code path so wrote this patch.  I wonder if we can improve the
> discoverability of TEST_GIT_INDEX_VERSION through better naming and
> documentation.
> 
> How about this as an alternative?

Thanks, I do think this is a good idea.  I do however share Ævar's
concern in https://public-inbox.org/git/87h8itkz2h.fsf@evledraar.gmail.com/.
I have TEST_GIT_INDEX_VERSION=4 set in my config.mak since quite a
long time, and had I missed this thread, I would all of a sudden not
run the test suite with index format 4 anymore without any notice.

I think the suggestion of erroring out if TEST_GIT_INDEX_VERSION is
set would be useful in this case (and probably others in which you're
renaming these variables).  Not sure how many people it would affect
(and most of those would probably read the mailing list), but it's not
a big change either.

Btw, I think it would be nice to have all these renaming/documenting
variables for the test suite patches in one series, so they are easier
to look at with more context.

> 
> diff --git a/Makefile b/Makefile
> index 5a969f5830..9e84ef02f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -400,7 +400,7 @@ all::
>  # (defaults to "man") if you want to have a different default when
>  # "git help" is called without a parameter specifying the format.
>  #
> -# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
> +# Define GIT_TEST_INDEX_VERSION to 2, 3 or 4 to run the test suite
>  # with a different indexfile format version.  If it isn't set the index
>  # file format used is index-v[23].
>  #
> @@ -2599,8 +2599,8 @@ endif
>  ifdef GIT_INTEROP_MAKE_OPTS
>         @echo GIT_INTEROP_MAKE_OPTS=\''$(subst ','\'',$(subst
> ','\'',$(GIT_INTEROP_MAKE_OPTS)))'\' >>$@+
>  endif
> -ifdef TEST_GIT_INDEX_VERSION
> -       @echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst
> ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@+
> +ifdef GIT_TEST_INDEX_VERSION
> +       @echo GIT_TEST_INDEX_VERSION=\''$(subst ','\'',$(subst
> ','\'',$(GIT_TEST_INDEX_VERSION)))'\' >>$@+
> 
>  endif
>         @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 44288cbb59..31698c01c4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -134,9 +134,9 @@ export EDITOR
>  GIT_TRACE_BARE=1
>  export GIT_TRACE_BARE
> 
> -if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
> +if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
>  then
> -       GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
> +       GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
>         export GIT_INDEX_VERSION
>  fi
> 
> diff --git a/t/README b/t/README
> index 9028b47d92..f872638a78 100644
> --- a/t/README
> +++ b/t/README
> @@ -315,10 +315,14 @@ packs on demand. This normally only happens when the
> object size is
>   over 2GB. This variable forces the code path on any object larger than
>   <n> bytes.
> 
> -GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
> +GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>   path where deltas larger than this limit require extra memory
>   allocation for bookkeeping.
> 
> +GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
> +for the index version specified.  Can be set to any valid version
> +but the non-default version 4 is probably the most beneficial.
> +
>   Naming Tests
>   ------------
> 
