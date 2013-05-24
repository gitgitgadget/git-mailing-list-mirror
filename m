From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 18:12:43 +0200
Message-ID: <20130524161243.GB2104@goldbirke>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufubv-0002Gi-DV
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab3EXQMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 12:12:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54983 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab3EXQMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:12:45 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MGmMn-1Uk3KM2em1-00E7xS; Fri, 24 May 2013 18:12:43 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:FI8RPybiNbuqYU/0rihBrAmFgH4RwvBeVtu2tqSubXL
 P5icgEnOQE0g6Jk5arvKkmkQMQ/xxNXF+DLgB6qquaKyLQ8dkO
 44GUQ6oxkvjmcU0AQbH+5xGVBJN0RYAWiF44U8qaSf02atmvqh
 m2P4PFNDiKSmLu9McSakFDndfqkbZnaVeoZhSa8GU54k96fhXB
 S59m+B7qBlxunnb0cT+YpLn+nXN78GYXLC85yqezELaoGSJUHf
 ASC12jjpat6CBFXEsM5XU96+na9YacpdvWX23x62IptWRMuuN7
 7L443I5j5TvJ7fyagLjG89dmB6iqauhRL8/3N4xd4KqzyqqCwX
 X/DpdiIURdkQgj6UUjQs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225371>

Hi,


On Fri, May 24, 2013 at 05:03:27PM +0530, Ramkumar Ramachandra wrote:
> I'm not able to sort completions for some weird reason.  No matter
> what I order I insert stuff into COMPREPLY, bash seems to auto-sort
> them lexically.  I tried to pass --sort=3D'-committerdate' to git
> for-each-ref so I can get a sensible 'git checkout <TAB>' reply, and
> I'm very annoyed that it doesn't work.
>=20
> I thought it was bash's complete builtin doing the implicit sorting,
> so I read the manual with no success.  Is readline doing it?  If so,
> why am I not getting the ordering even in zsh (which doesn't use
> readline)?

The order of elements in COMPREPLY doesn't matter, it will be sorted
anyway:

$ _foo () { COMPREPLY=3D("foo" "bar" "baz") ; }
$ complete -F _foo foo
$ foo <TAB>
bar  baz  foo

I don't know who does the sorting (Bash or readline), and I don't know
any way to disable it.


G=E1bor
