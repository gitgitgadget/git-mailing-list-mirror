Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A7720248
	for <e@80x24.org>; Mon, 25 Mar 2019 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfCYOiP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 10:38:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:55911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbfCYOiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 10:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553524673;
        bh=ri3dq2n3eZRRDJ3X5U0rCDR5Ry71EuJOR157sq9svBc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ou0hITCKjTdbJtkPEh3ZLA5mOjzi8lnL0W/SjNP7Etkd4QAXM25UQjZ9eISIjEWJl
         qfOYQtKKn2NPzayZefzqcHTBrwUKD6iTCXMov83Q/7rmnquN8zIbW+1wINuvTQzHsv
         4WoD9o4eaRHOj/T6NIH1CN13OOYM7SMJr2GKFFDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb8MV-1hOafz3qln-00KhLA; Mon, 25
 Mar 2019 15:37:53 +0100
Date:   Mon, 25 Mar 2019 15:37:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mike Hommey <mh@glandium.org>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: How to properly find git config in a libgit.a-using
 executable?
In-Reply-To: <20190322141925.olzzfjm5ytp2gwv7@glandium.org>
Message-ID: <nycvar.QRO.7.76.6.1903251529110.41@tvgsbejvaqbjf.bet>
References: <20190320101941.2xjsjx3zfnnp33a2@glandium.org> <20190322073311.GA839@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet> <20190322141925.olzzfjm5ytp2gwv7@glandium.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Sdze0u32NSPPibkJWQXK3/vBkj0OGYQWhPDWQAQrdP/TWXcmXvS
 GukWJZ3j9fhcXHII8SFTzh+AHJL2nSTnRYO8YsBDGZLDmSFLyDBTDiTTuFonthkq7xNJx/+
 7oeXkvRqNG54ZR7/xnkgcD72J8hRq8ZqVJs493zFwEYoVTVgP6MZPHZjs+bzzqySETmfZwj
 p5swIPbMP/rz6SbZFYG6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gO/tTmK/CYA=:jTPQi4LpIONY3NA0voPKi9
 VUejURyZ+lZNcjm59Kmh5CxyL2PI1NXKRwmzE6wXVcN/ACzZ9brl0shHNa3gOt5I1j6EXPBrV
 H6nLXNQDMP85INxUaRx3K6yJvaps1M7xBQxxwaW8mJ3VZWKui7lJe8MeRhu/l5fCTPRVvId/T
 p8hzlzkbjWZKjQMIpecq9gUBDmKd+GZC7Q8FlC4gSA0N/srUKyiI+cy1RL1Gf4NnYHL8n2EjD
 Gfy0IzhqlxaE3c72Z/kmieVGH3px882fwqDLi1sZgDsLVTlMP46bbABgW0BIDGNV7wtpDnkU7
 4iRuf5KHMIH8DstZgjy86eMvPb8ty+qRJufu9XFRTdL6UBWwPAEKc9q9BMAm1WlQF0Wb2Iy8B
 XoBeKNUx/kyoIDs6ku7kXm8A3aFrS05fS3XBzFIMF/JWwinZyTmz7P0Z6dyBjy/dRNgqSfmmx
 Wh8hudaN5NnurZOxL05oPoadWiuH5q3NbYOab0fuMOzHlIkOQomziFSzbqRueROHifPpVS/aC
 B8Cgep11Cgv17a93BRtLdJZxgAj6vUV6opE/nzitUv0Clvw5vie0cOf2+ujJ4u8wwDw2hToOC
 BP60VOTGXe+TAs4Kj/kOwXcRblomYYE0ZyMvaAZ2r5oeXbyJyVUqsoLGmRtHtKvVmfWVSsy1O
 hGwBwmasQL1y2YJ036iBb354RiGRgknXvjsDgx7utzgk5+m+QWN3MwuckrsdOQA4UEdwLfA7+
 NIkgs2SSqPVqBsRNCyVSwzkPcom2ar3gOXnrf7axWz0fT+AWE5jLSoy6ev778KfnxPIG/SMrh
 b84D+inKRJAHVlB2hMgFGxpgljuHztQZU8eKruXxSqNU7XKUnklGG/UywuOC4W1ZwffqMMXX2
 CM+Pvybh8xr5kDhARnPq8MaeYllNXOzO2LlEEPjRk3mU7+2/kiyju6A+491h30wM9MSat0RZ9
 qOXbwCwVTQw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Fri, 22 Mar 2019, Mike Hommey wrote:

