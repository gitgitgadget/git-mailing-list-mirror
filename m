Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791241F855
	for <e@80x24.org>; Sat, 30 Jul 2016 02:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcG3CMA (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 22:12:00 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38337 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcG3CL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 22:11:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id o80so173300521wme.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 19:11:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Onv671wJbdeTsXpJB2tSb71ShWuz0H4TXflfucNb/3o=;
        b=pfPlyVtS9I3isUVdHoYPsXvwM9qB3KYY8aiA0jArfK+O0vUVZfs9Z2u8mERDk9RBVW
         m9If2RsWm9V4IRVJCa4YGeiZhSC/QbSurg20pr/sJ2PpTEVS4iroD1186asvLXJtdWf/
         OeU75MVOYnuIbAv5LqXyL99LrRVuDK0VobA57YMjaIXn0sl0P//dp4f/NdfJFx2U0WfH
         kgVTHAalO+1JuN55OXf6s3In8VeAaF9NPPF7rwgoQSnwRjeCqN/blG1egbTmJOeGajXJ
         G2TpGnbJgGyBZli2+tFcuYdgN5/JQgJUaBHf0/6820t+Gl/5CcLmYMRauKl3LIoD+UB/
         41ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Onv671wJbdeTsXpJB2tSb71ShWuz0H4TXflfucNb/3o=;
        b=Y0jbWlyv0eVVD1pUwH2I54LnOlkyulaY5fSl7iR+PBcdOakTy5diAMd5U/bXzCsdcV
         Lfjev5mhhFUe9FEmCHCjhQ955R0saEps6qy934/Glb4vKAA2ohuzsJ8O1LByHIixjv5U
         4D9ejpLolZbrn+AseN3eubqPfFH4x8e8YXlAvSf5EX0ldHbnMQJlTMjtuTfbAuEe+UZv
         UBip2jtHJEMlE3Q4oJct0Ue/wR3SxSoGi/M5ytx0Hkzzn1O2MhiMa2Ghd27Kh1prXmMT
         /thjjWREMS/CSCzHArHhJxePHU7U07hwvGriB1f/BYVWGMLIvMFtNbJ+e5McsfDgf2/o
         muIg==
X-Gm-Message-State: AEkooutD/KqoMMoLngb+ZTo2fbLSQrgPFUfdoMCKJbrIxuAvuz6etsojsKNL0NzQk9rgmLZC+tBwiABSSztLWg==
X-Received: by 10.194.248.198 with SMTP id yo6mr13374874wjc.66.1469844717229;
 Fri, 29 Jul 2016 19:11:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.224.213 with HTTP; Fri, 29 Jul 2016 19:11:56 -0700 (PDT)
In-Reply-To: <20160729180517.GA14953@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net> <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net> <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
From:	Paul Tan <pyokagan@gmail.com>
Date:	Sat, 30 Jul 2016 10:11:56 +0800
Message-ID: <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
Subject: Re: [PATCH] reset cached ident date before creating objects
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

On Sat, Jul 30, 2016 at 2:05 AM, Jeff King <peff@peff.net> wrote:
> When we compute the date to put in author/committer lines of
> commits, or tagger lines of tags, we get the current date
> once and then cache it for the rest of the program.  This is
> a good thing in some cases, like "git commit", because it
> means we do not racily assign different times to the
> author/committer fields of a single commit object.

So commits created with "git commit" should have the same author and
committer timestamps...

> diff --git a/commit.c b/commit.c
> index 71a360d..7ddbffe 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1548,6 +1548,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>         }
>
>         /* Person/date information */
> +       reset_ident_date();
>         if (!author)
>                 author = git_author_info(IDENT_STRICT);
>         strbuf_addf(&buffer, "author %s\n", author);

But since builtin/commit.c constructs its author ident string before
calling the editor and then commit_tree_extended(), this would cause
the resulting commits to have committer timestamps which differ from
their author timestamps.

So maybe we would have to put reset_ident_date() at the end of the
function instead, at least after git_committer_info() is called.

Regards,
Paul
