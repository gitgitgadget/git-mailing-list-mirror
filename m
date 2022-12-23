Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06CC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 01:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiLWBca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiLWBc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 20:32:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE9E262F
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:32:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d82so2374004pfd.11
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuXefV/eayvPN6/jKPvvl78Cypmla7ccrkpR5cPXBlM=;
        b=OKTChtpUejQXibyCQpwRjx4wu1caJMgY6Ix2L3hX7P55tu1Gc5B9XWHfCU6kB+7MjT
         0ZwkM/g5ulzH0Eeg+bGr57fLepXH0io8/WA4zuYSEGwmu7mc50deZvKBOiqRPFqp4duM
         v0iz3ze0ZZVzWsZBXOpGbizEo21KWsCrxot+AySMiYtsqGQZ3VPHYeichIUWsi687IaC
         vFAxp4H5FgHCkwSHdcMEr0f56zrtF5cdmoyNQ5DS542JCHudTayWrpKfmRNQ/jT/CugD
         z/fCPHcD/pK21/ZveSHuF+FSSPlvj9Ik5+BwFICoMhwe2++K7abf9dnBHjHsZWc3Fo/q
         GNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uuXefV/eayvPN6/jKPvvl78Cypmla7ccrkpR5cPXBlM=;
        b=jvSeWBZd+/SD8lNPOemfTIfDcQNxyutdjMOoS/wLS3OQcQ7Se2VxlWmn1oh9kp/zcu
         BYUwfogAzPEZ/ldmW60vkpFHZ4QTlen29L3BeTBH9MSQBQRR84pZWS4Z6KP8HAL74Eu9
         99y7Q2cUQ3hRRqEmIRoSdpRyrReGpSPW0zDWRlEMGsg8xQkyuRSJwyRwnl3tSOzZBhMK
         dvREjHs8ZFqYaIieUcspZ8By96ZpL3ZFWgw94Q3dWgcOn14fB4m2B6l8YEwBONkfA7Ix
         KOF1E8/YAjeJPiXgiJpStM34O+Qz+xmphrSE1VIvYii/wwI6AXQjIxkxN/TdxKjlIvP9
         zU1Q==
X-Gm-Message-State: AFqh2kqkk6KIVFeUN647DIiKfYoVzh2eFW2/G16vJ1ZmXvWUJXYQKni5
        6IkCZ4gXCiD6KH/IpZVv+UE=
X-Google-Smtp-Source: AMrXdXv8IPNEYPAbmGt8FPQuxF+ZmBNvwOeqoQRROj/lFy8rL5v8/84pL8K82bNwkI9jhUo3dOLu7g==
X-Received: by 2002:a62:198c:0:b0:57f:ef24:5829 with SMTP id 134-20020a62198c000000b0057fef245829mr8929714pfz.17.1671759145421;
        Thu, 22 Dec 2022 17:32:25 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c184-20020a624ec1000000b00575d6dc996bsm1280950pfb.161.2022.12.22.17.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 17:32:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     James Lowden <james.k.lowden@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: report default colors
References: <FC7C600C-5D51-4BE0-82BD-9E28C88A1BB8@icloud.com>
Date:   Fri, 23 Dec 2022 10:32:24 +0900
In-Reply-To: <FC7C600C-5D51-4BE0-82BD-9E28C88A1BB8@icloud.com> (James Lowden's
        message of "Thu, 22 Dec 2022 12:47:44 -0500")
Message-ID: <xmqqili2rjkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Lowden <james.k.lowden@icloud.com> writes:

> I can get a list of all keys from "git help", which is something.
> But I'm left guessing at which keys control the text on the screen
> for a given command, and what color they are.
>
> In the instant case, "git push" was rejected, and the reason is
> impossible to read because it's in yellow on a light blue
> background.

Interesting.  I wonder where you are getting the yellow from.  The
hardcoded default comes from these in builtin/push.c

    static int push_use_color = -1;
    static char push_colors[][COLOR_MAXLEN] = {
            GIT_COLOR_RESET,
            GIT_COLOR_RED,	/* ERROR */
    };

    enum color_push {
            PUSH_COLOR_RESET = 0,
            PUSH_COLOR_ERROR = 1
    };

and the push_colors[PUSH_COLOR_ERROR][] is used here

	...
	if (err != 0) {
		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
		error(_("failed to push some refs to '%s'"), anon_url);
		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
	}

so I wouldn't be surprised if you see this painted in red, but yellow?

In any case, there are two things _we_ should do on our end.

One obviously is to document the default when we document
configurables (e.g. color.push.error only says "Use customized color
for push errors", but it should say by default it uses red).

The other is about this part:

> ...  My workaround
> is to guess what it probably says (probably it says I need to
> pull).  When that doesn't work, I copy and paste the text into
> emacs.

No color is well recognizable on all backgrounds, and people use
different background, so we need to make sure that our coding
guidelines tell our developers (1) not to use unusual colors for
common things, and/or (2) make both foreground and background
configurable.

(1) is because if we stick to small number of common colors, it
would make it easier for users to find and use a single background
that works well with these colors.

(2) is because there will be some users who find whatever common
default colors we use not working for them.  They may need higher
contrast between background and foreground, and allowing both be
tweakable would make it easier for them to find the color pairs that
work well.

Thanks.
