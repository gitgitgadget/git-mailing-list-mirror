Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C7C1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 23:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2W76 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:59:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52011 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2W7w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:59:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id v21so13269617wmc.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HQSRk+fVB+H3PA9XpkOGP5chp3fx4ei7fcrlkRP7mQU=;
        b=NEh/Rpa8gRvrWIVa5Ec9HFdjAB6cwx6C3aHGL9Fh59xE6jUXgR8dYNbYlD9rlUfWKU
         wssHNOlVRM/EFqPQJxPe1TMl9s8j9RaTgjn06A9xh32LEjNkxWnx8qIvpqpmgZHzTfb2
         nOQlRMX9mss7Z9nyU2aXr9Lp16mVYiVclvxpUziUxEWJyE7kA4/Nm2yXBx3BE+FpGRwp
         NUdIh9FvsrQnjEeKoZ6K1XmE9vGYj3KyG00QjpdlOyllhe394QBbgoof+Wdbe/+pq4XI
         T+eNSilhhnjaiotmZuIllRq6YS1JFYOBNh9XxR61QKxRKXvE5eZ5zKa7b7DCx/AvUuI3
         N+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HQSRk+fVB+H3PA9XpkOGP5chp3fx4ei7fcrlkRP7mQU=;
        b=qIt/EFjAaADsg09W8dGKdd+t857dY+KIiR/TrkfvrlIa+H8B18sV6TMhUA8TCUPb4b
         InIP1rElhitPSZNW1e2xI2Q+luGxqqsIBuS/ouxyIxWPsi7Cw+x68zgRUB5EQDRP4oYq
         IvZTaJFKhdpF9uXx2jtV6HvOjsUDPTJIbUjMK/nepOzXfA2VqSayK9ET9/kJzo5aY87l
         VnBFaHhl7rdARAJgWXT9B7mNDGMDgGVFvILV0NsMUFHx1WmUg/z5ZWkBU/vLaqudivVv
         diybanC/UX3Og8l4g6H2uwkpGL+1ukdc9wNjSI8T897i5ymfnYhXBymeZfOGYL1JMQfz
         0JOg==
X-Gm-Message-State: ALQs6tCYvdvEPtNJfumQ/JZv5ZWT2MWhQVmUeGeEsJE4WagfS3kLcZuv
        tqsq0Gt4Fwyzh8LdmJHiQYdP5KNezcQgK2CD8cw=
X-Google-Smtp-Source: AIpwx49paaH6u2jhTCoOMJAdTCSyRLfxPPBEVAY3DXw/RQA6eNLprezXItNfrBVIJnDQwQzJHFAgHQV6dEZFMwyoXbg=
X-Received: by 10.28.24.17 with SMTP id 17mr618784wmy.128.1522364391519; Thu,
 29 Mar 2018 15:59:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.208.210 with HTTP; Thu, 29 Mar 2018 15:59:50 -0700 (PDT)
In-Reply-To: <20180329225502.20112-1-eddy.petrisor@gmail.com>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com> <20180329225502.20112-1-eddy.petrisor@gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Fri, 30 Mar 2018 01:59:50 +0300
Message-ID: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     Eddy Petrisor <eddy.petrisor@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+list)

2018-03-30 1:55 GMT+03:00  <eddy.petrisor@gmail.com>:
> From: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
>
> There are projects such as llvm/clang which use several repositories, and=
 they
> might be forked for providing support for various features such as adding=
 Redox
> awareness to the toolchain. This typically means the superproject will us=
e
> another branch than master, occasionally even use an old commit from that
> non-master branch.
>
> Combined with the fact that when incorporating such a hierachy of reposit=
ories
> usually the user is interested in just the exact commit specified in the
> submodule info, it follows that a desireable usecase is to be also able t=
o
> provide '--depth 1' or at least have a shallow clone to avoid waiting for=
 ages
> for the clone operation to finish.
>
> In theory, this should be straightforward since the git protocol allows
> fetching an arbitary commit, but, in practice, some servers do not permit
> fetch-by-sha1.
>
> Git submodule seems to be very stubborn and cloning master, although the
> wrapper script and the gitmodules-helper could work together to clone dir=
ectly
> the branch specified in the .gitmodules file, if specified.
>
> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
> ---
>  git-submodule.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 24914963c..65e3af08b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -589,8 +589,10 @@ cmd_update()
>                         branch=3D$(git submodule--helper remote-branch "$=
sm_path")
>                         if test -z "$nofetch"
>                         then
> +                               # non-default branch refspec
> +                               br_refspec=3D$(git submodule-helper remot=
e-branch $sm_path)
>                                 # Fetch remote before determining trackin=
g $sha1
> -                               fetch_in_submodule "$sm_path" $depth ||
> +                               fetch_in_submodule "$sm_path" $depth $br_=
refspec ||
>                                 die "$(eval_gettext "Unable to fetch in s=
ubmodule path '\$sm_path'")"
>                         fi
>                         remote_name=3D$(sanitize_submodule_env; cd "$sm_p=
ath" && get_default_remote)
> --
> 2.16.2
>

I am planning to write a test case in the next few days, between the
few drops of free time I have.
I am still trying to figure out my way through the test code.

--=20
Eddy Petri=C8=99or
