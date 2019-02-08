Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3391F453
	for <e@80x24.org>; Fri,  8 Feb 2019 14:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfBHOTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 09:19:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfBHOTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 09:19:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id h22so6914158wmb.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 06:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CrPv1apNSk3AeB1JlI9FBDdgoR16sRljIaQ3h0zMGQk=;
        b=Px895z4soJSa4lc9oKwAQcbLa2SySke15fhfPotzu5axxywvUrLdCf0ruIxJd/r+oz
         az2kmmVCp+DodMtCqXj286HYHWbt4beP6/ffoBwZ1NijmnYTQ9LHQVBKEBklC+hPm+v5
         /k744+0rQOpXBfATyxcxmGxIpobS0MmsabwAqVHmdUkAfERzX24JLfbcpOcEwVUTkE/J
         Z3IlzqLyz49EEEKGe1uwa/pUmZdLOPuiw8yRoMZvW51LYR2JO6+JrntqMx7nCxroU2Qb
         JpXBm/KDx70IVcXd0/R+CCZ8fDM/lQWz+qznlAqzmnX1jJQVQ6rNe+vSjdCRbeF2HjIW
         aNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CrPv1apNSk3AeB1JlI9FBDdgoR16sRljIaQ3h0zMGQk=;
        b=BnC55dlRMKKBbrvFlk/39DHD+v5AtFcDSYtZGkMRBacncuilHPG8nuY/926kowQDVe
         ZIGovoYdK3d1QdYCJCzbM0wTdjD+cArQqenOZ7btO6C1/NHRo1LjRKEDPFbgfcVHQKGz
         V+mjqdiwRgaSr6ev11fZ+hYzLkVAnHDB9sd/azxsnwsWPjAwh47Btl/Ji4JwNMDPe4N1
         6sMPH5PEbjnnXwgALJzkcVdSn9P/i2kfipj9fnwNWerXWnGMPFsyiQ638TFnxpKUjCk1
         fz10lGfYnE4WORbTOS7KqIhh47yN9CDJDk23MaG4G8aP6IJFu1PrMj5cm026cSbmqTY6
         PN5Q==
X-Gm-Message-State: AHQUAubIa0hGIl05L+LTz9iAdHP2JYLSyZRcJTV+FyvXxQB3my5NLlid
        MOE/ctESrJO+aYWeIpntGxU=
X-Google-Smtp-Source: AHgI3IbQ1f5xQAdYXAjhZ5nKoKn60XvhK9V9zoPKABDgViCQGvHFCmsvkOjtv8icZGZrbMOGds73Cg==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr12144223wmk.30.1549635558746;
        Fri, 08 Feb 2019 06:19:18 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id y20sm4673750wra.51.2019.02.08.06.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:19:17 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:19:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/19] completion: support switch
Message-ID: <20190208141915.GX10587@szeder.dev>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
 <20190208090401.14793-19-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208090401.14793-19-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 04:04:00PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Completion support for --guess could be made better. If no --detach is
> given, we should only provide a list of refs/heads/* and dwim ones,
> not the entire ref space. But I still can't penetrate that
> __git_refs() function yet.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 499e56f83d..891abb72d7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2126,6 +2126,32 @@ _git_status ()
>  	__git_complete_index_file "$complete_opt"
>  }
>  
> +_git_switch ()
> +{
> +	case "$cur" in
> +	--conflict=*)
> +		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
> +		;;
> +	--*)
> +		__gitcomp_builtin switch
> +		;;
> +	*)
> +		# check if ---guess was specified to enable DWIM mode

Nit: s/---/--/

> +		local track_opt= only_local_ref=n
> +		if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
> +			track_opt='--track'
> +		elif [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
> +			only_local_ref=y
> +		fi

Could these two options be used together?  I think they could.  If
that's the case, then the two conditions shouldn't be chained with
elif, but should be two separate if statements (even eliminating
$only_local_ref, while at it?).  If that's not the case, then the two
__git_find_on_cmdline() calls could be combined into one, and a case
statement could act according the option found, sparing one of the
subshells from the two.

> +		if [ $only_local_ref = y ]; then
> +			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
> +		else
> +			__git_complete_refs $track_opt
> +		fi
> +		;;
> +	esac
> +}
> +
>  __git_config_get_set_variables ()
>  {
>  	local prevword word config_file= c=$cword
> -- 
> 2.20.1.682.gd5861c6d90
> 
