Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5C0C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C050E61262
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhKEJPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:15:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:42557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhKEJPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636103548;
        bh=p8JsYSM287ZaueHrxOlCyCEYh1pm0HS3eyoMyZZ7FPQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W+lkSuhYn0Kylm7cwMaoof1624WGpGTU/rhPpQNtrgiVMG9qP2Zl+EkOSSG1GLyrx
         1MBCCo4sLYxWPbAeijDG07zJYQHweOLGw+Ga6MZngzv+sG0l2SFfESEijvoHFA7pNR
         /E8iFAJ9YwK4Nce+888EwvJHke7r7rPW9a9U2umg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1mkIiM3JBl-003i0O; Fri, 05
 Nov 2021 10:12:27 +0100
Date:   Fri, 5 Nov 2021 10:12:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
In-Reply-To: <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im> <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net> <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-964796656-1636103547=:56"
X-Provags-ID: V03:K1:0Kic/qLOcmVrGl8bOAP8edLWMWd0ibuI/njOpGbjbZDwkzZcU80
 2gx/X2Wwg2hlaU4bZ+aPS4rZRIFc/sV1GcpIELEf8uZ6VdO6O4JjvDLRaR+BCh7yxukUG5N
 OoXLdG0bpJ5GlBb8a4SobqS13kmZxVJ8EyryVutGiGZjL3DRDabI6WvJMZjNCNfRGSh3oG/
 jau+Qi9T3bDrOAZdYoEmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/W6zjcxA/w=:hauSOAh7ZTs6nhDS4umWiF
 LWmxtfdO0bQMSdxNhtFZ9RNA49upSq5oOMDJ5JiUDekcJO9wuCKAXUtxLeQM88yCFSP68dxis
 nD3We2FEd8O3aCfYEyaIoPuxmQHZTUBjAH+kqZB91N2KioFZVxdSND4eCLNKdwVcM9itzF4h9
 Rwjk0O83ucD1OpW2H/UTb/CkVdDYwkmVI+kkeqSC1A2H7IGUPrvs/QbZt12Nt/UuiOkeHFI6v
 pykTSg10/q3jc1ccmvmgLYNt2QdLciwwq1yqgaKxw71n4QA+19SYA6851mFe/5tOrK0OgYfso
 4ASCDWVepohqbKFk61J1krZ+j5f7V2gD/J/VrrYNJ0NL4YzT5CYTk/91vgA9maqU1ixynAStn
 FUYRjBvFMePMhjVHVuJmMAfnyWL6XIdHAppjY3IIZGlAOLBbM9ISxEqVoaPkTIfLXzX5iJI6W
 JwEGsK+I/xNEWWOcn/TGSBleA9t0DpXUFk0uJaM5YQ0zm6ipGdWOl0V55v+A/aoKofkqcQAq7
 JV5hVRRVBWdNsS5pmm4WS25K6DDUNoC+dCtqogOeRvU9/rTwifD/A5BehKArzbonAayVj2/fX
 WmQLSuByZ+6AVwcyvlUwHBsMUr0+ad2p6yBi3sUnci9eYkjT962cS11UtXFH/4Y7573CD+JBb
 vMS9vcR1cEcDkE5eDMn7ggvq65/CIOLq55UjlSF+nAT+wla0lxLnoLmXqFXfWYboZUzTfSVJa
 Lj6rQdUkkJaC0dqr+3pyYfb1NVd66IyUcxuQH/fZECksh9ad5kleNuu8EPf2+gYzMtKfvQ0U8
 8qpZDpZAUhusqadSd+eOxcD1AXo3I2Sluo5ZBBN48C7BaVOMpt698Yy/yxKnGWJGbxX+HrZSd
 XEYzTXF5Wu++iR8gKn1K8P+VzcKsDUFO3YRjej1mZEXpH/YNkjJI3J5eTXbjdIeJSUKufWpej
 DfJ+ruvcfwG3UV8paHD5eHhEqTJ6BFGwWH5EOLGloW5vd23s2Mwi4iY89kcYh4rHoNYy069uJ
 Rk00+t6rqcGIbCCp6OfhG27EUSs28jnNhz55VzwIo2BrGl5c5REm6NwxX5kTt7YhLFA3BWbf3
 HXKAolmkKLLBDA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-964796656-1636103547=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff & Patrick,

