Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637F71F954
	for <e@80x24.org>; Thu, 23 Aug 2018 03:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeHWGuN (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 02:50:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45663 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeHWGuN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 02:50:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so1332355pgv.12
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0Eil/2gLZXoyOybKy0G94/qTIVr2Xdm1NSdXc/8xF4=;
        b=j6iqrC0m29krZCiV8we5OdX8EKKXT0x7OV5/3NyO6PBNi6JeIfA/eBUT0qEHUwBfPL
         tRrz290/APD3FZxGxwX/t0ZAsnxeLa58hQcsWm1dSNlSTnGlpLfX09Dlw2k/oooNMM+b
         oE+quNHodqehBpVo9AnGtb7tVxkU3TWpaI3bZW02NtKX5Rr7ptQPCUHlPltYAr14mGfV
         tGzqlyapucusaO0uWH9U9v0BvD7gut2CSM6RBOrN8+iJfGFxNb7eVIeHmfh/PW68JCKm
         yH0rTS6P+k6tNLmteItDGq8LSt5ENpVqs16sdap9q22hGLP725dYOjKUbZirc6lSC9XI
         aBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0Eil/2gLZXoyOybKy0G94/qTIVr2Xdm1NSdXc/8xF4=;
        b=F/35lkUjgOk6AMJ6VtTfpPVW+qGCy2A9I7fUfdYQY/OkKNd5c4zyqwkuLZkICD/rpz
         E00u1+6NZui+YptSqZ//nGwEradsfWZsU/BJavHYImI/KAtY+ZD4DFWbTbxA9PcAGPah
         rGiq87Nrc5gdrJgFUUvQOGAxemP+KyOp2bCjApzw9mVhGU5A+rM5LXKE9jeFLhxEttzE
         fxP3o6gOKqYCYMXRdM34CZpX2tOw/A5Ql2tEv4QN4JCxS6VSOef9xbRg974Jqwjtjonb
         r6JS+frVu840bG/BwH2mOmL0BbCKIohsd8LtUK/R+VXfBqhWB/bDATsc+f0t+DkCC00I
         F2Xg==
X-Gm-Message-State: APzg51BgXyDq7iDsleoQ3WYZKW266f3WDgOLOSFZyKKHupGzw+L8fbFw
        uKl9WUxxPVmFsnGPfdu/SB5YQdAR
X-Google-Smtp-Source: ANB0VdbJ102yf4gEryt8AVR4GwBOHVxIXVRJH+cfPcoWjnomLVyGvj7LGWSi9IBXBZFqd6iQJbpOiw==
X-Received: by 2002:a62:1c7:: with SMTP id 190-v6mr10437281pfb.1.1534994560938;
        Wed, 22 Aug 2018 20:22:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n79-v6sm118275pfh.2.2018.08.22.20.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 20:22:40 -0700 (PDT)
Date:   Wed, 22 Aug 2018 20:22:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823032238.GI92374@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com>
 <20180823024719.GG92374@aiede.svl.corp.google.com>
 <87wosh7pjj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wosh7pjj.fsf@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Kyle Meyer wrote:

>>> -			    N_("color both diff and diff-between-diffs")),
>>> +			    N_("restrict coloring to outer diff markers")),
[...]
>> What is an outer diff marker?
>
> The diff markers from the diff of patches as opposed to the ones from
> the original patches.  I took the term from git-range-diff.txt:
>
>     --no-dual-color::
>         When the commit diffs differ, `git range-diff` recreates the
>         original diffs' coloring, and adds outer -/+ diff markers [...]
>
>     Use `--no-dual-color` to revert to color all lines according to the
>     outer diff markers (and completely ignore the inner diff when it
>     comes to color).

Aha: I think you're missing a few words (e.g. "color only according to
outer diff markers").  Though based on the output, I'm not sure the
focus on diff markers captures the difference.  (After all, some lines
are multiple colors in --no-dual-color mode and have no diff markers.)

"Restrict coloring to outer -/+ diff markers" would mean that
everything will be in plain text, except for the minus or plus sign at
the beginning of each line.  So you'd see a colorful strip on the left
and everything else monochrome.

I think what you mean is something like "color only based on the
diff-between-diffs".  Or it might be simpler to do something like
the following.  What do you think?

diff --git i/builtin/range-diff.c w/builtin/range-diff.c
index f52d45d9d6..88c19f48d3 100644
--- i/builtin/range-diff.c
+++ w/builtin/range-diff.c
@@ -20,12 +20,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
 	struct diff_options diffopt = { NULL };
-	int simple_color = -1;
+	int dual_color = -1;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
-		OPT_BOOL(0, "no-dual-color", &simple_color,
-			    N_("color both diff and diff-between-diffs")),
+		OPT_BOOL(0, "dual-color", &dual_color,
+			    N_("color both diff and diff-between-diffs (default)")),
 		OPT_END()
 	};
 	int i, j, res = 0;
@@ -63,8 +63,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
 			     builtin_range_diff_usage, 0);
 
-	if (simple_color < 1) {
-		if (!simple_color)
+	if (dual_color != 0) {
+		if (dual_color > 0)
 			/* force color when --dual-color was used */
 			diffopt.use_color = 1;
 		diffopt.flags.dual_color_diffed_diffs = 1;
