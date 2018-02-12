Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FB11F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeBLJ0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:26:49 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:33049 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeBLJ0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:26:47 -0500
Received: by mail-ot0-f171.google.com with SMTP id q9so13432429oti.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6SQMu89FtCbRlu5rRgxPqQhwSe5G99fxprqEq3pT1B8=;
        b=lBOKiic924cmAI8EldHHj4cG3oeSkG+bwZEEUa99U3tVK8Nxb1Phesjfx7+GsLrqQX
         7U+oWnOJK1h3fSa0uNqkF0AOPZyhGEkJqbty8P0wYTnP4RBj+vDfmuUf0wGSQ2OisbuO
         KqsEEQztIzktEbnLSbGQ8qLn7/vEzgiayA7CD0oMQySYa3fUXzBaSnBtB7YKfDYnsemC
         Z0z+Br8Aa05WKAW/eJHgHPMJ87axdEpAmNc7dCJbaF/JFS5ScnfXYfbl0Hqa1YLbUQwz
         8KLhRyKQV/FdlcWbnaAp4kHsNquRLSmWHDfELRtcMqEIe9gQHrJrdRaOdw2s6nMCb7A+
         QHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6SQMu89FtCbRlu5rRgxPqQhwSe5G99fxprqEq3pT1B8=;
        b=k/fCXSFWPYTcK4w2zP4edKOD+/VKux2TLeVaPiWm0m/jD6cJ7a3cOIQfWYkxNd5VzX
         ovSf4V7KTzt0NEAM/bbjV/44D96WVAPPJjrobJK5zT5ihL4JiTQKfptG+v0U5z/mM01D
         IrQPCWJ/E+KiWVZZ6ORIEfoyPrQDH7TEKZ/Bt/4TNGQR+BTfn4QAbRirznZcwUsi7dk6
         mCEVCXzKQsijDs+u3Xxxsb1oS8X0s+szK3pN/ioYPajghNcLMK8RfqANboSfZNOtJ4b9
         fYQjIBBRmDrGhc33OJzLt8ooQLtGsRfH+NVI7UeD3eYHk6TqUN7c7gv9/9H3ZOpZgcNN
         Mhqg==
X-Gm-Message-State: APf1xPBlPKwaF5/56gO5oq923gbX5zuCTbIVct6eJhKIn2JBx9Rd+36C
        zJsYCPwmTS0OGHIwMSGePEOcw0tbO7tq/mYrtJ4=
X-Google-Smtp-Source: AH8x224Zyq0e1bKUPCdV30NiiHMY3RSX2zHHZEmAmhnX+tdqAtKu7CiVIfqwDX1sx27tfhDbccbx11iFAXJLFnE6tuI=
X-Received: by 10.157.64.140 with SMTP id n12mr8462946ote.151.1518427607255;
 Mon, 12 Feb 2018 01:26:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 12 Feb 2018 01:26:16 -0800 (PST)
In-Reply-To: <CAPig+cQvVreeggOj52bVLS6R0ZCar_yfUcyLbN3-nLG81eOQaA@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-7-pclouds@gmail.com>
 <CAPig+cQvVreeggOj52bVLS6R0ZCar_yfUcyLbN3-nLG81eOQaA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Feb 2018 16:26:16 +0700
Message-ID: <CACsJy8BsdkZFWE2vaWtobMMum85U5vu-iu9MctaWn6vzqsZ3Vg@mail.gmail.com>
Subject: Re: [PATCH 6/7] worktree remove: new command
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 6:47 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> This command allows to delete a worktree. Like 'move' you cannot
>> remove the main worktree, or one with submodules inside [1].
>> [...]
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -688,6 +689,132 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
>> +static void check_clean_worktree(struct worktree *wt,
>> +                                const char *original_path)
>> +{
>> +       [...]
>> +       validate_no_submodules(wt);
>
> It's slightly strange seeing worktree validation in a function
> checking whether the worktree is clean since submodule validation
> isn't an issue of cleanliness. I'd have expected the caller to invoke
> it instead:
>
>     int remove_worktree(...) {
>         ...
>         if (!force) {
>             validate_no_submodules(wt);
>             check_clean_worktree(wt, av[0]);
>         }
>         ...
>     }
>
> On the other hand, I could imagine it being called here as appropriate
> if submodule validation eventually also checks submodule cleanliness
> as hinted by the commit message.

Yes I basically consider all submodules dirty until somebody sorts
them out. I'll add a comment here to clarify this.
--=20
Duy
