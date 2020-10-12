Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6BEC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F852078E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kMiEh951"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgJLUz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:55:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:52565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731627AbgJLUz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602536145;
        bh=jraI5MTVJE7GLVAPr4no/+Nw1h5WSGz3lf+ZJ1dv3gQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kMiEh9514eL9p//Dt9HmmiTTieaVdltKpd/yoE9d3FW6irdw6P3gTnp0sGFMtMopo
         F2JpQCNVWM7Ipm4+Gb80qIYb5RWgCLbdy2q03zGL8CI3r/ShHw4XKvzOAwBN9lftRP
         kCtDOPYAo90S0OpcxWg6WjH+H1UFIXEH6IHVSqzw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1kKUhx32rd-013Qvc; Mon, 12
 Oct 2020 22:55:44 +0200
Date:   Mon, 12 Oct 2020 22:55:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
In-Reply-To: <xmqqy2kbns5l.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010122239430.50@tvgsbejvaqbjf.bet>
References: <20201011224804.722607-1-samuel@cavoj.net> <xmqqy2kbns5l.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2087818744-1602536145=:50"
X-Provags-ID: V03:K1:2JwQaEEq2GFWL8iQuBzx7KNHcFkeoaNH7LZc13uHpqJ+n7i1beE
 OGvM6O68AwVlZCfzLJBcDUOAymkhMlJQTxD6HJNDDGDjvW3a19aLu0aBvoZESEiOPl0aqBN
 Xo7aWnGK3thF2I2nvqir0gICIF4h6dyvgHpF64uSc0NEhbpEeFLDVErWZL1pdH17L0mar/5
 Kk/bZO/PGefQjHEdeYHQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XRHCS9XrzNU=:Jp0HZ3kgMxxRprK1chJTe5
 7ebGbx3wiHCGCH7gYz1SIfUqmliWKphr5U13ML+7YIetOvOZvDBMncFlkX5cWaofpvgckBxES
 tnlZOjNLQeZYw/u5DEB1Nd9BAGilmmgjXVpS7aZLsen6sEn2s23x1dxAifs461XybA2eBF5qB
 TBLaXdXrQq91I5E4vUJjt0OnpJaRRuP/jO92yVe+M2Mj0aOIf834N/kSWZx0SMCE+fa6531iQ
 D7F+cOaIcXhGb8yxIDnIm3T5QciGof5ZXXnPA2VZsVRTMvuvAX7OkVzQERb85gzURhy5ZzFB3
 WzDMlNj19y+YYEIbnOXMDu0QKuIV55aW4si9qbE/Y6d+R7O8Hm9e79eF2WYn0DkaFHIOrPaUd
 sOvyv4a0DJ02f4FYD7ZDfulgDLK9m4y1QiAxOLyK+IEhdmZhLE6PMv+UDCo4L5AkOlX3T8Z8M
 Mc3xVQY/i5lNV8gQmVYVyYhBctk8mNRr5rxfPF2nd4A4VW5/2BR6FreB/ZNgsjmEwCb0G+qi6
 QdrQLn3UkneJHAcxopo0v9rumlGmLvR4zx4Hghcgl7946MpthnoIJ+kybuCRqLF5lPgwuEexG
 MC/TWZNxF/N+QRgPHxUXozQnn9mSoGY/HmEIomo7QekJWD+czmrc2BWNX1T3yg8MaV8uXlzL+
 /Rxf7x5S1GCw8UgV2tgaSVxeVAnqdpYU8jSIAHbPDOyMcpljm672SNdn3S+yXF00MSDc83fZo
 jRQArveZeZF6NCf2O/oowIAefk1nx55Q3n4QRYZgvJGosRmz/ek96H9FeNPUiccIlgXAOGQcn
 3HPx9fw1rHRa2MSMwcDKWRxCYgobN8mZ0KJtfrdrfLFivlgGYckebScxmbBuvpnOkCM9SwnVg
 JMZVV6OCFkFy1GUAsc3XVqek/sgjOMNSadKhAu+siqgToBji45zRqFR9cAAi/vwgBvmtCJSbs
 e2oTiOEaTI29KFUQmRqDI2fe3jkialM4NZma55ZQ4kv5e6+KtuPeWEMVDEhzcXgCi0SNum9WV
 RLLqJqFnUEJnoFDl2jglITFjhE8LRqyz9Zd89MXLiIiC+hTEVuPZaGEsbMSq8UMWighj4C3gU
 TUe/ONnPmKtz9Rk7XrdH6f0fPNrmNHx+6s/KUy/ofDwrmMOEDTFWyEXwoG1qFTcOSkg0zwc6+
 KB4MkmHHTn3uZjMVFkHCeSFKWfVfqM3QJWILQwtVY5zWJzpkxTqgJY9YUw4SOXQtzxtpb7ZOb
 xUalvz/mk2g/o1baLNhY4wCwVciPQe+fURc4PfQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2087818744-1602536145=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 12 Oct 2020, Junio C Hamano wrote:

> Samuel =C4=8Cavoj <samuel@cavoj.net> writes:
>
> > Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
>
> Puzzling.  Why do you single out octopus merge like this?
>
> sequencer.c::do_merge() is called from pick_commits() whenever we
> see a "merge" insn, and not limited to an octopus merge.
>
> Can we have a test to demonstrate the existing failure, so that we
> can notice if this fix is broken in the future?

Yes, now that I understand that not only octopus merges are affected, I
would be very much in favor of adding a test case.

If I may suggest to add a new test case to t3435 based on t3430's
'--rebase-merges with strategies' and t3404's 'rebase -i
=2D-gpg-sign=3D<key-id>'? Something along these lines:

=2D- snipsnap --
diff --git a/sequencer.c b/sequencer.c
index 00acb124962..88ccff4838d 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
 		strvec_push(&cmd.args, "-F");
 		strvec_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
-			strvec_push(&cmd.args, opts->gpg_sign);
+			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);

 		/* Add the tips to be merged */
 		for (j =3D to_merge; j; j =3D j->next)
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index b47c59c190b..f70b280f5c1 100755
=2D-- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override c=
ommit.gpgsign' '
 	test_must_fail git verify-commit HEAD
 '

+test_expect_success 'rebase -r, GPG and merge strategies' '
+	git reset --hard merged &&
+	git rebase -fr --gpg-sign -s resolve --root &&
+	git verify-commit HEAD
+'
+
 test_done

--8323328-2087818744-1602536145=:50--
