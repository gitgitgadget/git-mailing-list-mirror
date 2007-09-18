From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Latest builtin-commit series
Date: Tue, 18 Sep 2007 19:15:01 -0400
Message-ID: <1190157301.7157.1.camel@hinata.boston.redhat.com>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
	 <7vbqbzvcf4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmHt-0007TL-NM
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXIRXPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXIRXPU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:15:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbXIRXPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:15:19 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8INF8so001750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 19:15:08 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8INF8Id028389;
	Tue, 18 Sep 2007 19:15:08 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8INF7Oc009076;
	Tue, 18 Sep 2007 19:15:07 -0400
In-Reply-To: <7vbqbzvcf4.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58656>


On Tue, 2007-09-18 at 15:25 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > Better late than never:
> >
> >       * rebase to Pierres strbuf changes.  Note, there is still som=
e
> >         strbuf tweaking required, to let stripspace work on a strbu=
f.
> >         Also, I changed the semantics of stripspace to always add a
> >         newline if the last line doesn't have one.  I believe the
> >         current odd semantics (always remove the last newline) come=
s
> >         from not being able to easily add a newline, but now that i=
t's a
> >         strbuf, that's easy.
>=20
> I do not find the "remove trailing newline" so odd.  Didn't it
> come because you sometimes needed to _not_ add it?

All users add a trailing newline if it's not present after stripping.

> >       * Set the test suite default editor to '/bin/true' instead of=
 ':'.
> >         Since we're not exec'ing the editor from shell anymore, ':'
> >         won't work.  Maybe we should special case ':' in launch_edi=
tor
> >         or perhaps make launch_editor use system(3).  Not sure.
>=20
> We've had a few threads on the list about what to do with:
>=20
> 	GIT_EDITOR=3D'emacs -nw'
>=20
> I think David's 08874658b450600e72bb7cb0d0747c1ec4b0bfe1
> (git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR
> accept commands) is a sensible to deal with this issue, and
> prefer to see the same semantics kept in the C version.

Ok, I'll take a look at that commit.

Kristian
