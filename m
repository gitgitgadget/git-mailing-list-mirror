Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4426F1F453
	for <e@80x24.org>; Sun, 28 Apr 2019 23:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfD1XxB (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 19:53:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42902 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfD1XxB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 19:53:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so4271725pgh.9
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fE+FBROJDhdEDI+0FZ+8KV+mdTN1v27mOM0BJ5ilxv4=;
        b=ZcbJvq3nNSMISHC+RvibgmPD8c2p+5sr6FqsDMkZM4/7484T2rG8Fw8qSepmfeFp6F
         fM7DgIa7eaQFMLFCeCiY9JN75WmrbPMJpaAoZXv1Fz31D6epJxfgToNR+y3i4P7/P1G0
         6hiTT/JuKpU/bHCTV+T4Mz0bB4gnWE/EClnY0gE25tW3e1r2YkT58ism4eba4Wl4VVJ5
         ygzt/eeUZScMWqfE3bnI3YTVHKwqYQ7h71nkK/u3BO+5yDqMsRfFrWDKeHdFw1xgDTzc
         SrBXQWuweU225G9qWiImIBu8xi9+UwcQsk1Pg8ELUO/YN5GEUi20Ky1o1IIBF4xFmOSM
         Moqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fE+FBROJDhdEDI+0FZ+8KV+mdTN1v27mOM0BJ5ilxv4=;
        b=eaDtrLevdhVtoB0/nJDzqJL0qBKbtpzcDUI1dnuhL+fp0m7b2zvXmU0ykShw3SzvOr
         d3DWlnHZ52DffaWp5+pDyWOf05z6dyb+TzUitzzh2EQVIN6BcCHX2ifgg9iZJM2mCdwC
         J22/vkMdLV0VOkuPd2Qd+elht/2gu2z/S830Mcw+fx6kUCTJxtfB9nvHcozVWCJMiLl9
         cXf4K5TJ5qEOizeIpEmHhwdRM3BN01HwUAcI/Ms7Sznl0rk5SwBLmOZZK8tptPCkab0N
         zau4w7opS3g6s0IhGNH4oxYgbUkz3vEZlz4qUErv2rVT0uqwZxsZJeACoTc1X639dXo9
         VkTA==
X-Gm-Message-State: APjAAAWJCeYvRokvaYTtf6PJdooJ0IpixWbXa9amK5vCZoFi27L15T2n
        B2u7MGHCqAHMrzmfTUgcmPI=
X-Google-Smtp-Source: APXvYqyASfYhkV0MX7F/D9pvF3iUyRMjWM5AK6hYS+xNhmNk0r8vcb/UstS+nHCaA/R5d/79LGGR9w==
X-Received: by 2002:a63:8c7:: with SMTP id 190mr49349190pgi.447.1556495580697;
        Sun, 28 Apr 2019 16:53:00 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id s9sm41892403pfe.183.2019.04.28.16.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 16:52:59 -0700 (PDT)
Date:   Sun, 28 Apr 2019 16:52:56 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] mergetool: use get_merge_tool function
Message-ID: <20190428235256.GA6418@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 02:54:39AM -0700, Denton Liu wrote:
> In git-mergetool, the logic for getting which merge tool to use is
> duplicated in git-mergetool--lib, except for the fact that it needs to
> know whether the tool was guessed or not.
> 
> Rewrite `get_merge_tool` to return whether or not the tool was guessed
> through the return code and make git-mergetool call this function
> instead of duplicating the logic. Note that 1 was chosen to be the
> return code of when a tool is guessed because it seems like a slightly
> more abnormal condition than getting a tool that's explicitly specified
> but this is completely arbitrary.
> 
> Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not the
> guitool will be selected.
> 
> This change is not completely backwards compatible as there may be
> external users of git-mergetool--lib. However, only one user,
> git-diffall[1], was found from searching GitHub and Google. It seems
> very unlikely that there exists an external caller that would take into
> account the return code of `get_merge_tool` as it would always return 0
> before this change so this change probably does not affect any external
> users.
> 
> [1]: https://github.com/thenigan/git-diffall
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>


The author of git-diffall approached the list some time ago and his
contribution resulted in "git difftool --dir-diff".

These days we would probably encourage users to use the difftool
built-in feature rather than "diffall", but thank you for your
careful consideration against breaking external scripts.

Maybe we can submit a PR against the diffall repo mentioning
the backstory so that new users are pointed to the main tool.


> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 83bf52494c..68ff26a0f7 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -403,14 +403,17 @@ get_merge_tool_path () {
>  }
>  
>  get_merge_tool () {
> +	not_guessed=true

Tiny nit; I find double-negatives hard to understand.  Maybe rename this
to "is_guessed" and flip the logic below so that we can keep the
variable named as a positive flag?


>  	# Check if a merge tool has been configured
> -	merge_tool=$(get_configured_merge_tool)
> +	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
>  	# Try to guess an appropriate merge tool if no tool has been set.
>  	if test -z "$merge_tool"
>  	then
>  		merge_tool=$(guess_merge_tool) || exit
> +		not_guessed=false
>  	fi
>  	echo "$merge_tool"
> +	test "$not_guessed" = true
>  }

-- 
David
