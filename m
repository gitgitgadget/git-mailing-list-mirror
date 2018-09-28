Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A050A1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 20:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeI2DTs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 23:19:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33505 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2DTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 23:19:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id 84-v6so4747245qkf.0
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5Db0fB6cWuqlMfQSAvh1t19Noba0PtloQLj19JcljA=;
        b=co5L3io2lOkHwhxzfQ0Y1i1uzIj4Rc6KC9oqLKkTHcAiL17CaFs3+DvLONb1yx4gc7
         T2hGmRnCcIzVm/cR5xe0d/EnObc/BfOW6TmapLGphVLs6GnDv2ZOt4nLnLeqYBJ+6D41
         Zc4LjywujXrETeSZtT6Ry8b0+kPwA02DcqYdY7FB0ZX+RL1+80CFVvBl7kPCPvEnSpAA
         uhqbNbkSngIH7q582Gj8CwePMfqr+PxCR7QnpOTTU5c697wq4tZrGx00qatQvFa0EP0H
         ccxChY8gQ3ZB5+2vXddIyDbb4345Pyfwr6b8eMRaVviZbAEWU1DggqSyAxq+fuX/br2V
         jysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5Db0fB6cWuqlMfQSAvh1t19Noba0PtloQLj19JcljA=;
        b=L07g30uWZT8ogDzssOaEABw3KIYB/MLTWIliRSgwocDt6Ft99MDGvc4Tui6GkXmUW1
         mLIV0smd24uTG8X//YN0FcyNVGZLgivXfkA+Chwz9QZ4th47B6QMdfn0jlVwJlgIakiZ
         xJboKMvc/vYUBWI4Q5ONxG8SXssgiwiVLpd+DBksZVmH4VFdP55XtCSdVIMckZECf8Xu
         jLmouhQVtbO6Sa/nitbTbfEfIq9eScVPxccUSDe66hy7IaZskDjoTqx1xcTbp4UMi8p2
         bnlvmO6Afq2BtJTIY9lGsTvEBbg5U5hAUSb6mzzULQWBbJW+6UMLUfh5RJWcLVEvTD5F
         y/tw==
X-Gm-Message-State: ABuFfoin7/fULFcdq/OqX3hqD03V+G7HCxV9QH+XzFTIpgwX/gU7fvzQ
        raO7VeGTlocMIRovcOKrLOJED3RD0kOL25GK7lE=
X-Google-Smtp-Source: ACcGV63bqr9yTHxkkYUlwYGjKzzIWDxkrrzfuS/XflkTL0nrCYN/mFLcxdbqWk2O1XuQig9hfJL2i3YMDNCjLuVS4Fk=
X-Received: by 2002:a37:76c6:: with SMTP id r189-v6mr261730qkc.282.1538168057337;
 Fri, 28 Sep 2018 13:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180928163716.29947-1-khubert@gmail.com> <xmqqva6pbeud.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva6pbeud.fsf@gitster-ct.c.googlers.com>
From:   Kyle Hubert <khubert@gmail.com>
Date:   Fri, 28 Sep 2018 16:54:06 -0400
Message-ID: <CAJoZ4U3cLTJaX8ZJdmNN_xBLOVKXoy53F4n=Y76wYEoBsNWNcw@mail.gmail.com>
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the review, commenting inline.

On Fri, Sep 28, 2018 at 3:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> Kyle Hubert <khubert@gmail.com> writes:
>
> > Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
>
> Nobody will send in a patch to worsen things, so phrases like
> "Improvement to" that convey no useful information has no place on
> the title.
>
> There probably are multiple ways that credential helpers are not
> called just once and many of them probably are legit (e.g. "get" is
> not the only request one helper can receive).  It is unclear why
> "only call helper once" is an improvement unless the reader reads
> more, which means the title could be a lot more improved.
>
>         Side note: this matters because in "git shortlog --no-merges"
>         the title is the only thing you can tell your readers what
>         your contribution was about.

Yes, thank you. I just joined the mailing list. I'm getting a sense
for the style here. If this patch moves forward, I will rewrite the
title.

