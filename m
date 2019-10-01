Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A5B1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 16:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfJAQyq (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 12:54:46 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34491 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfJAQyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 12:54:44 -0400
Received: by mail-ua1-f68.google.com with SMTP id q11so5715784uao.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pmhCbI1PvErYRJUr1WcAQvWyaidOZngkz0nrOgWn58=;
        b=QkDhRRH7bGMfc8AqAMIqp0t47N1M8xDv6H9icHCDMT49345WqOErZ+Pi/VqroJjuih
         12o0ysTc3BUua6kNT7kcyUVwoCLaBlBfzfOgTXMCX5zxigcvxtvRp7DYwPYWSF89R3Uu
         ifZG4KZ0KNHJyk5W0U2gCAwx+9j5wn6LM3S/D7+syUSftNyvLy6pfYGGyLMCXvLkgDv+
         shs1U+lDxXqvwlqp6p7zZ0Pr/rm6rEqN9oUrcSt2XBjIosVWFnVC/ksW6MKr/wxDEBWk
         Vyk54ObkeaI9zhpW/qQiQeLl/YvlklKFgJYScPuu9e5kY0Sc/M+MDGtZ7W28RztaH6m6
         vumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pmhCbI1PvErYRJUr1WcAQvWyaidOZngkz0nrOgWn58=;
        b=k5uMkQXenNzLjeCSbNowdfYM0dkA9cfGscXx+ISAvqnN3oJWJUbJOOG72pOedQFc5I
         Y01F+31BETuUed9yLHtfmiU0k7i9sSlyRpWfCazL02Uj4scFmfuVRBAB4aayaQYwC0q9
         VCZ5wzEXDgvNSl1v0wjlfBU/F4ZG8hJpWJDaOV+wkaQXZI0WNrXSmtGq8pXw+waCaxLo
         w/w50xWrfC1toC5MEAdF8uLQShnHH21uSOPvqx7TJlGFlZ5wARMNPxUUhFpha6yb+vTZ
         QhdjA/asEcS3Bfj2QGQKzc8o4Y+LhruKFxdc5KIFtBoq6rB/zFrqQwjqxIuvRJtrejvM
         nJBw==
X-Gm-Message-State: APjAAAVYJwUv2G4HsIfdBucb29MDx10KenjJcT3+icki7CBl5iD27fa3
        1GeY/MdA6lkn5raVx6oWNZ6U75GB21GGM42ztYg=
X-Google-Smtp-Source: APXvYqzRjoaawm0nbMKUP2XJqC6LZs/ty0qu3isQnc9KKM4Q7Iv3jAilcfpL+5tYyxCNw7Lwkpos1BhG8NWBmWBjYGo=
X-Received: by 2002:ab0:734f:: with SMTP id k15mr1189707uap.18.1569948883293;
 Tue, 01 Oct 2019 09:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com>
In-Reply-To: <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Oct 2019 09:54:31 -0700
Message-ID: <CABPp-BHGNzLNzOW6nSi_ComA0DrRnJukqoemG8z_qS6e22uBUQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 9:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
> > This series makes the sparse-checkout feature more user-friendly. While
> > there, I also present a way to use a limited set of patterns to gain a
> > significant performance boost in very large repositories.
> >
> > Sparse-checkout is only documented as a subsection of the read-tree docs
> > [1], which makes the feature hard to discover. Users have trouble navigating
> > the feature, especially at clone time [2], and have even resorted to
> > creating their own helper tools [3].
> >
> > This series attempts to solve these problems using a new builtin.
>
> I haven't heard anything about this series since Elijah's careful
> review of the RFC. There are definitely areas where this can be
> made more robust, but I'd like to save those for a follow-up series.
>
> Junio: I know you didn't track this in the recent "what's cooking"
> list, and I don't expect you to take it until I re-roll v3 to
> include the .gitignore interaction I already pointed out.

Oh, sorry, I missed this.  By the way, is there any reason I wasn't
cc'ed on this round after reviewing the RFC?
