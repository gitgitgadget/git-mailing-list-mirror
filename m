Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7AE9208E9
	for <e@80x24.org>; Tue, 31 Jul 2018 15:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGaQ5m (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:57:42 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52987 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbeGaQ5l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:57:41 -0400
Received: by mail-wm0-f53.google.com with SMTP id o11-v6so3494161wmh.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JULIwk0z+mdtYeRE5/hH+5sJ1zSFZpeYcto8kliZNVE=;
        b=DR1YjudCOxHS8GMwnL7p/I0wgPftqBhN2lM8Wx2Fd3AOE/8dKpGvk2HrIm3S8vIKzH
         1BYgFcwOe9N0vSMAlOrzRSLbzkeF40BGt32KO0Vr//TplVe7jvMX199IuVzAr6onLAPE
         tednnIlInaoGCh4VuSOeZANAuodtLo5kSw/7E+CGqmAfnLXFhTdBDfbf9sdEdzGv3/DE
         Z5CK3emNG8bOUUTVELBffq7utIX7jEXxlcxxLyQfV27h3pZI8TY52mGVmKnrrNzG7HXJ
         zDqK9nlbWLB7KYToZjQuVJOZcdS9fnVrMfwC7zIeYZa/yonNC6QRsowmiew2LkcOMs8t
         wqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JULIwk0z+mdtYeRE5/hH+5sJ1zSFZpeYcto8kliZNVE=;
        b=eRycDR8N/4SWMnGdiDZ5PTkZR6cHV4YuT63le6qG6pmpryULUsmplPdqZyXMfiKrtD
         GFRNw1seGiCmsj3Pebq2pBKf3CCl1R+e4UiJUX1tNlnnxv0tuS5763dEOoRz7E+leHMZ
         sC82/Y/E939yiM2W6SHeRnpV5nQwlBt1efbIz0JUigBvEBYvYOrNgjddhCZgB6KehiWo
         K5psGGPBmmXlpBCk/IA25RXT+s7MI38EeFrQHKhVEdjLXk6QuLhd8R7P0vTgEN6IhYDL
         k0Fe37aWdx5N9x9FGuSvAbDA/+c0jgKmyaLyL+q6fLsxG67gjc/POZav19b7J+JbBVo0
         3S5g==
X-Gm-Message-State: AOUpUlGuPoyv3X3Av7xDrjf3KhuC6Sdi2rLmCBvmJBpS9ov4LG+Nbz/S
        ZC50QKqIsSXUaSvHmDWm5uY=
X-Google-Smtp-Source: AAOMgpd9ohhzotUhnIBBiU0qiYoAdb+JWgSq/fLIIs34dRGtIgblKW+ebACsv0TCtoIOzEoqkl3D2w==
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr89842wmi.116.1533050212826;
        Tue, 31 Jul 2018 08:16:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h83-v6sm2893773wmf.46.2018.07.31.08.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:16:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     johannes.schindelin@gmx.de, bmwill@google.com, git@vger.kernel.org,
        peff@google.com
Subject: Re: [PATCH 0/3] config: fix case sensitive subsection names on writing
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet>
        <20180730230443.74416-1-sbeller@google.com>
Date:   Tue, 31 Jul 2018 08:16:51 -0700
In-Reply-To: <20180730230443.74416-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Jul 2018 16:04:40 -0700")
Message-ID: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It turns out it doesn't quite do that;
> The parsing code takes the old notation into account and translates any
>   [V.A]
>     r = ...
> into a lower cased "v.a." for ease of comparison. That happens in
> get_base_var, which would call further into get_extended_base_var
> if the new notation is used.
>
> The code in store_aux_event however is written without the consideration
> of the old code and has no way of knowing the capitalization of the
> section or subsection (which were forced to lowercase in the old
> dot notation). 
>
> So either we have to do some major surgery, or the old notation gets
> some regression while fixing the new notation.

As long as

 - the regression is documented clearly (i.e. what unexpected thing
   happens, just like you have a good description in the log message
   of PATCH 2/3 for "[foo "Bar"] key = ..."),

 - users are nudged to use the new style instead, and

 - writing with "git config" (or "git init/clone" for that matter)
   won't produce these old-style sections

I think it is OK to punt.  I would expect, as Git's userbase is a
lot wider than 10 years ago, there is at least some people who did
exploit the fact that "[V.A] r = one" and "[v.a] r = two" give a
single "v.a.r" variable that is multi-valued, and it indeed would be
a regression to them, to which no good workaround exists.  

But breaking '[V "a"] r = ...' is a more grave sin.  Even though I
hate to rob Peter to pay Paul (or vice versa), in this case it is
justified to fix the more basic form sooner and wait for an actual
complaint before fixing the new and deliberate regression introduced
while fixing it to the old-style variable.


