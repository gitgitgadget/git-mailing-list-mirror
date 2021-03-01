Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9FAC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F1360231
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbhCATcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:32:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:47583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237235AbhCAT3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614626895;
        bh=GFguSRVX8q9C9n8CMkbY453YrLIJU+WF9ubhTNMXOPc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BASOAuP2rrtuuTXkA3naZkyxL3yQOsPNw3db+Hwn0wH4nDrfJ8oTNf6/jQtv9mLGw
         L1+fua2i/HKYsdJujjeRw6OKmaN8PavI6ZKaSYeqDDbge6d9Xo/3Q/NEWQ0itvyz0f
         uL+/2Zv2YxEmkW1EATSIp/M3rc7MUS5bb+utLTCc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.214.35]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1m6IyA1Ncz-00sRDA; Mon, 01
 Mar 2021 20:28:15 +0100
Date:   Mon, 1 Mar 2021 20:28:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: Submodules and SHA-256/SHA-1 interoperability
In-Reply-To: <YCmbKrTsJhgPHYLc@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2103011621000.57@tvgsbejvaqbjf.bet>
References: <YCmbKrTsJhgPHYLc@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RePwygreJsvME3xISx8AF1fw22oX8wRcIQobNZLrhBn98ulywUJ
 hRFJZwmPFtyUu5f94sMwwwbAUox9rH9Jy67KrILABrLzWE7Toa0gQJ2Msh7zPVi8gvqkwSw
 z7r+nhFi+XHf6UEv2GO1WX9v4voOwVmYSpgB1aXm/sKqC5sbmkVUFF0ziOVYJ+lj+9HFJR1
 NmQGDQFCg3j5/Z/cjCSfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wqemVboP4Es=:EvMHB+dJiQaub3P2fW2pNK
 ZxxUO0lq97mrCfq8IX2WTvXwcUUSrkc+SFinkbDG/meeeNrvejY+IO9JzVhuARlXhifnIakDm
 TEw1EeSXF6EfM0SvbJB3MTsJfzyHEyJGHLUZBUPOHYgtRtJE/QBABPkqUT0qOpWAHCMHFyFhi
 ONcAqJTFfhdyZH0ltZHUdXRCS1JwrgYxln/6pPdLLgh3K2b6dg4pAGV6Dv388GVyMh2ANDwEg
 Fnuc22nqTEx2pmfKh2jMA7LC2B4iFPgh2a3RHbfusAJ+plP989oz/O0XT8OvCseqdj0GY58Vx
 Zf9yUszEu37Sum0S2qptUWsaVhQh15woBVJNjJWo3JW56znr+SnNov3MUaqe5ADDlPOn+XRdZ
 BmW1BRMI08HTQ1qjD4sS3FXV7xVtl4g0x9W/T0RmbQ0irHSlRwwDbonYuQwg4Bim6fso7bLBW
 aEfw1aDNzjsCrviVIaabArU2NSAN68xkNj/StICuJCYEKet3btS4vTHXEvD2LtWu2RYFHrgGU
 6ptDiDIyTVC1ccbR5W3apC5x+TEsJMztDpedUoxQdUG8H3CKfsvm8k3Ckn5xMz7r/aaB8tL68
 qO/y2NGvDhLQh85Ey+4WDk2640MyXNpOumjBYPqsVxs8KkspDlEIG7L4I/be88ligN3+oa8tC
 omeibx/BIpu/5LzWQIkTSNalhrqiaYrWtZGA3yb3e3fQ4rozOc9R5hA8xEkMIC7XknmrwFeuT
 95x1ZSPoDWf4Zy04Ow2AR+ZQsRn+Yl9p7xuQMBaSsI3FAliFlGOgdAteXAoK4UdbNaeU/8Fh1
 lEqkA1ehBlJTqXf+WUNQAVK1zGR+ECPBuP2SQYi8YmQTYw5vO303OEsJnGdNdO5ez22XhBBmK
 /nCdbdX0ZwiER3AveB4PEOhihumzsq+C0iLqEXaKg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 14 Feb 2021, brian m. carlson wrote:

> I'm currently working on the next step of the SHA-256 transition code,
> which is SHA-256/SHA-1 interoperability.  Essentially, when we write a
> loose object into the store, or when we index a pack, we take one form
> of the object, usually the SHA-256 form, and rewrite it so that it is in
> its SHA-1 form, and then hash it to determine its SHA-1 name.  We then
> write this correspondence either into the loose object index (for loose
> objects) or a v3 index (for packs).
>
> Blobs are simply hashed with both algorithms, but trees, commits, and
> tags need to be rewritten to use the SHA-1 names of the objects they
> refer to.  For most situations, we already have this data, since it will
> exist in the loose object index, in some pack index, or elsewhere in the
> pack we're indexing.
>
> However, for submodules, we have a problem.  By definition, the object
> exists in a different repository.  If we have the submodule locally on
> the system, then this works fine, but if we're performing a fetch or
> clone and the submodule is not present, then we cannot rewrite the tree
> or anything that refers to it, directly or indirectly.
>
> So there are some possible courses of action:
>
> * Disallow compatibility algorithms when using submodules.  This is
>   simple, but inconvenient.
> * Force users to always clone submodules and fetch them before fetching
>   the main repository.  This is also relatively simple, but
>   inconvenient.
> * Have the remote server keep a list of correspondences and send them in
>   a protocol extension.
> * Just skip rewriting objects until the data is filled in later and
>   admit the data will be incomplete.  This means that pushing to or
>   pulling from a repository using a incompatible algorithm will be
>   impossible.
> * Something else I haven't thought of.

While my strong urge is to add "Remove support for submodules" (which BTW
would also plug so many attack vectors that have lead to many a
vulnerability in the past), I understand that this would be impractical:
the figurative barn door has been open for way too long to do that.

But I'd like to put another idea into the fray: store the mapping in
`.gitmodules`. That is, each time `git submodule add <...>` is called, it
would update `.gitmodules` to list SHA-1 *and* SHA-256 for the given path.

That would relieve us of the problem where we rely on a server's ability
to give us that mapping.

Ciao,
Dscho

> The third option is where I'm leaning, but it has some potential
> downsides.  First, the server must support both hash algorithms and have
> this data.  Second, it essentially requires all submodule updates to be
> pushed from a compatible client.  Third, we need to trust that the
> server hasn't tampered with the data, which should be possible by doing
> an fsck on both forms (I think).  Fourth, we need to store this
> somewhere, and the only place we have right now is the loose object
> index, which would potentially grow to inefficient sizes.
>
> We could potentially change this to be slightly different by asking the
> submodule server for a list of correspondences instead via a new
> protocol extension, but it has the same downsides except for the second
> one, and additionally means that we'd need to make multiple connections.
>
> So I'm seeking some ideas on which approach we want to use here before
> I start sinking a lot of work into this.
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US
>
