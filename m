Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA1A20282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbdFSJa0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:30:26 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38398 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbdFSJa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:30:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id u195so56071538wmd.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QLarnISFHUfkH1RNzqJbbwnfgAzdLwkJKaJUsOs99vY=;
        b=akl2EFRCwuFJJ7xFzaJT7Fk9WdbOXxnDAioGf6E/tMsncJv6s3Mbp2yckSOU9DOAcO
         Tt1jdLrCTAcn5a/vvP1v0vbzrpcQNQ44TMotCNOyH+5tXIW+FsoGW835X7tY+CRTcbwW
         4SmKL5Kp9oOcfCbERJ+WOhtP0TIxq+n1qPrdqbHvc4XSjOm8MXzQ0yCD3r+hRJTZz5uy
         NzG92k7aZYRiRhOAZ2rwzSdkH762bFY9ryCgy2nvoIz3aHWu843Rp3ihbrneVUAFF6T0
         kIMs2jC8J9NnFBV2a/gnK8gRQ7Z/6KtATvYd8kG/oZbRY6jd/NMPkUebDpqU9hQ9UCSO
         ucaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QLarnISFHUfkH1RNzqJbbwnfgAzdLwkJKaJUsOs99vY=;
        b=N/xw2Jb7Ey+pLQ2c51lWhwNOA+GjQgHuLdNb74qiYzJMAcY2utG4m71LDWrarwq85G
         jHEcHaG8IQecONCd6JLihaw2piZDU+/fdC9b+xHVdO/h2PHDLgjeudjyTPiCvfA5G2E9
         hcv2Zw2eZ13iVnstkgxBvnTYpvb5CouTL1bTBs9ZMdLZyAfw3cyDLqvDTtbmKpBDiWcM
         eb9+2uYI5515wzIulEDhNbEk/DLNUCuA1LFu0+UTCCe/8eiLoWR2fPYgEj9cdyRhMnPb
         qfWIdcOhb/d87f4sRc0wuUo9WFEuEuW2SjtkVR3YoXYqHyAeCnV3cZHKyR8EnEBhzZyc
         u6JA==
X-Gm-Message-State: AKS2vOyk6zSRQ2D42y8Vql/uxfI7g/ocNsy4W9XMN4ovCF3xsoBM8z5E
        suk0+V3jYS7zM8vi/CY=
X-Received: by 10.28.151.207 with SMTP id z198mr15184039wmd.48.1497864624537;
        Mon, 19 Jun 2017 02:30:24 -0700 (PDT)
Received: from [10.146.248.54] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 130sm5797835wms.30.2017.06.19.02.30.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 02:30:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Restoring detached HEADs after Git operations
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
Date:   Mon, 19 Jun 2017 11:30:21 +0200
Cc:     Git Mailinglist <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 19 Jun 2017, at 10:46, Patrick Lehmann <Patrick.Lehmann@plc2.de> =
wrote:
>=20
> Hello,
>=20
> I wrote a Bash script to recover branch names after Git operations =
have create detached HEADs in a Git repository containing lots of Git =
submodules. The script works recursively.

I did run into this situation myself and therefore
I understand your motivation. I've CC'ed Stefan as
he is a Submodule expert!


> I would like to see:
> a) that script or algorithm being integrated into Git by default
> b) that as a default behavior for all Git operations creating detached =
HEADs
>=20
> That's the command:
> --------------------------------
> git submodule foreach --recursive  'HEAD=3D$(git branch --list | head =
-n 1); if [[ "$HEAD" =3D=3D *HEAD* ]]; then REF=3D$(git rev-parse HEAD); =
FOUND=3D0; for Branch in $(git branch --list | grep "^  " | sed -e "s/  =
//" ); do if [[ "$(git rev-parse "$Branch")" =3D=3D $REF ]]; then echo =
-e "  \e[36mCheckout $Branch...\e[0m"; git checkout $Branch; FOUND=3D1; =
break; fi done; if [[ $FOUND -eq 0 ]]; then echo -e "  \e[31mNo matching =
branch found.\e[0m"; fi else echo -e "  \e[36mNothing to do.\e[0m"; fi'
> --------------------------------
>=20
> How does it work:
> 1. It uses git submodule foreach to dive into each Git submodule and =
execute a series of Bash commands.
> 2. It's reading the list of branches and checks if the submodule is in =
detached mode. The first line contains the string HEAD.
> 3. Retrieve the hash of the detached HEAD
> 4. Iterate all local branches and get their hashes
> 5. Compare the branch hashes with the detached HEAD's hash. If it =
matches do a checkout.

If there are multiple branches with the same hash then
your script would pick the first one. Can you imagine a
situation where this would be a problem?

Plus, you are looking only at local branches. Wouldn't it
make sense to look at remote branches, too?


> 6. Report if no branch name was found or if a HEAD was not in detached =
mode.
>=20
> The Bash code with line breaks and indentation:
> --------------------------------
> HEAD=3D$(git branch --list | head -n 1)
> if [[ "$HEAD" =3D=3D *HEAD* ]]; then
>  REF=3D$(git rev-parse HEAD)
>  FOUND=3D0
>  for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); =
do

There is a convenient "git for-each-ref" function to iterate over
branches in scripts. See here an example:
=
https://github.com/larsxschneider/scotty/blob/master/admin/oss-fork.sh#L88=



>    if [[ "$(git rev-parse "$Branch")" =3D=3D $REF ]]; then
>      echo -e "  \e[36mCheckout $Branch...\e[0m"
>      git checkout $Branch
>      FOUND=3D1
>      break
>    fi
>  done
>  if [[ $FOUND -eq 0 ]]; then
>    echo -e "  \e[31mNo matching branch found.\e[0m"
>  fi
> else
>  echo -e "  \e[36mNothing to do.\e[0m"
> fi
> --------------------------------
>=20
> Are their any chances to get it integrated into Git?
>=20
> I tried to register that code as a Git alias, but git config complains =
about quote problem not showing where. It neither specifies if it's a =
single or double quote problem. Any advice on how to register that piece =
of code as an alias?

Try to escape ". See here for an example:
=
https://github.com/Autodesk/enterprise-config-for-git/blob/master/config.i=
nclude#L76-L94


> If wished, I think I could expand the script to also recover hash =
values to Git tags if no branch was found.

It would be indeed nice to see the tagged version on my prompt.

--

Submodule processing is already quite slow if you have many of them.
I wonder how much this approach would affect the performance.

- Lars

