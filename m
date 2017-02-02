Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC1B1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdBBJQX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:16:23 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35685 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdBBJQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:16:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so1065945pfa.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nN5I9WloZVDkbr+DN2sLhO8YyLo2KG0AW4SuQhG/kZY=;
        b=lBi/UatY6fCQ98n/EMgCxMB2AQFxWxfkK4bYNKb095XN06uJia90U8+HACBKtJI+F9
         rm0giiK1X+xqj31xsGL9SK9fHfytoBm2Sb3qXYA+l75dlEAv/yJQ4CWFAzEZo09OgrkV
         XOMyvuaok+aYwAxI+g6Dpi7IYY9AfAkZmB1QvDqX4IPjEnBzVJKd0hgv6qTSxOSgCR39
         yolnrHTXoj+QiGe7+WHOc8wkIZAqJ3VT9Q8UffDBY65yCa8frbqycyi2myEhDMFnOESj
         Ac1Uh7D1RCgYi631ot/uyU1oTpIZ0+8jXKED16TVMhMpNb960zuhHDNSKruptieuJmlS
         ntTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nN5I9WloZVDkbr+DN2sLhO8YyLo2KG0AW4SuQhG/kZY=;
        b=rjt505I/49Bz06yDqz+BYwpmhonMkDUK/4GxV46lVgXg4fZ5HN3DxeYSbico3vBy5W
         tBPwsQbfUwE51E731ENSpcSml4qXm+d7LFO2P/Og//lOCAUxeTB0S2UnJO/HBtLR306F
         yzeeaVJR1uTuZFAwwG+xbWKOZD/VY1Zm4p93k2HrVnYt0Z7pUQGvLei0364arO85TRvF
         yWKpZIS7IF/SnwpwrYlVBi0JGwokUZ948gInMUwjMpU7QkAob/xjF6w9z4mpqz5LHwmo
         hBZ7EtapW94TZnra91eF46zhw9gYD2tDe5IV3ooL65s3SgNrXWrTdHD56zX3yHcRcOzr
         n+zg==
X-Gm-Message-State: AIkVDXI2w/0x8AS6JCs56wzxYFs1aQSOXg0bIEdd01o84oYAHL5L4pgcT2q8OcmvolAh2Q==
X-Received: by 10.99.112.6 with SMTP id l6mr9407917pgc.33.1486026980322;
        Thu, 02 Feb 2017 01:16:20 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d68sm56313618pfj.92.2017.02.02.01.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 01:16:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 16:16:15 +0700
Date:   Thu, 2 Feb 2017 16:16:15 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] color_parse_mem: allow empty color spec
Message-ID: <20170202091615.GA22337@ash>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
 <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 01:21:29AM +0100, Jeff King wrote:
> On Tue, Jan 31, 2017 at 02:45:40PM -0800, Junio C Hamano wrote:
> 
> > * nd/log-graph-configurable-colors (2017-01-23) 3 commits
> >   (merged to 'next' on 2017-01-23 at c369982ad8)
> >  + log --graph: customize the graph lines with config log.graphColors
> >  + color.c: trim leading spaces in color_parse_mem()
> >  + color.c: fix color_parse_mem() with value_len == 0
> > 
> >  Some people feel the default set of colors used by "git log --graph"
> >  rather limiting.  A mechanism to customize the set of colors has
> >  been introduced.
> > 
> >  Reported to break "add -p".
> >  cf. <20170128040709.tqx4u45ktgpkbfm4@sigill.intra.peff.net>
> 
> I hadn't heard anything back,

Sorry I was accidentally busy during Luna new year holiday.

> so I wrapped up my fix with a commit
> message and tests (it needs to go on top anyway, since the breakage is
> in 'next').
> 
> -- >8 --
> Subject: [PATCH] color_parse_mem: allow empty color spec
> 
> Prior to c2f41bf52 (color.c: fix color_parse_mem() with
> value_len == 0, 2017-01-19), the empty string was
> interpreted as a color "reset". This was an accidental
> outcome, and that commit turned it into an error.
> 
> However, scripts may pass the empty string as a default
> value to "git config --get-color" to disable color when the
> value is not defined. The git-add--interactive script does
> this. As a result, the script is unusable since c2f41bf52
> unless you have color.diff.plain defined (if it is defined,
> then we don't parse the empty default at all).

..

> --- a/color.c
> +++ b/color.c
> @@ -212,8 +212,10 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>  		len--;
>  	}
>  
> -	if (!len)
> -		return -1;
> +	if (!len) {
> +		dst[0] = '\0';
> +		return 0;
> +	}
>  
>  	if (!strncasecmp(ptr, "reset", len)) {
>  		xsnprintf(dst, end - dst, GIT_COLOR_RESET);

I wonder if it makes more sense to do this in builtin/config.c. The
"default value" business is strictly git-config command's. The parsing
function does not need to know. Maybe something like this?

diff --git a/builtin/config.c b/builtin/config.c
index 05843a0f96..ec1f4f0cf4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -322,8 +322,10 @@ static void get_color(const char *var, const char *def_color)
 	git_config_with_options(git_get_color_config, NULL,
 				&given_config_source, respect_includes);
 
-	if (!get_color_found && def_color) {
-		if (color_parse(def_color, parsed_color) < 0)
+	if (!get_color_found) {
+		if (!def_color)
+			strcpy(parsed_color, GIT_COLOR_RESET);
+		else if (color_parse(def_color, parsed_color) < 0)
 			die(_("unable to parse default color value"));
 	}
 
This is also a good opportunity to document this behavior in
git-config.txt, I think.
--
Duy
