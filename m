Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27036208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 07:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdHKHC1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 03:02:27 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35777 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdHKHC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 03:02:26 -0400
Received: by mail-qk0-f169.google.com with SMTP id d145so16166154qkc.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yX0kw4kbFmbt67OqzueUYwEffw55BSUHoCvDEkJ0EfE=;
        b=UdfhrRPMiQs2t0o5sYduyvDqD1YDvehNW0mP4kFEfKAEhQOSNPLilPBFrgo3esfY76
         xgohwyYGNbj08Ga7X+MHS0YZ8GQ7KCsf2T/WeHogwV+EveM8mnqquyqsfBTcHn+MUlqv
         rm6WkbZkH3nOtsPboTXGtUpGEwPvIehASe05NtFtQpdMveTuNiJYemKBbr+0Zr5UpXsr
         eFOJEM3kyc7ltngWomNqKs9VzQxR8mwlycmnX8lxpgZe2jghftMiCkV0XRf29TnrWZvE
         s0PbYC/HALGVNlwXODEdftBZkoy+vpg3X//aCh+0dQpTI2RuGZg7nb9PbhCMEZgA6M3C
         IhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yX0kw4kbFmbt67OqzueUYwEffw55BSUHoCvDEkJ0EfE=;
        b=eQ6C7GVkU0LizZk2LWxGf5sz2hy3nCiluhuGNL1UiB0gGnkgkyhD3i3L1OJwLDI5Tt
         Mq4mT4Y4JpSLet669NA2yJSX4nsS70w69Ncap1PFDeSJoHaPl93PRBBw3MF/U34qfRpF
         Hkj56IjU+2eGqB6+yG3GAEx0C/nCY3kY8jxhHbW9OPtxEbOGJZVl3+SxBqs31eTQs++x
         PEpPwDzOsrfWQMIozAAKGqWtMjAS4BsYjtd1Prv12y5LWNiUMQTJFI6jYIBsF0pFzJ2p
         x41Ovlp9HuMsLSdrAhRJxTBHa1vJ12XfEZ+dlSP4I/FvyZfqQLa4QxCEWu1s2lifoM4L
         I0dw==
X-Gm-Message-State: AHYfb5jRtxsFvV2laAn6o8xJcHJ2Ews5T858Y0Im88wDbIBtBJo7aCH6
        6pdLnW9MFCT0Xty70JzGJ8BwGmlXEQ==
X-Received: by 10.55.163.69 with SMTP id m66mr19252952qke.139.1502434945313;
 Fri, 11 Aug 2017 00:02:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Fri, 11 Aug 2017 00:02:24 -0700 (PDT)
In-Reply-To: <20170810231038.4s2btsotoq76atuu@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net> <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net> <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
 <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net> <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
 <20170810231038.4s2btsotoq76atuu@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 11 Aug 2017 09:02:24 +0200
Message-ID: <CAP8UFD3RWByUBZf=E_EBCW2Zk7voogfB+Qpsx4U2YNq0T0Hqag@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 1:10 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 11, 2017 at 12:02:49AM +0100, Ramsay Jones wrote:
>
>> > But some of those things are not 1:1 mappings with normalization.  For
>> > instance, --json presumably implies --only-trailers. Or are we proposing
>> > to break the whole commit message down into components and output it all
>> > as json?

Well who knows what people might want/need?
Anyway in `git log` --oneline is not a direct mapping with
--pretty=oneline as it also means --abbrev-commit, and this is not a
big problem.

>> Hmm, to me the operation wasn't so much a normalization, rather
>> it was an --unfold (or maybe --un-fold ;-D). I suppose going in
>> the other direction could be --fold=72, or some such.

Yeah, we could call that --no-fold or --no-wrap if we expect to need
--fold=72 or --wrap=72.
At least it is more descriptive than --normalize and if we later
introduce --pretty or --format we can say that it is a shorthand for
--pretty=nofold or --pretty=unfolded.

> But I really don't want callers to think of it as "unfold". I want it to
> be "turn this into something I can parse simply". Hence if we were to
> find another case where the output is irregular, I'd feel comfortable
> calling that a bug and fixing it (one that I suspect but haven't tested
> is that alternate separators probably should all be converted to
> colons).

Though "fixing" this after a release has been made might introduce a
regression for people who would already use the option on trailers
with different separators. That's also why I don't like --normalize.
We just don't know if we will need to "fix" it a lot to make sure
scripts using it will work in all cases.

If we use --no-fold or --oneline instead, we don't promise too much
from this option, so users cannot say that they expect it to work for
them in all cases.
