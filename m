Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A50C20248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCKQCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:02:00 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40602 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCKQB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:01:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id t7so316858uap.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WOz5R++2/6g5mwJkcXGIW7Z7EZBtCHycI5GIopCDSEM=;
        b=dWjaYwmzal+DRu7CN1lY8K78+aQ3fZjzJqg82DUh+wEjHEHO4J1LOM0GiUN3/fM1JI
         yK9tv6dxw77Le37xtAS9OVfuFmh9elWdH9uYRs9eoFqWAfFZ6LVTlodFLFvhUTYX+BDS
         tsTG33fOiACHvi1Ywk3QPsvs/yra0s5va7V3Nu1vWe9K1ODV05M8uZ7MMIwjqwsM77Ls
         K5RAeslc6KtqrQxhvsGg2TZoh/9kAplW+6tfuxBqSv4siWGl3/h24c8q3lAX+Tc/6pmK
         a0qqEQ84QHwh8+md55CAA7as2+uqehGKxp0kxANFSWrBVLLaYSagezCqfugftxRHkl1i
         j+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WOz5R++2/6g5mwJkcXGIW7Z7EZBtCHycI5GIopCDSEM=;
        b=kn+BWQYtZk4yL+noDojwX7xrfcNsIwUuZaDp7ZuOmG+Cp6mkh7jrkktObq7NijJRmx
         tm3TosrktmSiiLMwjnBjrfc4naCa8sCoIQLM8+YUZfYML4YPfyo5N+jrwmIjhI6tsLpr
         dlk6i23qq9jl1A/IYO+xNh/aKXi0T4+PSHADuK0ct90pG0Rt7kcyXbnaRdmFgEtXwlHI
         Ga+Zqq54Pq4mA8rATL30+W59JRIFl8alsefkn7B5B4C90sb2XkN8pzHsvV2dgYDe0VGT
         SESvYmG1WN05Vp8EdFHxx0eG7CoymfaEyHkZmPnhzqX9vJulZ4ql+vkUdwq0YQgk44lO
         YNXA==
X-Gm-Message-State: APjAAAX2xt3vM0Yg5JdsShIK0ygDqvaky9noOHHG+aTonkZybmdomL65
        ao1KGHMqOGVlz/p1ebYBsvI5jMHKlNEPaho82lNjlQ==
X-Google-Smtp-Source: APXvYqyYmMwZ1pnvNoAzt1WaAo5QtgMZp7VholVe8emn60wQXAJ0mf3ZTO7GDAjdtuabazTU6Nq3JHP94MaJ7WWJNDo=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr16358144uad.104.1552320118728;
 Mon, 11 Mar 2019 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
In-Reply-To: <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 09:01:47 -0700
Message-ID: <CABPp-BEmqJ4MfKwW81X21yXjZpf35kzqb9KaFs1uuBsmZ47_LA@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] And new command "restore"
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 4:19 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Mar 8, 2019 at 5:17 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> > - --index has a different meaning in git-apply. I don't have a good
> >   suggestion except "yeah we have two different worlds now, the old
> >   and the new one"
>
> I will rename --index to --staged to avoid this. It is already used as
> synonym for --cached in git-diff. I will also add --staged as synonym
> to "git rm" so that "git status" can consistently advise "git <verb>
> --staged" where verb is either restore or rm.
>
> Since option rename is a lot of work. If you think this is not a good
> move, raise it now, even if it's just "I don't like it, no reasons".
> --

Works for me, but this sounds like the kind of thing Junio might
object to, so I'm curious about his input.
