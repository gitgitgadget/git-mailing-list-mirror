Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC20A1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeKIBVa (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 20:21:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:49769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeKIBVa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 20:21:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVBq-1fsqKi3nSc-00gXAP; Thu, 08
 Nov 2018 16:45:19 +0100
Date:   Thu, 8 Nov 2018 16:45:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net> <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
 <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mHnpdimpHjR4MpH5n2yfQHqfjMEVbzpWPdek6PdC6e2DCDDqpJg
 NGc132NQB4uJ69ltz6O+JGdwWtuBHEEcXloqlUhwPmf+xYSHFNeFlLj5BuOb//0i06d4qWr
 qIW8+VHy/C/Q1BfQHkFvt5d9A+SNpqkORoWGM+S1rhfeMVfOsL55umeMf47JA8bHzNScm0t
 ewlbiohHMny4fRBjnzyRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XeDEvoTMbRg=:fexfABoQxu14q47sCbmKyN
 fwY1Us7CDBV5fOv91Lgh65nskaTX4x5964PcPwr5RyDHyT0Uk4FpG2L0hpnOISS1bSTKEHSP8
 trz/F7RcVPtRtfE6chCjtrQ5hpsnfG/SkzQhanz6cJXlfQXJaVlyhAWoAN9h9rXDFiFy689EB
 Zij0eUMEJccAYySWGmKOaiRSHQMU+t+Ux2JtNxkMJJArfWrvykAkoAxW+kBKRKdfT+2Nk2NQg
 2G398ISvXwOiz8YAwHsWQgL/9/24qHG+crYcOWmSLVGkFAXqkm+2aMQfi3seRIYZnsWIHfqNM
 nO+Sjat8a6DmUoU0jsVMVe6Gl4licfJXvUTPcJtFsSwTMNSuOaRZFX0CjrcyYGI522cBRRov0
 cPTP3/83Q9yx3rDY3vTkm7O6lppFvUL9fJ2NMfO8TdT6d9a2F3cMXBjngNtFwzpExOCQvE9EQ
 JPKkd0tzHFPtdSV2kuMzd0IEihOchgBxIbv1Hn7XsW0A0E8NyiQ1uafJCNqXtgbeEtNnsDKC/
 KaSkxgCO4CBbjELylmv8oCHRzKSJICZtjLCIYbLyzOqESO0kWsE3FNDQa7VaaLqvR2WlM1n1Q
 fNIieGqki9+YXH/5qVBG8TYIvKk04fzQ6v8h/JCbxKJOVekA3Gj5kiDnRmXTDgQKCOdBs9HSk
 qVlmzBnAm4DQTHZ0Jjz29FXdR5cO9i7ZomdQ+jw0K7GjyfGxg2SOsWbBHrlg4SsYPf7XyuySa
 AXu5Fo8RPrv7aUAj68O1/HqipBS9hxi2lYY+5FfObuXCMWhCl0Bwii6qmzqZwTQeKEHz7XRGO
 R4Cr4v8jU6mMrX7Y4sh6NwsUdzfzsdT2bufQuVVo5Z3FgikIvnwe66GBX9hcFKmjzPSVoU/bL
 UGJOKLO/jrSmgTfwpYq/XWTtTMdfCYTfW5TqBVLlSFVIE26zVTbjuV5iQKZ2mF2DUZQU5hOsg
 NOp63UOjnXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 8 Nov 2018, Duy Nguyen wrote:

> On Thu, Nov 8, 2018 at 2:14 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 7 Nov 2018, Jeff King wrote:
> >
> > > All that said, if we're just interested in allowing this for config,
> > > then we already have such a wrapper function: git_config_pathname().
> >
> > Good point. I agree that `git_config_pathname()` is a better home for this
> > feature than `expand_user_path()`.
> >
> > But now I have a really crazy idea: how about ~~/ssl/certs/ca-bundle.crt?
> > The `~` prefix is *already* a reserved character, and while it would
> > probably not be super intuitive to have `~~` be expanded to the runtime
> > prefix, at least it would be less ambiguous than `$RUNTIME_PREFIX` (which
> > *is* a valid directory name).
> 
> One thing I had in mind when proposing $VARIABLE is that it opens up a
> namespace for us to expand more things (*) for example $GIT_DIR (from
> ~/.gitconfig).
> 
> (*) but in a controlled way, it may look like an environment variable,
> but we only accept a selected few. And it's only expanded at the
> beginning of a path.

I understand that desire, and I even agree. But the fact that it looks
like an environment variable, but is not, is actually a point in favor of
*not* doing this. It would violate the principle of least astonishment.

The form `<RUNTIME_PREFIX>/abc/def` would not be confused with anything
that it is not, I would think. The only thing against this form (at least
that I can think of) is that some people use this way to talk about paths
that vary between different setups, with the implicit assumption that the
reader will "interpolate" this *before* applying. So for example, when I
tell a user to please edit their <GIT_DIR>/config, I implicitly assume
that they know to not type out, literally, <GIT_DIR> but instead fill in
the correct path.

Ciao,
Dscho

> > Of course, `~~` is also a valid directory name, but then, so is `~` and we
> > do not have any way to specify *that* because `expand_user_path()` will
> > always expand it to the home directory. Or am I wrong? Do we have a way to
> > disable the expansion?
> >
> > Ciao,
> > Dscho
> 
> 
> 
> -- 
> Duy
> 
