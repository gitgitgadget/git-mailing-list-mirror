From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Mon, 10 Nov 2014 14:04:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411101403380.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <545F9990.9050505@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 14:04:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnodr-0007nP-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 14:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaKJNEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 08:04:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:51432 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaKJNET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 08:04:19 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Mcyxq-1XWpiZ1mR0-00IAbM;
 Mon, 10 Nov 2014 14:04:05 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <545F9990.9050505@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:b1KD9XqBuwedQSVfH6sqTFBwOROUtGg+lb3uUYTMe9HAJS+xtLV
 pndWzUbeKoAW/8b084B6kA7P0WGfe1vZsy30G4YziTvinTsvQoa4jHNhytIpzrukdNQU2gY
 n8qfdbWtzF0M+cSm5mDPy/hlZVbQq7M9Gk6xdlSZMcf7k5yiG+HnqUUxnWiP6gwl6Ez85WD
 bwWrh2F7AiZEDTR0y9v3w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jens,

On Sun, 9 Nov 2014, Jens Lehmann wrote:

> Am 07.11.2014 um 20:20 schrieb Junio C Hamano:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >   builtin/receive-pack.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > > index be4172f..4ba51df 100644
> > > --- a/builtin/receive-pack.c
> > > +++ b/builtin/receive-pack.c
> > > @@ -740,7 +740,7 @@ static int update_shallow_ref(struct command *cmd,
> > > struct shallow_info *si)
> > >   static void merge_worktree(unsigned char *sha1)
> > >   {
> > >   	const char *update_refresh[] = {
> > > -		"update-index", "--refresh", NULL
> > > +		"update-index", "--ignore-submodules", "--refresh", NULL
> > >    };
> > >    const char *read_tree[] = {
> > >     "read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> >
> > I suspect that you did not squash this into 1/2 on purpose, and I am
> > guessing the reason is because you were unsure what should happen
> > when there were differences in submodules' working trees (otherwise,
> > you would have simply squashed without "oops it was a thinko to
> > forget passing this option" as a separate patch).  I am not sure
> > either.
> 
> I think --ignore-submodules is currently the right thing to do here
> and would rather squash this into the first commit.

Done.

Thanks,
Dscho
