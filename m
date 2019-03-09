Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4631520248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCISa0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:30:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34649 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCISaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:30:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id o10so11042768wmc.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o5CwRa/INsIOY4n+I8uxXwoqhzh1BFAz3s1fJZIBI+E=;
        b=ZXU1cGuw7HVroeu/DPZVZRAkXKSP191bcuA62i55BDt4sxFis8cgBgTlnDO0Ec3cWa
         PntpwOKqcRdxcQb+N4OXC3+rn342MdJQiJymgrmqs9Umw4wQuTvUtJdOyrhVrmhNlf7F
         s7GlUcl6TSAwutLGHklK6Ko29I2j7YA/PMY/Kk4rUWHuTFTzguwj0TEi523G+gUZ6gSF
         94falafMb5HnpvyJspRX6pZMebrtFYJSgZn+sX0JtnCPzqFwNZIMOqrQnW1H6xiyV9kg
         ilNg1sD5NfWQL80RjXBClNGAlX2KPUi9wFC2oS/PDb5R6vhdEZKFqoF5Q5FZs7ZrhfEu
         U2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5CwRa/INsIOY4n+I8uxXwoqhzh1BFAz3s1fJZIBI+E=;
        b=VjY3+vUQKie8UGzA0LZi9LRFjUZRZiMXmYpgZX0Uv/ex33Gl0eUI/FXErgDQb0VnFw
         /6VEKke7cwESgJEVj9xzzjUqIcnucahrESmpXq924sTgfbwdgaYwNNxsIOZPLmsF/D5C
         CyTyAKkdE7G6dsdmJC+JZcaysVHMBy9rwEsb5UfU30dWIulzcec0W8PS3S0IcJ6WY3oE
         C7lNUshZZcXDQwqu5wXHH4Qy3XW/c4hW/WGMRE8TM8dSwfIvjGyExdKhF70bft3T/9+k
         rm2BY39PlbLX8/P156Aud2Sl06hJ4l5f4MlqEy5h+qIlqFCHdyNN/+ZZxOc+/oDdgcC6
         uRkw==
X-Gm-Message-State: APjAAAXaAdyEMb6HXNjCHFZSFRNOR1tx5q2VWQ3I4J3jvxVXIcPfUCrx
        PE6dTp1K8/rBBOto60hWMGA=
X-Google-Smtp-Source: APXvYqzx4oE/4Usbj+3tm3j1vZuH4jTCzy3jai3wbscqjZGjEzNnS3GYmIVrMy3ZvtYmaKIIxo0VHQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr12581049wmg.111.1552156223320;
        Sat, 09 Mar 2019 10:30:23 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id y140sm32344890wmd.18.2019.03.09.10.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 10:30:22 -0800 (PST)
Date:   Sat, 9 Mar 2019 18:30:21 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [PATCH v13 12/27] stash: convert drop and clear to builtin
Message-ID: <20190309183021.GE31533@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-13-t.gummerer@gmail.com>
 <20190307191533.GA29221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307191533.GA29221@sigill.intra.peff.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07, Jeff King wrote:
> On Mon, Feb 25, 2019 at 11:16:16PM +0000, Thomas Gummerer wrote:
> 
> > +static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
> 
> This series hit next recently, so I started building it merged with my
> -Wunused-parameters series. This "prefix" parameter is not ever used.
> Skimming through the function, I don't see anything that _should_ be
> using it, so I think it's just cruft, and not indicative of a bug.

Agreed, I think it's only cruft, and shouldn't be used anywhere in the
function.  Below is a patch to remove the parameter.

> The same is true of create_stash() elsewhere in the series. But there it
> might be worth keeping for consistency with the other top-level action
> functions. The other ones pass "prefix" to parse_options(), but
> create_stash() doesn't actually parse any options (and intentionally so,
> since even "--help" should be taken as part of the stash message).

Agreed, I'd be happy to keep the parameter there.  Looking at your
fork, you seem to have some WIP patches to introduce a UNUSED macro
for parameters like this, which I don't think I've seen on the list
yet (though I may have just missed them).

I guess it's probably best for you to mark this parameter as UNUSED as
part of your series, but if you have a different preference on how to
handle it, let me know.

--- >8 ---
Subject: [PATCH 2/2] stash: drop unused parameter

Drop the unused prefix parameter in do_drop_stash.

We also have an unused "prefix" parameter in the 'create_stash'
function, however we leave that in place for symmetry with the other
top-level functions.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 6eb67c75c3..069bf14846 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -527,7 +527,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
+static int do_drop_stash(struct stash_info *info, int quiet)
 {
 	int ret;
 	struct child_process cp_reflog = CHILD_PROCESS_INIT;
@@ -597,7 +597,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 
 	assert_stash_ref(&info);
 
-	ret = do_drop_stash(prefix, &info, quiet);
+	ret = do_drop_stash(&info, quiet);
 	free_stash_info(&info);
 	return ret;
 }
@@ -626,7 +626,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 		printf_ln(_("The stash entry is kept in case "
 			    "you need it again."));
 	else
-		ret = do_drop_stash(prefix, &info, quiet);
+		ret = do_drop_stash(&info, quiet);
 
 	free_stash_info(&info);
 	return ret;
@@ -663,7 +663,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	if (!ret)
 		ret = do_apply_stash(prefix, &info, 1, 0);
 	if (!ret && info.is_stash_ref)
-		ret = do_drop_stash(prefix, &info, 0);
+		ret = do_drop_stash(&info, 0);
 
 	free_stash_info(&info);
 
-- 
2.21.0.474.g541d9dca55
