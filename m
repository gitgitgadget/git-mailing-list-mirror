Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DD21F462
	for <e@80x24.org>; Tue,  4 Jun 2019 03:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDDQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 23:16:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42896 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDDQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 23:16:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so3764014edq.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+tQQH5YnnqwRmul+DOE/GLcdC6gOXf6YKnTmFF6OQo=;
        b=KLhUb/R1ZsyQl0ocDtlTEPWBKJu47kIqWvl1bYyrGnurVcFzqhK/Lok1vA01iilmRO
         TqyizwtPR+zN6ppVgBwyk5X6kexC2tjbnJgKPtQs1AjVv3TpjgjM9dnZpx8iNnoYRZPD
         VeqXEt3uvW15iP7i4yrDhEeTOnsUSD0gL9HfwBDFG27AxTGS+3GEuz9fAQlRPfqMgfZn
         k7R0if1nS5NFlXQi40HDFQ2Cg7o+wyRS32Bs1h4tiemuPdJkpKTRJkiPgCSQdCXtCkF9
         Y2uWS8MgM+sea7w4QyFiD1mSyw4+UC4Hb3KfG1kJTmJvs3VFTZUqJuGP8LYq4YpgfBmD
         AkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+tQQH5YnnqwRmul+DOE/GLcdC6gOXf6YKnTmFF6OQo=;
        b=HRu2m9Fpx3bdtPm8Iy+G7Ro3+j0iymSK6a8bc/4LMBTqmYqskEp9d9EJYR/aH4Z4Vw
         q17/90AMCeH7neUs1m0Zq8ggFHfTAW3Nn0j/R2YIVyNQw2EFcsnfvg6jaRiORYir9Hhk
         NwGHpvt5J/V9gj0StMXaXsMEJ6uyFI6qm3AsW9cYiPhv5w6ZljnZQI0zVK3B8yUydArZ
         ugwYjSzWoKmjFd1NqIE0/Ks7QsvenngXCVGIb1SpPd9Lkkq7vRpkoK7kc1aaKiPKnNfi
         CZyp0ay6CCC839Ah+lpZivGkjkyFf8uIOMAYjZ0ylVd8dCrdH9B+h5LJUm7UKSyLMWZH
         Slfg==
X-Gm-Message-State: APjAAAXkGOaZ7XRE8PnY1NtASXAGaSASoZx+UleP6G5uOPZucYPXKjsw
        ZtycR/oAiTLWL5wMTAoWjXPLYOG0P+Mp+ZuYJ9jrsHa9LyU=
X-Google-Smtp-Source: APXvYqyICRXpBRkEDeOm2lBmZhxEc0tbSf0MyXofONzrDytkHRY+adVzpeMy7NNKLjGD7IC1DR4pDgAknfEhDdJyDzI=
X-Received: by 2002:a17:906:6a89:: with SMTP id p9mr7818357ejr.44.1559618203022;
 Mon, 03 Jun 2019 20:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <20190601003603.90794-9-matvore@google.com>
 <CA+P7+xqqS8wMeNw1E8yXzStNHgrCU5ME1wpWckbPA7pBD3OBHg@mail.gmail.com> <20190603223925.GH4641@comcast.net>
In-Reply-To: <20190603223925.GH4641@comcast.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Jun 2019 20:16:34 -0700
Message-ID: <CA+P7+xp6FYWZA8yXcksw6OiMqiM3Ja5EpVSTbcgeaGD-s+c6=w@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] list-objects-filter-options: clean up use of ALLOC_GROW
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>, dstolee@microsoft.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 3, 2019 at 3:39 PM Matthew DeVore <matvore@comcast.net> wrote:
>
> On Mon, Jun 03, 2019 at 03:07:40PM -0700, Jacob Keller wrote:
> > > +/*
> > > + * Similar to ALLOC_GROW but handles updating of the nr value and
> > > + * zeroing the bytes of the newly-grown array elements.
> > > + *
> > > + * DO NOT USE any expression with side-effect for any of the
> > > + * arguments.
> > > + */
> >
> > Since ALLOC_GROW already doesn't handle this safely, there isn't
> > necessarily a reason to fix it, but you could read the macro values
> > into temporary variables inside the do { } while(0) loop in order to
> > avoid the multiple-expansion side effect issues...
>
> For x I don't think that's possible since we don't know the pointer type. For
> nr and alloc it doesn't make sense since they're being assigned to. For
> `increase` I could try this:
>

Ah.. you could do the compiler typeof extensions, but I guess we
probably don't wanna rely on that.

>         size_t ALLOC_GROW_BY__increase = (increase);
>
> but I'm not sure how well this works when `increase` is a signed type. This
> seemed sufficiently pitfall-y that I didn't attempt it.

Ok that makes sense.

Regards,
Jake
