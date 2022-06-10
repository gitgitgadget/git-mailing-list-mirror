Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A4C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 21:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiFJVq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbiFJVq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 17:46:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8A49C80
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654897598;
        bh=E+UCML+woDEjpb+s7w2SHzU6yqa8U0piZi2WtIoFyXI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g0v/455ydPMucpqB97JKhNk1qG/7HOxWE1oIzS1d/w/o1PI5dyV6Q6/mLa6mKxp/E
         tl9aVklgecEtnYpsNQGwMMrCs/2VmjRtyiu9P7um1WehcVJ8re1gW1+5QM1Qssfi5k
         Tr1Urg5W+A9WkF2jG9HL0pi5biRxRv3VlZ9JFFy0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.123.239] ([213.196.213.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1nwy602XRy-00G0R3; Fri, 10
 Jun 2022 23:46:38 +0200
Date:   Fri, 10 Jun 2022 23:46:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Best way to update `HEAD` in mirrored repos
In-Reply-To: <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206102327540.353@tvgsbejvaqbjf.bet>
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com> <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet> <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZOFv/ycXSo5fmFbtuQ/U+rqtaD8I8so4d/WS9p4h1Xlu/546Kk5
 I3wJc+OKQ8vTu1o+PdzhwxTtwT6F+jiXrP/KfP5eroFIrIl83OPkkrQ1Lyrs5T9GAZ8GnYg
 vO0D6jW14Jkee7Dz64lXyczLDdmGu8+ZWBiYCNOLVpARaq3WX84OOAYgoatDqRKqsRNBiZG
 nt1SE0cZerHltyY82a2/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:glBUqkc0gy4=:+Akq61wGVqRjh0c1VmeCPK
 Nq4Elx9efJK4dZxzspTi7M+a5kzLA3UArWysIHAyTL1tFZjQzh07VeTj7N0cGl2hm1/uQgnni
 SIxjja0y0C9cD3vmQm8HVRRbRvqD7/7MDhCtp1sfeBfbVV7HJHRpHyIQzVhk3PaZF7Uh2XKh4
 clbWrO4XT+t6FBk8hboN0LVGM7bUi3XXNlzuhofDNBxEBmDtGTaq0hTIWg8Qfr35L/1LS/N4h
 i88AYn4c1X1gBJXKwcwC351UTS/aRPCxur3M//PJzRvIA5ENjG/3mi4ZhlBhzTPs27r9q+Wg0
 sbDWV/lA378mf8opOKFx94us2r0ZQRl/w0Sr+BECdvDyN49nOgXXXb2qNUJxxGWgT6aQnaKUD
 hyUVbTxoCfW7cMvt09VgDv7FRKQ0TfaMnxYtKlhPXOEjHK2JHMHWwsYUNx/zDs2ruKmLWfWEz
 F/olMIndgmvnaYZ4uazEH62NX5B/aBa8yAOpuICQlemD08+QrEJknGv0Sp8umIEDT5rtSJduT
 2hun8J4GfYeP5TfzFL8EUHNj//tF0A8qHnuBHqIMRMCeI5nIeBKGD0iYuWgONknUdlmOHG/QP
 G6qyL7rvimDMZQ0t43tU57eQwASgGD+d0ZTQCjTIGcA3thS9mRt74MLVP1GERss/wvCRf3yLU
 v901c9gh2V2b1VqUfpCr+3Nv450KAUU26zTrXwf1Cfj98XH/kn6dn6MEl3JzD8pCA4fwuSVuw
 pdnIP4ZzBf0pgZ0G1fGrrK3jboArAN3XGJ6SNt9oBFo/Br4D9Hops7LT3AgBCduXxAwAlpoce
 YgaTNJhe/4f59An5fdNhHuqgv5wliY+kXCOlmG6lQqszUF2StWZwjb8ufUVmPLBIB3yaDVIAX
 IlXLegUVF7koMqE9SxF0Y33YdrcQCGOKzh28Iwilg1l+ZGSmO5fbc0n8xzKz0E6uDVYm7Hnip
 AtPVQb3H9WdBcLdmLyRbYVehhr6adn+Z88dapICXlH2+Z+TpbVteuK8oQSHsAGZ1TmadxupVx
 I+b99CLO2ZsQmypLH6R0l09HaYGE5QeX9XF+KIHpSVVXBgp8hxZG8ve0yZ/zAw+HC7DAX0JXo
 PmU8QIYya/An2rpBrhFT62dy2AkUmeYODe5Mm8tA0Zl6GivBU/2xlIBog==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rodrigo,

On Thu, 9 Jun 2022, Rodrigo Silva Mendoza wrote:

> On Thu, Jun 9, 2022 at 1:02 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > The reason is that `set-head` expects options to come before arguments=
,
> > like so:
> >
> >         git remote set-head -a origin
>
> Hmm, that doesn't seem to work for me either - I get the same type of
> error as before.
> Here's a minimal repro:
>     $ git clone git@github.com:git/gitscm-old.git --mirror

Here, you set this up as a fetch mirror. That is something I've missed
before. It is also important because it means that there is no
`refs/remotes/origin/HEAD`.

>     $ cd gitscm-old.git
>     $ git remote set-head -a origin
>       error: Not a valid ref: refs/remotes/origin/master

... yet that's exactly what `set-head` assumes. The following patch fixes
it for me:

=2D- snip --
diff --git a/builtin/remote.c b/builtin/remote.c
index eddd40c8f87..fead15adb97 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1344,7 +1344,7 @@ static int show(int argc, const char **argv)

 static int set_head(int argc, const char **argv)
 {
-	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0;
+	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0, is_mirror =3D 0;
 	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
 	char *head_name =3D NULL;

@@ -1357,8 +1357,16 @@ static int set_head(int argc, const char **argv)
 	};
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_sethead=
_usage,
 			     0);
-	if (argc)
-		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+	if (argc) {
+		struct remote *remote =3D remote_get(argv[0]);
+
+		if (!remote || !remote->mirror)
+			strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+		else {
+			is_mirror =3D 1;
+			strbuf_addstr(&buf, "HEAD");
+		}
+	}

 	if (!opt_a && !opt_d && argc =3D=3D 2) {
 		head_name =3D xstrdup(argv[1]);
@@ -1383,7 +1391,10 @@ static int set_head(int argc, const char **argv)
 		usage_with_options(builtin_remote_sethead_usage, options);

 	if (head_name) {
-		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		if (is_mirror)
+			strbuf_addf(&buf2, "refs/heads/%s", head_name);
+		else
+			strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
 		if (!ref_exists(buf2.buf))
 			result |=3D error(_("Not a valid ref: %s"), buf2.buf);

=2D- snap --

Would you have a chance to build Git with this patch and verify that it
works for you, too?

Ciao,
Johannes
