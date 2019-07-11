Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9281F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfGKRnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:43:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41702 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGKRnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:43:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so3088638pff.8
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DEuIXH8YEPB/F9SxgSXnC5ZdpHchNCHckP2A4h8zyWE=;
        b=H2vd33Ms9JdomfoGdozm+2qMyikZHs3ScPiqA1UlMQH0dWZ0jAphNT37jq8w+0Hme9
         v6ZlcvPPaHv5b7POz8D/AzjWkLIsMNpAR6juItAVfFKKtpfijGPaBZB2b3nH1oMcQt8T
         QnbDRZooe/BSOPl5+tZZt3NyhIqlxN6+BqYQsSxRkRJR3hBIlX4Yp4vOQRRCfi0SRYvc
         H4SnOXCCCM9EDeiI2PhTMGl65Zz5dGySPM64P6+pCEAzO25SXxrSr6DfszIhyh3Ct00o
         BTu+clTy8mospEbWsiHCDR2WkxSH4nkgM2Po5eFbtIpuIgpwbSVnilVO4C4PN7S90k/G
         1r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DEuIXH8YEPB/F9SxgSXnC5ZdpHchNCHckP2A4h8zyWE=;
        b=YZPzo2lWJ5NqAQn7A8NjHE/YZ3QJY+QlVuPtPWqtUSKvETHD0hZL05tNp0UqTP4I+X
         jBGZW0vDNNPGhhTXYTlmcI5grkXa6gewtx8vA+l4S02PbFhT39tcIzxN5Xuci4/FPyGH
         Txj5ghBRebknIkC+mhLv8ceW84LElPAxD8Fp6E8xg8r6zW2OyExf+Fo+G4b56xlKByon
         f8lwtdiIqV7EI827Nfe9SAuHLrbFOaZfjHoif5xBRRAV9xnBDMh19TgmNGE8jD6UzEh+
         VgzTK5lEJXosDdE6n+xGxPcmzt37zqYAVGUbgCJ1WWVe5TmdEtTPmxabx/9ytFeKdHs5
         eOOQ==
X-Gm-Message-State: APjAAAUCDwjkifq9FuiB+59khAQlrDucNsHk1D/30UCRbveDvImDbf7u
        q3QoGLRwyUMP5EX+VmUvsiaS1/eoJhLc047vq7ZtaoQy
X-Google-Smtp-Source: APXvYqwO+cG0fE4m8EPIRNmfthLAjMTViUq/33QVrIqXZoUKaAvSL++DkQ8yG+gh+u9ofx0gXu/7ijlapVEMQ6j5VyE=
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr6408964pje.12.1562866985410;
 Thu, 11 Jul 2019 10:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190711081958.2201-1-ariadne@dereferenced.org>
 <20190711151900.GI9224@genre.crustytoothpaste.net> <CAAOiGNzXreYk9xoVOFkcivrXK4QkH495T7Lq76j3oz593rSzDQ@mail.gmail.com>
 <CAN0heSqZcTBE4qtCNQNUVB=4y8OUh03U5_a+PDJU7vfZ9Nwu9w@mail.gmail.com>
In-Reply-To: <CAN0heSqZcTBE4qtCNQNUVB=4y8OUh03U5_a+PDJU7vfZ9Nwu9w@mail.gmail.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 11 Jul 2019 12:42:54 -0500
Message-ID: <CAAOiGNxnOQ-FMGwBzZ92c8gJr0i+e8VBNCp6itJGCs24C6SGvg@mail.gmail.com>
Subject: Re: [PATCH] log: use mailmap by default
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jul 11, 2019 at 12:09 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> Hi Ariadne,
>
> Welcome to the list!

Thanks!

> On Thu, 11 Jul 2019 at 18:39, Ariadne Conill <ariadne@dereferenced.org> w=
rote:
> >
> > Hello,
> >
> > On Thu, Jul 11, 2019 at 10:19 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > On 2019-07-11 at 08:19:58, Ariadne Conill wrote:
> > > > The `git log` command shows the author and committer name recorded =
in
> > > > the git repository itself, while other commands respect `.mailmap`
> > > > by default.  I believe this is a bad design: it causes log entries =
to
> > > > reflect inaccurate information: anyone who changes their name or
> > > > e-mail address will not have that change (recorded in mailmap file)
> > > > reflected when using `git log` by default.
> > > >
> > > > Anyone who explicitly wants the current behaviour can clearly reque=
st
> > > > it by setting the `log.mailmap` setting to `false` in their
> > > > `.gitconfig` file.
>
> It would be useful with some tests for this. That would be a nice way to
> showcase how this is meant to work, and to protect this from being
> broken in the future. From looking around in t/, it looks like
> t4203-mailmap.sh could be a good spot.

I agree.  I added a regression test to t4203-mailmap.sh in my second
go around, already.

> > > While I'm in favor of using the mailmap by default, typically we want=
 a
> > > way people can override a default setting from the command line.
> > >
> > > So in this case, we have "--use-mailmap", but we don't have a
> > > "--no-use-mailmap" (at least, it's not documented in the manpage). I
> > > think we'd want to add such an option so that people can set it if th=
ey
> > > need non-default behavior.
> >
> > I agree that there is probably some useful reasons to have this
> > option, so I can add an option that forces mailmap usage off to
> > supplement the --use-mailmap option.  It's no problem.  I will
> > generate a new patch series in a few minutes.
>
> There are some tests already in t4203 which test that for example `git
> log --use-mailmap ...` does the right thing. If your implementation is
> correct, it should be possible to drop `--use-mailmap` from there and
> everything should work. It would then be very useful to have tests that
> `--no-use-mailmap` does the right thing. There's also some testing
> around the `log.mailmap` config, which you should probably adapt and
> possibly extend.

Alright, I'll adapt the tests as proposed.  I agree with your
conclusion that dropping `--use-mailmap` should be perfectly safe and
not cause any regressions in the testsuite.

I already did add a regression test for `--no-use-mailmap` which tests
it with `-c log.mailmap=3DTrue`.

> The documentation for `log.mailmap` will need to be updated, since
> right now it says (or at least implies) that the default is "false".

Yeah, I just noticed the documentation needs to be updated for this
change.  That will be resolved in v3, as well.

> This looks like one of those very small and simple changes that turn
> into quite some work to ensure that the tests are all there and that
> the documentation is up to date. :-)

Yeah, this is definitely more docs and test oriented I think.  Thanks
for the review.

Ariadne
