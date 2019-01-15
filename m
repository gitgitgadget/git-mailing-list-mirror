Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1444C1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfAOTBm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:01:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfAOTBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:01:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so4437852wmb.3
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vWfVNZ/U2p+PSSCwcidXnXRQrEWXA7O4gjg3p1XPi9I=;
        b=YHUsznhiIlGIXsrEngWca7oeTn2yqjO8LJ3/o0yxqEl06U2Y+YYMekEa8VHEZxWCdM
         uAUfFssg4llELQqspeTtQWffmaGWSiaqY93/5DEq7hyDgEWfsmsbQBEN7wCpPVaMzzAC
         sYKZaCVvBcKn9H/bvcf1IInklsYv7L8EbuA09XRxMMov8IujjFEkL+5cOkl1+oVDN8J8
         3A1B11ZY9iB3wAQRXFMSxUctZiddctBsvBZOTl1aX1sc0BfBNhvRNTUMuy0cs4JlJmiQ
         +LuXqKo86N1Mfa9Jbp5//U5TqtyMnbJ37pZoS8iEeAITWtLy97bR65H2gADefmpIk4vT
         /XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vWfVNZ/U2p+PSSCwcidXnXRQrEWXA7O4gjg3p1XPi9I=;
        b=E9GtGEV9hK5Wp96wmL4AoUlJz/CHtJeIvxJTr2ePLhhJorZ3DGVrNYLEKV0M9UhLlJ
         D5Gi6xL1WN1+5J74UU6PI6mM3IoKCQ+uoqw00jG/Ch80nGvse9meC6YvdjArncgov2bT
         3hhgL0n31D2xD2f/JHNtGm+4spy6AYkBmZe2tfMRaUzPTFpNA+Tcxy7KuXPE30y2oEi+
         M9/YBxSvjfnFOdtlTEUMNStLASziCeVgIUzMBVOFElAGGtmqBZGJLwIk1iwh4gwX8oy6
         1LByHsqofa2n0ZW7YjSVdck7q2sJSU++onwRrZOU5Pz1w4hxGHECUfDKm8+PsOeDvtnt
         Zwxg==
X-Gm-Message-State: AJcUukeWyaoHO2leHLu84irCEEfAF5vD6wqjWS35Ea0UJzgCBJ2FCshC
        QrXMFN1sqISSBofLkCIZBNk=
X-Google-Smtp-Source: ALg8bN7CbjXOOSKMf6K2bWMIdrOftPuXiQgePpGxPpu1b8svYiFToecKo5x2zS52B9T4F23nvId3TA==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr4536757wmb.125.1547578900436;
        Tue, 15 Jan 2019 11:01:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h10sm28613965wmf.44.2019.01.15.11.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:01:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] add --edit: truncate the patch file
References: <pull.107.git.gitgitgadget@gmail.com>
        <52f74c5d356325660ca1b494e78fb99a3c6c3861.1547566970.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jan 2019 11:01:39 -0800
In-Reply-To: <52f74c5d356325660ca1b494e78fb99a3c6c3861.1547566970.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 15 Jan 2019
        07:42:52 -0800 (PST)")
Message-ID: <xmqqa7k1sq24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Of course, this file should not be left lying around. But at least in
> one case, there was a stale copy, larger than the current diff. So the
> result was a corrupt diff.

After creating the fd (now with O_TRUNC), we die in a few places.

 - Failure to open the file for writing.  This is OK and do not need
   any further clean-up.

 - Failure to write a patch into that file.  In this case, it might
   be worth unlinking the file.

 - Error exit from the editor.  In this case, the user may want to
   take a look and use the contents in it manually, so not removing
   the file, which is what we do right now, may be the right thing.

   On the other hand, such a patch file is easy to recreate with
   "git diff", so it may be worth unlinking the file.

 - Failure from stat() after editing the file.  In this case, it
   might be worth unlinking the file.

So I agree that "this file should not be left lying around" in most
of the cases (except a half).

In any case, when we are about to use the file for a newly created
patch at the beginning of this function, we know that the old
content is no longer relevant, so the change to truncate before
using it is absolutely the right thing to do, and makes it moot to
ask "should we remove it after an error, or should we leave it to
avoid information loss?".

Good ;-)

