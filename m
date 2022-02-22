Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F161C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiBVMoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBVMov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:44:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF2C122F69
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645533859;
        bh=9kJtF9ig7nKnZXq+eREQXaBTUUSRIakZkUgfumdx13E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xp6aOmjdaXvOpX5gItxw+hU+Bm0893EF/HY18i8G/cryiJtiquqKE792zb065nKEX
         XG09N0GyZVmvqO6W4SrPmYNUaxJV8NGtZamAWzgQBZtCTLDebZg2YifL/k/gOOaOyM
         UVsCpmMxfJf5FxcboFUrkqbrnfWBEXlEq/QXDfxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1ndkYv3cJj-00Jdh7; Tue, 22
 Feb 2022 13:44:18 +0100
Date:   Tue, 22 Feb 2022 13:44:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
In-Reply-To: <CABPp-BGdbh=HM7jA+_RTwSWVcMr_qvEY7RoNXooeBT2NB4Ubzw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221331220.11118@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com> <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com> <nycvar.QRO.7.76.6.2201111448140.1081@tvgsbejvaqbjf.bet> <CABPp-BGdbh=HM7jA+_RTwSWVcMr_qvEY7RoNXooeBT2NB4Ubzw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MV86i2RGVOraD/lIAxE2lsOOmBFbLCY4bOO7fFUrc7cSJJiDt1E
 bdNYU28AZTzvVhlgEkZvi4rcJo8c65jcz/djedmFxkfdmDUsZHk7Ybk1Cu7RDh3jrbFgHcw
 aL+B6260kDbYP5aEZbo6yiOf6G9zZXd84CjAEn9oaLum5hfp9bNAI0Le3iaGxLr01NCohh0
 NVoj6LYDVxta2Vsr+YDmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dKIXjQ2okqg=:EkthK6AbPSARSL0Ro2nSXq
 VJPhlHYtK8M8OlgSJuETFCJm362yruiw6K9cNwDMXawLT+2hI/3vOXOeHVEWv8yOrYevhDowx
 ral/+jBqPx7R6G08J1aG0V837aYSqwiWGCO4FmPpS7LASM4C189zvzzc4OxViTuSf8Q9MuLq2
 39kvGeEerbEt73qNcQibxtLUUn3GdkSIOsPyxa1K8OrQPJk/R5Bjkrg5J9NvpnON0L/X/6hPV
 M8WT2a2sTFmd0TkXypcfbtcDHoyZsk/+h5VmyBLzrot9M4oLaD4NrjO6v20vJBqKIPMcThdMk
 JWDmBSy0QFDDzHN1tAY330e7p9xEG5aFbldWMgNzCumvC4Kd5lvJSX1Pvkk/j7uFwerkFR+5L
 lt44hrX39OScfR26TY0jURpfLGBUXBlqXMbtIDz9a80VPqxok7IwkM8tWyvx1XB9g2qMw4I4y
 30sGWl4woq7m0hULtcfjTarCK/Gz0De431UhJChVGmaTu+wwkl6qyiIVMAN9QGW2DODob/7c7
 99mW4c8WLRR7XRp3gunlhCN4hIJot7ppP2V4ZZTPr3Q0NQMyME/2yWpOS3Eu3o9uAOzjiBEqz
 L2NYUlv8id2Sc4vQMXEh7XDBnJlqF8MsxSMZElnaGz6uc76u9XBHlRydcgka5yHWe7jL/01lC
 DVGbTIOGpkmfS6Xjtr8PNNocA8jiryeofC7p2I+CsIih6FqiB0FnxyGYpVnE/n3+guvvKD1i7
 eHuYJRNOXy66HmmXIadGzvinsoRO50WXgr+xBwy5L3t9h+3eE/25pTjU/vUKE/40yft7ZOjbp
 JSrUBem6RHwBi0l9EYLzGl9isbgXWTGFcArrECM4kPaOVfyITpCOFDE4e1+2wGvTNTPj20GPI
 tvf9aprNqBMxv5VRBdj7eCicHjSZqZnfEAfkWZdLOocm1lrYE7/3RT2ii5juzyRQmio7mhrPu
 +xhUg7xJpktIpwysPka7qUB2RlR+33mJiXiF0xyTDaCiPb1L4FYyZG/ADcbPI12MroyUjduBZ
 +BBOdYI+WBKzvPsxZdQfHWagS9alyrqaetTi4lAkkGf5YaDTGj2k9zK9tACmY7YKEGYSxy0x/
 3UghLrdIvCJkf0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

to save every reader some time, I snipped the parts that were addressed
elsewhere already.

On Tue, 11 Jan 2022, Elijah Newren wrote:

