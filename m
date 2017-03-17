Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55BD720951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdCQTz3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:55:29 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35543 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdCQTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:55:27 -0400
Received: by mail-pg0-f44.google.com with SMTP id b129so48077995pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sGH5+NcImgOItcKcILQP9qqKeG8mLa/W918RCUjniHo=;
        b=VXSGRaMYL/+nATlQVzQ93nQscDvsyyDYMVZFQHAG+41mXl2kaOz+CvxiboWaLlGlr9
         qscC0qVz4J2SUod6DAEbI3rxta7vmAoT6zOQwJDhA/YVB8GQ8NjgSwHVNp/WzeGZhZli
         EfYgzZRGWFCb9nB/zauwV3A02FJjxlpcUuRCy6WlbFhgzJuHsPjpX3iM9SLGlM1BkPTJ
         cZjtQTMArrhTb9aCfPfRUyNIUhtWhhXz9/SE/aFtgj+OUIJBWRETlJ8YnqYFP4mJzeRT
         mI3c4soXp26rEpZRNNCO7evGTwUdiFR3/Pyb7Xiuwg+TH4UZA9H/KYCsJb0SfM+GIJ+p
         uA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sGH5+NcImgOItcKcILQP9qqKeG8mLa/W918RCUjniHo=;
        b=n31E+YjnDK+tofn+02yXSHga2N3PU6yUHqCUQearNv2nhEM0X+pdunzEWiSF0q/XGQ
         wvXby0jfLTqMVswpXWqg4NfOwX9Oqr9NyWXe6VtM6HTLYPigG/7adYOwmw/4qI41QW0n
         WpXH49NoAyMAlme6Ep2v38Ss0jevkw+ACyAQUSyjzr3v7RY3b5gIVdmgDDSKon+lECtm
         WZnqGBQLtGOv2/SOEv6y+BWFrvRd5IgbdGoFNnXgWFf6CETjJZ1d2bbT5KLX6xj3uam4
         Aw3VWVDqupgRGswUgXr7IFYqv4Od4CznLp5RQ6cLsDODO6Twwh7DfIfdJTVh+ip0+yDD
         D0+w==
X-Gm-Message-State: AFeK/H37L/cHEg00r/rFxckBug5hRVb7dEVo5p1iTfgDn2F7xd15iGuoiv9uXTTvl/5QHM+BmfJKGN38gQwYMhjV
X-Received: by 10.98.44.15 with SMTP id s15mr18712562pfs.161.1489779912121;
 Fri, 17 Mar 2017 12:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.180.134 with HTTP; Fri, 17 Mar 2017 12:45:11 -0700 (PDT)
In-Reply-To: <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
References: <elvahoiwfqayelbskykd@qjih> <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de>
 <hpulcgxossrwvfbbcvcl@zndn> <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
 <ogwsaxvtiqlsiwojzxul@owpk> <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
 <tskgutqgpyszzedvyfra@prol> <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
 <ffntuqzgjgcfhebokbty@eduj> <7f25def4-9943-ae59-a649-b4348a79890e@web.de> <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 12:45:11 -0700
Message-ID: <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 12:34 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 15.03.2017 um 22:30 schrieb Ren=C3=A9 Scharfe:
>> Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
>>> $ git bisect bad
>>> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
>>> commit 7333ed1788b4f2b162a35003044d77a716732a1f
>>> Author: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> Date:   Mon Jul 28 20:26:40 2014 +0200
>>>
>>>     setup: convert setup_git_directory_gently_1 et al. to strbuf
>>
>> That's what I half-suspected, and I think by now I got an idea.  Here's
>> a test program:
>
> And here's a patch for letting strbuf_getcwd() use the same getcwd(3)
> extension that pwd(1) uses.  It avoids the need to guess the path's
> length and thus reduces the chance of stumbling over strange error
> codes.  I wonder if it helps in your case.
>
> Ren=C3=A9
>
> ---
>  strbuf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index ace58e7367..4c02801edd 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -442,6 +442,14 @@ int strbuf_getcwd(struct strbuf *sb)
>  {
>         size_t oldalloc =3D sb->alloc;
>         size_t guessed_len =3D 128;
> +       char *cwd;
> +
> +       cwd =3D getcwd(NULL, 0);

from my local man pages:

  As  an extension to the POSIX.1-2001 standard, Linux (libc4, libc5,
glibc) getcwd()
  allocates the buffer dynamically using malloc(3) if buf is NULL.  In
this case, the
  allocated buffer has the length size unless size is zero, when buf
is allocated as big
  as necessary.  The caller should free(3) the returned buffer.

This sounds specific to Linux (though I am reading Linux man pages,
which claim this; Also it seems I might have misread it as it also states
"The pathname is returned as the function result and via the
argument buf, if present.").

Looking further:

  These functions are often used to save the location of the current
  working directory for the purpose of returning to it later.  Opening the
  current directory (".")  and  calling  fchdir(2)  to return is
usually a faster
  and more reliable alternative when sufficiently many file descriptors are
  available, especially on platforms other than Linux.

Not sure if that opens another door here?

Thanks,
Stefan
