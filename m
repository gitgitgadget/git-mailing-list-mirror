Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32E71FC45
	for <e@80x24.org>; Sat, 11 Feb 2017 08:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbdBKIAN (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 03:00:13 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32841 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdBKIAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 03:00:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so3698189pfg.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 00:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+mCHU7Dktp/YEcT+j6kTiQWxSIUw4WQG1yeiHbP6quo=;
        b=tBvTL/LsxRsItLbGOZko0jAhpA2Y0J9P4LIPD1JdUUcnlxHn2E+lD5Q8d1I12GO9QA
         OGMiYIYhhqXeVKHshCOYDTIdBk2Gn+BiHMgwKBSWbCaDJs2a1T3nwwkDn/ZwdkfUbFny
         bPw4s4R1YcYcts00rDDhM4ZdEfd5EEKr9twC5jrVQHV9xFZNIpZUBG96w8yx5j2VVj62
         KSCZpm8ktTQdvpHZTyB6dqK0A5dQ8uUHqh1XPcJBK2njgLONI1c7eMHt3pvMaOWIBhKL
         rLKlfrTiU5rRpjgkjxuGJ8aQgfM6Bjg84HbQwnPAT1Bc9LjFzHro+AsgQYb6I1eh1SUM
         VxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+mCHU7Dktp/YEcT+j6kTiQWxSIUw4WQG1yeiHbP6quo=;
        b=grTvvMRL3yOLl5pgsldvF+JxI+lY9u6GAI2zrdMDAcsm6GbfdlHJOkkRAX9V726g86
         bgnyh5zt+4oCf7E7/uLdGsYAMgf6zEUYQBQauFXXrfHzUlvnYT+6uM/PZpu9UoYr3G6l
         CaDY61ZMOp67SBGVFLpIeaq+jGX4yVvWPJWmjuKJS5dxUTKnh8sCGXogjMiQJCEMiM/5
         bQkv1pxcEZw+XRgOKAe3LVo5MgHDXXLR2QrCFGCXyOikAtRxKWrwxwT5nO7DyXFxgA4w
         HnIwCzPxtvWirc5tpSJbKqYQtDoHPgVQroj8wVnZ8rIzEGRimaXEqgmNR3kN7jYJLuKH
         k9Lg==
X-Gm-Message-State: AMke39n6RV05FKkr/Z929Y1JQXVrAEe/Hwh+ViT0Iwh5/aK4zAMMpi01x6Mb47D1GHiEtQ==
X-Received: by 10.98.210.3 with SMTP id c3mr14909678pfg.7.1486799577387;
        Fri, 10 Feb 2017 23:52:57 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id n189sm3097050pfn.108.2017.02.10.23.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 23:52:56 -0800 (PST)
Date:   Sat, 11 Feb 2017 07:52:54 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a
 revision
Message-ID: <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,
On Fri, Feb 10, 2017 at 03:35:47PM -0800, Junio C Hamano wrote:
> So the difference is just "--left" (by the way, our codebase seem to
> prefer "left--" when there is no difference between pre- or post-
> decrement/increment) that adjusts the slot in argv[] where the next
> unknown argument is stuffed to.

Understood, I will use post decrement.

> I am wondering if writing it like the following is easier to
> understand.  I had a hard time figuring out what you are trying to
> do, partly because "args" is quite a misnomer---implying "how many
> arguments did we see" that is similar to opts that does mean "how
> many options did handle_revision_opts() see?"  

Um, okay, I see that "args" is very confusing. Would it help if this variable
was called "arg_not_rev"? Because the value that is returned from
handle_revision_arg is 1 when it is not a revision, and 0 when it is a
revision. The changed block of code would look like this:

---
 revision.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec..4131ad5 100644
--- a/revision.c
+++ b/revision.c
@@ -2205,6 +2205,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		int handle_rev_arg_called = 0, arg_not_rev;
 		if (*arg == '-') {
 			int opts;
@@ -2234,11 +2235,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
                    }
                    if (opts < 0)
                            exit(128);
-                   continue;
+
+                   arg_not_rev = handle_revision_arg(arg, revs, flags, revarg_opt);
+                   handle_rev_arg_called = 1;
+                   if (arg_not_rev)
+                           continue; /* arg is neither an option nor a revision */
+                   else
+                           left--; /* arg is a revision! */
            }
 
 
-           if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+           if ((handle_rev_arg_called && arg_not_rev) ||
+                           handle_revision_arg(arg, revs, flags, revarg_opt)) {

> The rewrite below may avoid such a confusion.  I dunno.

Um, I am sorry, but I feel that decrementing left, and incrementing it again is
also confusing. I think that with a better name for the return value from
handle_revision_arg, the earlier confusion should be resolved.

I base this on my previous experience following the codepath. It was easy for
me to understand with the previous code that "continue" will be executed from
within the first if block whenever arg begins with a "-" and it is determined
that it is not an option. 

going by that, now, "continue" will be executed whenever it's not an option and
_also_ not an argument. Otherwise, the further parts of the code will execute
as before, and there are no continue statements there. I hope this argument
makes sense.

Also worth noting, The two `if` lines look better now:

1. If arg is not a revision, go to the next arg (because we have already
determined that it is not an option)

2. If handle_rev_arg was called AND the argument was not a revision, OR
if handle_revision_arg says that arg is not a rev, execute the following block.

Perhaps, someone else could please have a look at the changes in the block
above and the block below and give some feedback on which one is easier to
understand and the reason that they feel so. Thanks a lot!

> 
>  revision.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index b37dbec378..e238430948 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2204,6 +2204,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>               revarg_opt |= REVARG_CANNOT_BE_FILENAME;
>       read_from_stdin = 0;
>       for (left = i = 1; i < argc; i++) {
> +             int maybe_rev = 0;
>               const char *arg = argv[i];
>               if (*arg == '-') {
>                       int opts;
> @@ -2234,11 +2235,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>                       }
>                       if (opts < 0)
>                               exit(128);
> -                     continue;
> +                     maybe_rev = 1;
> +                     left--; /* tentatively cancel "unknown opt" */
>               }
>  
> -
> -             if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
> +             if (!handle_revision_arg(arg, revs, flags, revarg_opt)) {
> +                     got_rev_arg = 1;
> +             } else if (maybe_rev) {
> +                     left++; /* it turns out that it was "unknown opt" */
> +                     continue;
> +             } else {
>                       int j;
>                       if (seen_dashdash || *arg == '^')
>                               die("bad revision '%s'", arg);
> @@ -2255,8 +2261,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>                       append_prune_data(&prune_data, argv + i);
>                       break;
>               }
> -             else
> -                     got_rev_arg = 1;
>       }
>  
>       if (prune_data.nr) {

Thanks Junio, for the time you spent analysing and writing the above version of
the patch!

Regards,

- Siddharth Kannan
