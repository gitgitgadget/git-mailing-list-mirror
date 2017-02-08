Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0310A1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 02:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbdBHC23 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 21:28:29 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34476 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdBHC0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 21:26:45 -0500
Received: by mail-qt0-f196.google.com with SMTP id w20so21371449qtb.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ain/+ZFcFMNgbPrGW7iD11hA/1O37G094z/VlOhsxns=;
        b=EuhGQ6N6rcDBCcZUepeFvzyfPxwUeGwUbaBuOpUhCWsku3PUpMvWGkyboV9eIJJjhH
         Yxi9IaqQwAKaLpJMMb+xbzE/cA8n5zHvoTUsAP657FCcDc1LSRLHoOiC+7nM6QAN+lMw
         oqIqv4frR0RcZ8HYxTJqE742E8y8Lqpw2Gc4h4AU5rsonXjtlcob+iY46r+iWdWQ15Sb
         sPB+lFAk/a/caBk8/fKy9F9L2TPfoFudA1SKE6MivUFK0NbkhlKYWgnRLBQB8dO/wiki
         4DxEv9Pfetzjzh/isRO7StKibydNBPYJ/yAS56Z7nA7hcZL+tWl5xm2AoPR1dfIRD/Pj
         3bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ain/+ZFcFMNgbPrGW7iD11hA/1O37G094z/VlOhsxns=;
        b=Pey8kWYqtFf81/uVKYOrDfQ2razvuA38KtDmlVfVPKc5GLexHygwsAbJJEQCxbKHdh
         2biGqORbKGTKIMoKWex0cBOTULQZhHlVcZ7HIJUEaaGjcwm65NuNJb88EBQNUh7LRNL8
         fHnOfijEBzLBivQJ/7mq6QicCoKohOStFR845fzwJ1XqACH/0s+1jsLXFCxoZnMsOY7s
         iXr3jnqI+wF8bAtrPi2wfES+9yurRYIGxRZYSa0GJsluJKtlya2RaDkODyPR8zZ3D1e6
         l3Ke/j+fc42h4iOUyM+seSj5GQ9BVgsBPq9phB7um2S77A4zI54bJOxro9dXczaI+qQM
         WpTg==
X-Gm-Message-State: AMke39mKLMIEweaf4SlvssHqyjHJ6Fy3zwkTMfe5vOfuQOAaABreuW6Vsyo5wI7NeFmpig==
X-Received: by 10.200.54.178 with SMTP id a47mr18669966qtc.132.1486520317138;
        Tue, 07 Feb 2017 18:18:37 -0800 (PST)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id r10sm5008459qte.1.2017.02.07.18.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 18:18:35 -0800 (PST)
From:   "Ben Peart" <peartben@gmail.com>
To:     =?utf-8?Q?'Jakub_Nar=C4=99bski'?= <jnareb@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'git'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Ben Peart'" <benpeart@microsoft.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <20170117184258.sd7h2hkv27w52gzt@sigill.intra.peff.net> <002601d2710b$c3715890$4a5409b0$@gmail.com> <CAP8UFD3R6nzDPApNvK6rcXR2qdAE6G4J3xbvEam3xsobO7viiA@mail.gmail.com> <002701d2816e$f4682fa0$dd388ee0$@gmail.com> <04cdd7ae-3349-470f-39c6-7f8723fdcae8@gmail.com>
In-Reply-To: <04cdd7ae-3349-470f-39c6-7f8723fdcae8@gmail.com>
Subject: RE: [RFC] Add support for downloading blobs on demand
Date:   Tue, 7 Feb 2017 21:18:34 -0500
Message-ID: <002901d281b1$a72797b0$f576c710$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHeqv64Rhj1j9YcMHkE7nrdCUWdigFWth5RAVxc1xMBPYXSowGWv7m9AQIZfy+hEb+BgA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jakub. =20

Just so you are aware, this isn't a separate effort, it actually is the =
same effort as the GVFS effort from Microsoft.  For pragmatic reasons, =
we implemented the lazy clone support and on demand object downloading =
in our own codebase (GVFS) first and are now are working to move it into =
git natively so that it will be available everywhere git is available.  =
This RFC is just one step in that process.

As we mentioned at Git Merge, we looked into Mercurial but settled on =
Git as our version control solution.  We are, however, in active =
communication with the team from Facebook to share ideas.

Ben

> -----Original Message-----
> From: Jakub Nar=C4=99bski [mailto:jnareb@gmail.com]
> Sent: Tuesday, February 7, 2017 4:57 PM
> To: Ben Peart <peartben@gmail.com>; 'Christian Couder'
> <christian.couder@gmail.com>
> Cc: 'Jeff King' <peff@peff.net>; 'git' <git@vger.kernel.org>; =
'Johannes
> Schindelin' <Johannes.Schindelin@gmx.de>; Ben Peart
> <benpeart@microsoft.com>
> Subject: Re: [RFC] Add support for downloading blobs on demand
>=20
> I'd like to point to two (or rather one and a half) solutions that I =
got aware of
> when watching streaming of "Git Merge 2017"[0].  There should be here
> people who were there; and hopefully video of those presentations and
> slides / notes would be soon available.
>=20
> [0]: http://git-merge.com/
>=20
> First tool that I'd like to point to is Git Virtual File System, or =
GVFS in short
> (which unfortunately shares abbreviation with GNOME Virtual File =
System).
>=20
> The presentation was "Scaling Git at Microsoft" by Saeed Noursalehi,
> Microsoft.  You can read about this solution in ArsTechnica =
article[1], and on
> Microsoft blog[2].  The code (or early version of thereof) is also =
available[3] -
> I wonder why on GitHub and not Codeplex...
>=20
> [1]: https://arstechnica.com/information-technology/2017/02/microsoft-
> hosts-the-windows-source-in-a-monstrous-300gb-git-repository/
> [2]:
> =
https://blogs.msdn.microsoft.com/visualstudioalm/2017/02/03/announcing-
> gvfs-git-virtual-file-system/
> [3]: https://github.com/Microsoft/GVFS
>=20
>=20
> The second presentation that might be of some interest is "Scaling =
Mercurial
> at Facebook: Insights from the Other Side" by Durham Goode, Facebook.
> The code is supposedly available as open-source; though I don't know =
how
> useful their 'blob storage' solution would be of use for your problem.
>=20
>=20
> HTH
> --
> Jakub Nar=C4=99bski


