Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA164203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 05:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbcGUF0b (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 01:26:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33810 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbcGUF0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 01:26:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so4788603pfb.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 22:26:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7BmF02TwZmjQngAjc3DbyFjDzy0kBzG/nQ3V4c6EdA=;
        b=VTpix02eVX7crsXuEYx+s8XWFuJPLE5D//7dBPC86vVTbole7yK+rJehdtdfhDPGz1
         5CEoToMXXRTX54hNJkZEpUKuoL0G8xejdxRGtjAWMl14Mpw0bCzA6XbENI0BQ/yu8lni
         kyw166KQSyC4SiVI3TeZFTi+JNoLEvwGqWn+EtH3YKKJcHaiK2oypZSvxUqMFywhhYUs
         t/kjKecgM+YCEc+guapvGaoYFcaT0YTxentdMbRghzHSJz+QOOMD3QPlA1Sc6mAzY3qG
         c7cK9//K1DdnKEWh4+Sn/ziI/MoiNW1gsAHESuTyYqYUuz4b/H3MvAAUptH1aJPCY12b
         LUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7BmF02TwZmjQngAjc3DbyFjDzy0kBzG/nQ3V4c6EdA=;
        b=k72H0RHWVG/t00StPYL9JsM5dGugMt0gNlH8GCvAfd7y3pE7hvyyQzHrr2S6eIvUni
         y6/nX5xftUcHusvPVX8jw7M9qKEbHUwgUIv6/iXQSaK3x/c8B/1dMPBYiXtaSA0+3gEG
         nY7aH2cZ90PrivWaoGVJUYbJ9/wVmHLUzHNoFPzUIPq6f7/dI+HpQPQ7G+akiGMdIyyB
         GN0CSbQQVkIztnf7uny5XcBeHmZsit8mwLnCVduTzEhxmzrJRuiejqDGeVN603m5F9k7
         Tw8ONRECu2i428RAfF7sAumD3hHYCs0gJYwq0FkwEne4D30CK0l1iWme9AKKIDxTcTS1
         blkQ==
X-Gm-Message-State: ALyK8tJ7pOu74wFGiY24J2Ls/YpM/XJIsgR9DskBcRqd4gSfau0PtLVh73K2q2W5Y199MA==
X-Received: by 10.98.222.132 with SMTP id h126mr37722651pfg.61.1469078789298;
        Wed, 20 Jul 2016 22:26:29 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id d5sm8432203pfc.4.2016.07.20.22.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 22:26:27 -0700 (PDT)
Date:	Wed, 20 Jul 2016 22:26:25 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Brett Cundal <brett.cundal@iugome.com>
Cc:	git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
Message-ID: <20160721052625.GA31423@gmail.com>
References: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[cc'd Roberto for submitGit q's]

On Thu, Jul 21, 2016 at 12:56:51AM +0000, Brett Cundal wrote:
> ---

<emtpy commit message>

The message on the pull request[1] has a better justification
for this change, which would have been nice in the commit
message itself:


	Git 2.9 added a check against merging unrelated histories, which
	is exactly what git subtree with --rejoin does. Adding the
	--allow-unrelated-histories flag to merge will override this
	check.


Is it possible that maybe submitGit can detect an empty commit
message for single-commit PRs and transplant that message onto it?

As-is, the commit itself should probably be amended to contain
that information.

>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7a39b30..556cd92 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -661,7 +661,7 @@ cmd_split()
>  	if [ -n "$rejoin" ]; then
>  		debug "Merging split branch into HEAD..."
>  		latest_old=$(cache_get latest_old)
> -		git merge -s ours \
> +		git merge -s ours --allow-unrelated-histories \
>  			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
>  			$latest_new >&2 || exit $?
>  	fi
> 
> --

With the above description this change makes more sense,
but it seems that the existing tests do not detect the breakage
fixed by this patch.

Can you please add a test case in t/t7900-subtree.sh
demonstrating the breakage?

Looks good otherwise.

[1] https://github.com/git/git/pull/274
-- 
David
