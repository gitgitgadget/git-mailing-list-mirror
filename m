Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE64C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2A61074
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhIJUcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:32:46 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37682 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhIJUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:32:45 -0400
Received: by mail-ej1-f44.google.com with SMTP id h9so6738100ejs.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jO8KWrlRZR5saN4v+DUCctDrgU5ntovuewk6Zo3aY24=;
        b=fKWj47CtU1VgSEhhIyqpqB8VCYhR3MzFMkyPoODu0HzZcqSBSzQAIPGjlFal/pjoRW
         S+bAzOOj56lPYhJ8DlvFX8wdpeTHiI4jtFaSZu0LAdqoB3fVlfbUEou4gtvRJBMmDmae
         rKHCvWEfFuZ+2xzf85fJTitqj9NQFemmz/OJsXd53TayD1rok6M9TKwebJ+TLMmaU9CN
         skfADkJN4+RLvCkp6TfUddmH6TSqNzKZOyvjUAZWQnR5gadkujgKieTKa6QP1x+tkmxO
         U7FlKJ6A9J+MJmM6XgLHCwokjeS8lTrVHhcJ7m3QHFKdI41xWI42rWoeO/PhtsOPiWkc
         IIBQ==
X-Gm-Message-State: AOAM53233CjZQtWBerD/iT45gmzQuOUTfsJ1J8HOjv8wbkxwoOFjLDEs
        4hCqAQ6FNcFvO/ugfmNXWM9NmuYa597is4OuubGFik8B
X-Google-Smtp-Source: ABdhPJyudZX//a0UfQwDBAkEXZPx5OUrOVObhm+ch+Fv11UzQLX/SPsBTJ7TR+if//Iu5C8v97zbFb0x7L1tJRnLhrc=
X-Received: by 2002:a17:906:318c:: with SMTP id 12mr11534257ejy.28.1631305892680;
 Fri, 10 Sep 2021 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
 <xmqqeeaa4y0v.fsf@gitster.g> <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
 <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com> <xmqqwnnos2jz.fsf@gitster.g>
In-Reply-To: <xmqqwnnos2jz.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Sep 2021 16:31:21 -0400
Message-ID: <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Have we made a decision about whether this patch series -- which
> > avoids indenting blank notes lines -- is desirable? Or are we worried
> > about backward-compatibility?
>
> I do not know about "have we made" part of the question, but an
> input from me to come to an answer to the question is that, while I
> can see why it may be desirable in some cases, I do not view it as
> compelling enough to risk any unforeseen breakage to other peoples'
> workflow.  My opinion is based on an assumption that it is desirable
> because it would squelch "here is a trailing whitespace" noise in an
> editor and/or a pager that is appropriately configured and allow the
> user to spot whitespace breakages in the payload more easily and for
> no other reason.  If there are other reasons that make this change
> desirable, they might influence my opinion.

Thank you for the response. I didn't have any other reason beyond
squelching "here is trailing whitespace" noise when submitting the
series. Thus, I can't provide any other reasons to promote the change
as desirable.
