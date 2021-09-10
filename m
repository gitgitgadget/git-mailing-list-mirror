Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202CC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732F761051
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhIJLY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:24:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:53949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhIJLY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631273023;
        bh=lEVoGAx5uYB3J9jAQyNhNWZYNF2Scpt6qswE+uv/qFc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sa/ZkWeyXy65fyGYPbXy0xfa58KWf1cpHuHVlBlSJaVhjov15u4cSzCN6ziwfb/Uk
         Z9adrFVeaR9JjHw9RS2lktx+cF43LZhziyMASEtMEoy7iRCVKfpuIng9gI+kgsCkMh
         ifPdcu1aPd8HFl2suPmYl7INZ12SRhamSZKDEsNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1mlOmW3IhS-00oDov; Fri, 10
 Sep 2021 13:23:42 +0200
Date:   Fri, 10 Sep 2021 13:23:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-tool run-command: fix confusing init pattern
In-Reply-To: <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109101319110.59@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet> <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2066968464-1631273022=:59"
X-Provags-ID: V03:K1:n/FxwxZxz/lCcGlv3DVu/JG+B+lBK8CcHT1dTqqKcMgwsWWXbTK
 YApFTrBLGTMkODp3OwacKVQNyR4J94onOgsLoe52QnvOkCNYBkZdcMER4WHXuSDZxp15cmR
 OdSF8+MKjanW060+KLCbSthoA+mRiCA84vfn3xpQmZTlKaL5nQyXegGrU8KmD9ILzoJHi0/
 MLndC5QXPItAuIqL7LtbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nRXMPI2vfog=:Z664GxjqLuY1E2X94tHpgX
 h1i/1zcbY2v8rJQi58RypYe1wGZMsrq3CC32sxn5E+VbUdkA+QOYFdQDzGVRKws0fdIwQxLCO
 BdoEp8UzVlnDNUvkyuqgofsnlXIf8qdRmFeXNl95tGYewg/A2kY1iEF9nPut3CLdwc0iWqpBG
 mI3aLj/q98oTwwWBLwLqicXrW6w2yU56mOjo8hq6tLlvRs19SujO5+2C14tqeVlTT/LZ1Sgro
 3GATONbpgv/i6Zx7ejpSsgHI2+Y5BP75aprn8Hn833f8McMMOa6ciW+zlq33nCPq5WJVE0wjF
 OPyDe/lJvcmDc4eQUbIh0N52ls1sdZmI488ABoBPMQzJd6t41VX1/leTbEqdzEnv3cO3SyuHA
 N7dBivXE8oEJPJPJxhr+oIRBT3TIbN21UULVBfb48lEt7YO7IfYnrqWCdD1Ai6gVdvLJ4YAWS
 CzMKDgyN15t6/P7Q16B/cSKBqrp2kIwVvPGEEiBQnWIiHc+J+d6InKhTrrAcVV+fDvgH+yTEa
 IDBl/Y5t6Fl4Q6F91vrRwl70+92/uSjoXNz3ntBO23WHUH/8hvdrYgajBXJWGh+ILTyh6fyeH
 RGLXOhoAqAqilzqJxBMCeQZyxHyK9bGBLgbbgPFfExAASaRj/z9MxvXiJe9zsOGSjGvVePsOl
 3JEBC/72K5QobjPVUlQTuuRRMBbjO4EjWF9+iUa8egbhV5zqYUWQ05VxB3RNCkdMdDuJpCGf+
 4Bvvd9GJQ+rRMzaRPQ8GxaisC8TGiL21pOLqqTfuoBJo/NbiF/BdHE8L0rnTWqWjDz5AzTVft
 fGdC+2SnvJmzxY+eEKuxIXN7jYHcOP2YP//Nmx7/0zsf0Y6KPy+tBy/49iTQ+SZRbuz0crfBH
 S6Rwvc8BTAWhUexuSzYMhKeuiWDdUPWIFDYmllCSe0Wmr458hIGdwax4DaVCO2uVE6nUIoMWb
 P7Cn3MCLHzuO0aHZQs8kvlqR4M3umtxlUGm7NjzuAmKIzimDHsYlsyuDDGi1FElYloE3YrejO
 DwArw6GgC8QLl0oX8Lt8ub6tY8eiUBUIfwkMBIeIP2OW0Dw0Oa1v7Gj7wbWhdeu1WtMlmBtN8
 0aydfQrRDZ1R9c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2066968464-1631273022=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

the commit title is misleading: it suggests that there is a bug that needs
to be fixed.

The idea of the patch, however, is to avoid redundant code, and if
described that way, the patch is a lot better for it.

On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In be5d88e1128 (test-tool run-command: learn to run (parts of) the
> testsuite, 2019-10-04) an init pattern was added that would use
> TESTSUITE_INIT, but then promptly memset() everything back to 0. We'd
> then set the "dup" on the two string lists. Our setting of "next" to
> "-1" thus did nothing, we'd reset it to "0" before using it.
>
> Let's just use the init macro for the STRING_LIST members, we can then
> remove the already redundant memset().
>
> Note that while we compile this code, there's no in-tree user for the
> "testsuite" target being modified here anymore, see the discussion at
> and around <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>[1].
>
> 1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbe=
jvaqbjf.bet/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> This patch is the immediate reason for why I submitted
> https://lore.kernel.org/git/patch-1.1-d1e464da0a9-20210906T002938Z-avara=
b@gmail.com/,
> since Johannes would prefer to keep it let's fix this init pattern.

The diff does too many things, some of which are your purely personal
preferences and do not actually need to be changed. This is a much more
to-the-point diff:

=2D- snip --
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc7123..14c57365e76 100644
=2D-- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -61,7 +61,7 @@ struct testsuite {
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
 };
 #define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }

 static int next_test(struct child_process *cp, struct strbuf *err, void *=
cb,
 		     void **task_cb)
@@ -142,9 +142,6 @@ static int testsuite(int argc, const char **argv)
 		OPT_END()
 	};

-	memset(&suite, 0, sizeof(suite));
-	suite.tests.strdup_strings =3D suite.failed.strdup_strings =3D 1;
-
 	argc =3D parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
=2D- snap --

I would strongly suggest to use this diff instead.

Ciao,
Johannes


>
>  t/helper/test-run-command.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 7ae03dc7123..8e42516bdc1 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -56,12 +56,15 @@ static int task_finished(int result,
>  }
>
>  struct testsuite {
> -	struct string_list tests, failed;
> +	struct string_list tests;
> +	struct string_list failed;
>  	int next;
>  	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
>  };
> -#define TESTSUITE_INIT \
> -	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
> +#define TESTSUITE_INIT { \
> +	.tests =3D STRING_LIST_INIT_DUP, \
> +	.failed =3D STRING_LIST_INIT_DUP, \
> +}
>
>  static int next_test(struct child_process *cp, struct strbuf *err, void=
 *cb,
>  		     void **task_cb)
> @@ -142,9 +145,6 @@ static int testsuite(int argc, const char **argv)
>  		OPT_END()
>  	};
>
> -	memset(&suite, 0, sizeof(suite));
> -	suite.tests.strdup_strings =3D suite.failed.strdup_strings =3D 1;
> -
>  	argc =3D parse_options(argc, argv, NULL, options,
>  			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>
> --
> 2.33.0.867.g88ec4638586
>
>

--8323328-2066968464-1631273022=:59--
