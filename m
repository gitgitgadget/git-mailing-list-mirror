Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F01CC433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A252074B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ra4OqIsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFHWqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:46:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:48223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgFHWqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 18:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591656385;
        bh=xrcR1b+ijF/LkBE8Iqyi7Y7f0bMG87kXAbk2OyOe+F4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ra4OqIsKsuIiD/SDxvDdn5GzcKpxxt+VaKn/EObkfPJZsjrjd01xfnbycabU/wkIs
         Yvxb+k5g3rvKJ8q8fxoMU3kQ7/wObN/gZWss9sq6awKuDpQLq7UOVMM6ctLMpZ14tq
         OTBxUCrspb+NGSQnA/86l6Cw3R1mIkWCo+N4E8i8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.24.170] ([89.1.212.67]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1jQ4Ae2OjF-00IzXY; Tue, 09
 Jun 2020 00:46:25 +0200
Date:   Mon, 8 Jun 2020 19:39:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-QA14EDB.localdomain
To:     Steven Penny <svnpenn@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Change Native Windows shell
In-Reply-To: <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006081935530.482@ZVAVAG-DN14RQO.ybpnyqbznva>
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com> <20200605000039.GB6569@camp.crustytoothpaste.net> <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:foHiLEQwa4d8VHFhUhesghA5G3TH0pPdHHd8MKg27aES4yiK6Da
 Qbwda8vam7uasoxtdIyeGNV7nmVW+jBUVnxJw/p39lEpzixVnWu/v89noQ7P2tmPmQfz2L/
 /2c6I4vDlTS3ts7OPoaKgzvVf62bO8S54W383of2HwboAhuYyInbvB7cXods51du3dduQvV
 DkH6XvVyp3Fdc9Z1M2pRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwrFXE4WZYM=:Dix3USf6u7kLOf/r5cJdWb
 1pOnxHBpHBnZ0Ru6NmNpmDvdSnIw17oQNzBqSqBJPyQkksXc2WtV9Qx82vJaWpffoIVUPd5Wh
 Ca8J+UzIbQz6gW1LYW6BGJ9qw6LCKBWWP916uO/ocWNk2GTy213UyTPKm4SuCnNYODo0BxBF+
 b8nJkgYWVL0FYvWI0Ml6PupcGJeUus61AYuaqQTKAt12wvpJVaVtSCaWAC6n/c48qIw//VpSU
 r1kVtKQq62YVAlUeiKflraymvA9XQJ3xW0HTiFTJ0UpnA/GJuglAT1F9MhSz9qkynbVdTCH7k
 IY0TfnW7DwdFWhccGlUJvO0bZTg1XixHpR6vhW4/oS1CyxQGoxiG9zF1mrIHkbMyENm+Mirh7
 qKahKPKSNZFEpo1Ek+FmAGu0QCrXwr9NOyUDYarEqLYcN4ntlmlES2bRRXSLU5erMuUjAse+6
 mIPbpsLcjY0uwxP5Bbbj3jxcoqflkLt5VBX4FThaWAXtR0XE+1KgJvj2l77HYrk3yozUwhl7H
 nMI/TYU7dlqfvn9AvTdnQLVy0UHs/IIKxcrx8lDCrDsbbm8ZOKdYBG1SgESK1INHjDrxgKTzi
 sRVveywl5LxZ4K9gJeHhj5J5uOVoSey+6JSSKqS3x6YUcD30erfLPVG930VSvNZpgNpX/64s9
 re4yLpgKBn56qg6tDI5Dc55FSu+asUB718zcFiJfVLCFhGIbzVmB3dYfHGFot077IE9M+1v8a
 +w7aJkr1BPxWAgC8NR1E2gp3TCiWBYyJj6+jURtRDB+UBTc0lqGPj+hrhY4sX3BTu9N2u5HDA
 /05yDy4ncrCySPWVtnEjUUWNbxvcL2ca0GEdj4+XSxjsrnezxe1b9Zx1Xl7vOZsQuSC7HpRMM
 cgH7dFGBr+HfUkkmzDzRSLJAjInP9RW9U/2CxechUPZOUQ9lUkFcDU5+U66sPlFdqkoUKehEs
 T3NM+WYUfBPYY34bmUU8ow8JJpD3uZQ57w6t/sIAuYrB9OgVkzLKWjG1/SmkS3DEfPEkYqIWZ
 D/MUHFE/HMHuuWolgExSGtfjeO5ufqb62hp1V4J/LsuTw3Tq3gizxgxY5Vfg8ZTmWsp39Kyhs
 OPbtdNGoy3hQl/2gJrzkR1hou2QC5VCOxyOYIp3vpdJZ5ZGE0pH071i75R6IBJgyjpmoWktjn
 DZvLKwjNuT40Okf3xi5kJd49wHLqcWeR0TYzW0j9J7UFJTSpz2RKunl2iPcLILz03LBuslt5m
 sBw1YnSbIIfSAYnP4
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steven,

On Thu, 4 Jun 2020, Steven Penny wrote:

> On Thu, Jun 4, 2020 at 7:01 PM brian m. carlson wrote:
> > If you really need Git functionality that doesn't rely on sh, you can
> > look into libgit2 and its assorted language wrappers.
>
> Uh yeah, no. Im not reimplementing the entire Git program, when the fix =
is 7
> lines. Here it is, if anyone is interested:
>
> diff --git a/run-command.c b/run-command.c
> index 9b3a57d..4945632 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -271,9 +271,6 @@ static const char **prepare_shell_cmd(struct
> argv_array *out, const char **argv)
>      if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=3D%") !=3D strlen(ar=
gv[0])) {
>  #ifndef GIT_WINDOWS_NATIVE
>          argv_array_push(out, SHELL_PATH);
> -#else
> -        argv_array_push(out, "sh");
> -#endif
>          argv_array_push(out, "-c");
>
>          /*
> @@ -284,6 +281,10 @@ static const char **prepare_shell_cmd(struct
> argv_array *out, const char **argv)
>              argv_array_push(out, argv[0]);
>          else
>              argv_array_pushf(out, "%s \"$@\"", argv[0]);
> +#else
> +        argv_array_push(out, "powershell");
> +        argv_array_push(out, "-Command");
> +#endif

That assumes that PowerShell is installed, which is not guaranteed,
either.

Besides, quoting rules are most likely different with PowerShell than what
Git assumes, so you will have to take care of that, too.

Finally, there are plenty of tips out there in the internet that simply
expect a POSIX shell to execute those script snippets. Any user would be
completely (and unnnecessarily) puzzled if those snippets won't work with
their Git for Windows.

In short: it would be unwise for me to accept this change into Git for
Windows, at least as-is.

Ciao,
Johannes

>      }
>
>      argv_array_pushv(out, argv);
>
