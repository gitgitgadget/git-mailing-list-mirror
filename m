Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B3CC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 08:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJDIlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJDIks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 04:40:48 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829429361
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664872842; bh=nj9VpHgL9omhRr7gmvmWCytmNwmIyTIO4cJ9DSy+b14=;
        h=X-UI-Sender-Class:References:In-Reply-To:From:Date:Subject:To:Cc;
        b=VdklDZTqIy9rhnYeAVMx5FR0y5WKC7/XxHWF/maKn37U1lWsEwn3lsMtWfJAL5zJO
         vbRiwkSfnnIy6P/i5BagbDr8/S3eTZnxknihlqT+K1zWhQ95BP8qDFI6MqaI/j0PnU
         9Dso9oFpIgyIyLqqTlCzTSfw8UUnzAi01QIKTSKDSosSJ4grkFWpa4z/5v4MI+Dunm
         L5YTufqoh7ljIqgRXUU42GeQaqEaEhxw/4jbuQpjDOy9MTufMav+L+b/A3Z5gX7r7T
         HvR/YyG3w7uQeWmgde1fB3UDG3N/l1pF68x8eYdjVGbc0uL1URnhs+hONeGyxr42bU
         WLUUvEbQgy5IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mail-oi1-f175.google.com ([209.85.167.175]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MODmV-1oqHXk3eif-00OTHl for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:40:42
 +0200
Received: by mail-oi1-f175.google.com with SMTP id q10so13768478oib.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 01:40:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf0KzYkC4eSugPgiF/c5r64kEbi5v2e06XBVYloUJEiXG9rFEu7Z
        267YZaGlK27y5c4hSF7G6Tw3w8IvI2zODKZDO2M=
X-Google-Smtp-Source: AMsMyM42iLHvO0ctq9eqn5p2sJmEVjhE5rYa41+DsBoXgY6Za1UCxp/3DmcWMKEiJ/zazH3m2Cxv1tjhdvSep/eZr6M=
X-Received: by 2002:a05:6808:10c3:b0:350:e563:7c4a with SMTP id
 s3-20020a05680810c300b00350e5637c4amr5541944ois.182.1664872840520; Tue, 04
 Oct 2022 01:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
 <YzvnadnAYce0dIpi@danh.dev>
In-Reply-To: <YzvnadnAYce0dIpi@danh.dev>
From:   darkdragon <darkdragon-001@web.de>
Date:   Tue, 4 Oct 2022 10:40:24 +0200
X-Gmail-Original-Message-ID: <CAAOCJVD+NHqhwRQnnz-krLfK=_4_Yaa5MhKhVv5GY9-fi4kEqw@mail.gmail.com>
Message-ID: <CAAOCJVD+NHqhwRQnnz-krLfK=_4_Yaa5MhKhVv5GY9-fi4kEqw@mail.gmail.com>
Subject: Re: Install-prefix when building should not be hardcoded
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XQSXzXMKLPCZDoNB0N4h3D1pv06fiMHTyKi+T7fQy1M9zdUINRW
 PrQodzeMZ5iY4wDsOHvUD+wCNSfKmBzlVCkY1Kw8B6YhgjMDb51KakDhYV0CeuOYjHl6azQ
 etszbzW6Kpi8uDQ87REgV9hIGHY8yOAAAdUMCNsZW3qhkAFWpduiq4Eon8d7HYf7bSJxITJ
 1clsgNCuUMeRgVYJGepkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DPJibkvB5y0=:xOXu3RcejyvzFvWlzcklz/
 1iHYjdWYeQbFJKQgJT7JjmYzpFiw02qbg/Kidue5kv9uCykFpXrSWYesYhqcX//3JGYsdmNa4
 arGh4F8iKRsNzUOqI5zkxXO5fp0o9ge4RyFIK4fPhRFk1iA9JjwreB9qyCYc6GBe5EVdqECHp
 mHvzSLn2UtF3dlUB8OtM43UKmJmojVNbwPVH0+EnCPDKZOXdKy/W+w41gsCD7WQyVAW7Rk71A
 mQPShHuQ67k2sv3INmuhbOn6t4OxuTjGb+yTLK5Le4iYxIxK4uY4Z6eQG/WZDWaho6AOXlC5B
 /ba1jTlu+9gZdjgOPnHHJ6D7sGRcAdApOUQK8zVhGEeCu2Xpd3ZZcNhX2LZD4KLX61RM86WlY
 OsH0c2Xb9x+T8VrcP2uVDUG4U6oGFF4BSddu01EfOG2OuLTeU3jdhUEndZXh/jN50yZLok368
 8T479QeoYmzOD1ApiNIffusBovsW2pRl3sbxt+htFn41bB4aavRiUXXL5Ozk+WL79CiwFsPtm
 lA9EkzbjTluW4CRR2EXu8R/bRu1NP6WcIooyoLOZZdYfjmUB7LM8qGNZypEZWgKHB72K/4IAQ
 Msn+HqyIM6pEeOih70pxhfJ89Me9eHrOAQmDRtFuS5ftIvD4gRXVoW79dopc+I5v9LdOyNk4w
 3pKZRPlAwh4ilXfyrn1CXEsKIxu697eeuc7k9m0ebuEwqqvsjp8nJ1mTKmKJQXdNcBMK3eWQ6
 pRCpvtnzRa3PxWS8bSbY0+M/xl+F1t1PQF21zDqQ4SZwMivz1WyxvjwhRSF6FCKuwaYPjBbip
 VWyYgZ4eAvtteBX1vX7reQCltLMuwXmXNHUAWlqd1t5kQD5f9kjJVQeiTLCOZju7muuxPdxxJ
 xk/OMXVUeFEd0Kl3oVpvkyy2q48wLjBPqDGv/wEohLLZB2J4tpn9TjBPCz1ZhV0kyjVC0cV5P
 dkQYhYhFlDkKmwGfm5ocVAgNZDPQhRoXKTmUMhTjdqtGOsuc9QYY5sT2hKh4ErB56zcRVbTpV
 GXNntnUa5u33T3LjwHbg5ibXjp3fJ3flN1MAEDVHIB4TeScQaiQslA8egQJ06wgYelPxMxzEi
 5UkfUNM1bcsr5TDOl/2+PzrwsIgK7z/BIvjl7dv4prYdVE+vUhHe1K8qdNv/9h9lL5flEJvU/
 g+ftmVQvHPVi6GCTe5bsGwI3Cl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the hint to DESTDIR, it helps!

Nevertheless, I would like to point towards the following section in
the [MAKEFILE][1]:
```Makefile
# Among the variables below, these:
# gitexecdir
# ...
# can be specified as a relative path some/where/else;
# this is interpreted as relative to $(prefix) and "git" at
# runtime figures out where they are based on the path to the executable.
# ...
# This can help installing the suite in a relocatable way.
# ...
gitexecdir =3D libexec/git-core
```

[1]: https://github.com/git/git/blob/master/Makefile#L525-L547

On Tue, Oct 4, 2022 at 9:57 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <=
congdanhqx@gmail.com> wrote:
>
> On 2022-10-04 09:38:24+0200, darkdragon <darkdragon-001@web.de> wrote:
> > Even though in Makefile, it is stated that git will figure out
> > gitexecdir at runtime based on the path to the executable, there are
> > many output files where $(prefix) will be hardcoded. Even git
> > --exec-path will print out $(compile_prefix)/libexec/git-core instead
> > of using run_prefix.
>
> I'm not sure about this part.
>
> > Example: We are building git in Docker at a separate stage to /deploy
> > (since /usr/local is populated with our compiler toolchain). The final
> > image is assembled by copying the contents of /deploy to /usr/local.
> > Commands like "git submodule" will fail because of the wrong git exec
> > path. Searching via "grep -r /deploy" in /deploy after make install
> > yields many results.
>
> But you may be interested in $(DESTDIR)
>
>         make prefix=3D/usr/local all
>         make prefix=3D/usr/local DESTDIR=3D/deploy install
>
> Does that work for you?
>
> --
> Danh
