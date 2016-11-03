Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCB32076A
	for <e@80x24.org>; Thu,  3 Nov 2016 00:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbcKCAW6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 20:22:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36310 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbcKCAW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 20:22:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id n85so3028960pfi.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9hDEJuTQgCOKy68eiNceFeFBdiS74As8RmNXLQOHULU=;
        b=lqz+EMEAfosLDGAkxdAIALxNdRGZDFzfkQY28rt3TSrULV9pJX7I4qppXSK6/E7fU2
         h70NelQH8kAGj3SOHu/zXPPEx4fAQDBjbwDVjSiMtMJflFaMZtupUaE4l6JyNAhD68sh
         Dht66mmed8Rk1ZMeHt+nL/gikEVzs30zZVIPTvVj4pjG722NC+XLq1d/qEPw9G2WBDta
         3CFHMiTiJ5TeB/NuqGX5T27RptVozdYk0VKnVZvqZo0bqhVSbVPltrJIwjqgNxVY6sXG
         g2OEEEl/DHnsf2NV1gMXDZBwB+xRq+eZe41iGngw7+9H4HiJqtPvAW/PrQWbyFgj/y1d
         Hz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9hDEJuTQgCOKy68eiNceFeFBdiS74As8RmNXLQOHULU=;
        b=dzsN0g4qosdssvQVhWscxADATh9Qe/VV4uOZxHsVuDi6Q/gp5Gl6kEavlb6168azeM
         nnE31GXQqRhGH8O5SCELdBB3GZsF5J+k5GUEmy6WIM5GlUO2pAP595pTx98Z1L2BeDJI
         EtZNZLYLTuk8ssGyPt0XSW1Kd3AbakODMmRVw+M9XvzW1JgALwonAgy7Sbdr6HUKV6tu
         zp284qHd9VUifFmPFxVVzY4rx+82Ri0HerFz2YdGhUauPD7vEWIORZciMe74sj1qVcHy
         hxZLkWgmFOKc87pnqomQYIicyBek2hzczw4ft4Znwu9ju5NyZibNyvs4m/QQL34sB8M7
         AqPA==
X-Gm-Message-State: ABUngvfyhBPeF1ILNTHJGQ8ylNysJyEkzNCbHj1VNYK96oHDRM6dYK9T8RlpOh6q9rB0oQ==
X-Received: by 10.99.38.66 with SMTP id m63mr9665311pgm.83.1478132576974;
        Wed, 02 Nov 2016 17:22:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:782b:e6dd:f883:e4c8])
        by smtp.gmail.com with ESMTPSA id q28sm7362934pfj.73.2016.11.02.17.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 17:22:56 -0700 (PDT)
Date:   Wed, 2 Nov 2016 17:22:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103002225.GA13369@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478125247-62372-1-git-send-email-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+peff and bburky, who introduced GIT_ALLOW_PROTOCOL)
Brandon Williams wrote:

> Add configuration option 'core.allowProtocol' to allow users to create a
> whitelist of allowed protocols for fetch/push/clone in their gitconfig.

Ooh.

This would be especially useful at $DAYJOB, where there is a custom
sso:// protocol that is often used by submodules.  Using an envvar to
whitelist it globally is painful because

 - it disables other protocols even when explicitly requested on a
   plain "git clone" command line by the user.  By comparison, the
   built-in git-submodule.sh whitelist only applies to submodules.

 - platform-specific instructions to set an environment variable can
   be more difficult than "just set this git configuration"

Another difficulty with setting GIT_ALLOW_PROTOCOL globally is that it
requires copy/pasting the default value from upstream and then adding
the values I want.  There's no straightforward way to get the current
value and add to it, in case I want to benefit from future upstream
fixes to the default list.

That is, would it be possible to use something like

	[protocol "sso"]
		allow = always

instead of

	[core]
		allowProtocol = file:git:http:https:....:sso

?

[...]
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -27,7 +27,8 @@ cd_to_toplevel
>  #
>  # If the user has already specified a set of allowed protocols,
>  # we assume they know what they're doing and use that instead.
> -: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
> +config_whitelist=$(git config core.allowProtocol)
> +: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}

optional: To avoid config parsing when GIT_ALLOW_PROTOCOL is already
set, could do something like

 if ! test "${GIT_ALLOW_PROTOCOL+set}"
 then
	GIT_ALLOW_PROTOCOL=$(
		git config --name-only --get-regexp 'protocol\..*\.allow' always |
		sed -e 's/^protocol.//' -e 's/.allow$//' |
		tr '\n' ':'
	)
	GIT_ALLOW_PROTOCOL=${GIT_ALLOW_PROTOCOL%:}
	: ${GIT_ALLOW_PROTOCOL:=file:git:http:https:ssh}
 fi

[...]
> --- a/transport.c
> +++ b/transport.c
> @@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
>  
>  	if (enabled < 0) {
>  		const char *v = getenv("GIT_ALLOW_PROTOCOL");
> -		if (v) {
> +		if (v || !git_config_get_value("core.allowProtocol", &v)) {
>  			string_list_split(&allowed, v, ':', -1);

This has the effect of always disabling other protocols when
core.allowProtocol is set.  Is that intended?

Like the default list used by submodule, I'd be happiest if this only
applied to repositories cloned implicitly instead of those passed
directly to 'git clone'.

That reminds me: external tools also set GIT_ALLOW_PROTOCOL when the
user hasn't set it explicitly, like git-submodule.sh does.  E.g.
repo <https://gerrit.googlesource.com/git-repo/+/466b8c4e/git_command.py#171>,
mercurial <https://www.mercurial-scm.org/repo/hg/file/b032a7b676c6/mercurial/subrepo.py#l1404>.
Other external tools consume GIT_ALLOW_PROTOCOL, like 'go get'
<https://go.googlesource.com/go/+/55620a0e/src/cmd/go/vcs.go#64>.
Can we make it more convenient for them to support this configuration
too?

An example approach would be a GIT_ALLOW_PROTOCOL var returned by
"git var".

That way git-submodule.sh could do

	: ${GIT_ALLOW_PROTOCOL=$(git var GIT_ALLOW_PROTOCOL)}

and it would just work.  Other tools could do the same, with a
fallback to the current default until new enough git is in widespread
use.

Thanks and hope that helps,
Jonathan
