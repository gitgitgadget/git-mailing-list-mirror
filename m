From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 22:00:43 +0200
Message-ID: <20111005200043.GA32732@inner.h.iocl.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com> <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com> <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com> <7vpqib8jzk.fsf@alter.siamese.dyndns.org> <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com> <7vzkhf713u.fsf@alter.siamese.dyndns.org> <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 22:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBXeU-0002uQ-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 22:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935363Ab1JEUAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 16:00:54 -0400
Received: from continuum.iocl.org ([217.140.74.2]:47772 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab1JEUAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 16:00:53 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p95K0hQ01770;
	Wed, 5 Oct 2011 22:00:43 +0200
Content-Disposition: inline
In-Reply-To: <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182879>

On Wed, 05 Oct 2011 15:11:30 +0000, Jay Soffian wrote:
=2E..
> > =A0- Error out (or warn if forced) upon any attempt to update the t=
ip of a
> > =A0 branch that is checked out in more than one place; and
>=20
> I think that's a worse user experience. "Sorry, can't commit your
> changes because you've checked out this branch elsewhere."

This is actually pretty much the same as "you can't push into the
currently checked-out branch".

I do come from CVS where multiple checkouts of the same branch are obvi=
ously
common, but the semantics are different. git would need to allow to be =
in
a detached state but still have a notion of a 'current' branch to mimic=
 that;
this tentative 'current' branch being what we need to merge or rebase o=
nto later.
Just thinking.

It may actually be logical to put the other workdirs into detached stat=
e when
the branch they are on is committed into; however, this is seriously co=
nfusing.

> Now the
> user's choices are:
>=20
> 1. commit --force (and thus confusing the other workdirs)
> 2. checkout -b new_branch && commit
>=20
> Both of which I think are worse than preventing the checkout in the f=
irst place.

Hmm. You mean forcing the user to make a new branch *earlier* than at
commit time is better?

Andreas
