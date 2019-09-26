Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55641F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfIZTsD (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:48:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:36889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfIZTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569527278;
        bh=HcxERnXq1HoUwIqE3zGJg1D1I/9PeSuJEMjBi7XQipM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eoVILQNBvAXC3S5zddYAd5KCz0Cc7mgaMkfOY/oZXzGYPGTjzsi4T8CFV8ddOui16
         yNZCvTPmkuXjRvLNA7K64a5TxiEnOayrSxgOc0T89z0Yqw7Z2KbUR1hGy3J/anMVwz
         8riUDeJQaFS5eZQiekXbGReUYIRU5jhwWDpNgpG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1hvd7L3tGY-00sbqL; Thu, 26
 Sep 2019 21:47:58 +0200
Date:   Thu, 26 Sep 2019 21:47:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Makefile: use $(ALL_CFLAGS) in $(HCO) target
In-Reply-To: <20190926173801.GA42456@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1909262144060.15067@tvgsbejvaqbjf.bet>
References: <cover.1569263631.git.liu.denton@gmail.com> <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1909261449230.15067@tvgsbejvaqbjf.bet> <20190926173801.GA42456@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bkrI5EUn5x2Bxe6H1Tq/qac7o8npMwzhMiMe8DH3qAFh4IWfF8n
 tNelrkhGxdKls20aQxN0qJ7CWViclz+4m5GmHnBYO8BjrIWSstjiiYjrTlPLInzOjHGg8i3
 5Z0nI9Akia724cTK5TQJNE5ENk38ssqLqJROzUKt+o8ahRWAWUxUqxmnvdX4dYG5LfURc/o
 B05QUYQF1TgrvZy7wUQaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOyd2zc7uBA=:ie8Q90I6/Qk4cuovSAppNY
 XuHheptWz6GQVZ2iWjrEj72+7Rxjjyidu+JY2QulcL/zpE2WObazvM/mas73SFd4TPbnXUeHA
 9pJi7toVQ509jOLxYWntpR0SGecEFl0DaIvvonfnS9RF6OeS3hV+xOrG67IRmeWRwqoMQMuwj
 133x1TYCQAsNC6V3o+/DcBAR6TJcBp9QyIFUD4SNGH+puldqL9q8GHDxc4WAnUPi+otynWoTr
 2Xm96Mv+QeOqOCJ3lqQdCX1K3VANFCFDWS6ReQ/tzFTN5SK3orV8HY8QEd4xnCwduSi50tFVX
 DJvFHoi1oRphUgDQxeJ3ZmjzFw05yBbSqvGzpP/owK3e2KTaE7NBFTupASEkWocbYfv8GyzNy
 3GBmeE7xnCC6R9VO/csygIZiW3eeoOeUJd+L6ehBaW0UYNwwt6CweyNYVmphO/mm6pw6a+pIX
 1Thx+B375/5Uj0+pLq/TjkMiuJ0fv+rx5KHSHymTEfWqSSQg1ELS9JGQWnGPBn7Mf84tOPdDJ
 fDLEqu60i2jCiTI2t6sYBoLUTieC9yaJ2piX58ZaU78m5TMDH7PxzfDMSma3LhwX3cPjZ9ouc
 8NrdFXUkxZM2gmWh/DMmyZQDtT6k5LPV+ty7WDOqa9xnl9g+lA1dFI7dsomtnbprE9XXUQpGg
 X90uQX8dQNkqTekIRgIwjF/ieWVSyK4atxj8XCg2wb1AV7wM2O6FWP+SuujGU+++06frVA5BU
 38qO7jx9obGkA8M7XAD0jlaOXP4qhUiLPG0bqagYwem5tBboaznR4pA6c3itc1BNiK0hhmaB2
 pcSvhkQAKpRItHYd0m3A8M6WZL1BDhcPklaWWNVz/Y7JPzl8cInMZqsQglrY7h3NyaOq/Ewhd
 JbKrjatpOEU7+3xb/jsNOwhc7WeNILgyqOsE2CwwJc348mPiwyO5lbpTR9cvnAtBvADVGBmb9
 PV38mAjyQ4ECgQqOyr5yhobFiuv8NQHUtn/9BQyo3rGzJj3Svnow3kdiH7tJdaMqe7uc44hgQ
 BPFTDiANwsndF/CH0bWzVfkNTpobYE9dGaBOJzmq8qs/c/e86L32MSumeyp0j41Xfb6N+FmwN
 DvCLKC87lTqH5Z0L3r9oeaCaL89eccGzF4SmE+G/WjK+bqdY0/2NZnhFqSVbhZkW7ARh8tgQJ
 hbSbzDhAZ38nnCbxDhA116uF3Y4fw75n7mUrFGAnf/vc1yY6tA5AbHeDyHzxOfyCXLQOucWit
 7JpQxHlz9WJ3Mavhva+exIoTNMTz6xrrnUw8QtHMY2huJ0mdC2PUWNEbgymI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 26 Sep 2019, Denton Liu wrote:

> On Thu, Sep 26, 2019 at 02:49:55PM +0200, Johannes Schindelin wrote:
> >
> > On Mon, 23 Sep 2019, Denton Liu wrote:
> >
> > > On platforms that can run `make hdr-check` but require custom flags,
> > > this target was failing because none of them were being passed to th=
e
> > > compiler. For example, on MacOS, the NO_OPENSSL flag was being set b=
ut
> > > it was not being passed into compiler so the check was failing.
> > >
> > > Pass $(ALL_CFLAGS) into the compiler for the $(HCO) target so that t=
hese
> > > custom flags can be used.
> > >
> > > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > > ---
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index f879697ea3..d8df4e316b 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2773,7 +2773,7 @@ CHK_HDRS =3D $(filter-out $(EXCEPT_HDRS),$(pat=
subst ./%,%,$(LIB_H)))
> > >  HCO =3D $(patsubst %.h,%.hco,$(CHK_HDRS))
> > >
> > >  $(HCO): %.hco: %.h FORCE
> > > -	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -=
xc $<
> > > +	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -=
xc $(ALL_CFLAGS) $<
> >
> > Isn't this essentially identical to what I sent in
> > https://public-inbox.org/git/pull.129.git.gitgitgadget@gmail.com/
> > ?
>
> Whoops, didn't notice this. I heard there's some quote about great minds
> or something ;).

Hahaha! ;-)

> Anyway, this patch is superceded by v2 4/4 which should emulate the
> compilation process even better, as suggested by Peff. The only
> problem with that patch is that it splashes temporary *.hcc files
> everywhere but I think that if it's only a developer-run target, it
> should be fine.

I agree that Peff's improvement is nice.

The only problem is that my patch made it into `next` already, according
to https://github.com/gitgitgadget/git/pull/129 (look for the labels on
the right side, or for the comments on the bottom), and
https://github.com/gitster/git/commit/a3f332f4fb10 agrees (look for
names of the branches containing that commit, under the commit message).

So we should explicitly as for my patch to be backed out from `next` and
be stopped from advancing to `master`.

Junio, would you kindly do that? According to the PR, you gave this
branch the name `js/honor-cflags-in-hdr-check`.

Thanks,
Dscho
