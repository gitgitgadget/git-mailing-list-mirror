Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B69C6FA82
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiIYIm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIYImV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 04:42:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFA38454
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:42:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso5183939wmk.2
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=iSVdXpcEqCspISQc2Zxei1soUp8C15zgJINVrblMzxE=;
        b=KcDqYjKp18jphY2QJJS7THLAiJfdPqJt3+PhCvovMmr+StPCyZSQVTsT8JFwrJOFZV
         fgDPL4ybYJjOfdotBISCkdqa65o537EzDQIKdrzVi2dfCyBnqoMVQxNEqZzVXAiBtRo5
         QFzgZqkCLuNlfkloyxa/IRBisttm2h8b5JaJbMhtb5gUKJ3lulaZ2cT6DQXQK9shCwBB
         6Iu4KcafknOqJLiHwYo+NEyCQHptUsKkRYf+ayk/d/6A+Zo5IQRdWX4rkRN8IYMJO2qR
         0PfBwBmk+J+2OJxn+qQ71mUQlfIdmUcDwk6+c54IDIVsmLmcd9XWzpSWS5ly4X7N09+D
         WIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=iSVdXpcEqCspISQc2Zxei1soUp8C15zgJINVrblMzxE=;
        b=TZ55PvCv0sKiTkYDSK8KGrsCir0HmAB0D23/hQ6q1J7FwefAOJLxSpzlZNTLI3QaDJ
         5+UA/aLdOkVj56F5zVnwv008jf+j87nBOin4EateeY/WyyyPdKCkFGRiwtoJlLJ1vx5Y
         lL3iLM79b0igkk+fvt+NIgcjRAZqeDu/0d4QCgZu+hWoVsJ2+t+WQl1UYBrIjJ7BwFqo
         91wWmnPXpuY0OHTOMXuBbG7cUY1kmklMhA0w7/l9CCZTHVUvhleeouRBRiUGXn3L6UOW
         kcU505dG7pd+USlgemwnUSs+s4zQk1ppoUCXlB5ZGhA69l1QFVa5FxBlWUWbc2gJcCtq
         iDDA==
X-Gm-Message-State: ACrzQf2tbGjbtjtpu6ZpFuemaIMMSKDPJqtcooT+wFU+OPqbg/+9Bbz7
        zwUsz3DfeAw1pshPZkJ+QWY=
X-Google-Smtp-Source: AMsMyM6qnMw1KlzegbBuRXWa5UeJgMLh1F4uKkoNOM1yfWysgKCuAotbc8c8YobRfcobNOfHtkvuxw==
X-Received: by 2002:a1c:f008:0:b0:3b4:fd2e:3ede with SMTP id a8-20020a1cf008000000b003b4fd2e3edemr13453870wmb.133.1664095326544;
        Sun, 25 Sep 2022 01:42:06 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a056000038900b002252884cc91sm11406918wrf.43.2022.09.25.01.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 01:42:06 -0700 (PDT)
Message-ID: <edad7b00-cf77-4538-9a1d-4e0e7e5d4261@gmail.com>
Date:   Sun, 25 Sep 2022 09:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/10] evolve: add documentation for `git change`
Content-Language: en-GB-large
To:     Chris Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <811d516e5d272acc40835aa6bdd4f79a001f72c0.1663959325.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <811d516e5d272acc40835aa6bdd4f79a001f72c0.1663959325.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Chris Poucet via GitGitGadget wrote:
> From: Chris Poucet <poucet@google.com>
> 
> Signed-off-by: Chris Poucet <poucet@google.com>
> ---
>   Documentation/git-change.txt | 55 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 Documentation/git-change.txt
> 
> diff --git a/Documentation/git-change.txt b/Documentation/git-change.txt
> new file mode 100644
> index 00000000000..ea9a8e619b9
> --- /dev/null
> +++ b/Documentation/git-change.txt
> @@ -0,0 +1,55 @@
> +git-change(1)
> +=============
> +
> +NAME
> +----
> +git-change - Create, list, update or delete changes
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git change' list [<pattern>...]
> +'git change' update [-g <change-name> | -n] [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]
> +'git change' delete <change-name>...
> +
> +DESCRIPTION
> +-----------
> +
> +`git change list`: lists all existing <change-name>s.
> +
> +`git change delete`: deletes the given <change-name>s.
> +
> +`git change update`: creates or updates a <change-name>.
> +
> +If no arguments are given to `update` then a change is added to the
> +`refs/metas/` directory, unless a change already exists for the given commit.
> +
> +A <change-name> starts with `metas/` and represents the current change that is
> +being worked on.

It would be really useful for users if this documentation included an 
introduction to the concepts behind the command and examples of how they 
should use it to track changes to a patch series.

Best Wishes

Phillip

> +OPTIONS
> +-------
> +-c::
> +--content::
> +	Identifies the content commit for the change
> +
> +-o::
> +--origin::
> +	Marks the given commit as being the origin of this commit.
> +
> +-r::
> +--replace::
> +	Marks the given commit as being obsoleted by the new commit.
> +
> +-g::
> +	<change-name> to update
> +
> +-n::
> +	Indicates that the change is new and an existing change should not be updated.
> +
> +--force::
> +	Overwite an existing change of the same name.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
