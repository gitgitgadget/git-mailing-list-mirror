Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358403AbhLBPGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:06:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:44897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358601AbhLBPFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638457315;
        bh=o8ZRQH1tOZGt8mhHM0H9s/65nf9WbUZtBEkDjAJFJ3M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MvEdRA3AvovYleTRUh7KDUyFsHkvosfmIuq0zUbT7cmtv5zNm7CqzgxK+T68SDr/+
         OEYQ/c7WEjSqx1yktxC6oXsvRYQ2AGnM8KhEzi9DIdZAB2CGs4KCizGa1O2jAQZSxZ
         hQUQ9/dBXkIq1qZ3whPu8jvFHyiBb8dQQML4+DYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1mfeKY0rfF-00veW0; Thu, 02
 Dec 2021 16:01:55 +0100
Date:   Thu, 2 Dec 2021 16:01:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
In-Reply-To: <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112021557530.63@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com> <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ubMTy/hvyHpz49gxX9RBnDaNvTXgKVkhYK5bOxaAC8OW4UWHPVH
 lNQzKxSU4rVBYtAC2b+7SH+wsHlwxi0+cVCgqp0N8qxm+dKvTzwezMYyDBt8T9sHuRASe8V
 8s1GLnyqrZeyK9iiaqUpfWYUiMtOAouOkuDG+/XRoBL3Z8W4BqkUCrIYTYCGh3MltuuTzVy
 gksqdwcrpicGrxw3cOuQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4uygwPn6q9Q=:j5Il0bgDMcAAMTWgBXkO5y
 5CDT+xJtSP/E+2NW8szRo+EuozQNDzCE3XjCXNtMXdI1XQFKCDzL6bB3zqWh/1NZWuFFI/D/n
 8F8mdj6WcWMzWhzCvoz3F/k9FAl/UgB3vzEubW0qcu4gXLMqpLdBANcyhVRv31gVZm3FpOwzt
 ePebOjUjVzCakSk1XRwHQbLC5e5CtfVzoZLXE0MFRGqajQhD5KUxYLBnfT7Ft4f7LCSnXzry2
 DC7HuKxpt5+BV0A26kCOxTTIt4ieY6kQY3caU4jUJwRIH9kno8F4VQtE723ZLoW8nHwoGRYtO
 u6u/QQ/pb8VfIu6heZUUeWWKOHdVZj1T+Da51asdMUtoEaPdC3yr2gI7fXalXy+zDrYhnvu3o
 +9kbRcMzvHPjBwBjTIGoQb3JMLFDpO9ETAr0bcKzMwocgiCuRt1euNZvSKQZHM4jwNqMtqGqZ
 NTrQNK0yVYdUWnMaO+8/ns3sN5rZ9NryU1qlNKQ+AdelQiB7U/t8RUah+oksfn3xsslatAWqI
 UvSFgFAZM2JcJ1pVES3lb14bDTAZe44Y1nVnSfyv+6T58ZDqddB5ETW36JjaSOIyBIEFgngzW
 LfJErBe8I+X+/xPvpSLyMjPFXXXIa5O+XEXCiL2PrYNZmCwKcAS5AWmxI6uI0dE9Yj5K97zS+
 xBiFGOREamF5lhmIaaYPPBaBE92MkJuuRJsn8g6UDmFIVt0ZiIJoAXnT0iCku8qbBfv1HV6oU
 dSBpro7isvOLh7I8O4K5yrnGTCMrBiBoQ6AI4a1T75Ylr06+anja698vrMaRej+amLYfQYgZd
 hYpDd516zT7MwZuOSg6PRUbKFunU1aJQow5U5ITAl7mOBwb0nfxRVz19Xm0F5s37JmjwpPjbm
 edrwvK3l7iKiW1gcRfJAN9096Gw2pM+PI7K2zAU1wwHRXSypLPL6Fk3zOQiXrgJSCEbbuG/aE
 gdI7uZSE+08VrSs5rKVo4Y0OHmqSbkX4XS2qJ/8qbja+3qejwya7zn2zdmvcER7jSDhd7F1NV
 Uq/LUxh+ZKiNvSHHCTT8be/91rZ/CJ+YjwM4Xm3V1mIgaYj6DM3axb6AVaexofq+Y7btkguvy
 ZBLhGDzjfMBcDI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 1 Dec 2021, Phillip Wood wrote:

> On 30/11/2021 14:14, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/builtin/add.c b/builtin/add.c
> > index ef6b619c45e..8ef230a345b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, co=
nst
> > char *patch_mode,
> >    int use_builtin_add_i =3D
> >     git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
> >   -	if (use_builtin_add_i < 0) {
> > -		int experimental;
> > -		if (!git_config_get_bool("add.interactive.usebuiltin",
> > -					 &use_builtin_add_i))
> > -			; /* ok */
> > -		else if (!git_config_get_bool("feature.experimental",
> > &experimental) &&
> > -			 experimental)
> > -			use_builtin_add_i =3D 1;
> > -	}
> > +	if (use_builtin_add_i < 0 &&
> > +	    git_config_get_bool("add.interactive.usebuiltin",
> > +				&use_builtin_add_i))
> > +		use_builtin_add_i =3D 1;
> >   -	if (use_builtin_add_i =3D=3D 1) {
> > +	if (use_builtin_add_i !=3D 0) {
>
> This could be simplified to "if (use_builtin_add_i)" but don't re-roll j=
ust
> for that

I was actually considering this, given that Git's coding practice suggests
precisely the form you suggested.

However, in this instance I found that form misleading: it would read to
me as if `use_builtin_add_i` was a Boolean. But it is a tristate, it can
also be `-1` ("undecided"). And I wanted to express "if this is not set to
`false` specifically", therefore I ended up with my proposal.

Ciao,
Dscho
