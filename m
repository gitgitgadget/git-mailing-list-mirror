Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330C9C27C7A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbjHQNXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351499AbjHQNWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 09:22:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5926A8
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692278521; x=1692883321; i=johannes.schindelin@gmx.de;
 bh=CJrgkQ5GdNxIjnyfFECiAGLTEuwWFRW24Ne128zqR8A=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=fqW3/8cpkd5QwNbgC+wTdarwWXiWxHSuzkkuUCyBHidlkQI/sOvk8G7hKpVQlNpE8ArUjx0
 7KfLFC3gruMQmKUMv5XSWeP3/x0rXve+1qolkM0I5rrt7jU7onhm7XlwxzyUFOtW3TqAR4rGB
 9ZIdbaEvRf+VN7l1JXxWr09G4hn4vK2XBgipWkl/LTWAWweyamOzXxrxZKiB1tuFjVUHNJp7b
 2nTRg/A76xYRvKiuvJhE4jsgsN9rBsw02xJsMxqNDkqA/02/deBGGmFD9S32K1OMQtUrYdZuK
 +xqUH7FLX6wIIU7USXIDf/XH5OObLZrw76VAmbStiqHrqvs1PKrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1pwSib0i7Y-00aRtw; Thu, 17
 Aug 2023 15:22:01 +0200
Date:   Thu, 17 Aug 2023 15:21:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
In-Reply-To: <CABPp-BE5h6C1iuGDz4HdJzb2bDLidEnQ0_U4fv93JrYXA2_cbw@mail.gmail.com>
Message-ID: <304f2a49-5e05-7655-9f87-2011606df5db@gmx.de>
References: <xmqqfs518gdh.fsf@gitster.g> <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com> <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com> <xmqqv8dqhlkz.fsf@gitster.g>
 <CABPp-BE5h6C1iuGDz4HdJzb2bDLidEnQ0_U4fv93JrYXA2_cbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1130246202-1692278521=:158"
X-Provags-ID: V03:K1:dcUReyOpWibHme3xftCzYwutflY2d+hZR34FvAVeTDBeApHtp6f
 1gsMl+WCKHPkue/HnJ/iXE4vreblesTOAA1og03jskOBwEfhL5uP7Fe+8aQSm5/gzTFvBH1
 YqoKs8G2hUfdzwzRiTgLSI6aMc4fYNmzQgmsqCpFxDsRe5ei4MGGWclBEsEqjbQWRDgMA0e
 IfuXgOnst9RwSczzWZvUg==
UI-OutboundReport: notjunk:1;M01:P0:OpW6pFjGCHg=;jXbIK5FNNG1R8svyc2KoEoe1r8L
 /JuNdEHnM8rZ65i4HDjj26/EEDT2HRyrMt+Pg7+lF4wmigmAsIqswMt90oCJeyt62VSxOTeDt
 mUoy2qJM2zAl8JgAfcOBKUUQ0OXUzkk/NyGq8IkaLdOhwl/U9DBKwfE1imXo9y8XO7W8wMkFs
 LhEZeJRwQ0YICj2hntLj0K/N1Ckp4ymPSgy6tCw0RmYOfGTf61lz46li2PV6JHuFL3tkCXzwM
 UV4GRgvNGuCMZkVItE8J91uqiXcg/9as3G2xGHyKBkBAsMRlV/v2RSnaM6fXNGPW9oKTxOkVP
 /NCpzJATUnoXM6FyHFHydzCnKo5ahIsn7Aae9FNswanOiLT1T2UeG57BkyLY34bJoUor+vH24
 N5UfNwZ/u1HS8V1ODdyy/dFuUTUnFr71mpI5yvPjVbxBc6yIeTu7Smp58toUOJElYCiUfdq3c
 CmTbq0Ir4Gct6yiSjUYH14B0msbS9Ser+6ZeLGRmJUsiwy61Q00O4UbLbyt3teqOsj+6VC8RN
 0l4kUzuyLfFh5hLm6RMd3LzPGPkQLzTpjqU6xTzBMrvtIRc8cKrPmpookX3HW+xTxCv8FtJFC
 pSGddl0q4h5RFKPGgFD8GdFs/DDZGj2DrpvN2ZDhoVFtu6cNchJihSlmqPgZZwmQDUcwg/X4V
 LSYT/U38xPvBnxTvYplgIkJ5rcpuHwieqjoUbEG1A8g24bMovyBGwx8R4BgrkvjzBIjeQiTmf
 xXKpuW127U1/Yp+U3YCbXawG4rVjEg47jVeezACMF08vO87WyWfR9h64sqB0q1QtQKCXOGyl1
 RWGO/nWtvkQfvrThOaUbH00yA4mbgUoyyk8rs7IkTOH2LyIvPfV/rtXBQJduR6MytcomubwXY
 yUVtWiClgPVh9dS093KNDmaXjTd8d88CEXNcq+obe2rEYlUjysUXsy7bsk272Il84C5FhjyPD
 8cpm1cPZPncjNayC1UEkg11m6WY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1130246202-1692278521=:158
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 7 Aug 2023, Elijah Newren wrote:

