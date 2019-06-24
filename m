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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8261F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfFXJwa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:52:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:35137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfFXJwa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561369946;
        bh=cdbVNnaPNbX/CSp+10WYMKnC7MKHv3uibitPZ01XdLk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XxMQcbYAKz+tVtKpFdxpJZPknyatME8pCuNjCBl15/SR4KdVs6e5z/WSdJQ06lTo1
         d8Q7AZYMzIelLhKiJ9Gthhng6ipV236cjVzquI2eKQa8JqxUpy76dHNpJV0XTO3Rz3
         6Pmam3aGEEU27dwu+AVsLRAoJZo+DGtWn/mIH2/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1hjlV403Cy-00DGAp; Mon, 24
 Jun 2019 11:52:26 +0200
Date:   Mon, 24 Jun 2019 11:52:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
In-Reply-To: <20190621205150.GC25874@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906241136040.44@tvgsbejvaqbjf.bet>
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet> <20190621205150.GC25874@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wCEyeOKY3fp2xBN+O+jH3W3zKDrX/aThc6OG4v4+HJMMfF7w9u4
 Z1mwT0jKesjeMQtyevd0WGu1IKoFCzvx9YednXUDy41N7zsII7Fp8z6mgByrY0zKzRQlY8M
 70dLdQpEURrhEGiqx2XRi1r2xaFAIDYNpZfA46xtUBD3bteIK7OUVsyNJHkOdAujWAvbsUx
 Q6ubehYhydCiqRU3toc6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yDKkk5zCAe8=:5z8fiafQtTkq+iQvHlXWFv
 ujg1Tsn79pxxEVCAJPxE3IFW4QpCZBUS0B+V8pVXrTz2xoIn1hmf1xyWXXgimMdP899CSSItD
 3+BdkQmRcmHkyixwl6717vwHJgnOkRV//+pRPJdBlw+XK90RilgWaEnwlf6/i/ikb1yLZUo/W
 XAeuI9jbDgqBUSix+o1wD0uKZsQWfVsBMQYQ0EVJSQ88P7TD3lTt2swCd8OQ5oEAqskkfWOlQ
 mlqFESg/aZB9UKVr2XIEu5NjlkoMOzxdDY9PvKlQwMxrdxasuRiyPs45JDKaJFpFwVmOmzQ+t
 9FLpNBEKCBDFcYC8+OUH+GnFf2dYy4A8GQWIH31l8+jPK2mQ5vXdWs6XTMoQrsna6/wPUlYhf
 ZjloyPhnlHnW0+1lHBlRBEzYOLkeKJrsy/DRIHv2M1MoU9AYgARyPqZeWUH3Fz/TZDfsathfe
 mnggeVAktD+RzCvdANLSXU/44QuBDHVXHYyffQauW9eKnT4snNcyzNHHSG+YVAK5syeCCyaCW
 4OSPekGuqbtpSF3z00B0a9BEwk9TG6LtensrKRe0TLUHwQyI3AT5KJ/hWxkw9krXx0jY8K/pi
 3tgCS2/EuIteBC/ntbQMl43ZpeB/7ll0rZUjhB+VvzUTZZI/OsEq3k/eOEO64VClMC5DKToHF
 IeJs/JpR4YPWLEiriYlvyfy6QENuotL/C3iJ25XTW7mXhOnLXpMXlc7Gyrd+MR4kdJci+lztX
 W9oRSsMfkbit/pya6guTaQa3e+q53o7ccpjhYIj/enmBDACkrSmf0sKm6wet+D24wytQnKBJN
 TeOnrguHeDofza4CPiQtOy2wiIEJASFS2+k3F3ZgbvGT0fdMiT7aoAMeZUkR5WRD3oY/hgrAk
 /Z5b54vaP4fJq57xuVRCpD3EV1cUZc2v4hPLBYaEwiEFIGP8dlbXOfZpG49Hnpkt8lmUG5I4p
 VnFNN5htXVrvJplPe8jli4KwylTO/RRhDoc/SL8u6IDcXfLeCrM4Z
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 21 Jun 2019, Jeff King wrote:

> On Fri, Jun 21, 2019 at 03:16:52PM +0200, Johannes Schindelin wrote:
>
> > > I think your warning in the manpage that this is for debugging is fi=
ne,
> > > as it does not put us on the hook for maintaining the feature nor it=
s
> > > format forever. We might want to call it "--debug=3Djson" or somethi=
ng,
> > > though, in case we do want real stable json support later (though of
> > > course we would be free to steal the option then, since we're making=
 no
> > > promises).
> >
> > Traditionally, we have not catered well to 3rd-party applications in G=
it,
> > and this JSON format would provide a way out of that problem.
> >
> > So I would like *not* to lock the door on letting this feature stabili=
ze
> > organically.
>
> I'd like it to stabilize organically, too, but my thinking was that we'd
> wait a while and then promote it to a stable name eventually.

Git's command-line options have stabilized organically.

Example: to include untracked files in `git stash`, use `-u` or
`--include-untracked`, to include them in `git add`, use `-A` or `--all`,
to include them in `git grep`, use `--untracked` (no short option), to
include them in `git ls-files`, use `-o` or `--others`. The command `git
commit` does not even have an option to include untracked files.

You know of more examples of organically grown designs in Git, I am sure.
Given those examples, I am not sure that I want the JSON format to
stabilize organically.

> > I'd be much more in favor of `--json[=3D<version>]`, with an initial
> > version of 0 to indicate that it really is unstable for now.
>
> That's OK with me, too, if you think "0" indicates that sufficiently
> (we've used "v0" in a lot of other places to refer to stable protocols,
> like the git:// one). Maybe it's OK with some documentation making it
> clear.

I did think that the `0` would be clear, but you are probably right.

> I'm not sure whether we want to be locked into supporting this v0
> forever or not (though maybe it would not be such a burden).
>
> I think JSON-based output also has the potential to need fewer bumps.
> It's syntactically stable, so it's really just about our schema. And
> it's easy to say "newer versions of Git may produce new keys; you can
> ignore them", as long as we do not change the meaning of existing keys.
> That might be an easier promise to make.

Right.

Thanks,
Dscho
