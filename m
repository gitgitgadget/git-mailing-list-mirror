Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD36C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A05610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhDKJiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:38:05 -0400
Received: from mout.web.de ([212.227.15.4]:37967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235267AbhDKJiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618133867;
        bh=ti0mhvoEjet0anG10bHIRu8geevobdKXzEv/8SUUa9Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ieXZQ+DKP5GLoCdduclI4/eOGeVYOfDyy1ovV755uD9D5jespim43MNQOxpYNbuWK
         r5JqVGpbAZDfICgpAINQAdL5Za55NfiSAeTVzCfJLPm5mmciFL1BSZrF7JDeyFQDfM
         4DcEUoV2XVksha+wfZtoVq6FyvxUBVc2m0XMbITE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UiB-1lkSrA1Kpv-00yPt9; Sun, 11
 Apr 2021 11:37:47 +0200
Date:   Sun, 11 Apr 2021 11:37:46 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-p4 crashes on non UTF-8 output from p4
Message-ID: <20210411093746.ymqofe2uawclwu5i@tb-raspi4>
References: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
 <20210409153815.7joohvmlnh6itczc@tb-raspi4>
 <CAKu1iLX1AyTCSGxDVgiR1cr4=4ODD-gn8jHAinhp7OhDChAf1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKu1iLX1AyTCSGxDVgiR1cr4=4ODD-gn8jHAinhp7OhDChAf1A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:0/7FnbRQcbQZfN7TaoBTLNn1V60QyN/UBgJn41PkBKeM07DBqpY
 02Qis2Vz6+3cbk15X9CPLOnGwOfjCKCPTRHa/CwDGE+uEaoIMVGZr/AjnvepNYMY47gWXDM
 Us7JhmQBvhXyUlXBd/CUt/ppHDhyJM97RD4hZ2b30aZfsY/ljlVq8dnMWref74gdzBzW5fI
 AcXZK6LpjZ9HoTEw6t2IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U2Z1r+H8yIU=:4J6PKph7ZuM+VwUK5BqGRz
 llouBEIuF33txOSF8I5zc4xDBne1L3zgm6i3exgas+BCptmKA9hv5VhboMsb9OnSn8oU8wZSG
 KcOb+ipjBYumHunjluLR4r9cKbPxvmzj/P1/MPm9EFFWu6BTaWAo3z5I+q9KVo3DFntUvPGSt
 gLCenl+6DIDTA0s9Laq4idrZt0YorezDSyVuY2rPSxCykLzcGqL629xNdovy23krdpDBUvxfc
 UpXSxVi3TIF3TnVs+jwHF+A6IgKeeR4qxXApZ4X9wFKSwaIVg2nTEJIgp89dnTyh68whzwMcG
 FEgwVSrN41D4nnTHAc114We7F2ViP7a0yhBCYruWgVcnhcrcRv3BT9bBJvfUx0mVswmwwVAv5
 DksWMjRUq1vRdMDrSRpXmA0YPm8Y3IrtpcfpRSmQAr93abxS3V601o+Gyd795+XX1TKTipomN
 0hFIwpkBGzGhG5PPwmjbeicD2clB2iCfcaW8CSTjViYD7pRMF8dNhm6ivLjvO7gRRuOXfVmLr
 8feu1dqxF1gQlC4C3HiTvz8tmyv06Pe1X5e3bQWKAmXKd2z54HdGJ8Kk2aXJr1ehHGEGgVcOn
 eZg4ZhWdoUKq5FHQbM/BVA9Kgopl5kAxHit/vy/sb1PmPiTfYxzt6hFN5U+zMZuYHyqvxiBCh
 IIqJQOvKk+xmwx2qPiQRLQSSc+MWcRh+nXMofQrCsnVEHGojTjVGG9udON2VyhhQ6U28IpJbu
 g/LKU8TsQTX+B8JFj8yjr3MYrvhf4J8c3zILEigA6CO1J3Epi9BGIqvZSnwoX3183kbYzm8zS
 dYzG9VjyQ9LUu9V/txkl9bSPqOQYIC89o0sf6TYCAzxQt3ESSa973ivdvwsOkh6FTJcNdaAO4
 th6nwrdlF3zjPB4QnpEZFIBPFJugwAVjuMU4pMNyXwX/z2mK8mYsFoVXw+fBlb0nGC1HdwbHr
 4Yn+jbDzmGa9bZk9DPKY+AsYry4OyUYlQi12630AwVryFFTGW53zil5+QoFPYBGiFfWJnvlve
 xTGuWTFdF8z09Oc4vwgXc92ZGaojvnaqY9dzpRAxQFK88cSjOo/5K3HC7+cDhRKa79zi252o3
 IPuUg+p80Bb+HB35MzZpyzbjDidvoNhYZlMVtE8/0wW1OCvis4Ww6RLFtHYQlvT8b1n/PoTpu
 0pqKj0g6Z07Wt9ywvoGaqEALd7VPbDhmKJEESW41mjA16JJpas2HjV395fOGk7VoicRsU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 12:16:25AM -0700, Tzadik Vanderhoof wrote:
> Here is the pull request:

Thanks for the work. Some comments inline.

>
> From 8d234af842223dceae76ce0affd3bbb3f17bb6d9 Mon Sep 17 00:00:00 2001
> From: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
> Date: Sat, 10 Apr 2021 22:41:39 -0700


The subject should be one short line, highlighting what this is all about,
followed by a blank line and a longer description about the problem and
the solution. The original description was good, see below.

> Subject: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
>  git-p4 from crashing on non UTF-8 changeset descriptions

In that sense I make a first trial here, subject for improvements:


Subject: [PATCH] Add git-p4.fallbackEncoding config variable

When git-p4 reads the output from a p4 command, it assumes it will be
100% UTF-8. If even one character in the output of one p4 command is
not UTF-8, git-p4 crashes e.g. with:

File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
    value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
decode byte Ox93 in position 42: invalid start byte

Allow to try another encoding (eg cp1252) and/or use the
Unicode replacement character  to prevent the whole program from crashing
on such a "minor" problem.

This is especially a problem on the "git p4 clone" command with @all,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

Introduce "git-p4.fallbackEncoding" to handle non UTF-8 encodings, if need=
ed.

>
> ---
>  Documentation/git-p4.txt | 10 ++++++++++
>  git-p4.py                | 11 ++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b..71f3487 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -638,6 +638,16 @@ git-p4.pathEncoding::
>   to transcode the paths to UTF-8. As an example, Perforce on Windows
>   often uses "cp1252" to encode path names.
>
> +git-p4.fallbackEncoding::
> +    Perforce changeset descriptions can be in a mixture of encodings. G=
it-p4
> +    first tries to interpret each description as UTF-8. If that fails, =
this
> +    config allows another encoding to be tried.  The default is "cp1252=
".  You

I know that cp1252 is attractive to be used, especially for Windows instal=
lations that
use Latin-based "characters".
But: If we introduce a new config-variable into Git, the default tends to =
be
"if not set to anything, behave as the old Git".

> +    can set it to another encoding, for example, "iso-8859-5". If inste=
ad of
ISO-8859-5 may be more portable on the different i18 implementations
than the lower-case spelling.

> +    an encoding, you specify "replace", UTF-8 will be used, with invali=
d UTF-8
> +    characters replaced by the Unicode replacement character. If you sp=
ecify
> +    "none", there is no fallback, and any non UTF-8 character will caus=
e
> +    git-p4 to immediately fail.

As said, before, many people may expect Git to fail, so that the default s=
hould be
none to avoid surprises.
When a "non-UTF-8-clean" repo is handled, they want to know it.

> +
>  git-p4.largeFileSystem::
>   Specify the system that is used for large (binary) files. Please note
>   that large file systems do not support the 'git p4 submit' command.
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93..18d02b4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b'=
,
> cb=3DNone, skip_info=3DFalse,
>                  for key, value in entry.items():
>                      key =3D key.decode()
>                      if isinstance(value, bytes) and not (key in
> ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> -                        value =3D value.decode()
> +                        try:
> +                            value =3D value.decode()
> +                        except:
> +                            fallbackEncoding =3D
> gitConfig("git-p4.fallbackEncoding").lower() or 'cp1252'
> +                            if fallbackEncoding =3D=3D 'none':
> +                                raise

Would it make sense to tell the user about the new config value here?
 raise Exception("Non UTF-8 detected. See git-p4.fallbackEncoding"
Or somewhat in that style ?

> +                            elif fallbackEncoding =3D=3D 'replace':
> +                                value =3D value.decode(errors=3D'replac=
e')
> +                            else:
> +                                value =3D value.decode(encoding=3Dfallb=
ackEncoding)
>                      decoded_entry[key] =3D value
>                  # Parse out data if it's an error response
>                  if decoded_entry.get('code') =3D=3D 'error' and 'data' =
in
> decoded_entry:


Did I miss the Signed-off-by here?

Please have a look here:
https://git-scm.com/docs/SubmittingPatches

(or look at Documentation/SubmittingPatches in your git source code)

And finally: Thanks for the contribution.
Is there any chance to add test-cases, to make sure that this feature
is well-tested now and in the future ?


> --
> 2.31.1.windows.1
>
> On Fri, Apr 9, 2021 at 8:38 AM Torsten B=F6gershausen <tboegi@web.de> wr=
ote:
> >
> > On Thu, Apr 08, 2021 at 12:28:25PM -0700, Tzadik Vanderhoof wrote:
> > > When git-p4 reads the output from a p4 command, it assumes it will b=
e
> > > 100% UTF-8. If even one character in the output of one p4 command is
> > > not UTF-8, git-p4 crashes with:
> > >
> > > File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
> > >     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> > > decode byte Ox93 in position 42: invalid start byte
> > >
> > > I'd like to make a pull request to have it try another encoding (eg
> > > cp1252) and/or use the Unicode replacement character, to prevent the
> > > whole program from crashing on such a minor problem.
> > >
> > > This is especially a problem on the "git p4 clone" command with @all=
,
> > > where git-p4 needs to read thousands of changeset descriptions, one =
of
> > > which may have a stray smart quote, causing the whole clone operatio=
n
> > > to fail.
> > >
> > > Sound ok?
> >
> > Welcome to the Git community.
> > To start with: I am not a git-p4 expert as such, but seeing that a pro=
gram is crashing
> > is never a good thing.
> > All efforts to prevent the crash are a step forward.
> >
> > As you mention cp1252 (which is more used under Windows), there are pr=
obably lots of
> > system out there which use ISO-8859-15 (or ISO-8859-1) we may have the=
 first whish:
> >
> > Make the encoding/fallback configurable.
> > Let people choose if they want a crash (if things are broken),
> > fallback to cp1252 or one of the other ISO-ISO-8859-x encodings.
> >
> > In that sense: we look forward to a pull-request.
>
>
>
> --
> Tzadik
