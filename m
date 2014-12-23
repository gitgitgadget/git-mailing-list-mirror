From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git remote add: allow re-adding remotes with the
 same URL
Date: Tue, 23 Dec 2014 19:26:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231923560.21312@s15462909.onlinehome-server.info>
References: <20141216021900.50095.24877@random.io> <cover.1419267895.git.johannes.schindelin@gmx.de> <9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de> <xmqq1tnrbmn1.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412231425220.21312@s15462909.onlinehome-server.info> <CAPc5daXcXs+Sw8jr65dmLnpf6LQ6Lr34y80bxSf2AhhFyXa_mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:27:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UAp-0003Ni-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbaLWS1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:27:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:57791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaLWS07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:26:59 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M4WuC-1XgJTw1zKO-00ygWF;
 Tue, 23 Dec 2014 19:26:56 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPc5daXcXs+Sw8jr65dmLnpf6LQ6Lr34y80bxSf2AhhFyXa_mQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:QPff3X8OrxRm7XKgOTu90e9OaQ8vA49sj1tiURR/rgvQCJPs5No
 6YRxQIoSg3snnbzRz9FAIPqld6htrpxrmFRrHSctgf8yEwA91GBSrk/Utq9LbRaVD1BOP5Q
 XfTTRQlbJ4AxvtLd41ER7AyPQV1VbxaSQ6fOtKg+64FJD9z4dC0Tqm75f4yGlUIWY6cZ3FK
 Ezsf7Frh59JeEUZ06zWMA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261760>

Hi Junio,

[re-Cc:ing the list]

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> On Tue, Dec 23, 2014 at 5:25 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 22 Dec 2014, Junio C Hamano wrote:
> >>
> >> So, it is an error if we have "remote" and if
> >>
> >>  (1) URL for the remote is defined already twice or more; or
> >>  (2) we are adding a nickname (i.e. not a URL) and it is different
> >>      from what we already have; or
> >>  (3) we already have fetch_refspec
> >>
> >> The way I read the log message's rationale was that this is to allow
> >> replacing an existing remote's URL; wouldn't checking the existence
> >> of fetch_refspec go against that goal?
> >>
> >> Puzzled.  Either the code is wrong or I am mislead by the
> >> explanation in the log.
> >
> > I hope v2 addresses your concerns.
> 
> Unfortunately I am still confused.
> 
> The way the overlong line is folded in the new version of the patch
> makes it easier to read, but I didn't find a reason why checking the
> number of fetch_refspec does not go against that goal there.

Since you pointed out rightfully that the main goal is *not* to allow
multiple `git remote add` to succeed when they try to add the same remote
with the same URL, I changed the commit message to point out that the goal
was to handle adding remotes via `git remote add <nick> <url>` when
url.<url>.insteadOf = <nick> already exists, with the same <nick> and
<url>.

Since I have no interest in opening the can of worms to allow re-adding
remotes, I did not touch that part at all, I hope you do not mind.

Ciao,
Dscho
