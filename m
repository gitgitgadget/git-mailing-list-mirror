Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6657C20970
	for <e@80x24.org>; Sat,  8 Apr 2017 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdDHVyy (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 17:54:54 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35847 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbdDHVyw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 17:54:52 -0400
Received: by mail-lf0-f52.google.com with SMTP id s141so20240422lfe.3
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eeolFKHTk6KWSbpZKT3Bm8xynk3PvxecqXJ+XBRN9vs=;
        b=IzP118Vx4yNjHwB+GF4/4zslZV3WqKKAs+sN2oIBwe1xm0G3Y2p1SmxjcNmZUU3fNQ
         3rJi040AjUrbGzLXt6PZVtWFvbHTk3Nn/u9lNGOleVUJx6FM3fPV8VkujJ7wEVLtDQoR
         sthKPx8HdXueiZLXGMhcagTKT9lKa/S9PQuWjnGr4/f9HpRZ0uIeNVNz23U0Gdw6Azn6
         7i7xSi0m4DUWWHK1zsAlomZwYAeZN3IBxz3hlREtXpIfYX1g6oJEPCIuCzVCg7iyYaVE
         TlgY9Q1DCF0X0JD47hn0jK7MwZaYs/nx/KbAkynLNnlTy/a10DiyTdyL+4lQtgti/0YD
         Z/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eeolFKHTk6KWSbpZKT3Bm8xynk3PvxecqXJ+XBRN9vs=;
        b=hmXk8vzr6qHJhGJw3/4fQE+gxUSOGLt5Ot9vW2JtpdNG34FslfwUG/YB8MJpEdsIzJ
         zUo/lccTUvogRH0sO3YMUzog5caHxaeN6nfv+JN41RZaEVjr1tT3aI/QpPIDwz8TcSXx
         GkBiwgxQtasLk7hGGgmW+OC8QGm2iuWo0W7y2Bda/VwQGkCVJo1DHtOKQYCGUVRWgcTF
         fUQk76lUkYF5GenWVFNRIU8PTbwn3l00IaLQZ26pg4RW25pAkaZflfoQ5rIPaZahoAxA
         p+l+6sjextX3jGZHpg8LsLjdib5iaoi1Ej5OH1kvsSJ7V/abS9HM9qOS6WYKAOZVBBmN
         jg4g==
X-Gm-Message-State: AN3rC/6VWw9O/GsDvq8wkIP+r+9zDzkwuPWPtqrquaNGaxBwd/arxXxxv1H5VAa4qxArFl1t6TK2poeoN5SyIg==
X-Received: by 10.25.216.212 with SMTP id r81mr49847lfi.66.1491688490006; Sat,
 08 Apr 2017 14:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Sat, 8 Apr 2017 14:54:29 -0700 (PDT)
In-Reply-To: <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
References: <1491617750.2149.10.camel@mattmccutchen.net> <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
 <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 8 Apr 2017 14:54:29 -0700
Message-ID: <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 2:29 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 09:35:04AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Is it correct that you'd essentially want something that works like:
>>
>>     git push --force-with-lease=3Dmaster:master origin master:master
>
> I don't think that would do anything useful. It would reject any push
> where the remote "master" is not the same as your own master. And of
> course if they _are_ the same, then the push is a noop.
>
>> I haven't used this feature but I'm surprised it works the way it
>> does, as you point out just having your remote refs updated isn't a
>> strong signal for wanting to clobber whatever that ref points to.
>
> The point of the --force-with-lease feature is that you would mark a
> point in time where you started some rewind-y operation (like a rebase),
> and at the end you would want to make sure nobody had moved the remote
> ref when you push over it (which needs to be a force because of the
> rewind).
>
> So the best way to use it is something like:
>
>   git fetch              ;# update 'master' from remote
>   git tag base master    ;# mark our base point
>   git rebase -i master   ;# rewrite some commits
>   git push --force-with-lease=3Dmaster:base master:master
>
> That final operation will fail if somebody else pushed in the meantime.
> But obviously this workflow is a pain, because you have to manually mark
> the start of the unsafe operation with a tag.
>
> If you haven't fetched in the meantime, then origin/master is a good
> approximation of "base". But if you have fetched, then it is worthless.
>
> It would be nice if we could automatically deduce the real value of
> base. I don't think we could do it in a foolproof way, but I wonder if
> we could come close in some common circumstances. For instance, imagine
> that unsafe operations like rebase would note that "master" has an
> upstream of "origin/master", and would record a note saying "we took a
> lease for origin/master at sha1 X".
>
> One trouble with that is that you may perform several unsafe operations.
> For example, imagine it takes you multiple rebases to achieve your final
> state:
>
>   git fetch
>   git rebase -i master
>   git rebase -i master
>   git push --force-with-lease=3Dmaster
>
> and that --force-with-lease now defaults to whatever lease-marker is
> left by rebase. Which marker should it respect? If the second one, then
> it's unsafe. But if the first one, then how do we deal with stale
> markers?
>
> Perhaps it would be enough to reset the markers whenever the ref is
> pushed. I haven't thought it through well enough to know whether that
> just hits more corner cases.
>
> -Peff

What if we added a separate command something like:

git create-lease

which you're expected to run at the start of a rewind-y operation and
it creates a tag (or some other ref like a tag but in a different
namespace) which is used by force-with-lease?

However, I think using origin/master works fine as long as you don't auto-f=
etch.

If you're doing it right, you can handle origin/master updates by
checking that your rewind-y stuff is correct for the new origin/master
RIGHT before you push. The tricky part here is that you have to
remember to check after every fetch before you push. This is why I
would always create my own tag or lease reference prior to the use.

It might be possible to generate these lease tags prior to operations
which modify history and then maybe having a way to list them so you
can select which one you meant when you try to use force-with-lease..

Thanks,
Jake
