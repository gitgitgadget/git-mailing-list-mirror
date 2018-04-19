Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54FAD1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDSBzv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 21:55:51 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44208 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 21:55:50 -0400
Received: by mail-wr0-f173.google.com with SMTP id o15-v6so9599439wro.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QKSrtE1unrElHL8v1qGHB8u06MtuiZo5MQcs7EGPdRs=;
        b=RBBL9gUIRNcDuTyOeNf6iS//wtMgKHkA/mb45Q9mhSaK3X+elqg9enPrHe1BvwMpQk
         bAXalTjHaYYsdeshG++sEzWQ4PNLk2ZmsPPBkiS6BL2IHdy8DqfQA3rT7j4WFumRB+uP
         LK4yJS7N1+V/ra7fRxs8qB7fmzelOtHKLTLF3H86QlHNrpwGBfc0zk7ME2cOFmhqvCx/
         gtIsKcY5WZYr49q6j35G0b5JLNLORrOe2OO7AFOwycxH/Uh2kAyLThJkap/HM5t5bVZS
         Ks94uoOjYi+dviijH8Upj6ex/3LxCNIxD0aspHrFMcoLedq3Ii8oYy1SzLt/WBsuDXvY
         ZFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QKSrtE1unrElHL8v1qGHB8u06MtuiZo5MQcs7EGPdRs=;
        b=r/T33haou+KuGWbF0ReHBW+jsqrbk6QbWgbZ85MpdV0Yai3GvwbKheWWaPjTVTROab
         mN8Mh1bFKSkErGDyiaAwemuRdMhuBrAkMyH7aP2HYCxV+7Sx9dKVvA9D8i1Dwss5R2Nm
         VYrJb81ktVaDz4w23FzzOBeOCsAfuYlb5pA4n3/yi/uB35i6jwdrB34VFsrmGbwL1OW9
         x8pkXKivLdIBb1FsUQcVxCoQWXYb/ypFJEw5qADNkMn7fXJEtLxz7CNe6BAwk/hmPU+T
         aMypIW7SzIXGVGtzh8Hd+4AXYES1PcrXBSFrODR/AjyG1em6P4qAltBShMQvcx9NoV8y
         rrNg==
X-Gm-Message-State: ALQs6tBbtqxdOS111SJEm4jenN+RtmDlXVgXu4d3rrTQtT4R594Cp8dL
        XrEp7YAGp9EeifeaaMhrUdk=
X-Google-Smtp-Source: AIpwx48lY5dsvUfSnZFGCqmF9WxvvfQkOT9jD13NYMtr0Dqr8cma2nEI+6vilDQdLVi5nNy4DIbPGg==
X-Received: by 10.28.66.206 with SMTP id k75mr3226201wmi.34.1524102949317;
        Wed, 18 Apr 2018 18:55:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e50-v6sm1979703wre.4.2018.04.18.18.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 18:55:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Apr 2018 10:55:48 +0900
In-Reply-To: <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Apr 2018 10:52:47 +0900")
Message-ID: <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It turns out that prune silently goes away given a bad expiry
>
>     $ git prune --expire=nyah ; echo $?
>     129
>
> Regardless of your originai "git gc" issue, we should make "prune"
> say something on this error.  And when we do so, I would think that
> error message will come before the final "error: failed to run
> prune".
>
> Or perhaps we do so and then squelch "error: failed to run prune",
> trusting that a corrected "git prune" will always say something when
> it fails.

It turns out that

    $ git worktree prune --expire=nyah

shares the same issue.  I'll take a look at OPT_EXPIRY_DATE() thing.