> On Fri, Mar 22, 2019 at 02:39:43PM +0100, Johannes Schindelin wrote:
> > Hi Peff & Mike,
> >
> > On Fri, 22 Mar 2019, Jeff King wrote:
> >
> > > On Wed, Mar 20, 2019 at 07:19:41PM +0900, Mike Hommey wrote:
> > >
> > > > I thought of a few options (it's worth noting the helper is invoke=
d in a
> > > > way that makes $GIT_EXEC_PATH set, which can help a little):
> > > > - spawn `$GIT_EXEC_PATH/git-config -l -z`, parse its output, and s=
et the
> > > >   internal config from that. That's the barbarian option.
> > > > - build the helper with RUNTIME_PREFIX, and modify the RUNTIME_PRE=
FIX
> > > >   code to use $GIT_EXEC_PATH if it's set, rather than the path the
> > > >   executable is in. That actually sounds reasonable enough that I'=
d send
> > > >   a patch for git itself. But that doesn't quite address the nitpi=
ck case
> > > >   where ETC_GITCONFIG could be either `/etc/gitconfig` or
> > > >   `etc/gitconfig` depending how git was compiled, and there's no w=
ay to
> > > >   know which is the right one.
> > >
> > > I'm not entirely sure I understand the problem, but it sounds like y=
ou
> > > want to know the baked-in ETC_GITCONFIG for a built version of git (=
that
> > > isn't necessarily the one that shares your build of libgit.a).
> > >
> > > There's no direct way to have Git print that out. It would be reason=
able
> > > to add one to rev-parse, I think.
> > >
> > > Barring that, here's a hack:
> > >
> > >   git config --system --show-origin --list -z |
> > >   perl -lne '/^file:(.*?)\0/ and print $1 and exit 0'
> > >
> > > If the file is empty, it won't print anything, of course. But then,
> > > you'd know that it also has no config in it. :)
> >
> > How about
> >
> > 	GIT_EDITOR=3Decho git config --system -e 2>/dev/null
> >
> > It will error out if the directory does not exist, for some reason, e.=
g.
> > when you installed Git in your home directory via `make install` from =
a
> > fresh clone. So you'll have to cope with that contingency.
>
> Thank you both, I can probably work with this, although I might have to
> alter the git init sequence.

If you spawn this, you should not need to alter any Git init sequence.

Also, I failed to mention that the error message when the directory does
not exist is quite helpful, too: it mentions the path to that directory.

Oh, and I forgot one really crucial thing: you want to set `LANG=3DC`, too=
,
to make the output parseable.

> I'm not sure my usecase needs git to cater for it more generally,
> though.

I guess the idea of Git is that the command-line interface is "the API".
With that idea, you should indeed not have to know the exact location of
the system config, as you can simply consume the output of `git config -l
-z`.

However, given all those really impressive performance wins we get out of
all those conversions from shell/Perl to C, I am inclined to agree with
you: any remotely serious application that uses Git either has to access
libgit.a directly (even if that is discouraged), or has to have
non-trivial code inside Git to support their use cases (all those
`for-each-ref` pattern enhancements we had to introduce, for example, to
make it remotely feasible for a 3rd-party application to work with the
amounts of branches we sometimes have to deal with, for example).

> Who else uses libgit.a?

I only know of cgit, the fast alternative to gitweb.

Ciao,
Dscho
