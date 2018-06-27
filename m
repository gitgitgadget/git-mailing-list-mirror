Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605211F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964802AbeF0RRC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:17:02 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:34482 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0RRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:17:01 -0400
Received: by mail-ot0-f177.google.com with SMTP id i17-v6so3036746otl.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMh0Z2K2RsR+Doc/5D0YVe0wZQid+yCyEEU5cEHsXBk=;
        b=0Z/V7Kp+DYsWDpDnyCSckkazkBlrvH9+hT5qp8+wZo1Nfs/jZxtCWh+w9C+213Brtx
         QQ5CY2lJs4Nhif96NAbSy1EUIG4RL3aSPHtFLWUo3y1V+hFH4aPTsjxpw77UOpL7pdFW
         02ipQhB7Urm0Y7Q0g9gSEjvBSdWgn7N0IiF4T705OMrZRD0PsvCkRiW+XSoC+7MrQpE4
         SmjCawBp4ekS82H1hUPRYo6aeeIa90k0x90MmQ4lXypx3+SUeLypKVpVA5wjR2hz+ywV
         Ur5NBVOVDjEHIXeZrMnK5acjy4h+Ej8EyQ+KoTSiqXHHMfnEz1YBNdaF3oCR8XW8t/T1
         D69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMh0Z2K2RsR+Doc/5D0YVe0wZQid+yCyEEU5cEHsXBk=;
        b=OZT0pX8naAErk3yt/ka5lAQoXgx5RRztCCAC2tcfYTFWUyfWMMz5utbbceTM14MiVM
         8QhbCkgo//x+EplmJ98g5VKg+p6ejPz6D4NexEYCj2igcMYeJfxQZXUC53NuO9H8nkfO
         q+RWDTLpspETSQhxIHJyDibsq+anBYNE2oXIj1xZ2Evowj7X16BJb6W0P/CgJaqTD8gz
         GxxTVFLtAll+YeRHQzmGSNTC1Ua7T91UJMmVaXRbpktkK327lpP/7Udceo94dyKZjErx
         MhDKsbPTtmQj3AtlkP8iO1aaqESVNnuzsnuBP89LvP8OGvP9V+sfZQAaUdJoySzbDEdd
         JaVQ==
X-Gm-Message-State: APt69E1rFErk9bekFfknMW6km5G21j08D+AccUpdLtXfLaABDrBgU13P
        8ulScxw8VYuB9TlF5RlBg24jXQ==
X-Google-Smtp-Source: AAOMgpe5MBzVCEj3HsBC2ZC1pKuUBSOvwsM5BqXckVu4r8SECq6xAk8DYgxelxSAasa/gfNRCf+t1A==
X-Received: by 2002:a9d:389a:: with SMTP id p26-v6mr1056946otc.304.1530119820782;
        Wed, 27 Jun 2018 10:17:00 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id h39-v6sm2211474otb.47.2018.06.27.10.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:16:59 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 27 Jun 2018 12:16:57 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
Message-ID: <20180627171657.GA26628@syl.attlocal.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
 <xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 09:40:10AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > -		if (sign == ':')
> > -			match_color = opt->color_match_selected;
> > -		else
> > -			match_color = opt->color_match_context;
> > -		if (sign == ':')
> > -			line_color = opt->color_selected;
> > -		else if (sign == '-')
> > -			line_color = opt->color_context;
> > -		else if (sign == '=')
> > -			line_color = opt->color_function;
> > +		if (opt->color) {
> > +			if (sign == ':')
> > +				match_color = opt->color_match_selected;
> > +			else
> > +				match_color = opt->color_match_context;
> > +			if (sign == ':')
> > +				line_color = opt->color_selected;
> > +			else if (sign == '-')
> > +				line_color = opt->color_context;
> > +			else if (sign == '=')
> > +				line_color = opt->color_function;
> > +		}
>
> The above change (specifically, the fact that this now is enclosed
> in "if (opt->color) { ... }") unfortunately leaves match_color
> undefined at this point in the control flow.  The next loop then
> calls output_color() with an undefined match_color and tricks stupid
> compiler to issue a warning and makes -Werror build to fail.

Right, this is because we are using the `while (next_match(...))` loop
for non-colorized output, which is new. This seems like a definite
problem, and certainly causes the -Werror build to fail for me, too.

> >  		*eol = '\0';
> >  		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
> >  			if (match.rm_so == match.rm_eo)
> >  				break;
> >
> > -			output_color(opt, bol, match.rm_so, line_color);
> > +			if (opt->only_matching)
> > +				show_line_header(opt, name, lno, cno, sign);
> > +			else
> > +				output_color(opt, bol, match.rm_so, line_color);
> >  			output_color(opt, bol + match.rm_so,
> >  				     match.rm_eo - match.rm_so, match_color);
>
> output_color() does check want_color(opt->color) before using its
> last parameter, and want_color() gives false for opt->color that is
> 0 (i.e. leaves match_color to be undefined), so in this case, the
> compiler is worried too much, but still, we should work it around if
> it is easy to do so.
>
> Just initializing match_color where it is defined at the beginning of
> show_line() should be sufficient, I think.

I think that we could also use the following, and leave the `if
(opt->color)` conditional where it is:

diff --git a/grep.c b/grep.c
index 48cca6723e..b985fb3ee0 100644
--- a/grep.c
+++ b/grep.c
@@ -1448,7 +1448,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
-	const char *match_color, *line_color = NULL;
+	const char *match_color = NULL, *line_color = NULL;

 	if (opt->file_break && opt->last_shown == 0) {
 		if (opt->show_hunk_mark)

From my reading, output_color() appears happy to treat a NULL color as
meaningless, and instead redirect the call to `opt->output` without the
preceding colorization and the reset afterwords.

We could also move that `if (opt->color)` block up closer to where
line_color and match_color are initialized, which might appear cleaner.
I think the best time to do that would be in a preparatory patch in this
series.

What do you think?


Thanks,
Taylor
