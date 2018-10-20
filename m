Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AADF1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 05:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJTNfm (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 09:35:42 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34829 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJTNfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 09:35:42 -0400
Received: by mail-lj1-f170.google.com with SMTP id o14-v6so32595145ljj.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 22:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q0JD8yNszo0O+V01s6fFiWUmRC/jvJ10eA7I6+Q1Cus=;
        b=RHNCuVRx3rj+clgY2EYHnE2uKHjoxxqkCj9LAVBzqp8HmmPJ4JiyNf7NBP/FcRKJ3D
         a4z35jRwZYH124Ypps0KMC/2xJhOdVtYO18ylaa+LiVFHOP8NYm0MX57nUCh0yN9KTvt
         4eXUOMgTFTTkentHZ6ILzKmkIYqiyJDJnyrFZas5Cti3AyT/5Fc+YR492Z2aUJ9X3Ys3
         h9BvxV4w7VQu4QRxx3PBSxzT8ATR4aJDwfOSwE9e1uCd9t8ip2uiIRDSTSKk+uYAZVFv
         2lBJ/WcWsz+4W80bxxpRZ5ZRYEm9qE0f62u74w/Vb7PLPPhi860mWjTUyfW60nhPcy3C
         //0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q0JD8yNszo0O+V01s6fFiWUmRC/jvJ10eA7I6+Q1Cus=;
        b=l3v5UxxhOw85YqAthMsJTmHiE0CbgHkJT6td/qgzP4n/b6+MiBDsUUVizA1udQc1uh
         UjhU6tbPgfhVP1ULnLUe8Yjz3oy7mnnUSttEhi5FsmicC5DsD1wBbHXMDOabihPX1cSx
         o04vaiXdyOFDZdx17P4QEH1EtUoEmdmF9ajQQLZeZ5eZAFRtz8m8tNbN6++l2Js5WhiO
         2x7D60H/Fz6wdj6nhcLM2ZQgfWFUExWgOIDXjJvg7viqP0Lq3fLwelpjkb66pnG6J1SF
         lhXBw+BzLfYOkCmqDDyi/iY5TJK/3CKVi08UCILxB71to2wLbbN+ACWzLbz+Vh8R1T1M
         iaLg==
X-Gm-Message-State: ABuFfojFvr65RRgYM6Wpb8A95lN9k3YizJLUyc91kRVYQsMxUF3kE8Qj
        FC/b0CoARqWP4ezJ3sJbosI=
X-Google-Smtp-Source: ACcGV61A8ohJMQOfjAFZkzpH0eQGy2jCr4tkzxkB+U/Dy2pitXgGFXodiXtFQPfy516Bn087mikjtA==
X-Received: by 2002:a2e:90d8:: with SMTP id o24-v6mr24016128ljg.97.1540013189729;
        Fri, 19 Oct 2018 22:26:29 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 21-v6sm5657622ljf.41.2018.10.19.22.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 22:26:28 -0700 (PDT)
Date:   Sat, 20 Oct 2018 07:26:24 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     dana <dana@dana.is>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
Message-ID: <20181020052624.GA31433@duynguyen.home>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 05:19:06AM -0500, dana wrote:
> Hello,
> 
> I'm a contributor to ripgrep, which is a grep-like tool that supports using
> gitignore files to control which files are searched in a repo (or any other
> directory tree). ripgrep's support for the patterns in these files is based on
> git's official documentation, as seen here:
> 
>   https://git-scm.com/docs/gitignore
> 
> One of the most common reports on the ripgrep bug tracker is that it does not
> allow patterns like the following real-world examples, where a ** is used along
> with other text within the same path component:
> 
>   **/**$$*.java
>   **.orig
>   **local.properties
>   !**.sha1
> 
> The reason it doesn't allow them is that the gitignore documentation explicitly
> states that they're invalid:
>
> ...

I've checked the code and run some tests. There is a twist here. "**"
is only special when matched in "pathname" mode. That is when the
pattern contains at least one slash. In your patterns above, that only
applies to the first pattern.

When '**' is special, if it's neither '**/', '/**/' or '/**', it _is_
considered invalid (i.e. bad pattern) and the pattern will not match
anything.

The confusion comes from when '**' is not special for the remaining
three patterns, it's considered as regular '*' and still matches
stuff.

So, I think we have two options. The document could be clarified with
something like this

-- 8< --
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d107daaffd..500cd43939 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -100,7 +100,8 @@ PATTERN FORMAT
    a shell glob pattern and checks for a match against the
    pathname relative to the location of the `.gitignore` file
    (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
+   `.gitignore` file). Note that the "two consecutive asterisks" rule
+   below does not apply.
 
  - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
    anything except "`/`", "`?`" matches any one character except "`/`"
@@ -129,7 +130,8 @@ full pathname may have special meaning:
    matches zero or more directories. For example, "`a/**/b`"
    matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 
- - Other consecutive asterisks are considered invalid.
+ - Other consecutive asterisks are considered invalid and the pattern
+   is ignored.
 
 NOTES
 -----
-- 8< --

Or we could make the behavior consistent. If '**' is invalid, just
consider it two separate regular '*'. Then all four of your patterns
will behave the same way. The change for that is quite simple

-- 8< --
diff --git a/wildmatch.c b/wildmatch.c
index d074c1be10..64087bf02c 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -104,8 +104,10 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					    dowild(p + 1, text, flags) == WM_MATCH)
 						return WM_MATCH;
 					match_slash = 1;
-				} else
-					return WM_ABORT_MALFORMED;
+				} else {
+					/* without WM_PATHNAME, '*' == '**' */
+					match_slash = flags & WM_PATHNAME ? 0 : 1;
+				}
 			} else
 				/* without WM_PATHNAME, '*' == '**' */
 				match_slash = flags & WM_PATHNAME ? 0 : 1;
-- 8< --

Which way should we go? I'm leaning towards the second one...
--
Duy