> > When calling the Git Credential Helper that is set in the git config,
> > the get command can return a credential. Git immediately turns around
> > and calls the store command, even though that credential was just
> > retrieved by the Helper.
>
> Good summary of the current behaviour.  A paragraph break here would
> make the result easier to read.

Check.

> > This creates two side effects. First of all,
> > if the Helper requires a passphrase, the user has to type it in
> > twice.
>
> Hmph, because...?  If I am reading the flow correctly, an
> application would
>
>  - call credential_fill(), which returns when both username and
>    password are obtained by a "get" request to one of the helpers.
>
>  - use the credential to authenticate with a service and find that
>    it was accepted.
>
>  - call credential_approve(), which does "store" to all the helpers.
>
> Where does the "twice" come from?
>
> Ah, that is not between the application and the service, but between
> the helper and the user you are required to "unlock" the helper?
>
> OK, that wish makes sense.
>
> It does not make much sense to ask helper A for credential and then
> tell it to write it back the same thing.
>
> HOWEVER.  Let me play a devil's advocate.
>
> The "store" does not have to necessarily mean "write it back", no?
>
> Imagine a helper that is connected to an OTP password device that
> gives a different passcode every time button A is pressed, and there
> are two other buttons B to tell the device that the password was
> accepted and C to tell the device that the password was rejected
> (i.e. we are out of sync).  "get" would press button A and read the
> output, "store" would press button B and "erase" would press button
> C, I would imagine.  With the current credential.c framework, you
> can construct such a helper.  The proposed patch that stops calling
> "store" unconditionally makes it impossible to build.

This example helper would require knowing external state between
button pushes. What about aborting the operation? Regardless of the
example, I can understand your concern. If a helper depended on
receiving confirmation and rejection, this change would break that
behavior.

The patch is intended to address the common problem of a multi-user
system running on a server in headless mode, in other words, without
libsecret available via DBus. As such, this patch could eliminate
having to double type passwords for every git operation accessing the
stored credential.

> > Secondly, if the user has a number of helpers, this retrieves
> > the credential from one service and writes it to all services.
>
> It is unclear why you think it is a bad thing.  You need to
> elaborate.
>
> On the other hand, I can think of a case to illustrate why it is a
> bad idea to unconditionally stop calling "store" to other helpers.
> If one helper is a read-only "encrypted on disk" one, you may want
> to require passphrase to "decrypt" to implement the "get" request to
> the helper.  You would then overlay a "stay only in-core for a short
> time" helper and give higher priority to it.
>
> By doing so, on the first "get" request will ask the in-core one,
> which says "I dunno", then the encrypted-on-disk one interacts with
> the end-user and gives the credential.  The current code "store"s to
> the in-core one as well as the encrypted-on-disk one, and second and
> subseqhent "get" request can be served from that in-core helper.
>
>         Side note: and the "store" to encrypted-on-disk one may not
>         even need passphrase, even if "get" from it may need one.
>
> "We got the credential from some helper, so we won't call store"
> makes it impossible to build such an arrangement.
>
> The above is a devil's advocate response in that I do not mean to
> say that your proposed workaround does not solve *your* immediate
> need, but to point out that you are closing many doors for needs
> other people would have, or needs they already satisfy by taking
> advantage of the current behaviour the proposed patch is breaking.

This seems very valid, I like the configuration your propose. The
argument for not storing to all helpers is to prevent leaking
credentials across many key stores. In some cases, a developer can
short cut looking up the plain text credential, and instead copy the
encrypted credential to a new server. This behavior can lead to
copying to a local development machine which is not headless, and does
have an OS keychain available. If allowed to write the secret
credential to all available helpers, this will leak the credential to
the developers local machine.

> So, I dunno.  I certainly do not think it is a bad idea to stop
> feeding _other_ helpers.  I also do not think it is a good idea to
> unconditionally stop calling "store" to the same helper, but I can
> see the benefit for having an option to skip "store" to the same
> helper.  I am not sure if there should be an option to stop feeding
> other helpers.

I understand your thinking. Is there code you can point me to that
would allow referencing an option to specific helpers? Maybe it could
be reasoned that configuration could dictate not leaking credentials,
and retrieval doesn't need confirmation.

Thank you for your review,
-Kyle
