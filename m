From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: BUG! missing .idx causes .pack to be removed
Date: Fri, 13 Aug 2010 18:02:21 +0200
Message-ID: <20100813160221.GA10974@nibiru.local>
References: <20100805170137.GA2630@nibiru.local> <AANLkTi=bjM7rGSXv0eB5+6VEX=wY84upkzDcBJ6C9KdK@mail.gmail.com> <4C5BB64A.4070601@lsrfire.ath.cx>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 18:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojwru-0003B4-2S
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 18:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934540Ab0HMQMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 12:12:24 -0400
Received: from caprica.metux.de ([82.165.128.25]:40580 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754512Ab0HMQMX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 12:12:23 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7DGC1ZF017937
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 18:12:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7DGBKJ7017910
	for git@vger.kernel.org; Fri, 13 Aug 2010 18:11:20 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7DG2LBh017331
	for git@vger.kernel.org; Fri, 13 Aug 2010 18:02:21 +0200
Content-Disposition: inline
In-Reply-To: <4C5BB64A.4070601@lsrfire.ath.cx>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153474>

* Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> > IIRC, a .pack file is useless without its corresponding .idx file. =
So
> > the removal of a .pack file makes sense here - to me, at least.
>=20
> git-index-pack can rebuild the index for a pack file.  Not sure if it
> should be done automagically, but the file is not completely useless.

ACK. packfiles are completely self-contained - the index files are
only used for lookup and can be created any time (IMHO that's also
done automatically on remote transfers). So removing a packfile,
just because the index is missing, causes an serious data loss.
That's what I'd consider a critical bug!

The correct solution would be either recreating the index
automatically or at least spit out an big-fat warning.


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
