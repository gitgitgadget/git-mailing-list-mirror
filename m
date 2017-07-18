Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E25820356
	for <e@80x24.org>; Tue, 18 Jul 2017 19:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdGRTWi (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:22:38 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34424 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdGRTWg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:22:36 -0400
Received: by mail-pg0-f51.google.com with SMTP id 123so17801925pgj.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kSQ6oKt9kBhhJwIFS0HpShsRI19g3dKR3w6aUrF5QVE=;
        b=imMj26kYXpa/bSbZx3ezrY2oe8UMHi3f1zq6sksKt3E2xnBvbJSgElq460wuISkKaW
         p4QHrfYUBgxcSX1nZQgng/0U0bv8rXS7rRPMO7uD0D0XV2W19WkkwgdDB8OQYn283Sl/
         PGG89l45r8a373eMZGjYOMQc/mW92mucIh084GsBCkALuimHQw0FLibfxZR0dVtJiheG
         F2VElaJlmRHF1NyFUQdyMG2rbygRRBIMED7hVi/1SURzGta+k5fDzMtPxobHFT/tWXuR
         0rvd65B61LeS9li2sf5F/aT26vDxnQln7Eqi+INvnnGBZJixKm/TBRIl52TnpGQxzNQc
         Uyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kSQ6oKt9kBhhJwIFS0HpShsRI19g3dKR3w6aUrF5QVE=;
        b=oPPLNwNzNd/vi+EhoEAUYVx/tJi1RZpeSGHcJXtluH6v+eJxB0zOSUl0IzBA6rb9Ag
         nyEEixwgGtc1iNaev0oWpD5APThcj+8VSkeTt/jlXq1DYViLBnWJWsMioXrJbtiZZMFV
         8ffGVd/3/Jfdr2BaYPKA4+Fmv3CDwNcS5cBHv1eb2wMaH4Eb3IhR8EDZPKnidp7HIhza
         BdQITOUN13j49SB5Ngrly8my/SXs627wnVepCju+fvW1VzfqxBPHbY9t74kBSsjk8JFw
         s6bQ9cMbEgOGzOzg2YwcJYEjDRlky2Iz5GIzjHuIE8jJfqxhvcD8j12vDT//+g28mEKv
         CIfQ==
X-Gm-Message-State: AIVw1131Dk2dYlxck6AKFD6Jm99cAbVuD42zsY44qr5ol23r/mS68zdn
        HMrjrAn950obW/UAXLJFMFXcmLXnsr4pZsc=
X-Received: by 10.99.149.79 with SMTP id t15mr3233341pgn.247.1500405755746;
 Tue, 18 Jul 2017 12:22:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 12:22:35 -0700 (PDT)
In-Reply-To: <xmqqwp75o8qi.fsf@gitster.mtv.corp.google.com>
References: <20170718002020.14309-1-sbeller@google.com> <xmqqwp75o8qi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 12:22:35 -0700
Message-ID: <CAGZ79kbTQ=eSoDCRFTt_B3kjDbWZDkcPwc3fMvhd8dEKPWr-8A@mail.gmail.com>
Subject: Re: [PATCH] t8008: rely on rev-parse'd HEAD instead of sha1 value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 12:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Remove hard coded sha1 values, obtain the values using 'git rev-parse HEAD'
>> which should be future proof regardless of the hash function used.
>
> Don't hardcoded lengths of the hashes defeat this future-proofing
> effort, though?  It shouldn't be too hard to do the equivalent of
> the auto computation of abbreviation in this script, which would be
> true future-proofing, I guess.

It depends on the definition of future proofing.
My definition here only included the change of the hash function,
not the change of display length in git-blame for a small artificial repo
with 2 commits . These seem to be unrelated, so in case we'd change
the length of the abbreviated displayed hash, we'd still want to have
a test to tell us?
