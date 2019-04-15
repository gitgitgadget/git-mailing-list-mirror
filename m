Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7B720248
	for <e@80x24.org>; Mon, 15 Apr 2019 18:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfDOSsj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 14:48:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfDOSsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 14:48:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so23338552wrp.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wEmrf0pb5b69NV9xl5HWmVtXYxjyPl+48s0en5BI/og=;
        b=Ggn21O1x/FOrr6oWS/T+xyIXKjTP4eBpx1Ofa59t+cDOPYq1/EYYBrcb7rOMNTN2PL
         lzakrX6xRylppbHBJV2/pwP2BCa9WpTjylNiyvj5Vpk899zBNvk5O9OVf4+n9Ua4WBQL
         NI9kwsj0xL1lcbpwXcrGTtZmlEk29E7Hch62yS7ZZxd8ieSWFBczNK/M0C+QlCOZkGKS
         uU3GW9JSdmHzk493mm/U+RleVxccroUo+X5UVSDoZY2gB+WtKO4ADUgzIqr9pefCqcQO
         ddfKoHsKY+ipkMu7w7iDjQDvuKB7uXYZaOzdw21dtlM7i22wZmHxiOjcwlzEKfgzuEFN
         4aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEmrf0pb5b69NV9xl5HWmVtXYxjyPl+48s0en5BI/og=;
        b=LTM0zWa3nY5i3+Zm8DMFe36D/nH4U0+ycmVsCHawRiBnTJ6XZUe3PPa0GdMm+qQNlL
         gCmsAg8+sI/FVsrd0NgFyBKMlbL8ESnAgv0EDKTt+S0K4tviO34golRpifT13IaHDUef
         JHqqVSZp0s5Fa8Y+HrIlojqf+CacCFAFYk0nCCEj0FnJ3qiyVPPmU8AZXvGYy+OKqkUO
         dQDDWtJzWX6RiJMLJQbnBIsK9tQhiT9LHYynh5/m0tb4a5wMJsGnwJzUonzq5Y3S9/Dp
         OYrNVEUs695Ipyfqhojh29/pvsBXYRBDIOcZUH3ZmffMuHZlc/s2cLbyim7sBZpAIG0u
         iSYA==
X-Gm-Message-State: APjAAAUPr1s0jWW5Ws+LmT9KqdECN/dJElBNfIhKqw+YZcthYg2sdABg
        9XbpD/afkwgSZEbVUPfIFhQ=
X-Google-Smtp-Source: APXvYqyhjjfTiMFFzB5fEOjRHUgaBKhDEVdEokarksXWiVuiZFd3O1QSbEJ+maLS1BJ57x5Cy0IWjQ==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr41417508wro.40.1555354083762;
        Mon, 15 Apr 2019 11:48:03 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id s203sm27218949wmf.14.2019.04.15.11.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:48:02 -0700 (PDT)
Date:   Mon, 15 Apr 2019 19:48:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/4] range-diff: add section headers to the outer
 hunk header
Message-ID: <20190415184801.GA1704@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-5-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1904151442150.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904151442150.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Sun, 14 Apr 2019, Thomas Gummerer wrote:
> 
> > Add the section headers we introduced in the previous commit to the
> > outer diff's hunk headers.  This makes it easier to understand which
> > change we are actually looking at.  For example an outer hunk header
> > might now look like:
> >
> >     @@ -77,15 +78,43 @@ modified file Documentation/config/interactive.txt
> >
> > while previously it would have only been
> >
> >     @@ -77,15 +78,43 @@
> >
> > which doesn't give a lot of context for the change that follows.
> >
> > For completeness also add section headers for the commit metadata and
> > the commit message, although they are arguably less important.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> 
> That makes a total lot of sense. So much so that we should protect it by a
> new regression test case.

Yup, definitely.  As mentioned in the cover letter, I punted on to
discuss and settle on an output format first, so I don't have to
duplicate a lot of work writing and re-writing the tests ;)

> > diff --git a/range-diff.c b/range-diff.c
> > index aa466060ef..15ac54f369 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -124,8 +124,10 @@ static int read_patches(const char *range, struct string_list *list)
> >  			strbuf_addstr(&buf, " ##\n");
> >  		} else if (in_header) {
> >  			if (starts_with(line.buf, "Author: ")) {
> > +				strbuf_addstr(&buf, " ## Metadata ##\n");
> >  				strbuf_addbuf(&buf, &line);
> >  				strbuf_addstr(&buf, "\n\n");
> > +				strbuf_addstr(&buf, " ## Commit message ##\n");
> 
> Should this not rather be added when `in_header` is set to false?

I don't think so.  The commit message counts as part of in_header, and
starts right after the rest of the commit metadata.  If we would add
this after when we set in_header to false, we'd write it after the
commit message, which would make the hunk header "@@ ... @@ Metadata",
even when we show the commit message in the output.

> The rest of the patch makes a whole lot of sense to me.

Thanks!

> Thanks,
> Dscho
> 
> >  			} else if (starts_with(line.buf, "    ")) {
> >  				strbuf_rtrim(&line);
> >  				strbuf_addbuf(&buf, &line);
> > @@ -387,8 +389,8 @@ static void output_pair_header(struct diff_options *diffopt,
> >  	fwrite(buf->buf, buf->len, 1, diffopt->file);
> >  }
> >
> > -static struct userdiff_driver no_func_name = {
> > -	.funcname = { "$^", 0 }
> > +static struct userdiff_driver section_headers = {
> > +	.funcname = { "^ ## (.*) ##$", REG_EXTENDED }
> >  };
> >
> >  static struct diff_filespec *get_filespec(const char *name, const char *p)
> > @@ -400,7 +402,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
> >  	spec->size = strlen(p);
> >  	spec->should_munmap = 0;
> >  	spec->is_stdin = 1;
> > -	spec->driver = &no_func_name;
> > +	spec->driver = &section_headers;
> >
> >  	return spec;
> >  }
> > --
> > 2.21.0.593.g511ec345e1
> >
> >
