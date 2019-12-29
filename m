Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1FC2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737A52071E
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="q3SS4dJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL2O3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:29:12 -0500
Received: from mout.web.de ([212.227.15.14]:51987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfL2O3M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 09:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577629749;
        bh=HV8zngrWcRxM8SyptcUqVgD44KlYtTJduqgIcC+/gmA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=q3SS4dJCTmktICNbAJREGOOusZHYiENHq9zVKmOe3KpFL6ROIFBomG7gaqTKIKUpc
         DKPvKnk2RnUFC6dNitljRJRYzpJfPauEqQ6bgwIySMAFAtT8ZAXd8ZGqOyX+Uom4Sl
         G++bqXa8bhDuwgJJW134WtD6slrKG4Efs57rx2cA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgHf2-1jYsvx2zJs-00nh6n; Sun, 29
 Dec 2019 15:29:09 +0100
Date:   Sun, 29 Dec 2019 15:29:09 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
Message-ID: <20191229142909.7bmjbrroboitvnzq@tb-raspi4>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:CR7DaZNGn2IQw2qSnoyUPEL/7w+0b7G0uT0ZTlZJ4UGUqoL/8rd
 fid9nYKeZcEFl8+o0kp9+Uxf7yidXT6XpPbO/CXfzX3oiXxE5ACZrumgpbTOcKNivf7fzaJ
 qtzJR4k48RihEm2xxOb4QnTajhSwPE1jlmhkSOp1irmekeI97gx7aBqdonrPz6IDJ/WEjRK
 IXMwQY5ZoopndFV3tcxaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4APeiYuR5E=:/1P0t8gvxC0xWtAxX/bjyI
 yqFI/Wlg3yTLw6mkNEbwXuL+7FvpbdY9cfT6y9rAgyrx02Jxrd6uDU/cSSPoHkwsNJ9MR9Gl+
 GPKMz25ZLCS1u38gK+3Cg5pyCREkZZnpU0TNCQdi2ebE0qwWoDXLDbNvjZBj9qmMfV54NddPC
 2UVna+bLjCJFiKLYa56RmPRsUBxzj9vR8ZlD2xgBd8BBVjSdBq+F6kuRiuh9sMXqT1avcKsau
 gaJsuELlAFTLdacAUBH7+2QAEhBvp7x0rvHxFfILX8OX9Q6L7TzzfW2RXaqVUPEc4Z8uEYgZl
 ztWMuV6hFwjGJdufEcFrYGQIVaVFy54e+IZcwS8ES/rg52RGEBpIjJwMAehATnRr7U3psYMLe
 FZaYonZy4xJwdFXMJmGR9sWMhOBg5QTBu6L9Vtcs1Av4DH6vh0ep6+j3Yh4NCv3/ovKzDF6ft
 +FA0SX5CzL05c8VxYkWCscxOrDCetxyr71tmXqeTHQycb05JziW5wB/50JLkKXrlk9N/R46Ka
 KMvEE0/z5X5v4ur+o02sgz7E7BsuprLD3yKJKLFaf7PvMUbRZWbc4vGkQPJjkaPdKEL8WYX6a
 mfwKtU3/YYvKrKSTfkTnrOyCI5f2y2LGqGq0RBJKD28LEDLdCMeF3WNuS7mUxCIaKTWFzNdn9
 QJrzKGkfhuaJ6xivI2YV66J2aiCYJ0Kb3v82l3isH1xJqwB/k6s4IDu0ugn3AcvWyeYpOStCa
 0S5Io97OBOQ7wyMTU6X7j/Z9dYceu7KtARuMjuUEhmktj7FfryifIZesDXlRhGgICZBOVyUSJ
 L/A8GKpaafv9kwuXB6L1q9wcFl5fJGXpjXRuecAS9LkiCYQPzec317Bz8bGjZtP85McsWcZmb
 JXAyZB6qVdVW3g+4hKqNG0h8s/k7OdgGqyEa5uCJ0vjhNULwM/1fen1P59dm2tYTecfj7IeEt
 POcQUC9Z0XHY/OwKAlR2hnrxRfcI2Ou7ZhImYnDaj0JpIbyUW84yCF2H21c0f1bmVZzx0J2Lq
 IpFSzCgQxomB6+2HhzbTATVPFP5r28oXeRH+De0udgARBV5vy0zXH0W2QSaX7ZcRFd7EfNKmP
 zn7h9UuRO3SjYaqKGO1qPk+6JRBDGRsi2Kk+s7uGa9nYU7J5ZatyIYni+VW2dyN9/ICEyqM3y
 ZXD9oeh6liixvd2b19gWWlrDrxbs6A2FT4O7wXl3PzmkdZRXhDa3mZI7s1niyP/noFRyCZHJF
 jPiO9tpfmDJQQzeglmxHhFlEqNZ5MJseyvEyEaw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 28, 2019 at 04:41:42PM +0100, Johannes Sixt wrote:
> In sha1-file.c:read_object_file_extended() we have the following pattern=
:
>
> 	errno =3D 0;
> 	data =3D read_object(r, repl, type, size);
> 	if (data)
> 		return data;
>
> 	if (errno && errno !=3D ENOENT)
> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>
> That is, it is expected that read_object() does not change the value of
> errno in the non-error case. I find it intriguing that we expect a quite
> large call graph that is behind read_object() to behave this way.
>
> What if a subordinate callee starts doing
>
> 	if (some_syscall(...) < 0) {
> 		if (errno =3D=3D EEXIST) {
> 			/* never mind, that's OK */
> 			...
> 		}
> 	}
>
> Would it be required to reset errno to its previous value in this
> failure-is-not-an-error case?
>
> The problem in my Windows build is that one of these subordinate
> syscalls is vsnprintf() (as part of a strbuf_add variant, I presume),
> and it fails with ERANGE when the buffer is too short. Do I have to
> modify the vsnprintf emulation to restore errno?

If you ask me: I think so, yes.
At least the documentation about vsnprintf does not mention that errno is =
touched at all.
That is the man pages for Linux and Mac OS, or see here:
https://linux.die.net/man/3/vsnprintf

It would make sense to analyze the complete callstack, I think.
Is your problem reproducable ?

Changing the function strbuf_vaddf() strbuf.c seems to be straight forward=
 to me.
