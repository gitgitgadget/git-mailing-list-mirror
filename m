From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in
 t1508
Date: Tue, 26 Jan 2016 07:53:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260747180.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de> <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com> <CAPig+cQfbJUtqu2F497Usaz3Ysf-5-vQgtg-0y8qh+FUQ=HeTA@mail.gmail.com>
 <xmqqd1sph4so.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Braun <thomas.braun@byte-physics.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:53:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNxVg-0002vw-2N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbcAZGxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:53:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:64963 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbcAZGxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:53:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWPOI-1actqb3lJy-00Xev3; Tue, 26 Jan 2016 07:53:40
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqd1sph4so.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3NluzW2hBF8dpbB54vPUJaH1mGnkSnjxjw3ERV6Js4PWG0NbKFZ
 jl4Xudpp8MA/DvlPcAT184Gmt3hV259MWnoMZAEti57mFXk9Su2eVEmlR/HuCSeBqehLsvp
 g1wym2awtXTrrYGFo+BXDnQ2YRWW0oEvd9Yb6MWGTrRacxgglMcYPfdn+SPJKdcVKjLdocH
 u6VqiGcCgNHSMO4pvu5Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NxR7zEBoAaM=:bWE6TMUsk/BflGNld+G/3x
 QFPVi+TBlKyyrv7MET6QMXUvmOLC4HnhqqzxdLCyDqqhakhtL54NbJNODOF3Xu64vRQT3z3jD
 Yp9LhrknY+81bEk9RFBSYdVr6iWS4cTXOls6MHZFwzN7Q9a75abFRON8sGYJecAmnk6Ld/YGe
 JCedP7q5phTb0ZETAyqEFhcEON2oKKrNPHNPlI8dBT0Y+Cqg+yTtbTSo/2h7W7mQlvUg5dkMi
 /W9KhQciTd7G8hVrFmdtBcJtx9U17hpcdyJxFYmqtN2ZYMZMaCQrx/exm3Xfvgoq70L0Fpr48
 yDqeaGt7o2puh2nPaTit5MIxNifm+tPB16poekfACNFNgkVvKS1QS1LvBGEA0zsvCeQms9OZG
 7e2t8ojFn+ExCNP2hmoNudKyV/i/8DM+6Meo/wEgaGGjyNMXXOihuviMfFsVivOIU/iU1mWT/
 Qs7sV73li7cXyUhd4qJsqhkWw9maSCKj+HIBAgbhiPgsuWGuClZDzxWLLypTIY7oVzjpNtdjl
 Sg90/pZI4Oi1NBKL/+0plh5wgwETSM7C/cJ+SXrqOt6eAdpS2OQ+4XUWT8PB1DQjjPHRCMg5c
 N0lI75yWHuXKUx855xgVQcWIQrlrvP8LhAKPvXNgblt/9Bq+moqBK9eZ7Y8rL76crFID934Ow
 Ag2mPf46DTb9e/e/rqhBBZ9zR1+na/Es+0agOJpzjUPD9enuH3CuwLwjW0tGOz50H+ApvFUMF
 J9tglxEa6U2mFWQ/cr0afbqMfNYgdA3pM1PB1XntdgIrJrA7SSZVvTJokcbd8GGJf8TKOfMd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284783>

Hi Junio,

On Mon, 25 Jan 2016, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Sun, Jan 24, 2016 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> The new test hardcodes and promises such an incompatible behaviour,
> >> i.e. a request to create "@//b" results in "@/b" created, only to
> >> users on MINGW, fracturing the expectations of the Git userbase.
> >
> > What the commit message doesn't explain is that ...
> > ...
> > This commit message is trying to say that MSYS shell undesirably sees
> > @/fish as an absolute path, thus tries translating it to a Windows
> > path, such as @C:\fish. The only way to suppress this unwanted
> > translation is to manually double the slash, hence the patch makes the
> > test use @//fish which, when finally seen by the program, is just
> > @/fish, as was intended in the first place. So, doubling the slash on
> > MINGW is not promising incompatible behavior for MINGW users; it's
> > just working around unwanted path translation of the shell.
> 
> Ah, OK, thanks for clarifying it.  Presumably you would then use
> "checkout @//b" to switch to it, and "log @//b" to look at its
> hsitory.  When you read "git branch" output and see "@/b" in it, you
> would also not complain thinking "oh I thought I created "@//b", not
> with a single branch!".
> 
> Then no issues on allowing "checkout -b @//b" to create a branch
> "@/b" from me.

I actually disabled the test for MINGW instead, as I agree that we do not
want to test MSYS2 in our regression tests.

Ciao,
Dscho
