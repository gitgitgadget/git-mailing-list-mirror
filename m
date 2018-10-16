Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9897D1F456
	for <e@80x24.org>; Tue, 16 Oct 2018 18:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJQBvt (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 21:51:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37441 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQBvt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 21:51:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id r83so19051023vsc.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLGa0/AK6btJv3f4bXHJ/kya4T0PPvkQh8/tZp8GqHk=;
        b=RuaiNAdZ/B4COSmXBJ6Cti95+DV911IdWeTLjScq+lkZSgAPzcgQa26BdHdC+pOFWn
         hYcyoPM3U/xPnA9mYfhX266obchKXcXLtSbn35IbY8gvOaPkZ6XqeKatBUM3laAZdWnj
         B12eNvveHSEx4RwxCb6jJDmD5CIRuL4u8DUO/gbYLsDV4wtTS0YBZ5hxqvKCYPk5kpLW
         hXtU75gOEGs1yYLhwJnPCvlI+bEMTV7f4h2nLj1pxBIHZFjlrZK/imjsZAiWFUpg7c3Q
         IijmdF+nDxhcTxzy8ScXcaiwdr1goC3tXizUqsCexUzRbYAFUKHNjXbe8g9ZnOlLgvmn
         exsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLGa0/AK6btJv3f4bXHJ/kya4T0PPvkQh8/tZp8GqHk=;
        b=ANR13WYnfJLNms8l8vV+ZByew0GKuOSSz9wnNOlYDrQqLmfV1UR1x0zhWotFPAl2OU
         B9wHhuCPFjxIeB1LfR19agGqWFAKUOgfaLJIHyeZ8YKzEBkf1cCBNHNkuIyNfapCmBAG
         HVyUahIy+UVRE67QDpDphQo2my1CVMpq914CBhr+N/aWuwki+0X95EGr1wY6qjaicO7C
         QBzSn3NCR7EPsEqTXph9NfFe90yKEFwVdiK1tRko2+58Y2doq2Vhu6cblI3ZQoW2fvvO
         85tbiNKCbmGl/2Ayg2HqsXXG3GJext6koOe/IRZjAZwJ9hu7S1q6HUzRNPbSeG5gH7OP
         Zp0g==
X-Gm-Message-State: ABuFfojyuqaKdCtY+q1ikELB3GZOIZ9Qy76bco1g8yha5H2Ot5xHQJHJ
        obupWKVnltfkQWcXjj8Q/SV2PrHKVsi2bbr8edTHgA==
X-Google-Smtp-Source: ACcGV61lhOaqTzVVfuVrp9frMeTu3nyP+NwtuluomXv2V8BqPf9m3ikxDD7YAg5XAmEWvTBloJviyO7emlw7Ke/PkeI=
X-Received: by 2002:a67:2cd0:: with SMTP id s199mr8932688vss.117.1539712812986;
 Tue, 16 Oct 2018 11:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181012212551.7689-1-newren@gmail.com> <20181012212551.7689-3-newren@gmail.com>
 <xmqq8t2z6bem.fsf@gitster-ct.c.googlers.com> <CABPp-BFJTFN1prCwkidnQiKNP=5wdAV0AdXEkTjCT3HTHyB=Mg@mail.gmail.com>
 <xmqqr2gq3aau.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2gq3aau.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Oct 2018 11:00:00 -0700
Message-ID: <CABPp-BGQv35K+wt2pY6ddVCiU=GL7jhqqEmAB0eWRVsaMTk8tA@mail.gmail.com>
Subject: Re: [PATCH 2/4] merge-recursive: increase marker length with depth of recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 7:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Would you like me to edit the commit message to include this more
> > difficult case?
>
> Neither.  If the "marker length" change is required in a separate
> series that will build on top of the current 4-patch series, I think
> dropping this step from the current series and make it a part of the
> series that deals with rename/rename would make more sense.

Okay, I'll resubmit this series without this patch or associated
testcase, and include those in the later file collision series.
