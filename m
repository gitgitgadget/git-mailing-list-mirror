Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB4C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjAaT0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAaT0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 14:26:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259625287
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:26:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k13so16195473plg.0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUJ2zPZUPeLqusvTcRUQ3ZbNH8+7XWPYISgiLr/dFRM=;
        b=doKvotRMoNDDiH3xzZ5udGcN+k7ZiPjjg6maojLVN5XUjNBIqDL3znRzbc7lD6vAPo
         QgjIhgdhfgJ/kJ+2rIQArQly1lzeoKT8xJGJzR0aW3TvUTgA46b9wtvTjzGPddVuiHAG
         nDE60NXQOtOo10stvHTcnG15d50HouOAzs6N6twKbfnjDPedJWm3H0lRXH3Qm9l068ur
         WvDK3Sgkpi/tdBmTFhoxls/lqx0J4ebHRMXZepq//dApIYeWz2LVzE2V87202OjCf3IS
         aaMpUOPWZ7rKhwD4Knf6JApwn4VEN9AGhKcVAVPexI1K4P08r1pdXIP9bGoRrKKjxum5
         jSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUJ2zPZUPeLqusvTcRUQ3ZbNH8+7XWPYISgiLr/dFRM=;
        b=yMfcXVFXsjOVqIGzSxiM/I2JyIMleyrDnc2tjO8sg1nmAByerb55S44pCE8I+V1Lsn
         Sfc30K5WQUpJkolRcuUG0FLpLMp7pPgcJYKhHxvBaayi7DofRLsNDORRGoJZtu8+yWpU
         TWtD0CQcSu/FvkX0hXjQJWJ28KuETYQVcP5rrHzw/g7w4A3axdjp97Q/BmJcXOzcHaru
         rpB4B9xhg8q5sto4cU3KbGVod3SLHOTb9kWjhGwb7Oc1HHufWG58NzMyk66pAqTwLavN
         QzQo4fyDMCjotS2ynWAg+xp8f9V8KjLuF/BUKwabPyIRctiACHVat5/fZk6pI/TUi9J7
         PfXQ==
X-Gm-Message-State: AO0yUKXH0BBFYM4qyGYdtwyHaroB0COAyTWHNlr2yjc6w4NKjwK8MlEB
        TH+BLHC6cQm7DvxZIaPFj+4=
X-Google-Smtp-Source: AK7set+kOtD/dPsM0FuLQdPC7pQLP93IT0+dDD40r9NuELkf+/50nOJtf8Uo9K9LpVKuJ/gTfgD1nQ==
X-Received: by 2002:a17:902:e1d5:b0:193:2d53:3fcf with SMTP id t21-20020a170902e1d500b001932d533fcfmr102595pla.14.1675193171320;
        Tue, 31 Jan 2023 11:26:11 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001947222676csm10168921plb.249.2023.01.31.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:26:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: gitformat-index.txt has a gap in the "mode" description?
References: <kl6l357qy7r2.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 31 Jan 2023 11:26:10 -0800
In-Reply-To: <kl6l357qy7r2.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 01 Feb 2023 00:43:45 +0800")
Message-ID: <xmqqmt5yy08d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> According to gitformat-index.txt [1], "mode" is 32 bits, but we've only
> documented 16 bits. I tried poking around read-cache.c, and my
> impression is that other 16 are just NUL. If so, it would be worth
> documenting that they're unused, especially since we documented
> unused bits right in that section.
>
> [1] https://github.com/git/git/blob/master/Documentation/gitformat-index.txt#L84

Good thinking.  The existing explanation starts with "32-bit mode,
split into (high to low bits)", followed by "4-bit object type", as
if the "4-bit object type" occupies bits 29-32, which is not quite
what we want to say.

By the way, we should avoid saying "unused" but be more explicit and
say "must be zero".  The latter has no ambiguity but the former can
be misinterpreted to allow any garbage.

Thanks.
