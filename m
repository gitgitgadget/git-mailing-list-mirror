Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E0F1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeJWR4x (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 13:56:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:57359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbeJWR4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 13:56:53 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUm1o-1g768P3N9A-00YAg4; Tue, 23
 Oct 2018 11:34:13 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUm1o-1g768P3N9A-00YAg4; Tue, 23
 Oct 2018 11:34:13 +0200
Date:   Tue, 23 Oct 2018 11:34:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2 3/3] rebase (autostash): use an explicit OID to apply
 the stash
In-Reply-To: <xmqqzhv5s3lf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810231134020.4546@tvgsbejvaqbjf.bet>
References: <pull.52.git.gitgitgadget@gmail.com> <pull.52.v2.git.gitgitgadget@gmail.com> <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com> <20181022223256.GI30222@szeder.dev> <xmqqzhv5s3lf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-988226563-1540287257=:4546"
X-Provags-ID: V03:K1:1/80+2gX3Oum+0IOhqbGOW73cCtH/PNQSPmu5zbJT5BUiQW4di/
 KDQyohwx4/ZNuXq87FNlMR5sJSvgSog0VhOkJIgkewZHrhvk9j4PRm+g7SIlmsYVNf/u5rF
 YBUShwl27+3bgV9xI/Sei+J6I/8TCY5iwZ2eEbvhP1h5YHbPq0qusAqzIYbQhltxx/bI0zK
 4WHj0SAsepNPmcwpMuX7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XXZLBOdlF3Y=:DtPkwPng/j6/o7bBI20iqv
 lSBH1TRndUSZZq1j1vEYYNHuWGgWm7sJEkQ55oAXqeI8Z9+jxj8i6iHfSIYuWbcKPDrTt482y
 kQB0AhhL0kSIgPmfclnK3O1MuvwV74goxNnLhhf6px5a0KAxWsSygyzoyXiPzV980RDXnFOTf
 r0mAYYZxfZNV0jbn0/0yyoCpnMjMAl3ca0XO9ITOXrk1NwTBZ9qEMo6TlnmaqFqlZx8QegVWI
 VDjL+RCwCoNJtJCG4dUdHZe7Dn9Bxdu2tVNCci1sTBP2yULwaYzpYSRHHNcfDYmK47sPPLpqs
 fI5jwn0yt3LKzu5NduvwsUnAs05w6yO24PHRwjZAutxhbCgfCAxEuSkp2/rbGkR4VPidRuVe9
 HbXk14RQTmqeA5OlDfpuZiKDEOvyA2vmmcH+W8hASv6x5rddCfKoKhNqpUDRxgI/7wnwTKwy3
 dLjbYZxd0rtK8lE7Zdylh7xbCWXgw+PQUHdtTVyUEX/cz8/2Mo28Jdj7dI76vXvTN5F0J2KSV
 LJVTwGjrNkl1JBh4K7K2J869lt5p449RyVBJxRRvaEBvtsSSADtYKpoyNcGDrQye/U4iZ6CEP
 ZV8IqqyiE/8B6MB+HXDD9JuhmtjwBnfYD0tR/F5pp1NFnk7qVgyvKJ0oNkrnbSdA035SMqAJ4
 zquxe3Q+o0XTt4HklDRRN26icWLb3uzmnWvE1CUhGTP6zfpcMXcXbo5YjZBBch1SLmtsPAUy+
 Q5IjmYrCKZXgQ+8GwYCH9mB9XVaIXGU4nntag3Vulw2/mxArQe/GRFFNWLbecds2/IVpEFXLm
 Qt9chRowE+TzL4l+INpanVPol8iX9WaCaiuRNQciCoKPjPIi00=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-988226563-1540287257=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 23 Oct 2018, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> To prevent that from happening, let's append `^0` after the stash hash,
> >> to make sure that it is interpreted as an OID rather than as a number.
> >
> > Oh, this is clever.
> 
> Yeah, we can do this as we know we'd be dealing with a commit-ish.
> If we made a mistake to use a tree object to represent a stash, this
> trick wouldn't have been possible ;-)
> 
> > FWIW, all patches look good to me, barring the typo below.
> > ...
> >> +	/* Ensure that the hash is not mistake for a number */
> >
> > s/mistake/mistaken/
> 
> Will squash this in and add your reviewed-by before queuing.
> 
> Thanks, both.

Thank you all!
Dscho
--8323328-988226563-1540287257=:4546--
