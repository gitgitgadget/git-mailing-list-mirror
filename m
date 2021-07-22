Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D878C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4354C61289
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGVMi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:38:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:45109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhGVMi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626959942;
        bh=oxn7FwA/A8KBLZFb4lYzYDynJEMJ7DmfN4kFKqDqTa0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AgGgtIuJaVeMpA7RegY7M6urJVXa67uL/l1RT/MeLLqg4Ibx8Z/vC/dY4SZ7L3x/O
         xJ+bmTJ7/2ka2FIpcf+XxrMzx5rVUk8mzr4y42TeLsLc68UYXIw8ImH6kxnxRdyiH1
         MN4uolrhHwJg6FES/eaDLSHvT+qnH0k7YwPHuw/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.102.245] ([89.1.212.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1m28l41Zlg-004SA7; Thu, 22
 Jul 2021 15:19:02 +0200
Date:   Thu, 22 Jul 2021 15:19:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: 'git range-diff' does not detect submodule changes if
 'diff.submodule=log'
In-Reply-To: <e469038c-d78c-cd4b-0214-7094746b9281@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107221516240.55@tvgsbejvaqbjf.bet>
References: <e469038c-d78c-cd4b-0214-7094746b9281@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6z5R4uaFYbsCRlXka6Ak5kBqDuof6GxcZvqNQIRSi8I3Lr0kT0J
 vXujxXBbVBz2Q603/42863OqtagRp80lQYpMmK8v4hUUP3nTcMniiwdlzo/b3uu3nvLY6HO
 cu9gnQiqDjm6qJhOC/ZTw1AuIcqUMn5Frgax5IEUN/gHBPWDHvfCWOrSzCeIQFRH4QsFSl8
 d/DjMlUBuLXbh5AFEuzzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TGffa9AchrY=:IrontJzx29CbfQ2kRyxBJ5
 bC87QYNUlvX4YGHCx79zfTXF5oF9+f08lzjezo8BuhNzcDs3uI2NVMeVdZoJHh6dS1hqiZOln
 Lio8U0M35VzVk90ikcA/tgzQpKiDhJDGCb0iDfbrpB2dEquLIGKyotW1yeRUC8kFv5gxd4zrB
 pDcQ/U8Cwj3ieXGvgwmPBQ0EQADkR4bz4CeXQySehwcknyVYAG6RnCH2H0GEvTJrJTlqDvOI2
 9hSUFBYaWVHkWPoSBF1IY5BddbfWgXQ2jHw7Xr0r869BILzABKrwzdDq5K8Lpe1DIJ+9tWo8H
 RYeQz/4ZVeCnPAzj29i8MxxlKLDFFP1asBoH5qsMoJ8ROPZyKOzXazxyNr+2UtN9SYaqm5FaT
 lEdmKArhfKCriQ5WWPXqvMWaXQks+Si7Z2D++mJX+qRWUkx9GHpG/BAeq7FFMbxqFSYhABZwX
 xzb+jABIpBOvnXBjdGupQ0z3YqtjBZpxDjCofuavJupRr2CK3z+1ED49w+LdVWorTdTIsFQUD
 LY0X0GUQwr2QVl3sMy6JPlJZ0CfL58DayaIsP6I3hNrKn4CZR9Nih2d3SujgIrbhdbq4hoLn9
 RtA/YCm0Jx2LK3rwcqR2fQgobbmb2sZFh7/m2yDOsGYlsm9EsQVgmTCKFFjAiJNbpPV/t59GM
 io/d5C30QWx/5Ckw8Zd90JSbG3IcjIXSqXx7CnTK7r+VeyFHtHSwyd90s5VrgNWahu4zxYjUq
 CN2WVsKTHy6lPURSuEk6zSOax2Vxnj4gKXIQcnl7smQiO/h+sVd+GjPuIHNIMHCt8BRaLsoFo
 wV/A1oqzunU5THRejrYaRVuVOMqZynqZH8ZcGBuL98vjtU91XbLDCoG+afIDv5A3GCX0G6JCS
 UzFzfu7AbsAlrsgmqWSL3GWcvXU+lu77L7vjZwDDlIG5oVptID1qvwcXHrlLTPtJxIp4Sc/49
 xXRNP0+yqa03AFyPuCwK/U8Jq4OSJ/o9VKznZlNwF7EHfkyx0Amqt4otpkWqQN2+cRTE9KF6E
 jnw3uWukiMYxJ6LeIUM5xXxuYGNbNd2LhjjiMypeppbdC9BqDW8A7wlc/1TX15yXDn8Jt0M1o
 qUkso3RSdM61c+1/QbvEFSWzPKIlQJmuUQ/Vco9XJ3mfQ7qV5ZoIkpq3A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, 19 Jul 2021, Philippe Blain wrote:

> I noticed that 'git range-diff' silently "drops" submodule changes if
> 'diff.submodule=3Dlog' is set in the config. This is because the 'diff -=
-git'
> header is not shown in that case, and the code in range-diff.c::read_pat=
ches
> expects that header to be found to detect changes.
>
> If 'diff.submodule' is instead set to 'diff', the range-diff outright er=
rors
> with
> (at least in my case):
>
> error: git apply: bad git-diff - inconsistent old filename on line 1
> error: could not parse git header 'diff --git
> error: path/to/submodule/and/some/file/within
> '
> error: could not parse log for '@{u}..@{1}'
>
>
> I think it would make sense to force '--submodule=3Dshort' for range-dif=
f,
> something like:
>
> diff --git a/range-diff.c b/range-diff.c
> index 1a4471fe4c..d74b9c7a55 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -54,7 +54,7 @@ static int read_patches(const char *range, struct
> string_list *list,
>
>         strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>                      "--reverse", "--date-order", "--decorate=3Dno",
> -                    "--no-prefix",
> +                    "--no-prefix", "--submodule=3Dshort",
>                      /*
>                       * Choose indicators that are not used anywhere
>                       * else in diffs, but still look reasonable
>
>
> What do you think ?

Sure. I never thought that `range-diff` would be useful in the context of
submodules. But then, I am an anti-fan of submodules anyway, so don't put
too much stock into my opinion about anything submodule-related.

> P.S. As an aside,
> I'm  not sure why you chose to skip the 'diff --git' header with
> '--submodule=3Dlog'
> (I did not search the list), but I think that in general 'git diff' and
> friends,
> it would be nice to be able to still see this header even with
> --submodule=3Dlog...

I don't remember the details. It might be that `git-tbdiff` did it that
way, and I copied it without questioning.

*clicketyclick*

Yep, that seems plausible:
https://github.com/trast/tbdiff/blob/047d1c79dfada57522a42f307cd4b0ddcb098=
934/git-tbdiff.py#L48

Ciao,
Dscho
