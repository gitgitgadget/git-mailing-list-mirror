Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625C21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeIAACM (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:02:12 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52421 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeIAACM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:02:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id y139-v6so6191375wmc.2
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=666PTXuxPrE6kUsF/lpa+n9LPfOez7LpcIeeUJcCKSM=;
        b=SIPLyNm/zYlTYMXaVCa501fgUbKO4pTt4oqEbDBaZIfgcArzQymygBfIUd3b1g4sfM
         w+6NPIY4TCB4rH4ZB77YBI5lzFwQrYpnNfBsXZ8IT8H50UuyShte5tqYoHMq5u0tKORJ
         zaAY/vAqNjquVaktWUD0xAmxCyblypWApHLLilXkIxeHkMm1w/ZFB2S3PH2kUH4Nlm+m
         TzDduhT7+BWZQWOCoTXRdjkeEURhFhJCKFL+QmPWMDlJWrisr2JFGwWxxEpi4o2R9tJX
         R7b6sdPH/fiyKb6RHl4lFJ02V5nAR4gC4diE67tk9S8ntgXDwy53CFdl4cYEyWPHQ1jH
         aijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=666PTXuxPrE6kUsF/lpa+n9LPfOez7LpcIeeUJcCKSM=;
        b=XsfMP/T9iFiUo6veLp0xNwROdFVN94l5Mz6OSrbb3QzcLrkzaX80AjwXASknkP4/NO
         4HKRgYqmogCNFogom2T1j6YT36XopJ9aUM7CRG9572e/nUuAs0jAgZCG6b7cj269qj/M
         Sw4fOw1bnS2N4xeuoynm+t+tCFQta/GBSmyF95heopBOWR1yqHWLzd/AVbeeFpcxIJ4s
         9uJfIF2UkisGYTi4rFC7OsZrTn1vZ46e7+0CkKIpDyOrJKWSXuTHyL5/+yo3BNyZEmMH
         jNYWp2gpzJ2phe81KIbpnv3nht8pCYSaU2HqxPD+YCyAjuixK4rbnv2MmsJI99YItgQ0
         bJHA==
X-Gm-Message-State: APzg51DlwvzSAgzNYN8YBP6QMWn4ktVwxQeX7sufO0y9FSydPWPlp8o9
        fQKicb8fnySVrEcG+wMg49Q=
X-Google-Smtp-Source: ANB0VdbVjlN7psizpm3iE1dTjBf/OJ83dsehiNyoprlRmVYlu8N0CJPKuTOe1VH8WPJ0xxLTuBv3VQ==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr5654731wme.139.1535745190330;
        Fri, 31 Aug 2018 12:53:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p11-v6sm16338466wrd.74.2018.08.31.12.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 12:53:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com>
        <xmqqzhx36er2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BE43kFwRZ90-EWB9Em6xk-T=QfNXCepY=0O5OYYZe-qAg@mail.gmail.com>
Date:   Fri, 31 Aug 2018 12:53:09 -0700
In-Reply-To: <CABPp-BE43kFwRZ90-EWB9Em6xk-T=QfNXCepY=0O5OYYZe-qAg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 30 Aug 2018 09:11:35 -0700")
Message-ID: <xmqqr2ie1ffe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Suggestions for a better rewrite is very much appreciated.
>
> That makes sense.  I'm not sure I can concisely convey all the right
> points, but here's a stab at rewording:
>
> Recent addition of "directory rename" heuristics to the
> merge-recursive backend makes the command susceptible to false
> positives and false negatives.  In the context of "git am -3", which
> does not know about surrounding unmodified paths and thus cannot
> inform the merge machinery about the full trees involved, this risk is
> particularly severe.  As such, the heuristic is disabled for "git am
> -3" to keep the machinery "more stupid but predictable".

Excellent.  Let me use that when merging it to 'next'.
