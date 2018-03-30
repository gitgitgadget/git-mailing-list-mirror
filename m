Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8851F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeC3TE1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:04:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:48707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbeC3TE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:04:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaJPk-1fHRnq48cK-00Jodt; Fri, 30
 Mar 2018 21:04:15 +0200
Date:   Fri, 30 Mar 2018 21:04:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
In-Reply-To: <20180330140840.GA5869@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803302102480.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de> <20180329213823.GH2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180330131456.GB29568@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301558360.5026@qfpub.tvgsbejvaqbjf.bet> <20180330140840.GA5869@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8KjBMgzZsjt1Fu7FGdNlIe8eswLeaRQtkMsSdQ55ZzNDVjV8AT3
 1p8zepdXny0YhZyV9oxZ1z3rE0q0Dd7G6OqRgWL+GPPuF6YsUFpsD1sEll3GtOEJdJUU3GM
 ozgTHAU3fEOp+QHUqwy+yXBLGcMIxITCbTokDoJ8HiA3RKLYThkdGz4GY7L9RIPhMw+I4/v
 qgx+CKPjKLolBh2CU8RIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vXk0AK6fiP4=:A8hbgGBalInwmPzjU0ljg2
 JsWclR0rFhRaKbS+TILiFoSg0H2ITmyt5ONGWiaZjZj0JbCmv8lnZyBhcjmy+o3E4qXHsz50w
 vBvxqM0vqo7vwwfu34fyaxQxtlTNpz/wFzzdsmmbJs9sO/ATl89wpRAhpEv/eU0gDC3gqHnZm
 Aadoh5QtC3iWZrtPtc75lWHNg6uX4Sp4jGazo6L0L/vQeSMtzQ6TboRYAR3m0zIFeBYn8H9Wt
 CPmO3zZd3T3K4kHSFo9nBbT0J6rIaYvqeYbU8G7xM7btRXGGaLEhB46r3xtkxp0aFdWV+APkM
 s0xuitg3ZjIWV/mC3l5imdfB4xG2npWa8Iya9XrPvtPeqb+oDF2ZYiKWJxFBBs5zm95j7RA/T
 XbvCNoN46dy7rUJpDLi/ITojLutNrhKalUT6juREXMVkNLs7+NPhEj857Ar1XwqNPU90MuS4y
 Xoph5X0VJazfdqZc3wt8N3BmFLLuN166aWR22xi2aBmsu3ERSlogq+FP4sDxC4xnJfrrg83fc
 N6K4WdonuxDwnFN+QhdfLmIYhCW9gwh8vH5DyqltnBd61yd5DjD2Rb9aOzj8/d0DAV6Ll7wbY
 xGzLw9pJq6hXvR5K0pNXOO7upQi589PDFK3Fu03lJ9szhY9WwEbuEeVEGB2Qkr6V28lQ2nyho
 yb53Nb0kdJHQQg1NLw9GpYZnzSRppWhxfAzh6GKubc9xjYIwUC9mQuZ1i840b4/mCznkhSI3P
 WwH1tbdWjoa9zRN56PpM2m0SFAnZxC5g8b+pDbQtZKb+UoT+H6jm7UWSg1SQJ97R5SWurJ+bw
 gXATRlMeEerBfE6XwDhuSGsEeo8Eh/frOoakM6CLUxM4JL+F2zjIBudFmJKuRC2I6nDFpC2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 30 Mar 2018, Jeff King wrote:

> On Fri, Mar 30, 2018 at 04:01:56PM +0200, Johannes Schindelin wrote:
> 
> > You know what is *really* funny?
> > 
> > -- snip --
> > static int git_config_from_stdin(config_fn_t fn, void *data)
> > {
> >         return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data, 0);
> > }
> > 
> > int git_config_from_file(config_fn_t fn, const char *filename, void *data)
> > {
> >         int ret = -1;
> >         FILE *f;
> > 
> >         f = fopen_or_warn(filename, "r");
> >         if (f) {
> >                 flockfile(f);
> >                 ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data, 0);
> >                 funlockfile(f);
> >                 fclose(f);
> >         }
> >         return ret;
> > }
> > -- snap --
> > 
> > So the _stdin variant *goes out of its way not to flockfile()*...
> 
> *facepalm* That's probably my fault, since git_config_from_stdin()
> existed already when I did the flockfile stuff.
> 
> Probably the flockfile should go into do_config_from_file(), where we
> specify to use the unlocked variants.

Ah, that makes sense now! I am glad I could also help ;-)

> > But I guess all this will become moot when I start handing down the config
> > options. It does mean that I have to change the signatures in header
> > files, oh well ;-)
> > 
> > But then I can drop this here patch and we can stop musing about
> > flockfile()  ;-)
> 
> Yeah, I'll wait to see how your refactor turns out.

I don't think I'll touch too much in that part of the code. My changes
should not cause merge conflicts with a patch moving the
flockfile()/funlockfile() calls to do_config_from_file().

Ciao,
Dscho
