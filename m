From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] contrib/workdir: create logs/refs and rr-cache in the
	origin repository
Date: Mon, 19 Jan 2009 13:20:18 +0100
Message-ID: <20090119122018.GA25566@chistera.yi.org>
References: <1232208943-31756-1-git-send-email-dato@net.com.org.es> <7vbpu54cxe.fsf@gitster.siamese.dyndns.org> <20090118113830.GA1394@chistera.yi.org> <7vskngwfko.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 13:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOt8U-0008PZ-2C
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbZASMUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 07:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZASMUW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 07:20:22 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3980
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbZASMUV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 07:20:21 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 68C78801C0E4;
	Mon, 19 Jan 2009 13:20:19 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LOt74-0006h5-7X; Mon, 19 Jan 2009 13:20:18 +0100
Content-Disposition: inline
In-Reply-To: <7vskngwfko.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106349>

* Junio C Hamano [Sun, 18 Jan 2009 11:59:35 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > However, I've as of late directly created bare repositories knowing=
 that
> > I wanted to work just with workdirs against it. In this case, the l=
ogs
> > for each checkout'ed branch will be stored in the workdirs and not =
the
> > repo, so deleting the workdir will make you lose those logs. Which =
is
> > bad, since workdirs should always be safe to delete.

> I had to think about the above for a while, but after realizing that =
you
> have a strict distinction between a "workdir" and a normal "repositor=
y
> with a work tree" in mind, I can see where you are coming from.  A wo=
rkdir
> is transient in nature and you should be able to dismiss it safely as=
 long
> as the repository it borrows from is intact.

The thing, for me, is that a workdir should result in effects as close
as possible as doing the work in the repository with the workdir itself=
=2E
I normally use workdirs when it's not feasible to do the work in the
repo itself (eg., there's work in progress I'd rather have around,
rather than committing it to a temporary branch, to leave the repo
"clean" for further work).

>     A workdir is a new work area that is not a normal "work tree with=
 a
>     full repository", but borrows from an existing repository.  Any s=
ide
>     effect from the work you do in a workdir will be saved in the ori=
ginal
>     repository, and removing one would lose only the three kind of
>     information listed above.  Creating a new workdir has the side ef=
fect
>     of enabling reflogs and rerere in the original repository.

> But the last sentence somehow feels dirty.

I really don't understand that last sentence. Does "mkdir logs/refs rr-=
cache"
*enable* reflogs and rerere at all? Or, rather, it just gives an empty
space for the workdirs "connecting" to it to save their reflogs and
rerere stuff iff they are configured to do so?

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Love in your heart wasn't put there to stay.
Love isn't love 'til you give it away.
                -- Oscar Hammerstein II