> On Tue, Jan 11, 2022 at 2:30 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 10 Jan 2022, Elijah Newren wrote:
> >
> > > You have a couple problematic assumptions here:
> > >
> > >   * What if the user's resolution required fixing a semantic
> > >   conflict, meaning they needed to modify a file that had no
> > >   conflicts?  Your code here would ignore those, because the clean
> > >   case is handled above.
> > >
> > >   * What if the user's resolution required adding a totally new file
> > >   (either because a rename is handled as a separate add/delete, or
> > >   they just needed a new file)?  The loop above isn't over items in
> > >   pre_resolved_conflicts, it just assumes that items in
> > >   pre_resolved_conflicts are also in the plist.items being looped
> > >   over.
> >
> > I can see how these assumptions may look ludicrous when coming from
> > the command-line. But again, we are talking about the realities of a
> > conflict resolution via a web UI.
> >
> > So I think that it is out of the question to address non-textual
> > conflicts in this scenario. And then the assumptions make much more
> > sense.
>
> Waving your hands and saying it came from a web UI doesn't reduce my
> worries or concerns at all.  I could easily imagine a web UI that
> allows users to specify other modifications they want to make, even
> limited to textual ones, to include in the merge.  What happens when
> they modify some file that had otherwise merged cleanly (e.g. a file
> that gains a new call to some function, which after the merge needs an
> extra parameter passed to it)?  Your solution doesn't handle it; it'd
> send that user-specified change to /dev/null.
>
> To be fair, you mentioned below that this is just a proof of concept,
> and that certainly reduces worries/concerns.  It's totally fine to
> have such things.  Maybe you intend to keep this patch internal
> indefinitely.  That's fine too.  My commentary is just feedback on if
> we want merge-ort/merge-tree extended more in this kind of fashion
> (and it might also serve as useful pointers on how to extend your
> internal patch if you get requests to extend your web UI a bit to
> handle more cases).  :-)

Fair enough. I think I'll keep this patch internal-only for now, and
iterate with real scenarios to figure out what we need/not need.

> > > Could you clarify what you mean here by OIDs and modes?  For a given
> > > path, are you just looking for a (pathname, OID, mode) tuple?  (In
> > > which case, you'd get the OID of a file that potentially has embedde=
d
> > > conflict markers)
> > >
> > > Or are you looking for multiple OIDs and modes for each file?
> >
> > This. In case of a conflict, I am looking for (mode,OID) for the merge
> > base (which _can_ be a virtual one in case of recursive merges) as wel=
l as
> > for the two divergent revisions that were supposed to be merged.
> >
> > I do realize that other types of conflicts can occur, such as a
> > rename/rename conflict, and we would need a way to represent these in =
the
> > output, too. But in such an instance, where no clear (mode,OID) triple=
t
> > can be provided that represents the merge conflicts for this file, the
> > current web UI cannot offer a way to resolve the conflict, so I am a b=
it
> > less interested in that scenario.
>
> Okay, this is helping explain a bit better.
>
> Out of curiosity, does this mean the web UI only can resolve cases
> where all three modes & OIDs are present, and the files are text
> rather than binary?  For example, does this mean the web UI cannot
> handle cases like modify/delete or add/add?

Right now, the UI is based on the assumption that the underlying merge
machinery does not even try to detect renames. Which simplifies the range
of supported scenarios somewhat.

I have not looked at the underlying code, but
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/=
addressing-merge-conflicts/resolving-a-merge-conflict-on-github
clearly says:

	You can resolve simple merge conflicts that involve competing line
	changes on GitHub, using the conflict editor.

So yes, the UI does not even try to support resolving modify/delete
conflicts at this time.

> > But again, you made me think of rename/rename conflicts and friends, a=
nd
> > we would need a way to represent those, too. Even if my current use ca=
se
> > would need to only detect their presence in order to say "nope, can't
> > resolve that on the web".
>
> But now you're making me worry whether I can satisfy your requests
> again, or at minimum, whether I need to do a lot more work in
> merge-ort to answer them.  Do you need a representation other than the
> list of (stage, mode, oid) triplets?

I guess we will have to accept that the (stage, mode, OID) list is the
best form, for now.

We will have to see what is possible to do on the UI side, and then extend
the `merge-ort` side as needed.

> I'm a little worried I might come across sounding a little picky since I
> tend to dive into details and really fixate on them.  I apologize in
> advance if it sounds that way at all; you provide lots of good points to
> think about and I can't help but dive into the quirks surrounding each.
> I really appreciate all the awesome feedback and food for thought.

Personally, I did not find your comments picky at all, but rather
constructive. I find this conversation thoroughly enjoyable and productive
even at times when you prove me wrong. You set a really high bar as far as
collaboration style goes. Thank you very much for that!

Ciao,
Dscho
