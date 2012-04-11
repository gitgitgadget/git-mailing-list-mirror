From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 07/12] completion: simplify command stuff
Date: Thu, 12 Apr 2012 01:01:57 +0200
Message-ID: <20120411230157.GV2289@goldbirke>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
	<20120411221430.GT2289@goldbirke>
	<CAMP44s3hYHxs2HZ59meEO=SU7gXuxU=m489LdxV38=7PDeDFdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:02:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI6YA-0004ft-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761395Ab2DKXCC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 19:02:02 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60187 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761391Ab2DKXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:02:00 -0400
Received: from localhost6.localdomain6 (p5B130C22.dip0.t-ipconnect.de [91.19.12.34])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lp8j6-1RmMEa30mC-00fh01; Thu, 12 Apr 2012 01:01:57 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3hYHxs2HZ59meEO=SU7gXuxU=m489LdxV38=7PDeDFdw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ZebacMuHmKIE2c+OHB/L6oARewvYPTU/SuepaoJgjZI
 EvbOAgpvkvFqdwceEpEXEU4p1xy6IZZVNDk7xABoF/wzspwol7
 mDsPz3HkZLAUdWm79rNuVooltoEd6LN+/raRv/jbu4mN/0+Pf6
 X1Ey7A56vi9ZmcwLoNgVD6wdK2paPR/JHZBWBwvcRjrLh8uy3/
 OhKa7B8qtz0SU1gAUWLUCa90L2hpKxWxB0EoV+SxPL/BKwW9yB
 N9tMx1T5BJ04ddjVEYWFuh+WAWCWXVWoJ14zeYkRyHX8rkSUib
 bQl1lYwHgczhrMXw7lSKBqNwmG6Td6EZLzgdhm+A4YX75Epz+f
 lxEEemrtAfLsaFFmeQMY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195280>

On Thu, Apr 12, 2012 at 01:21:17AM +0300, Felipe Contreras wrote:
> 2012/4/12 SZEDER G=E1bor <szeder@ira.uka.de>:
> > However, this change "promotes" the command (or cmd) variable from
> > being just a variable in _git() to a variable that is used in other
> > completion functions, too. =A0Why not go one more step further, and
> > denote this by adding a __git prefix (i.e. renaming the variable to
> > __git_command)?
>=20
> After thinking more about it, and analyzing the next patches, I don't
> think it makes sense to have such a variable; it's only used by
> __git_complete_remote_or_refspec, and it would be easier to make it a=
n
> argument to that function; that would simplify this patch series a
> lot.

You mean that _git_fetch() would call

  __git_complete_remote_or_refspec "fetch"

while _git_pull() and _git_push() will pass "pull" and "push",
respectively?


Best,
G=E1bor
