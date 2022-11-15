Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E2C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 09:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKOJy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKOJyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 04:54:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70722B0B
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 01:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668506047; bh=mR4d2GOAxv90GSEi6Cy6UN+QxLDR2cGUc/GJOQ5+mpM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PzhJM3wkrrc3CqgTmG5mD2PcxTWhRRAzVtk16Pb8OY00gyTeogZIjxcVCpgjA3olJ
         P+ozjqinQP16u6P6HNRx5Awv1ivZAVHRvgGcUvhcDCFwSQxH+vNK1E4EtKfrIf1MOy
         HvVqy1QT3LPeubGe+HhbnA6m8QMoRyeqZZ1YRpic5Ex6qI9urt1lv0eLUSnQ7wbXRx
         RaVPLFpShEm2LLy2xRfxxu/v/H7kupGvt/R6RDYm0YZtqo2Og1x2XbeMg7sUerlloL
         sr1xkWT3pjrktWSLrvsGofFX4JSkbBLRCUufX0e5TjpoEkDij4Pj+mlL4OM1FGFyiE
         o6OisWLAtb8Vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.115.3] ([213.196.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1pMD2B482f-00jatT; Tue, 15
 Nov 2022 10:54:07 +0100
Date:   Tue, 15 Nov 2022 10:54:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH] builtin/gc.c: fix -Wdeclaration-after-statement
In-Reply-To: <3p6n2r7s-q136-n7q9-8o27-740q4qr5os84@tzk.qr>
Message-ID: <r31o6p7q-po67-osr1-3qq8-93s4p3o23nq2@tzk.qr>
References: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com> <3p6n2r7s-q136-n7q9-8o27-740q4qr5os84@tzk.qr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-727370782-1668506047=:183"
X-Provags-ID: V03:K1:UAs5BL3/ZI4rHyxNJ56GoXopixgD0sU51cbgAnGKV/eP3cW6WAX
 pOWsYcSqi+ThengHYjtZUMmfRiZaEL1nX4IUwxYj/nimpRgv3//eAFRFGwT1vxmrga0qQs8
 gcNAd3fPYqzW2dgXm+qBgkpms9vLBK0Xdjmwtg6z7bNtsI3WBqz/atrR3OQfMNsWamSFWBn
 WV7Ug3mKCrryrlnrRXK8g==
UI-OutboundReport: notjunk:1;M01:P0:2bqbzxFYBw4=;Nnun9NdZMIkU6a8tqLvPqhJNsMY
 RxxCszXwv7V8tbFkLlnsPCKtPrt3TOCWy/DZJKcQrrgVRMPxu7CG/4CPwGYIyTt7oNU+c8J3x
 4hDbkrCp0PqVcsDRT5LBiUKsog59AXL9o69sPu5MBmVaW1U6zdgFUqpPIlmyjKH/FWeodMXdl
 ORF4/akZDqsabBRDCEAikfIyYzvjaIMipXeO1cpgYOJpQcke6QCQD83xyiV5dA+V5IQoP09zi
 kOO9uLtX8SKtCIGm6tKus7Nl7p6n9Ho0XsYKtyR2KdrWHj2PLUZibssxOMWtrIVCKcZFUCwS+
 DfVth1XDJSicGEbvhG0lNQa1mwhATPCKGBGoYo9QTP1TtsMtEwCDSUzdaADRAmRkmq4uG/hhj
 Qu9atdBXZdRx57RRnAX5kB1RII2RccQ8DheBfIWDTHlBqbieUiHiSxwpeosoQDImXyPDVOiFU
 UuBOWl0zXNqNP7oz9ftgsoBvSx+FFqAsz7r8w+CXIVg9/ldmqhWn1JGcS4QnNpsgMeEf4rCDG
 DZ/B9XyHEJc9P98VdFo34mLnr6VolnyNxlNrxh3VVQxJ+ascf4XFeVXT088qUXcFPdZtUHmI8
 4vVMJf3cHlWOvFmhy9Mz7jBmvZT9NXw+Pusx0TgISrLrrjNDBylQvabtdaJENKQNL6WHDJUel
 TIhs4FnedkfjcUTxcGi7u5xHxdPLZcC+tJzmbItV1XjuRiveRq/h+L0J6ALdpuXadDRmcQDY1
 SknJlKYHIktUJvGrOMVn49VSkdTkljXkckejWa4iN0cU/5plob8FjRL6n8d08DSeEnP9r7K8F
 wu4mf+TR1s254iTUO1B4RoGIKDzFKtI7yy1xR2Gqr9/RTQCOhQcbWXEtu7ZdTQ9KrhV5gu4/0
 F/KRlW6cdCaoFkuo0DVY08jUu2O+xWfRlwj0AHDs23X6PDPqdct8fqmgPlJb6uXOIOKgBkWor
 9AMKy5xWa3k+jY1OOqZwQP3STIc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-727370782-1668506047=:183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 15 Nov 2022, Johannes Schindelin wrote:

> On Tue, 15 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > In 1f80129d61b (maintenance: add option to register in a specific
> > config, 2022-11-09) code was added which triggers a
> > "-Wdeclaration-after-statement" warning, which is on by default with
> > DEVELOPER=3D1.
> >
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> > ---
> >
> > This landed in the latest "next" push-out, causing e.g this CI
> > failure:
> > https://github.com/git/git/actions/runs/3467538041/jobs/5792504315
>
> I looked at the same thing all morning, and found that
> https://lore.kernel.org/git/20221111231910.26769-1-ronan@rjp.ie/
> _probably_ was designed to fix the same issue (and I think you agree tha=
t
> that patch should be used instead of yours because it is more complete i=
n
> fixing left-over issues).
>
> However, try as I might, I did not find out yet why it does not apply
> cleanly over here (I got side-tracked into range-diff'ing patches
> downloaded from the archive, which is quite the challenge and not even f=
un
> because `range-diff` requires commits, not emails, so I side-tracked
> myself into teaching `range-diff` to accept mbox arguments).
>
> Maybe you can adjust that patch so it applies cleanly?

Seems that the v2 of "maintenance: improve error reporting for
unregister" [*1*] was _partially_ folded into v3 of "maintenance: add
option to register in a specific config": At least the config change that
talks about `--config-file` inste of `--config` _is_ part of v3, and one
reason that the former patch does not apply cleanly on top of the latter
patch. Which is a bit funny because the former patch was sent out two days
_after_ the latter patch.

And it looks as if there is one more thing that needs to be forward-ported
from that no-longer-applying patch: the initialization of the configset,
otherwise we're potentially trying to clear an uninitialized data
structure.

This is the patch I am currently testing (on top of Git for Windows'
`shears/seen` branch:
https://github.com/git-for-windows/git/commit/cd7b86d19f):

=2D- snip --
diff --git a/builtin/gc.c b/builtin/gc.c
index 635f12499d68..a3f63880dfba 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1569,6 +1569,7 @@ static int maintenance_unregister(int argc, const ch=
ar **argv, const char *prefi
 	int found =3D 0;
 	struct string_list_item *item;
 	const struct string_list *list;
+	struct config_set cs;

 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1576,9 +1577,8 @@ static int maintenance_unregister(int argc, const ch=
ar **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);

-	struct config_set cs;
+	git_configset_init(&cs);
 	if (config_file) {
-		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
 		list =3D git_configset_get_value_multi(&cs, key);
 	} else {
=2D- snap --

=C3=86var, can you please have a thorough look and see whether there is
anything else we were missing before advancing this to `next`?

Thanks,
Dscho

Footnote *1*: https://lore.kernel.org/git/20221111231910.26769-1-ronan@rjp=
.ie/
Footnote *2*: https://lore.kernel.org/git/20221109190708.22725-3-ronan@rjp=
.ie/

--8323328-727370782-1668506047=:183--
