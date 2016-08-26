Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165CE2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbcHZNq7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:46:59 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:32899 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbcHZNq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:46:57 -0400
Received: by mail-yw0-f169.google.com with SMTP id r9so48654054ywg.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+G7qojbf21y3m6CNnoR39Z4/sQqM4NAB490nS5P8OeE=;
        b=WhHa4NbyAGQ8DD4fNPJ6ah+IsfDxZRpQE+CytDPQvXaJYxfVGmr2G6ldp+EET24AE+
         Yh6l1O6rzhRdbhm/XB4mB8K6LMixQ6EaW2uIqMe5++C2o0UJyf67xqf6QzqlHaOmbb48
         FHn3kWTLYb9rEw4bgICo2/dX6UY9MJ5MsCMXkFp6uxXS6b7KYtRs+JswWscfirZpRUhF
         tY7WFz2mrbR2xiyCJqApQbqqPgC+EVNMxi2I2sUle+nN8ImqFtyGo/EvFi0hPJCYRfzC
         yRHI3RWKoAdRGyjV9Fd2YB64jmL62HoV8Or7gTmlCmlxT1LGLoq2jMjhQqUU8Vs2c1bR
         n/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+G7qojbf21y3m6CNnoR39Z4/sQqM4NAB490nS5P8OeE=;
        b=FO4g6LlF2ioyTGwTXV1sQkxl6Dznit7FyzH720maLzRLLTLydZyWIe3CzxA0MityOr
         DDXIxpzr1fEBg5RXljf/U9Gav0aEHPh6bhvukF/tZP86KFYGtf+YqM7AuVm9k6kUFtXy
         zTgmioTAj4wXuwX0njahsWe9uLpGr/Qg93A1qtLbTElBfhbrbmbho2AcjtMlC67eC6W+
         +jErcRhvFF84t4eBLQq5lsRLeqBsjMDzssglEoB8+zfOfuFyrtv3PrOgmTxTA8mcnNhJ
         7PC/tlHogeTh3J4HiNSuIZ3nyB//j581CKu+W9HUooO66gHAuA154IsidKNvixIprX2R
         Q0yA==
X-Gm-Message-State: AE9vXwO/jrjhXd1i6I6JOXJyjSr+NGvEwVei9yRMpVcYtkzjdndga8KjtXieMH64tnp2tRS7TKJmWJ6Fi8Dx4w==
X-Received: by 10.13.193.135 with SMTP id c129mr3099193ywd.302.1472219216558;
 Fri, 26 Aug 2016 06:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Fri, 26 Aug 2016 06:46:56 -0700 (PDT)
In-Reply-To: <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe69a-13136cfb-4daa-4f5d-9b56-537adf2c6942-000000@eu-west-1.amazonses.com>
 <xmqq4m69q3b2.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 26 Aug 2016 19:16:56 +0530
Message-ID: <CAFZEwPPfXvLUtcBR6cYAP2dT8FAePFPjDSnVm8BhpLN9cfR1uw@mail.gmail.com>
Subject: Re: [PATCH v14 07/27] bisect--helper: `bisect_reset` shell function
 in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Thu, Aug 25, 2016 at 2:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
> > +static int bisect_reset(const char *commit)
> > +{
> > +     struct strbuf branch = STRBUF_INIT;
> > +
> > +     if (!commit) {
> > +             if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
>
> Hmm, tricky but correct to do the "< 1" comparison.  If the file
> does not exist, you'd get -1; if it fails to read it, you'd get -1;
> if it turns out to be empty, you'd get 0.
>
> > +                     printf("We are not bisecting.\n");
> > +                     return 0;
> > +             }
> > +             strbuf_rtrim(&branch);
> > +     } else {
> > +             struct object_id oid;
> > +             if (get_oid(commit, &oid))
> > +                     return error(_("'%s' is not a valid commit"), commit);
>
> The original is
>
>         rev-parse --quiet --verify "$1^{commit}"
>
> Unless the caller of this function already appended "^{commit}" to
> whatever the user gave "bisect--helper bisect-reset", this
> conversion is not equivalent.  If you said
>
>     git bisect reset HEAD:
>
> get_oid() would tell you that the top-level tree object of the
> current commit exists in the object store, but the original is
> meant to catch "That's not a commit, it's a tree!" before attempting
> to run "git checkout" on it.
>
> I think get_sha1_committish() is what you want to use here.
>
> > +             strbuf_addstr(&branch, commit);
> > +     }
>

Ya! get_sha1_committish() would be better. Thanks!

>
> Also this version fails to catch "bisect reset a b c" as an error, I
> suspect.

It didn't when I tried it right now. Could you please elaborate on why
you think it can fail? There might be a thing which I haven't tested.

Regards,
Pranit Bauva
