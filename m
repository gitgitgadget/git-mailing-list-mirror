Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8C71F731
	for <e@80x24.org>; Fri,  2 Aug 2019 14:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436747AbfHBOrw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 10:47:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:52731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436743AbfHBOrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 10:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564757263;
        bh=oGTyXEpjLgRJOgVWMr/A3nSe8t8aFYET0Coey/WOg48=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C6MKfHrnSUaiWos1j4YricCKwfBR3dNjBjihrTP8DRSCfhJ10bTzthy0urcynSMCy
         holLgLalybMgZQxgEbQElcQKI7jnQqq8I9/3uhJu7P1DIkMD4QEjrwz2DFPgp5hVOt
         2tbByV/GES1Na2cFCGDLro6l26iNA/a+V2jOPYz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1dc-1ho2Yt2zdU-00W0F6; Fri, 02
 Aug 2019 16:47:43 +0200
Date:   Fri, 2 Aug 2019 16:47:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
In-Reply-To: <ed45493e-2a99-1137-cdf1-9a14b9c3bf7e@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1908021641200.46@tvgsbejvaqbjf.bet>
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com> <20190731171956.GA26746@sigill.intra.peff.net> <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com> <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
 <ed45493e-2a99-1137-cdf1-9a14b9c3bf7e@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2127KSYASG7vWwLVttqbPfJdQxTcUTw1AziepcSYYEt0YOGUdDl
 hzF9cOQP7Ha+CYWGoFhwAxGz1Yabs52kB8Bckt+QoA9OLZKPcxTs3cc9oHxbtagtrqPwhwA
 TrzjeDUlLziuixF1frwhnuMWYmy2ly6x+KPETG8YWJ+CUchKRMlu0rhVkmahgg3AMWmgRsb
 z+mFU2AR+WTPyjgslYIGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kO4la9OUYDU=:nycP6bbuPXsJRzeqi0GGvz
 JOkHB/SlgH3TW4o7J45yAt7Y4EtEsMBYdXrsJLwfkV53qIVMbp8KXa4tLNzQkzFTyKqyerJ36
 aGvJOlgRAnKX1TU7ziA0fbQsU/naQpDQCeefq8bexkdTrL2uJWlS2biGDAzsPSlv8DsRc5rFq
 cTbdR78UnL6K1zoP9kfjmPXiEyzaqeeM+Vhm5cqdtu2vF4A6rufYYQKMOkesyr9R7/QHTZcID
 tGEA7O0MdQNiMkhleEcTaLkX0o/dh07kG7HrRRVLKvRPcU05XRItRBhvIYHcE98uhpBZ/Pli8
 A9osFa/MlDXqNg8LwVfvOPjGo3J47L+9hg11t8+ANCwLBemOcSi72LvbadSAU9GuLvxtgmwL5
 DMzR7XrLqxaXCMM0XfuN7UhhotU/d+ZmRyWaqzcp77fK53TC3B/klPizqzPybutZXGj/Ij5V3
 DsawK2UdFvVncRAnHjD6HTGpFRAOC9Jf1LYYVwhKrJAgIl5EhcSlWoiWCh+cnZPkodWQ0D6Ts
 t6KqKtWnUTQCSZ9Uv5VJtNdjefnSgwTmitDdVvqjK1LpRZVFTQPEesFq/YS7HiYg+Qo1zL7Fb
 dt8j9a6bHNHY6dAwlEwxX20Rk9DupN0bXebCPECT/y74bvad204F1T9fbQMNgWimKOV5UeIA1
 ZX+i1jNN1uDwUhqPS1s11wK/wuj35qvKAxyOruvcmURxiqnmTlzXONOKzy2849AcTcs6KzsAL
 rnXcaZ3zKK6bCxYx2PrU7SMZK7bNwtgFhN2UZ/j0IZy66cKHfk7qlYV+j6vEEMNap3ICn453V
 Qju7pXXpelxgqAQ/GAQANudvRCdGMA83nTmnuVcWA4mV14VpkJfD3m4n7qf4jmYwdWO5Exv69
 feWNolBytOctRX3JG7Wyl22o+FFP4lZvoc99DGTekySuz93PvE03yf7J5rlnA/LubFIbJwT0I
 F+FdjS9zsKw/FbqYEVDnFvgKgZy7a1e5WKBVUxJujdcOwkvXF4AQN3cNtLbxWbhTgkcWUhQ1m
 Ce4Y6Ie2UlvkrvJg7CIs53+R7ikwZqd5Jbx884UP1FkKkVtHtKtS3WJJ84gnEpuoXbOQtPqBT
 cPNh3CAXqEjnijGmmdFqLbEPFBER5qHK8YXtFuGgiKf6a20TxI3CCk6pHVxQmSP0HV4PfhloE
 D3iI8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Fri, 2 Aug 2019, Alexandr Miloslavskiy wrote:

> On 02.08.2019 13:33, Johannes Schindelin wrote:
> > to teach `git reset` an `--stdin` option:
>
> I think it should be changed to follow the approach decided
> here [1] - that is, use '--paths-file', and '--paths-file -'
> will mean "from stdin"
>
> [1]
> https://public-inbox.org/git/a6610e94-6318-b962-5dd0-ca379def3bba@syntev=
o.com/

I am actually not sure about that. The use case I have for `git reset
=2D-stdin` is an IDE which wants to bulk-reset paths (and runs into
command-line limitations without `--stdin`!), and definitely does *not*
want to write a file.

So I _really_ do not need `--paths-file`, and I doubt that anybody else
needs it.

Besides...

=2D- snip --
$ git grep -l -e --stdin v2.23.0-rc0 -- Documentation/git-\*.txt
v2.23.0-rc0:Documentation/git-check-attr.txt
v2.23.0-rc0:Documentation/git-check-ignore.txt
v2.23.0-rc0:Documentation/git-check-mailmap.txt
v2.23.0-rc0:Documentation/git-checkout-index.txt
v2.23.0-rc0:Documentation/git-cherry-pick.txt
v2.23.0-rc0:Documentation/git-commit-graph.txt
v2.23.0-rc0:Documentation/git-diff-tree.txt
v2.23.0-rc0:Documentation/git-fetch-pack.txt
v2.23.0-rc0:Documentation/git-hash-object.txt
v2.23.0-rc0:Documentation/git-http-fetch.txt
v2.23.0-rc0:Documentation/git-index-pack.txt
v2.23.0-rc0:Documentation/git-ls-tree.txt
v2.23.0-rc0:Documentation/git-name-rev.txt
v2.23.0-rc0:Documentation/git-notes.txt
v2.23.0-rc0:Documentation/git-rev-list.txt
v2.23.0-rc0:Documentation/git-send-pack.txt
v2.23.0-rc0:Documentation/git-svn.txt
v2.23.0-rc0:Documentation/git-update-index.txt
v2.23.0-rc0:Documentation/git-update-ref.txt

=2D- snap --

So. Lots of precedent. Conversely:

=2D- snip --
$ git grep -l -e --paths v2.23.0-rc0 -- Documentation/git-\*.txt

=2D- snap --

Zilch. So I find the advice you received, let's say, interesting.

In `git hash-object`, where it isn't obvious whether you would want to
pass in options or paths via stdin, there seems to be `--stdin-paths`. I
am open to that.

I am not open to implementing `--paths` nor `--paths-file` in `git
reset`.

Ciao,
Johannes
