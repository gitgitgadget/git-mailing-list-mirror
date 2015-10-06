From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG?] parallel make interdepencies
Date: Tue, 6 Oct 2015 14:33:41 +0100
Message-ID: <20151006133341.GS17201@serenity.lan>
References: <56138273.6010204@drmicha.warpmail.net>
 <e76ba2a01053392526a499ec9bff0d37@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:34:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSNW-0005l1-G6
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbbJFNd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 09:33:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60282 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbbJFNd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 09:33:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D4527CDA5BB;
	Tue,  6 Oct 2015 14:33:56 +0100 (BST)
X-Quarantine-ID: <vLjHxwx-bvI0>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vLjHxwx-bvI0; Tue,  6 Oct 2015 14:33:52 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1A0CD866016;
	Tue,  6 Oct 2015 14:33:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <e76ba2a01053392526a499ec9bff0d37@dscho.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279141>

On Tue, Oct 06, 2015 at 03:13:05PM +0200, Johannes Schindelin wrote:
> Hi Michael,
>=20
> On 2015-10-06 10:12, Michael J Gruber wrote:
> > "make -j3" just errored out on me, a follow-up "make" succeeded". T=
his
> > looks like an interdependency issue, but I don't know how to track =
it:
> >=20
> >     GEN git-web--browse
> >     GEN git-add--interactive
> >     GEN git-difftool
> > mv: der Aufruf von stat f=C3=BCr =E2=80=9Eperl.mak=E2=80=9C ist nic=
ht m=C3=B6glich: Datei oder
> > Verzeichnis nicht gefunden
> >=20
> > (cannot stat "perl.mak")
>=20
> This one sounds awfully familiar. Although I only encountered this if
> I specified `make -j15 clean all`, i.e. *both* "clean" and "all"...

I've seen something like this after upgrading perl (I can't remember th=
e
exact error, so it may not be the same problem but I'm pretty sure it
involves perl.mak).  The problem was a result of the perl library path
changing, but I never got around to creating a patch.

I thought I remembered someone else posting a patch to address this, bu=
t
I can't find it so perhaps I'm remembering commit 07981dc (Makefile:
rebuild perl scripts when perl paths change, 2013-11-18).
