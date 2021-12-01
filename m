Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078BAC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhLAVcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhLAVc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:32:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D309C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:29:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so107469928edb.8
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=60jO/x7qhC/H6H1irwRNDgov6N06P1O3Yihxyn89xas=;
        b=AbofXgTnTzlMOHOse0USiUNJ57Oj3EEQZZnXXTteGfRZIEvEG2/Md4tEahSm/FbCBt
         stRytdoEDy1gQ/fszH3WZHg1kj/YAU59ZbbJht5LeTZ9oFnEuvhdENmr4HISoJc/0EeI
         WmoJiObLz5ACd8l2O3Obb/52aDn3+K6AtLuUI4JlFWty7Flo2BS1cwdmmHSWUUkwy6kc
         MJXQlsCZs5/wXwnamiAqIT/j/c0qobgyEwu7vm2/4Ehw+BqaWZB1uFRrkOrxDB45KjdY
         xN7H8/jQF/K8oKhUqvjsCXm1cA6No6pfiGbksGyXAyj2v8qU40JPZJeST+ndn6wM0mVc
         VS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=60jO/x7qhC/H6H1irwRNDgov6N06P1O3Yihxyn89xas=;
        b=PDRhLAVhOGHLoR4e12BomFyKnoJMCOEocgUNTAuGokzdxXHPLaW23EW9rBYTcY1Tw3
         d7wahbXxGA3BevkvzrTcykxRJ/xPzyBlMKONheA9l32+Tl7qRy/plGWRsIoOQbBY6aKD
         Elx9XJylnrOdWSdQXWDFouEuqB9MsWZ2z3uu+P6gBpphGNQZrl3mo3auyzTbQbCv3j7H
         9Gkb4PCNoIPpYmIfky/NKT/bsyjLglKWi6xQa4WqBjPweoLyrHe6ga/72sUFhPk26See
         fVUKKz8fnQU6LSnHfoI13wKOa32rcsI/VCNegxespO10MZTxy0IUOGTAsbdsBn0Nv/ft
         Xp/Q==
X-Gm-Message-State: AOAM532mkJ7AbmISVjfBz4Hl9PveNk2oigrU1jz+nOywpr8WMkN82kqK
        1zyIagk/f9ziyNuKl9gqiXY=
X-Google-Smtp-Source: ABdhPJwckCBkA9kGJy7nsWctqBXKAXykxG9KGxi9+1NWzh+KQ6LxdZ0egTORDBm2mAa2hYn8tXZ1Aw==
X-Received: by 2002:a17:906:7310:: with SMTP id di16mr9839471ejc.92.1638394144922;
        Wed, 01 Dec 2021 13:29:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r11sm597505edd.70.2021.12.01.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:29:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msXA0-001Q3j-0e;
        Wed, 01 Dec 2021 22:29:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v3 2/3] vimdiff: add tool documentation
Date:   Wed, 01 Dec 2021 22:27:42 +0100
References: <20211130204333.174967-1-greenfoo@u92.eu>
 <20211130204333.174967-3-greenfoo@u92.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211130204333.174967-3-greenfoo@u92.eu>
Message-ID: <211201.86ee6w9fq8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> +                                (diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname") |

Mis-indenting with spaces v.s. tabs below.

Then this:

> +	diff_cmd_help () {
> +		return 0
> +	}
> +
>  	merge_cmd () {
>  		return 1
>  	}
>  
> +	merge_cmd_help () {
> +		return 0
> +	}
> +
>  	hide_resolved_enabled () {
>  		return 0
>  	}
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index ed0d8584f7..8614253ef1 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -462,6 +462,17 @@ diff_cmd () {
>  }
>  
>  
> +diff_cmd_help() {
> +	case "$1" in
> +	*)
> +		echo "Run 'man git-difftool--vimdiff' for details"
> +		;;
> +	esac
> +
> +	return 0
> +}
> +
> +
>  merge_cmd () {
>  	layout=$(git config mergetool.$merge_tool.layout)
>  
> @@ -533,6 +544,17 @@ merge_cmd () {
>  }
>  
>  
> +merge_cmd_help() {
> +	case "$1" in
> +	*)
> +		echo "Run 'man git-mergetool--vimdiff' for details"
> +		;;
> +	esac
> +
> +	return 0
> +}
> +
> +

Isn't the case/esac in those functions entirely redundant and they could
just "echo"?
