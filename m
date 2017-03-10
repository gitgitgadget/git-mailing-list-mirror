Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CB520311
	for <e@80x24.org>; Fri, 10 Mar 2017 18:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933289AbdCJS0t (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:26:49 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34344 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbdCJS0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:26:47 -0500
Received: by mail-pg0-f51.google.com with SMTP id 77so41549939pgc.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ4uKRQGRZUjzrOJTwXrJqLN7L5v4FaNxWKqAFkHOG8=;
        b=VF5NZjkasOhnI2glwdM8MCWXCbChbPD3pdyqzgQ3bZravaImQVCGQHyiPvOcdTFgRC
         dD13cP5/lMxO8dOYIOwJWByxcXGPz3Zx2v3kB25RX+Gu8qSWFH7dZAy2Wfcsm+tkbOf3
         G8R/R0BEU10syjanw41zieOf+S6Mo9M8Jl3rQtDihirOprVTgfMxDlUcHKnEWxNyf/HP
         IMYQXoeh+UiGgjQVbxMyXj8xRRh7D5Imd1UNYUNO2hYT+HQ+DNEMxgJgUBnsPGG6mkcK
         R3PPB1HSHOPPA9jxIpqfJnXQVhNV7l0sqsdifuk9MDAEJLIoSYidn28dfTnkrhVcvF3K
         Y54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ4uKRQGRZUjzrOJTwXrJqLN7L5v4FaNxWKqAFkHOG8=;
        b=WoaUST6sdb4IfqZWDggX8hiXMpLhOvxtJ613FRSlfWaoFtm2JCGrjoDivz6WHNtu+1
         z6ENmHZFKawsqbJmxqr018bQS/WIrAn68NthSEo7aB/uWyfvKWpKSXOrCxh+DBPMZPyX
         2cm+XTrYvHdhPFCYkiK9yxvH/ygJrNL33ZtmXooespBJNKGKwZAU+yyS5BJdHO6eTjrm
         s26Bi87H1Bu1jxhGLbpDthZDIlu7Jz86e9Jn4bJSjqh8+N0r+6cYAeDGsWH7iFD2Cf2L
         wcWdIXIJYekHe43tnvgRs0/2V39mibpEg1x76HJrp8RFT82V2d3fFrBUJBy9/9Cj+3e7
         0cgg==
X-Gm-Message-State: AMke39lTUpzwC9pfxmhkCoTcjC6XcMRAV4a/lhwjHWKmITycXYtNc9HceargOLX5GIBi0dtb
X-Received: by 10.84.217.215 with SMTP id d23mr27739385plj.33.1489170406422;
        Fri, 10 Mar 2017 10:26:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:c69:ce9:a41e:fd0])
        by smtp.gmail.com with ESMTPSA id b77sm20021195pfl.2.2017.03.10.10.26.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 10:26:45 -0800 (PST)
Date:   Fri, 10 Mar 2017 10:26:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 1/2] pathspec: allow querying for attributes
Message-ID: <20170310182644.GB53198@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
 <20170309210756.105566-2-bmwill@google.com>
 <e8ef511f-563b-8b22-d8c6-daec2291f2aa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ef511f-563b-8b22-d8c6-daec2291f2aa@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Jonathan Tan wrote:
> On 03/09/2017 01:07 PM, Brandon Williams wrote:
> >diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> >index fc9320e59..5c32d1905 100644
> >--- a/Documentation/glossary-content.txt
> >+++ b/Documentation/glossary-content.txt
> >@@ -384,6 +384,26 @@ full pathname may have special meaning:
> > +
> > Glob magic is incompatible with literal magic.
> >
> >+attr;;
> >+After `attr:` comes a space separated list of "attribute
> >+requirements", all of which must be met in order for the
> >+path to be considered a match; this is in addition to the
> >+usual non-magic pathspec pattern matching.
> >++
> >+Each of the attribute requirements for the path takes one of
> >+these forms:
> >+
> >+- "`ATTR`" requires that the attribute `ATTR` must be set.
> 
> As a relative newcomer to attributes, I was confused by the fact
> that "set" and "set to a value" is different (and likewise "unset"
> and "unspecified"). Maybe it's worthwhile including a link to
> "gitattributes" to explain the different (exclusive) states that an
> attribute can be in.

Good idea! I'll add in a link to gitattributes.
> 
> >+
> >+- "`-ATTR`" requires that the attribute `ATTR` must be unset.
> >+
> >+- "`ATTR=VALUE`" requires that the attribute `ATTR` must be
> >+  set to the string `VALUE`.
> >+
> >+- "`!ATTR`" requires that the attribute `ATTR` must be
> >+  unspecified.
> 
> It would read better to me if you omitted "must" in all 4 bullet
> points (and it is redundant anyway with "requires"), but I don't
> feel too strongly about this.

I agree, the first paragraph already says "must" so it reads better
without repeating must over and over again.

> 
> >diff --git a/pathspec.c b/pathspec.c
> >index b961f00c8..583ed5208 100644
> >--- a/pathspec.c
> >+++ b/pathspec.c
> >@@ -87,6 +89,72 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> > 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
> > }
> >
> >+static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
> >+{
> >+	struct string_list_item *si;
> >+	struct string_list list = STRING_LIST_INIT_DUP;
> >+
> >+	if (item->attr_check)
> >+		die(_("Only one 'attr:' specification is allowed."));
> >+
> >+	if (!value || !strlen(value))
> 
> You can write `!*value` instead of `!strlen(value)`.
> 

Done.

> >+	string_list_remove_empty_items(&list, 0);
> >+
> >+	item->attr_check = attr_check_alloc();
> >+	ALLOC_GROW(item->attr_match,
> >+		   item->attr_match_nr + list.nr,
> >+		   item->attr_match_alloc);
> 
> Is there a time when this function is called while
> item->attr_match_nr is not zero?

Nope, it pretty much has to be zero.  I'll change this to just use
list.nr.  item->attr_match_nr will be incremented up to list.nr over the
course of the for loop and I'll move the equality check to the end of
this function.

> >+	string_list_clear(&list, 0);
> >+	return;
> 
> Redundant return?

I'll remove it.

> 
> >@@ -544,6 +628,10 @@ void parse_pathspec(struct pathspec *pathspec,
> > 		if (item[i].nowildcard_len < item[i].len)
> > 			pathspec->has_wildcard = 1;
> > 		pathspec->magic |= item[i].magic;
> >+
> >+		if (item[i].attr_check &&
> >+		    item[i].attr_check->nr != item[i].attr_match_nr)
> >+			die("BUG: should have same number of entries");
> 
> I'm not sure if this check is giving us any benefit - I would expect
> this type of code before some other code that assumed that the
> numbers matched, and that will potentially segfault if not.

I'll push the check to right after the object creation (see comment
above).

-- 
Brandon Williams