On Fri, 5 Nov 2021, Jeff King wrote:

> On Fri, Nov 05, 2021 at 03:07:18AM -0400, Jeff King wrote:
>
> >   2. It's not clear what the performance implications will be,
> >      especially on a busy server doing a lot of ref updates, or on a
> >      filesystem where fsync() ends up syncing everything, not just the
> >      one file (my impression is ext3 is such a system, but not ext4).
> >      Whereas another solution may be journaling data and metadata writ=
es
> >      in order without worrying about the durability of writing them to
> >      disk.
> >
> >      I suspect for small updates (say, a push of one or two refs), thi=
s
> >      will have little impact. We'd generally fsync the incoming packfi=
le
> >      and its idx anyway, so we're adding may one or two fsyncs on top =
of
> >      that. But if you're pushing 100 refs, that will be 100 sequential
> >      fsyncs, which may add up to quite a bit of latency. It would be
> >      nice if we could batch these by somehow (e.g., by opening up all =
of
> >      the lockfiles, writing and fsyncing them, and then renaming one b=
y
> >      one).
>
> So here's a quick experiment that shows a worst case: a small push that
> updates a bunch of refs. After building Git with and without your patch,
> I set up a small repo like:
>
>   git init
>   git commit --allow-empty -m foo
>   for i in $(seq 100); do
>     git update-ref refs/heads/$i HEAD
>   done
>
> To give a clean slate between runs, I stuck this in a script called
> "setup":
>
>   #!/bin/sh
>   rm -rf dst.git
>   git init --bare dst.git
>   sync
>
> And then ran:
>
>   $ hyperfine -L v orig,fsync -p ./setup '/tmp/{v}/bin/git push dst.git =
refs/heads/*'
>   Benchmark 1: /tmp/orig/bin/git push dst.git refs/heads/*
>     Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   0.2 ms    [User: 6.=
3 ms, System: 4.7 ms]
>     Range (min =E2=80=A6 max):     9.5 ms =E2=80=A6  10.5 ms    111 runs
>
>   Benchmark 2: /tmp/fsync/bin/git push dst.git refs/heads/*
>     Time (mean =C2=B1 =CF=83):     401.0 ms =C2=B1   7.7 ms    [User: 9.=
4 ms, System: 15.2 ms]
>     Range (min =E2=80=A6 max):   389.4 ms =E2=80=A6 412.4 ms    10 runs
>
>   Summary
>     '/tmp/orig/bin/git push dst.git refs/heads/*' ran
>      40.68 =C2=B1 1.16 times faster than '/tmp/fsync/bin/git push dst.gi=
t refs/heads/*'
>
> So it really does produce a noticeable impact (this is on a system with
> a decent SSD and no other disk load, so I'd expect it to be about
> average for modern hardware).
>
> Now this test isn't entirely fair. 100 refs is a larger than average
> number to be pushing, and the effect is out-sized because there's
> virtually no time spent dealing with the objects themselves, nor is
> there any network latency. But 400ms feels like a non-trivial amount of
> time just in absolute numbers.
>
> The numbers scale pretty linearly, as you'd expect. Pushing 10 refs
> takes ~40ms, 100 takes ~400ms, and 1000 takes ~4s. The non-fsyncing
> version gets slower, too (there's more work to do), but much more slowly
> (6ms, 10ms, and 50ms respectively).
>
> So this will definitely hurt at edge / pathological cases.

Ouch.

I wonder whether this could be handled similarly to the
`core.fsyncObjectFiles=3Dbatch` mode that has been proposed in
https://lore.kernel.org/git/pull.1076.v8.git.git.1633366667.gitgitgadget@g=
mail.com/

Essentially, we would have to find a better layer to do this, where we
can synchronize after a potentially quite large number of ref updates has
happened. That would definitely be a different layer than the file-based
refs backend, of course, and would probably apply in a different way to
other refs backends.

Ciao,
Dscho

--8323328-964796656-1636103547=:56--
