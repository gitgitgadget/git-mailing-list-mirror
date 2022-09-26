Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F6C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiIZPbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiIZP0h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 11:26:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D145D111
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 07:11:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a20so4121221qtw.10
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f5SFD7kvRjuMP7pTRBdJLPn1y1FQYYzo1Po0A3UmbhE=;
        b=PXBYvy/CA8KngzABywWtsRsRFW2hq2KKxdCr5y+L7UuT+Fpras4RlctspTspMWEH87
         4w1SHs5/24FEq0TffBJMnmz9kE0MnbKoCm/JWWOZ5hZvYbdviab7V/4/JgHaKrXClksa
         zrgEjgL1SBvRCdi/GrIpbWWP2dQlMek5fKqj/zEU0v9wdghAb27iaKbJo5X/Kpu+bNkr
         ORsNnk5vrVyHUQtZPrQzBLysbG6OEuLFIPAtGNJyp4g6vl2yKVg5U4vENoZsccQlZ5Jn
         NT6APSXP616gR4+lJAuhbK9j46cG2gPyEm5sCdIUmp7VTpIjMU9RGMhcHxCrnXLmYDud
         1vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f5SFD7kvRjuMP7pTRBdJLPn1y1FQYYzo1Po0A3UmbhE=;
        b=Gn65Iw668t/nzkY4odG7BoLfjTjRmR7kCVN5k3k9mb57sFIL3Ni5uLzaBxP4SVh6Or
         h9gsf/87bfx/kxvxqtmkHI2+0MMwauZN0sXNHYlCLZsOK6ULybNCOhzZPahh1euph6so
         bvpaOBrqYQxmIAPIMgV5F+nZUS3JOuZnZAdUrcr42HU5lqwEEWtjKRwhSYuLQqwVaReu
         mvOEZMbV9EdyTLpmbc1jROwOxUhy8kiCfMi8ZjbaOD7lQl7v6rolVHe0RhSsHyuzIGP+
         bPH05COkpVDBNuZTr/QJCYfi1qslESsA+1K8XBqHdQf4J76qbKIyL1jyxDhd7O2jMgkD
         lpjg==
X-Gm-Message-State: ACrzQf3H5TiGWB/oFX3jJ10fd24VoPst9Ztc5ABqNtE0rtKZCeRnLJi/
        5R4ES9+EaQ3GAjleG/GOvkY=
X-Google-Smtp-Source: AMsMyM5ITt99U3aL4ZsRojDQ/5sT4B/K3uF0/+wgzDGqqCpm4xAFMoSTHmxGcS0NHH/B4j7TzS6RGw==
X-Received: by 2002:a05:622a:1886:b0:35c:b9f5:cbcd with SMTP id v6-20020a05622a188600b0035cb9f5cbcdmr18107422qtc.290.1664201507529;
        Mon, 26 Sep 2022 07:11:47 -0700 (PDT)
Received: from [10.37.129.2] (pool-71-187-159-144.nwrknj.fios.verizon.net. [71.187.159.144])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a01c600b0035bb84a4150sm11446540qtw.71.2022.09.26.07.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:11:46 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Date:   Mon, 26 Sep 2022 10:11:45 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <750BA887-BECB-471D-8BB2-0B321778F376@gmail.com>
In-Reply-To: <20220926091442.222876-1-siddharthasthana31@gmail.com>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20220926091442.222876-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddarth,

On 26 Sep 2022, at 5:14, Siddharth Asthana wrote:

> The command git cat-file can now use the mailmap mechanism to replace
> idents with their canonical versions for commit and tag objects. There
> are several options like `--batch`, `--batch-check` and
> `--batch-command` that can be combined with `--use-mailmap`. But, the
> documentation for `--batch`, `--batch-check` and `--batch-command`
> doesn't say so. This patch fixes that documentation.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>
> This patch was previously sent as the first patch of a 3 patch series f=
or
> adding the mailmap support in git cat-file options:
> https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@=
gmail.com/
>
> Changes in v2:
> - Fixed the names in trailers in the commit message
> - Updated the documentation to clearly state that the `--batch-check`,
>   `--batch-command` and `--batch` options can only be used with
>   `--textconv`, `--filters` or `--use-mailmap`.
> - Fixed formating
>
>  Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------=

>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
> index ec30b5c574..2a8f050a29 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -89,26 +89,45 @@ OPTIONS
>  --batch::
>  --batch=3D<format>::
>  	Print object information and contents for each object provided
> -	on stdin.  May not be combined with any other options or arguments
> -	except `--textconv` or `--filters`, in which case the input lines
> -	also need to specify the path, separated by whitespace.  See the
> -	section `BATCH OUTPUT` below for details.
> +	on stdin. May not be combined with any other options or arguments
> +	except --textconv, --filters or --use-mailmap.

except --textconv, --filters, or --use-mailmap.

> +	+
> +	* When used with `--textconv` or `--filters`, the input lines
> +	  must specify the path, separated by whitespace. See the section
> +	  `BATCH OUTPUT` below for details.
> +	+
> +	* When used with `--use-mailmap`, the info command shows the size
> +	  the object, if the idents recorded in it were the ones "corrected"
> +	  by the mailmap mechanism.

When used with `--use-mailmap`, the info command shows the size
the object if the identities recorded in it were replaced
by the mailmap mechanism.

>
>  --batch-check::
>  --batch-check=3D<format>::
> -	Print object information for each object provided on stdin.  May
> -	not be combined with any other options or arguments except
> -	`--textconv` or `--filters`, in which case the input lines also
> -	need to specify the path, separated by whitespace.  See the
> -	section `BATCH OUTPUT` below for details.
> +	Print object information for each object provided on stdin. May not b=
e
> +	combined with any other options or arguments except --textconv, --fil=
ters
> +	or --use-mailmap.
> +	+
> +	* When used with `--textconv` or `--filters`, the input lines must
> +	 specify the path, separated by whitespace. See the section
> +	 `BATCH OUTPUT` below for details.
> +	+
> +	* When used with `--use-mailmap`, the info command shows the size
> +	  the object, if the idents recorded in it were the ones "corrected"
> +	  by the mailmap mechanism.

Same as above

>  --batch-command::
>  --batch-command=3D<format>::
>  	Enter a command mode that reads commands and arguments from stdin. Ma=
y
> -	only be combined with `--buffer`, `--textconv` or `--filters`. In the=

> -	case of `--textconv` or `--filters`, the input lines also need to spe=
cify
> -	the path, separated by whitespace. See the section `BATCH OUTPUT` bel=
ow
> -	for details.
> +	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
> +	`--filters`.
> +	+
> +	* When used with `--textconv` or `--filters`, the input lines must
> +	  specify the path, separated by whitespace. See the section
> +	  `BATCH OUTPUT` below for details.
> +	+
> +	* When used with `--use-mailmap`, the info command shows the size the=

> +	  object, if the idents recorded in it were the ones "corrected" by t=
he
> +	  mailmap mechanism.

Same as above

> +
>  +
>  `--batch-command` recognizes the following commands:
>  +
> -- =

> 2.38.0.rc1.4.g29ac4cf309.dirty

thanks!