> On Mon, Aug 7, 2023 at 9:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> [...]
> > >> However in a recent article
> > >> (https://github.blog/2023-07-27-scaling-merge-ort-across-github/)
> > >> GitHub says that they are already using git-replay (though not sure
> > >> it's this exact version or another one), and GitLab plans to use it
> > >> too.
> >
> > So there are plenty folks who are capable of reviewing but they are
> > not interested in giving it to the general public by withholding
> > their reviews ;-)?
>
> I can see how one could jump to that conclusion, but I don't think
> it's warranted.  I have a little information that might shed some
> light:
>
> -----
>
> At the beginning of July, well before the above link came out,
> Johannes sent me an email pointing me at
> https://github.blog/changelog/2023-06-28-rebase-commits-now-created-usin=
g-the-merge-ort-strategy/.
> In the email, he also noted my earlier stated concerns on the list
> (about releasing `replay` early possibly painting us into a corner
> preventing some desired goals for the tool from being realized), and
> tried to ensure we could still work towards having a `replay` command
> like the one I envisioned while also asking for my thoughts on pushing
> for the current portion of work to be published and included in git.
> My sense was he was pushing for the work to be released, but just
> being careful about my concerns first.

Indeed. The patches that are running on GitHub to support rebases
incorporate v3 of the `git-replay` patch series, and add a couple of
patches on top to perform rebases similar to how things were done using
libgit2 before.

> Unfortunately, I was on vacation that week, and sadly have otherwise
> been buried in coming up to speed on a new team and haven't had time
> to even respond to git-related stuff.  I didn't respond to him until
> late last week.
>
> I pointed out that the 'EXPERIMENTAL' banner addresses most of my
> concerns so it should be fine to move forward, but I suspect my delay
> has resulted in him now being buried in other matters, and in the
> mean-time the article Christian highlighted was produced by others.

The article was produced with my input, so I cannot claim innocence.

The reason why I did not respond earlier is that I wanted to have more
time to push forward with your vision of `git replay`, in a direction
where it avoids repeating the design of `git rebase`.

About integrating the current patch series as-is, I would be fine with it.
The best support I can offer is that this code (with minor changes that do
not fundamentally modify how the core logic works) has performed
gazillions of rebases in the meantime.

We just need to be mindful to keep that EXPERIMENTAL label until we fully
implement the design Elijah envisions. Which might very well need the user
interface to change rather drastically.

> Anyway, hope that helps.  I did review V2 and have been meaning to
> comment on V3 (and respond to Toon's comments), though not sure my
> "review" counts as such since I'm the original author of most of the
> patches...
>
> (And sorry for being missing in action.  I've flagged a few other
> emails that I'm hoping I can follow up on, but my time is currently
> quite limited...)

I haven't been a frequent guest on the Git mailing list, either, lately...

Ciao,
Johannes

--8323328-1130246202-1692278521=:158--
