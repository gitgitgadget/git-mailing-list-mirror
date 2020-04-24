Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F9C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971D22071E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cIeVkjNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDXARE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:17:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:44593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgDXARD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587687407;
        bh=TDioRPr53xVJaQxTNG+hF9dja04I8S1M8o3vOreCE78=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cIeVkjNGDz6KcPG7jz/P3czbUjnUIY+k5be6IrLCOt3b85PcyTTWfjk9AyH0lZXdh
         l8TV2qbqeFqxxI0lL4Dm7YasG4th/ZiJjKSGr70PL/WrCFs2NrmqOGFeEDFX+DDGTK
         GaUFiNV+JXfQdqTsnX4RWBXc9yvv82PW+77o1120=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mi2Jt-1ixP5T3m7t-00e13i; Fri, 24 Apr 2020 02:16:47 +0200
Date:   Fri, 24 Apr 2020 02:16:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <20200424000558.GB20669@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2004240215100.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <pull.615.v2.git.1587685397.gitgitgadget@gmail.com> <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com> <20200424000558.GB20669@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-52041762-1587687407=:18039"
X-Provags-ID: V03:K1:LNDVRbDlFcathYl2K7uyKpO1kKk8I4zhM/qBS7XSTSyEHsdA7tl
 /vu94Z423WKzyxqzbb4hv38Hwq9N2rLw11nIj1KMacvUlJkcYRTk2onIsLwQbZHjnodM8TP
 dPCF032ajib4RmyLjqVvragR05W/1DwHeBvZcUSPjuhtFrGNIAkJ0fvFqTQjwvidhCwH5Jb
 mqitbGQfYZuaLNi1j7NIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:svU6EZ49fX0=:0yk1f/cslLsN43mSUNlOmG
 dewNwmLNFhJXAM1wP6byzsviJHGR3yF1cP4qhmCLue+ksGLx+n/c3xygTOAI7XshaoAzOIOMa
 7ki3VB+XkYjlTfP80hd+oWBfMddSJInbjfOCaUGpHR2Wg5B4uPFLH+w1uliCtEO5xLNswqPyo
 fEix23mqLuyDFBCVTMoi9oAFWI69ZguNmgePz0W++n50Gh/9cbzteGMzD0zX5ypz8DBJky3uE
 eED4g/+t4M6zuFRSOHalDFkbOjTfruUH+1lK7CvxtEDBO3Cu7alaCaTcKb9wFJRELBjVhFhmM
 5oi3aLCBEVBYO7PjlHIkiNljBqDGXJPnP5ep2UCED7LcpWVDuVeLWanW6hQc2vzlmCBe9KOce
 4Q7kusT0lHXmSBueuCOio9TRkiSVUzr9G82uKMBU5+JpeZ9DHcQQjuC7mc9DPj8P6qgQXrzqH
 /8g/yaOh85kmNqfvqqUyUeL5/HPp1M5ZRhpkdtX60vYilslMRmyD2nmMH42RI5MEEtfvomGKY
 qM9k2KDaAz/8mJHZ9da1MGDo92sVTpCQaB+JRBLI3bDKP9tP+prD5xSeVl8b0fL52AFnKvIsp
 DHz0YPFQYtu3/96DImtnUfHQnGEEyWtOdBDTZc5wJ9tPbvQAj3nNYhG/2vrvdIjC49YlfbVL0
 UriFADceF/BMjT+Gcn6q7RX8oS3+YoxdilHFu9XBp9lF2iaC/X8F3z+I9eer9a932K/ppUYPF
 X0oW7mT7p++RImWkV2MdujusZZymllvpZRyxpOjo6f+NLMGsPbsAdkhjOVO89o2Uhon4LaETO
 eKwmMQ7IbwDMVPJeGyHmXOCk7bIrCjnCFyFmdkQyL/o6MC/5uYWGDHYQom10IdEHlPxvtelPw
 V+cX6GQeza+NbSGl+AfbpS2DGhMEA5uX2NlF917SztGYTfRKC95/6p75kFe1WBCQEP6dgHlsb
 L52V1ccRpOHwRZgzWoucWi1DwwDSJYLR73PZ9PfCcYn3Mknmg4i0jUG6VoN/CDkp1r2sce9Gk
 5MLXi2yApEYu8L1xZ1ppa+84ba24at5Ovtsn7lQnH/rEho0CozuUYkgcYiY/xL2V2rBqxO7eq
 Q44jeAHAG62E8YmE0FnEVIxjED7vzr8N9VWaBNQR/nTo0NjLMyy1rNm5WuazQO/5pJ/rnfzLv
 PQ/Q+TnqaJJ7b7Enni10RwGkzfcBUFi9Vnknw6M6QujBxciFiwSCTUMWnLQN4QpVCWArQnpKe
 om6y/A4jyah2SbkSL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52041762-1587687407=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 23 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/credential.c b/credential.c
> > index 52965a5122c..3505f6356d8 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -53,7 +53,13 @@ static int credential_config_callback(const char *v=
ar, const char *value,
> >  		char *url =3D xmemdupz(key, dot - key);
> >  		int matched;
> >
> > -		credential_from_url(&want, url);
> > +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
>
> definitely not worth a reroll, but just wondering if would make sense to=
 call
> credential_from_url_gently(!quiet) here, just for consistency?

We don't have any `quiet` variable here.

> other than that this series is looking great, under the assumption that =
there
> is going to be some more followup with non essential changes.

I am sure I don't follow. What non-essential changes are you assuming will
follow up?

> will chip in with an test helper for that series so we can hopefully kee=
p our
> sanity next time someone touches that function again.

Are the tests I added to t0300 not enough? Or do you think it will need a
native test helper that is included in `t/helper/test-tool` and exercised
in the test suite somehow?

Ciao,
Dscho

--8323328-52041762-1587687407=:18039--
