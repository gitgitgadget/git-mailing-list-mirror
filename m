Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611CB1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 02:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeDSCTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 22:19:34 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:53045 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDSCTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 22:19:33 -0400
Received: by mail-it0-f48.google.com with SMTP id f6-v6so5171670ita.2
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1ShMrqfUtOF34ugpjdtzHg/En7zBPbTA7CG8buoset0=;
        b=L6bewowvv8umtGQ0FiGLHEFLYNjC3T1aRbxnEzXRTxGc8radFHNqTNv0aoHoCeXNtD
         D5hJhPdEYl3y2P3ejHGI1OsR3MEAskhOt3M0SeddJsQLUiPRVdqZRFQjsTeBOJ+egHNU
         ibC2cDQC7SzH/EDIQVy4NrqGm1su3tVh/AjBsJjbVUclB+wzyRKU6M/VpiNAE1rID/Xt
         +kf8IEtsjQA6IFGUvhVEniUlhjMPih+i7n7AZ5qlwbCOHHiL+TEOkOw/K7fLMLd5ytPt
         SK7bBb+aeiJzIYIJj6LtIrcNV1ydOQ2YjbaKNvyGmkN04A9oswnq0/Bnx5ihcnlRcN0t
         enHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1ShMrqfUtOF34ugpjdtzHg/En7zBPbTA7CG8buoset0=;
        b=fb6OWqouS6RI9kYs/cPgAjZ3/00ALtDK3FkkCLqEwjDPwE1pgJMmpA5sdA6lcrtJnx
         vafs7GJs/wjxpHwj5HxrOCql6Cn+AaZqUxFWtpxMha2o5Syl8QZgIc8IfqMb6K/4HFaY
         tmYFGockd9fh9ZRL2Z+pGSwVragQP5wRDRxPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1ShMrqfUtOF34ugpjdtzHg/En7zBPbTA7CG8buoset0=;
        b=BbvBYBCy8QTfatgOUJxJIw5E9SnYfYPQ3Q5vO1q34lODInO+cE0BaDIvuip5KgZhLw
         4V4RjTw5ZOuxwxLxdoHzsoT7TOeF+srvyiK1IAys8S73iCgnvlqGTnvCiE4vRuUBtre4
         SuiBwNaf+SkK3w8ORGGUjNzfgkWsEZvaMHBqhispF/6HS3dtln/XkeGP44idf25SXUQe
         OuDmB1wZuwF9AD/PccxIO2Xgtbtq2kBGlHG0dbF2fst9fU2LCouBwz7WgKMbjqvfPyKB
         GKs4kdG0PfrwbiDB1o1hyow76u20JeFsfDnzbX1umG/DDOR5tsp7IoG/c0rxTYZXF/07
         0Q1Q==
X-Gm-Message-State: ALQs6tBOO5cSq4Pm4WtSTYbV3tvXIssera6UiRfGPGZgYbV/2cG6u8ul
        jH4/TYkXailWrq1rQnKSw+izv1GUjx3QLAOwJkg=
X-Google-Smtp-Source: AIpwx487ad0ijW27w8EEh0Rdoxs5HXOQG4IUPh+9sf0PRrB+Z/2tsRMZ9/OUUNomychrCgYlTaLnmR8wTIGmBNZx65A=
X-Received: by 2002:a24:3096:: with SMTP id q144-v6mr3282333itq.108.1524104373008;
 Wed, 18 Apr 2018 19:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Wed, 18 Apr 2018 19:19:32 -0700 (PDT)
In-Reply-To: <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
 <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Apr 2018 19:19:32 -0700
X-Google-Sender-Auth: Go2EVXvxZc4rTErfE26LUBMAPKk
Message-ID: <CA+55aFxSjUmbrocEr=FX=VOJ_-rtbOPYJ9mXFm+J60FKYtw9Vw@mail.gmail.com>
Subject: Re: Silly "git gc" UI issue.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Regardless of your originai "git gc" issue, we should make "prune"
> say something on this error.  And when we do so, I would think that
> error message will come before the final "error: failed to run
> prune".

So to me, the real failure is the fact that it spent a a lot of time
packing my repository before it then failed the prune at the end.

I don't actually mind the quality of the error message too much -
although it could be improved.

I mind the "oh, goddamnit, you just spent over a minute of CPU time on
my fairly high-end desktop, and _then_ you decided to tell me that I'm
a moron and couldn't type 'now' correctly".

So to me, the big deal would be that builtin/gc.c should validate the
date *before* it starts, instead of doing all that work, and then
executing "git prune" with invalid arguments..

                Linus
