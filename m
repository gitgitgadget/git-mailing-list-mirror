Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDBE1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeC2Sh1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:37:27 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33281 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2Sh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:37:26 -0400
Received: by mail-wm0-f52.google.com with SMTP id o23so19639869wmf.0
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wqi61JIKEvwA9SOwbH2ESk4L/AWdx9axdujgR9j6OtI=;
        b=C7VtfPTQsMpWfTidjSPhEchDcvvZVSk4YzTIP/uWGH0MXYPRLwyuqHeWG4NdZPMLAc
         i+TjvHC5zCxD+F2elXjz9tKN9rNJ7OLatg8Gwoj/QHHyHxfM2PdKhQlLI0gPFN7Jtw5l
         q2Dt8Zr5qceyj2vvmcxg2NPGxv5ZYk5j1eZV7n799zJLEGpTe4Ar4QEa0x/aXDDxIlEE
         KcssKdDGUzVxVjajBWeR7KAaAVWGiEbOOtLyg2J3FFMzp9CxraSLTmEBNRtlReYCNdOG
         7dhd618Rqt6u/lEarv+mBX4/ULhljRT26nehufIG77UrD9i8Ceb69kuG89VsLuqfC3yS
         gIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wqi61JIKEvwA9SOwbH2ESk4L/AWdx9axdujgR9j6OtI=;
        b=g36xyuvI72/mVCgVNrfCku+9VoQ3FrqGd0Rb25m+WLw8/SaGVj4QC6MMeiQnw41h3S
         TgA/YraS4vYSc//XrKsZCzJ9/Z5hQX1p4L3/WAgo9U6rbblTgfWivudJr3IuNFp8Ps7Q
         o3cg9VbrV6ce7mhwJarR4LyVihOge7av6m9on9LoKQbVNDJjjr9+RpSFD4cJv55wwjB5
         uDc7kWCyPQtjupks6gJyhdup6rl82GAYJXTaMTySvz3vDetgDNxq/o8ap+phETlPgEsf
         +KrcZqGfawr6h6h0Q0O0PMQ1ZkNVPtTtRLnr0KYZABI755jTRuDhI5WLkfJ0GzPlf0Bn
         T1pA==
X-Gm-Message-State: AElRT7ExiinpAjhJISAW/frzvnmkwcY9CiWhw4DmZcgZ525RH7AHfPGi
        +Uu1huiRSXzw5nEZUNCy+0U=
X-Google-Smtp-Source: AIpwx49hSkikPuk8dugn0DsOjru/Clsu/uVRhrn1JUDbpluFWvyhjvn6rUsgNUiIDJr+c92j4eEQ2A==
X-Received: by 10.28.213.12 with SMTP id m12mr79514wmg.98.1522348644526;
        Thu, 29 Mar 2018 11:37:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a11sm8487450wra.50.2018.03.29.11.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 11:37:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v12 00/10] convert: add support for different encodings
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
Date:   Thu, 29 Mar 2018 11:37:23 -0700
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Thu, 15 Mar 2018 23:57:36 +0100")
Message-ID: <xmqqwoxu684c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Patches 1-6,9 are preparation and helper functions. Patch 4 is new.
> Patch 7,8,10 are the actual change.
>
> This series depends on Torsten's 8462ff43e4 (convert_to_git():
> safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
> already in master.

I didn't see any further review comments on this round, and as far
as I can tell from my reading, these patches looked more-or-less
ready.  

Except for 04/10 that had a few messages around "who should be
responsible for handling the 'NULL is for the default UTF-8'?", that
is.

So, what's the doneness of this thing?
