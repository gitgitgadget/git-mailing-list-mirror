From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: config.c fixes
Date: Fri, 14 Dec 2007 15:19:44 -0500
Message-ID: <1197663584.615.4.camel@hinata.boston.redhat.com>
References: <20071214192852.GA24187@bitplanet.net>
	 <7v3au5rrjv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3H7d-000066-Ch
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbXLNU0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXLNU0j
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:26:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbXLNU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:26:38 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEKJoRS024819;
	Fri, 14 Dec 2007 15:19:50 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKJn2S003367;
	Fri, 14 Dec 2007 15:19:49 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKJnYY023428;
	Fri, 14 Dec 2007 15:19:49 -0500
In-Reply-To: <7v3au5rrjv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68341>

On Fri, 2007-12-14 at 11:43 -0800, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > While strace'ing builtin-clone I saw this horror:
> > I think the best solution is to just parse up the entire config fil=
e
> > up front and keep it in a data structure, make the changes and then
> > write it all out at the end.
>=20
> Yeah, that was what I suggested a few times when other people have do=
ne
> config writing side, but without successfully getting past their skul=
ls
> (it is not Linus's nor my code).  It's about time somebody started to
> clean up that mess.
>=20
> The timing is a bit unfortunate, though.  I would have preferred to h=
ave
> a week or so to cook this in 'next' before merging it part of -rc0.

Right, what I was describing above was more of a long term thing.  I
sent two patches more suitable for 1.5.4 that fixes the double close an=
d
the 1-byte writes in a less intrusive way.  Except as the Johanneses
point out, I can't use the lock as a local variable, but must allocate
so the atexit handler doesn't break.  If it has to be allocated, the AP=
I
should help/enforce that.  I've sent out a couple of new patches that
fixes this.

Kristian
