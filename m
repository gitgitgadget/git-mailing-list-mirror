Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4171F454
	for <e@80x24.org>; Thu,  7 Nov 2019 12:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbfKGMpr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 07:45:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:39453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733122AbfKGMpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 07:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573130739;
        bh=XSzdmlj2C7Dkql4PwSUcrYyDbTsLXEt463Fl0RJOkDQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k6A2fTeb0sBO01yuYOZP7fGOu2Ew18w2zToQzx+Kbn5WCj2ffzkFZ0cWwwRf0Hc7y
         RyhepU3plIHJC2dvlqtezF6pIug8NTsJL9pGZwB9IAdZbToPLmUDxD/Hn4REI1oaqj
         DRsKR7nTKoX8+4hjAkuRrkWRE2q6eW83uc42rgq4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1hc6Vv2VxA-00qye0; Thu, 07
 Nov 2019 13:45:39 +0100
Date:   Thu, 7 Nov 2019 13:45:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the
 result of an integer multiplication to a larger type
In-Reply-To: <20191107022347.GE6351@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.1911071344050.46@tvgsbejvaqbjf.bet>
References: <20191104095923.116086-1-gitter.spiros@gmail.com> <20191104095923.116086-2-gitter.spiros@gmail.com> <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com> <20191107022347.GE6351@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2rmsGyoALZSiigISaFwMv/eRVkshYqaHDCGBapnVacWLCStFd2U
 OuXVmCL06jria7fmtzWX/zDstV+pp0qBqZQIcrdr7CpO1/nF2Kh8N424+uDa1+LnMIJ+QEw
 nVvrZBFKroQ449SnDmiUMky5h2tnFErYb1NxjiXJvUDQeSEZl5k1+7Cf8/tU0oOS6O4+Qiz
 5PebOb/MUeuA8AlOZRNmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gvmp/antbMo=:qqY1TqgtUXXNOBAIlCbUHQ
 4jgIm6bdKaUwl2HNDZzY5e+MXQx7DG0OT1wiVAyWu3V+tLC+C9B/JHyWq1NyGa0Zvpg+ni2F0
 +p9Pf81q9rcgpLwo6r3dk6j1sSOXdL6H7ZYDIAN9g39TagWCZhWz6EXIn+CDK9b1AguCrANHK
 E6eqDLWQwo4jWhiKM7KC12/8XXKo2c1GhFznhmr2Tr72/gzsfQANU+tPW4UgQfIxNksIwcqM8
 kY/ikDtitDjmMgd8vwFhsE+4CcalRRKDEvlvpUerflc7PnUT50XJuhLnNigjFvUxhKvWmlpbe
 xt/27IRzgRwqh/kj4a2yAdBlrzYtOUT2cxpVj32H3Q5ujZZRl6E1Ekucbuhu3Gg809tcOzfeC
 q84O7qsRSpc8kPpmVqngpo1pQiOq1X8xB2pzrY3A2WQkcJcvfsNcMOWWSKVUb7BfCh99m2olb
 JsBc6U7BEotG79Gcxry1BR2o2rk6st9ERyrW2Ib16tbNRR9oGmcgWNb6xtbinWyC/+lYz8vJw
 lkM4a6a5ZwusuGau47om7e6E9Sss8QUXovcmhGqY1OHRkfpVvLyeqfKKkwAC7s+Rg4eqG8UGQ
 ULNs6s1aZBzlq7SJ1A5wkeTBVegND4bCD6UuJcoV0nC2s0K1mDnLyTDmpEFtk4G6BLjcvXVeY
 T9XSzst2FQxXcj7BWJOEHc9euFncmrG8Pr/vOPcCAE9ItXX12Po660XwafnbI4jS3sTheFzlg
 fuXMjLygKLb1ozGUs5Hh2kKxY6cyWDii4WCDRyNZt8q2eUrqMISOpXFKtHJlLuHmoTmZJ8eDW
 L6iKCXINHtvyWJ2VmLAvaa1rcy09E/Gsb/pYJO3fbAwBSsTw/L4Sn8Xu8g1qt19hzzMyubsl6
 eIlZM16FXL2FGllxxpH9X+ho+mAnUo35HTI8IFzD2CAAoB4uBrAjY4zPmLsqSa+Ry41VDisri
 6qRfdwIiJ9Ym9Q/f2mrILvYfnGC2bmmiU4R31fyg8mF9GGv20i85Zf4f0gfxdW0fozz9Z2SC/
 EP0f8w14dIyOhsm8vH1zZzBrDhffxcWyYIZE1EW3DHShDoaUlcVLQ0gQD1kxZx9ewC5A5AQNY
 ksMp877c7UUfI7/R+s0yi8UVDXON/Vcv1UnN9XUPUY9zvqPE6tGOV9D3ddYBfRg7ODBx+B/sY
 ou1iGopYBPXbFaDth+NVDaRjtqcBFcotwZ/Z0PMFmOJGg/kaNS2+XK6KqciuRIA7C4SnEV61e
 ORZVcfP6IGgoAClAu5xJewuQjwINk/XOvUOdC1OOO30uxlsnF+Uq+WnBLHEM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Thu, 7 Nov 2019, Danh Doan wrote:

> On 2019-11-06 11:23:00 +0900, Junio C Hamano wrote:
> > > @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct writ=
e_commit_graph_context *ctx)
> > >  			    num_chunks);
> > >  		ctx->progress =3D start_delayed_progress(
> > >  			progress_title.buf,
> > > -			num_chunks * ctx->commits.nr);
> > > +			(uint64_t)num_chunks * ctx->commits.nr);
> >
> > Hmph, do we need this?  I understand that the second parameter to
> > the callee is u64, so the caller needs to come up with u64 without
> > overflow, but doesn't that automatically get promoted?
>
> Neither num_chunks nor ctx->commits.nr is promoted because both of
> them are int. The result of `num_chunks * ctx->commits.nr' will be int
> and will be promoted to u64 to pass to caller.

If you up-cast, maybe do the second operand so that nobody has to spend
cycles trying to remember whether the cast or the arithmetic operand
bind stronger? I.e. `num_chunks * (uint64_t)ctx->commits.nr`.

Ciao,
Dscho
