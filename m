Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAB92089D
	for <e@80x24.org>; Fri, 28 Jul 2017 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbdG1Vnx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 17:43:53 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:37352 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdG1Vnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 17:43:52 -0400
Received: by mail-lf0-f43.google.com with SMTP id m86so88899899lfi.4
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cq/Ug7sD/bZ0qXU88cvW0BPQCdB5mhxsH25AmJxTnTA=;
        b=A/c69g8mFD7lJTM+LihiDpHfKwmUiJk9jIpB4gbeu6gLkKSuN7MwD/HIHppn8w/7MX
         G8ka2dJc5t/E0NmWPwJHgtpFjfWaEHDPCeM7RR9kRFAAI1CA1B2NT9oo5XPQIweKsyWv
         9fmeSX6xSuySKzFeCkkBJKH+IFWPXxg7iwzQ7hVpPIJZVRqvltazYxgly9SsNxB0wBI8
         PjUWC9ZnpmPvVu8bjmTg7FyCik9HWDr8zS3TqTFO4olhnkU07IRN4FAZzUmN6T0vKbWO
         V1nTpaCeq0fzzEwRsCrXeJvx91I+fNMzvcoA2WO+rKeI9H6CrIZGkgdqPH3bQVQwu4z0
         IOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cq/Ug7sD/bZ0qXU88cvW0BPQCdB5mhxsH25AmJxTnTA=;
        b=PSff9raN1wy/OByjghH5jWPX1MwkqBIFTe6ld11nhzgUBFCoMz2Qk727VFi7K0ZfXM
         97kV9NYfyKlxckdn+PS/i2btmLvAjxu/vRZxa9JEN4XMneXmN45+F7OSGZPoP+1p8yME
         mvXkDz1LcQzgN+Y06TsoL7fx6AkcOQL5ZQ9QlkF63srIyt5kQooLmqKS24S2SzYaFEo8
         YYk81mXfinGmXC8Nln4G/R/3Wqu/M2wKKldEr8KVxSuzHoOOeLd07s0iQZoDzJY4KahK
         kEAkMhTAOS52pZ9Y4MR4vgc/aCeFA9zE+8vRNLsE1oDpg/ZTMzi4z77eo5nb0vZmx7qi
         q7Iw==
X-Gm-Message-State: AIVw110iT6XTuWLOinexRA99G/QLEMJ0aU5LM4n5aHgcyvdRyGsK8bal
        RrIFcaMckE0EmoeqbykYw6AMk7xgI4s4
X-Received: by 10.25.99.145 with SMTP id v17mr3058804lfi.209.1501278230501;
 Fri, 28 Jul 2017 14:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Fri, 28 Jul 2017 14:43:49 -0700 (PDT)
In-Reply-To: <CAPc5daXgXpwOKB2J7cz7fFYNd3GuRK7fqeROhwouyaCCGU1ToA@mail.gmail.com>
References: <20170728171817.21458-1-sbeller@google.com> <20170728171817.21458-3-sbeller@google.com>
 <CAPc5daXgXpwOKB2J7cz7fFYNd3GuRK7fqeROhwouyaCCGU1ToA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Jul 2017 14:43:49 -0700
Message-ID: <CAGZ79kZxVhZjFmTs5oAXh_vBNix4G=LtL8zCjrFCnqS+5pkDwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2017 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> There is another one that is better suited for this demonstration patch,
> whose sole point is about creating bunch of objects that prefix conflicts
> with each other to test the abbreviation machinery.

'Another one' meaning in another test file? I'll go look for these
tests.

The first patch produces lots of false positives, so maybe I'll need
to work on that (is there another code path for sha1?).

Thanks,
Stefan
