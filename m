Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD8C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC4322473
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T92EZbpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGNOzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:55:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:41117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNOzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 10:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594738540;
        bh=88Gk47DFSU95rtcVmVhuQR9sR1O6wOagmg246iLqlC0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T92EZbpP9rBIrH/YnTTpwAErlIFyHwr/EHmgTzWNoN01M/0krx0QUV3P9gc9inGQj
         22ZV38NlYwmkoosNNYSdDEKgfH7nWuBzcTsUs5LesSIGzGg0IpyrqpakgECjZUGw1N
         OKFIIueBWaHw7nr0Qebkz+3m7iqjlq/Cl+Ybbny8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1kgZBo1l00-00nfuy; Tue, 14
 Jul 2020 16:55:40 +0200
Date:   Tue, 14 Jul 2020 16:55:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Edward Thomson <ethomson@edwardthomson.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <CA+WKDT1GMNTY5N862-7ui70D6-b1u6fuUkvctEYo+57aJGbjmw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007141640430.52@tvgsbejvaqbjf.bet>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <20200629224113.GC9782@camp.crustytoothpaste.net> <CA+WKDT2DV6ymu-AG9B2h34=K+4KW7tcCpAfTV-rTdifqfS7R=g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2007121007440.50@tvgsbejvaqbjf.bet> <CA+WKDT1GMNTY5N862-7ui70D6-b1u6fuUkvctEYo+57aJGbjmw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:alPC26nt2enJsTlsRU0iM5P4IEIcLQ1rZo0SgwStouYo9jmm1ZH
 OB25giO7fTcTBVYA0V425T/k4sqnxyXCNg+//oRTNo1LBu4xq/8cYhiN04SRU00zXT/PWN9
 /v6YQ6pBapkGpIGL+c3h3Xk+qtXUjS3oNhWBpeQCIWeob+Y/keFiPDP4d/lGnNTwQVtVA59
 IINNShQvVOZrzJpQOEJHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8MlE/H8K1wk=:N59n3pEWPYHaCD0QbHc7cl
 tR8aRetjiNIWXFT9+neWAJ9HQvpaaJMrYHetKGOFg75FQcOd/8qKigTT16K+ZIVqlNIx4ccF+
 0h7i7ybss3volbynepUqtRxmesSR2MI3TeHfVWzadLYT92yaUwcefZsM+GKXHhlBVaDglH5Nj
 g2um4eAzlMF6pqtRGNN3WUQrkGNpBi/GwetKEoU/09EjHkp/VRfOrEbXaeAHEdU4/JJO/93et
 5AnvL2y2cdwl2kirWqq7vM2nmEfbeKcC54raDDDhrZGVc2PPWKyOXbL5qIuhFNiTK8Ne7KmRY
 NuYkPlhsDnyfJBYeDwxEzA2Ma9FiSZg7y0R9laJ08a0cHWyOf5RRxMpvTeOeULQMsjVsN4Ie9
 Bko0QuyL0HH1vA2VR3fZiJkAW5XQG0tY6s5EcZEjX24eiXr9XrmZ7QhWNGtPMFIpHtl0Oavtj
 3YfAtKcmdvZr0ULtgezv7mZQujx5Qa/rCZq9K58eJN5K0//7yR20XKFdJ9VbJVRZ5OU6Zv+O8
 2HhNPhSWF1A289TCVnkcqxFoAH7PbhcpHAUFe/UGFYpgL/M5jkDPXm0VUyS7LckzNGNXLjOkD
 uJghRO6dWTEqWOlVgLGg9k1ljrtNZ2PW+cmOeYyE4C0JpkKbkljZRBWZaLwMhFO5j6bETNdBc
 sHx+qzzkM9Lg/Ry5tDYZlBcsmiOhYfjwhMtYV9w7KqaagYfRreLj1Ghw0H5WhJSrnuAsKd65d
 ShQQvf0MHhp8VTQqC2qlk6pl/b1pmCoP2mjX7Y0MAmIL16P2oo8xALDAUkEt63aTc6pahRiMe
 l4EJGvjrZZrSt8dQRAc6tTRqdJrWiMeUsMQPuJk4cZPRAhx2H96GzC3eaIhBJc5ySVAFarLeN
 Sti/S4fbomzZRhRBq7iiDkHfI1/aWQ84PjvtI60zj/ZE6rnLsApgOEi7tfn7Kg3KiKiHNPTF5
 90qPjmMXMnoA9QJBQ1y6mlWSjDzpbgklfvDSLiAlvtHzqe6pBk/I5pBj9Z1leg13tPC6om8fB
 TY57OQ+4iytNbN+8hBFThGxndJb0s191fsr24u2LbdhrhBXuq6RlSN+pkWkktYsxPIB5coiMh
 pwaPLal7GSS8RBnRu1BPs7SxkgFZoHZh2FdcoqTSED5U/RZDMhgFTUyxXCLHboUvgqnqf5bQh
 njE712aCj7rLjtEvfosrBSIYs0KX11cnOGpNWrq0XTgPENjf7+uafxlOBPszt4PCC5CVHGBj4
 JY+V2ffWMm0oamARHUz8IPl5F1LyRnF06xgo+HQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

