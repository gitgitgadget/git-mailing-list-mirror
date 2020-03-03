Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01ABC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7476120870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 19:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QVayV77F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgCCTi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:38:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:50593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgCCTi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 14:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583264300;
        bh=LEcYAeycZR8YlOMRuWJ9oU53EbOULUZ0ZGDGc3nVA64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QVayV77FIy8mV+Rq9Tm6WrcigcCD/9wOHVP1ltQNQ9WPOQYqQrSNqBhfGLWjlYXzr
         o6Trow2bKeM6DUOj1Updc478GSPvhmoEiV881D7s8FaatajzvKnjAEAxM3IoZIvvB/
         Lqv5iVKyBsOXbRf1gizPUANHaSpWCf9OGYN+VmJw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.80]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MI5UN-1jCBuF2tE7-00FEZz; Tue, 03 Mar 2020 20:38:20 +0100
Date:   Tue, 3 Mar 2020 20:38:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Bryan Turner <bturner@atlassian.com>,
        Takuya N via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Subject: Re: [PATCH] doc: use 'ref' instead of 'commit' for merge-base
 arguments
In-Reply-To: <xmqqd09ta4tn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003032035510.46@tvgsbejvaqbjf.bet>
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com> <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com> <nycvar.QRO.7.76.6.2003031507500.46@tvgsbejvaqbjf.bet> <xmqqd09ta4tn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7mO48CidrlFBYZOSVpNbqav7FMYoptzcrNrQgeMZrJBT9Kmdjkk
 pYonhFlOs2LdwpYZ+nx3YKtkJh6Oj54gknWNtzwMdNd4pdEZFxQV4ubBa3CvUUvWUqKRS3l
 vxLFyzWRv4xx1HA9zi4HB7IutBLRuVAUd8rzG6kLlqK8McdUDQqqamUQX+NHNkv7fbecoxS
 xgQyPxvSJgVY3QM8qMDwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sDRnCekNzio=:B/RFZNwxVYsJ3651pKZ/qY
 koPJ6KoPe35pHWkKfHWqSVR/RlSul/V/pBH4lMxQ5OzPaHl/F4wNqAQC8LlpGAEbMBNr/kRIT
 v5IKU898avtR1BGS84NRlQA1jTZqFasZo3owfTHZ4NQDYWmzR3QC5tRtgJzBxgybxGYTPJkto
 1G0hdHnmbY1deerQXVgHH6o10J2AjyJ5F97r94V1Rj7P8wN5SEiQtiBKD/QyML6S4sA9u/Anq
 PDFPJrZU0F+VzFCsRXJjan2FaFGNXuJjV2rfR0oUa9rgsDctant25KEa3b4KmKLCSngvrSFkU
 IqFlOPiJ/oKo+DWBSEUNmiBRSdsmlLtA8LdWrvE9TVIEJociLfC2BngfnhPRXR+/lEtC4249a
 AQp2d1cRvw4UHc1/Zlu8b8aEq+ICBGl+nG27sa6CeVat9R45K6De7cRl6WN3r1oONTZnzxi/z
 80mnMLa59We3CMNzmO8GxYiniWNXYW1iFcSQ+6hOe2ZyQw/hidMIE0ddQwiGHvLjQh5xaLDuJ
 6hG7zCJkhwS8YjCMzjHWY+qMWQCz3kNpAnPEBDcatk5UI3Iql1WTYDzU9hM2yHeFTzx5mM58D
 mCTzraortoTJjrj9AYWrAw0ZIqA6Sx2aXCDsbBVAXOpuj5rOlAGNgA49qXcgjci8k5T3gzFXT
 ZgP2QZju3VZ69mqsFBYQpMxepH6B/sVEu8nsBWDSaF5u8DQsrBlMeNK0XJntzYOHG0k4omgFJ
 3jaBFA/okz7ZMKqXweyp5pO+OzmlMawukNZsic0Obpaj/G2EvGGkuAk7mrdSZ8zCIljXvtYPp
 hck4LAOmtZ9+zu4z/DX3qx7PbqtNJJdN0JtK9MKqa9GNOAq9ZLL1Phr1gvg/TZnnhUrNl9CcR
 DYpZqFfWxcw8V3DLe9nt16RUhxT++Ezyr2K3xu6b+CBRRq3PBFBezXQnoUbQGFLAhxQ8d9KjR
 DcMUE4imp3H/BXQjhPROisucp3WvVZDSD2fLU+UUiR72EeVYg4HQfPK/Elva/w3QHnLmLgVCI
 EXrWIh2n/MtYxt4hGnOJBDpVnCKBjue0GNRITId26qZe3qOrrqecCM4JzgekC7/uqTMVvbZkT
 CUlTaHPBjLm3KivhNbGuByx3TZupdtUejya3a/LphJsxtTNwQEZ4Gjg+yzvD4jUCCP68DcyL2
 6brm7ptbcAVWZ6GXO+4JmwtbBakq4ymVUjKgUh+GsnroUySXX9wUvaB9DEOZTyLEOrPXqHi1I
 ALz7ZDwEaJTcX7jZY
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 3 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > The notation <commit> can be misunderstandable only for commit SHA1=
,
> >> > but merge-base accepts any commit references. Like reflog, the name=
 of
> >> > arguments should be <ref> instead of <commit>.
> >>
> >> To me, this change goes too far in the opposite direction: Now it
> >> sounds like the command only accepts refs, when it actually accepts
> >> any "commit-ish"--i.e., anything that can be coerced to a commit.
> >> ("git worktree" uses this term in its usage for "add", for example.)
> >
> > Maybe we can go for `rev` instead of `ref`?
>
> That's much better than 'ref', but I do not see why 'commit' is
> wrong in the first place.  There are many ways to name an object,
> and `rev` is an old colloquial way to say "object name".  Here,
> however, we want only commit objects, no?

We do not only want commit objects. It is totally legitimate to ask

	git merge-base HEAD v2.25.0

(v2.25.0 is of course not a commit, it is a tag that _refers_ to a
commit.)

Earlier, we would probably have called this a "commit-ish", but since
users got so confused by this instance of Git Speak (is my interpretation
of the reason, at least), we tend to call them "revs" these days.

I do think that the idea of the patch has merit, even if I agree with
Bryan that we can probably improve on using "ref" instead of "commit".

Ciao,
Dscho
