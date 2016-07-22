Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5593A203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 23:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcGVX2Y (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 19:28:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35363 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGVX2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 19:28:23 -0400
Received: by mail-io0-f195.google.com with SMTP id q83so8326986iod.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 16:28:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cYuXAc9LsKdMNRz+QQJQ/YzXqkrtH2UAWjszGpnkhKY=;
        b=gfZk5pt2Qg0g7cmsXcBAztYOBGMYzeZkvyz5UKlB33oNRKkqxbB5IjaN7VL/VMcdtw
         Zn5z0nv4+q0lEGtczjt5FhCnTZQed6PyRXGmJItBhLOvg60Bt5QU/0yvJ6luz17M4i2C
         7o3Ct7Fnrk+ilCTaC+n6NjoMZwHSkSyN8NnYvfQfn4egrzW7xjZi9lS5seY/ynpZ5T5H
         5zz58eBJnoYJEGVkMZjW6AM1p724sInRFV6HW/lc7iY/eIZx6VqVNfs6svsqYzML8rYe
         dVM8ueMHv0Ivcej5xkqrPjJYuYPUAn1TJWiyxU2dr5LnOULgnZrUaRNNN2nyLY8mySMr
         FZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cYuXAc9LsKdMNRz+QQJQ/YzXqkrtH2UAWjszGpnkhKY=;
        b=Eh1CaacRN8+GrlbYTFWCmHrKRp6nlR69yrxGFLOfESJA22cNYz3NqgXsCm0tiXVllb
         A0Ta47r9VhtE4oAr4DbR+5B6TyIwijZ5o8F++VKOb0j86xfmR/T7nxPGbYs6+Wxt0WhT
         qNLFRTndR3lX8TNQ9s7kYcCDa7H8P7HbGzlAqUaMfnPSJEMwFmojpR7ByqAVlHdYBWaf
         VsLqUS3b/z733oLYnp0V0gVDjviJvNrmHMwgoozCUQNA6lDlaIlH/LIK4ZvkFazJDKBX
         d//S+5/PN4gBhjRN8J4UZT8Sh6bxLKjw2dLPzeZmg4DGBe9r/lgDqPnnQ7gjzSEND6OQ
         O0Lg==
X-Gm-Message-State: AEkooutNyQvjBW6LRTUWyFgBrNTigKg20CmSHNkBgEX050NpVlRBxwylOp/UF/a3Y1oKn+7Qh/D/LTCSupREoA==
X-Received: by 10.107.25.14 with SMTP id 14mr7460794ioz.168.1469230102619;
 Fri, 22 Jul 2016 16:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Fri, 22 Jul 2016 16:28:22 -0700 (PDT)
In-Reply-To: <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
 <20160720134211.GA19359@sigill.intra.peff.net> <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
 <20160720205207.GA578@sigill.intra.peff.net> <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 22 Jul 2016 19:28:22 -0400
X-Google-Sender-Auth: -G90CpZ75aN-RZwYaSuoSy9Qgss
Message-ID: <CAPig+cSw2t36n3ir61BhcMbSVMYoTVrYwbyGVSPcLoGnwR4w2w@mail.gmail.com>
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	Richard Soderberg <rsoderberg@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] grep: further simplify setting the pattern type
>
> When c5c31d33 (grep: move pattern-type bits support to top-level
> grep.[ch], 2012-10-03) introduced grep_commit_pattern_type() helper
> function, the intention was to allow the users of grep API to having
> to fiddle only with .pattern_type_option (which can be set to "fixed",
> "basic", "extended", and "pcre"), and then immediately before compiling
> the pattern strings for use, call grep_commit_pattern_type() to have
> it prepare various bits in the grep_opt structure (like .fixed,
> .regflags, etc.).
>
> However, grep_set_pattern_type_option() helper function the grep API
> internally uses were left as an external function by mistake.  This
> function shouldn't have been made callable by the users of the API.
>
> Later when the grep API was used in revision graversal machinery,

s/graversal/traversal/

> the caller then mistakenly started calling the function around
> 34a4ae55 (log --grep: use the same helper to set -E/-F options as
> "git grep", 2012-10-03), instead of setting the .pattern_type_option
> field and letting the grep_commit_pattern_type() to take care of the
> details.
>
> This caused an unnecessary bug that made a configured
> grep.patternType take precedence over the command line options
> (e.g. --basic-regexp, --fixed-strings) in "git log" family of
> commands.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