[re-Cc:ing the list, I hope you don't mind]

On Mon, 13 Jul 2020, Edward Thomson wrote:

> On Mon, Jul 13, 2020 at 8:38 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 12 Jul 2020, Edward Thomson wrote:
> > > One thing that isn't obvious to me, though, is why templates take
> > > precedence over the command-line option.  I would expect the
> > > command-line option to be the highest priority option given, just
> > > like configuration values specified on the command-line override
> > > values from configuration files.
> >
> > Side note: I have not tested this, but I trust you did, and my reading
> > of the code agrees that it does this.
>
> I was speaking about the notion of configuration options specified with
> `-c` on the command line overridding things in configuration files.
> Like how you override `init.templateDir` on the command line:
>
> > The truth is that overriding the default name via editing the template=
s is
> > just not a very good strategy, it is fraught with peril, as e.g.
> > `init.templateDir` is a thing that can be easily specified via the
> > command-line (`git -c init.templateDir=3D/tmp/my-templates init`).
>
> I agree that setting a template that contains `HEAD` is perilous.  But
> it's an established and supported bit of peril.  I think that the questi=
on
> of configuration specificity is _also_ an established one (and not nearl=
y
> so perilous).  Just like `-cinit.defaultBranch` overrides the global
> configuration, I would expect it to override the templates as well.

Is it really well-established? If so, it might really be worth doing
something like this:

=2D- snip --
diff --git a/builtin/init-db.c b/builtin/init-db.c
index cee64823cbb..9149f9e51f5 100644
=2D-- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -210,7 +210,7 @@ static int create_default_files(const char *template_p=
ath,
 	struct strbuf buf =3D STRBUF_INIT;
 	char *path;
 	char junk[2];
-	int reinit;
+	int reinit, override_HEAD_in_templates =3D 0;
 	int filemode;
 	struct strbuf err =3D STRBUF_INIT;

@@ -218,6 +218,12 @@ static int create_default_files(const char *template_=
path,
 	init_db_template_dir =3D NULL; /* re-set in case it was set before */
 	git_config(git_init_db_config, NULL);

+	if (initial_branch) {
+		path =3D git_path_buf(&buf, "HEAD");
+		override_HEAD_in_templates =3D access(path, R_OK) ||
+			readlink(path, junk, sizeof(junk)-1) < 0;
+	}
+
 	/*
 	 * First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
@@ -265,7 +271,7 @@ static int create_default_files(const char *template_p=
ath,
 	path =3D git_path_buf(&buf, "HEAD");
 	reinit =3D (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
-	if (!reinit) {
+	if (!reinit || override_HEAD_in_templates) {
 		char *ref;

 		if (!initial_branch)
=2D- snap --

Note that I initially considered moving the `reinit =3D [...]` part to bef=
ore
the `copy_templates()` call, but `reinit` actually does quite a bit more
than just guard the symref creation of `HEAD`: it also guards the
`core.filemode` test, the `core.symlinks` test and the `core.ignoreCase`
test. There _might_ be legitimate use cases to side-step those by
delivering a `HEAD` in the templates (which is, just as setting the
initial branch using templates, a relatively awkward and fragile way to
override it, but hey, we're trying to address exactly such a scenario).

However, even having written the patch (which would still lack a
regression test), I am not 100% certain that we would want to risk
including it in v2.28.0. It strikes me as such a fringe use case (with
relatively obvious ways out) while the patch is not completely risk free
(I _think_ it should be safe, of course, but it touches a relatively
central part of Git).

Ciao,
Dscho
