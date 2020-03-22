Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7EAC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CC82072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PKCizHve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCVSHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:07:38 -0400
Received: from mout.web.de ([212.227.15.4]:42013 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVSHi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 14:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584900451;
        bh=/w+uF/xwezUKItUsJ/vAsNNQaY4gIF0xSzKqkZ5Crmg=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=PKCizHveim8afx4Am9TyuR7rFk3Olq3FOp/gSgPzS+v5gRPjkAxzm+1S7SLLO+8m0
         wmoARgJgUcmER9LxT2Nl9+Tc+Ma6Es5098Ck0QK3PzYWUSV1AwsLPbA7XuwGj3gzph
         fH7XqIvGQfHK+5IK6K5s33Ksr7jNQ6UagQPerGok=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3Spk-1jXbtL0fwG-00r2Pa; Sun, 22
 Mar 2020 19:07:31 +0100
Date:   Sun, 22 Mar 2020 19:07:30 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?Andr=E1s?= Kucsma <andras.kucsma@gmail.com>,
        git@vger.kernel.org
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
Message-ID: <20200322180730.57pe4awhglmmlxpm@tb-raspi4>
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
 <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
 <20200322165915.GA6499@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200322165915.GA6499@camp.crustytoothpaste.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Goixp1s3Mj4y+6ITU6ozm62GUkMctz6/QdocVaMqw2fxfBMH+XZ
 sjY0/iwcYfGlj4R9taQIEO+XBUvq4TfQecBt5zK8YiYkhlMlr2qc9CJ6gAl+soxjeJiAEOQ
 EM3ReAgThCKVyihZnGbo28SqjvpFesBigEji69AhM3QBnzkeoOX9EfR3FlK1xLA895/TzOL
 UJTZeq9VItNFa0wymqzMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWmpjTgKJ6U=:ItQPUQa5xAvWfFdiYUmJQx
 voVi9R1tIqtwmW68CmpIVWU/Pxq/B0YsILEb7wenCqKpchlHdnK7SDXQVCC0PpGBg0z31e9Pz
 ozS1EMwuaqBpgDEqJxNZRD3vYEi2U4ss0nUVLe3PLvl+/ly0c06Di5kkArvkkXI+Vvhc8+2Aj
 eE/KBJ1fJjPrHq5denUIsy6ekFpNKamWHt/3emYio2h9t6yB/+8gfDhhN7omadcXkYId/Cbny
 mNaAIYUo+5XgPU2k+B+LdJ7+wLCWsMrsPB3u/5nRjzDOnSHLDBeD8JsBrLdWGHQZsRrPQ4CqQ
 QJXXDicVcDrZwNA8M8tHqrYQoWcM1B4SBL9yJxcQ3zIPgjAATcuxEXeRvtD0YEvWPwVEc+0JI
 PVBlVNCll5q6Ea0EbqS3Juq26idKBtHyiyfonR5sDYsAdEaBeZrSX+H0DucbcrM439vCaImGC
 YxjQxDE24f+zEP4vTEHFzCK5Ej07EzN7Y6uT/eYf9L9cOmBH8x1hygTfbTA47aFtqmSuYS9nm
 LLA8XTwgev8kHFl8najxgGSglMMxyifK3byYiQQIg/pI6X3EyD/k9HFfvzgwa2xT7Znha/XTG
 imqx5pEhOGddf45Hz/6TvOcSGXdiNOT3l5eZK+f0KMaL9TigdcL8up6NxBGM2Eh1Iiw/rrZTg
 rYHZRUDIoGWPGobnqCln8mRj3gsFdWHBSOGEi4/akCfniWHu8BQGtA0I3IoZzlfyaq1wVg7oB
 35umyASJkUq4S98PMSzLqcA5Si9JG+PAtb2vhDGpYG1owZ3L0p/SyTN73hCHh6x3JWDYL4Hcc
 KBw+SIi8Wh+DHvvdOPXxbkJf7ia04lsFVeU2S0VOnn/R5plzvUurc5xmA9uVR8JFdLsJR3tj/
 xZHWvwBgD/+Wqzxukeb91kToM4uaDSbj8+JnPgvPZ2Z0RJcHcAdVhnmE8DSYtGYNVUCerhNC3
 gu+S+vB+KUa20IaRBoeeypnUc/bYBkfIpgLCn5S6gHP8McS06rLLVmbJdLPEX9lvkDEzFoyXY
 cgwbx/4Y8T0lsbTZRifmhCA1FHaNdi8wh4LyGNuIpwJ4VtuAsDqbqDHZOAfa/kl3Ydk1p8oIw
 sIcWSp0xsfpKWwfQ9m4rCVhTmmNwUGrYcOaC959XWZaqZhdjXvQSAWQxDuZQ+VbC4z1tBhjG6
 A8EIykCEzgxU+tJn9b6pEOmz+2A6fZvOO1dyiQE0vv8I2VueS3J/OQXyhlKaF5NBtyqkggKS7
 HwWg3ANckoQEFofFa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 04:59:15PM +0000, brian m. carlson wrote:
> On 2020-03-22 at 11:44:33, Andr=E1s Kucsma wrote:
> > My proposal patch is to take advantage of find_last_dir_sep function's
> > OS specific directory separator knowledge.
> > I posted the diff below, which is also available on github here:
> > https://github.com/git/git/compare/maint...r0mai:fix-prepare_cmd-windo=
ws-maint
> >
> > diff --git a/run-command.c b/run-command.c
> > index f5e1149f9b..9fcc12ebf9 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out,
> > const struct child_process *cmd)
> >      }
> >
> >      /*
> > -     * If there are no '/' characters in the command then perform a p=
ath
> > -     * lookup and use the resolved path as the command to exec.  If t=
here
> > -     * are '/' characters, we have exec attempt to invoke the command
> > -     * directly.
> > +     * If there are no dir separator characters in the command then p=
erform
> > +     * a path lookup and use the resolved path as the command to exec=
. If
> > +     * there are dir separator characters, we have exec attempt to in=
voke
> > +     * the command directly.
> >       */
> > -    if (!strchr(out->argv[1], '/')) {
> > +    if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
> >          char *program =3D locate_in_PATH(out->argv[1]);
>
> This function (locate_in_PATH) specifically says it is not to be used on
> Windows because it doesn't work properly there due to file extensions.

My reading is, that it dows work if you specify "foo.exe", "foo.bat".
And when you specify "foo" it may use "foo.exe", but there may be
a shell script called "foo".
But I may be wrong.

> I'm pretty sure a proper solution would involve touching that as well,
> although your solution does indeed fix the issue you reported.  That
> function also uses a colon-separated PATH, which I'm not sure will work
> in all cases on Windows (although maybe it will).
>
> From looking at this earlier, I think the problem here is that we're
> trying to use the Unix codepaths (on Cygwin) and then expecting those to
> handle Windows-style paths, which they aren't intended to do.  This is
> likely one of many problems on Cygwin.

Yes and no.
C:/MyTool.BAT is a valid Windows file name even under Windows.
Cygwin preferres /cygdrive/cMyTool.BAT
Git under Cygwin should handle C:/MyTool.BAT correctly, and to my
understanding it does.

Some interesting reading can be found here:
https://docs.microsoft.com/en-us/dotnet/standard/io/file-path-formats#path=
-normalization

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


