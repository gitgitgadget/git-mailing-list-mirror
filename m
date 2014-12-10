From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Wed, 10 Dec 2014 01:49:12 +0000
Message-ID: <1418176152.8290.9.camel@segulix>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
	 <1417878270-4364-2-git-send-email-philipoakley@iee.org>
	 <1418096636.19104.31.camel@segulix>
	 <xmqqoarcjpv3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 02:49:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyWPJ-0005OL-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 02:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbaLJBtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 20:49:21 -0500
Received: from host1.easyho.st ([62.210.60.225]:43043 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064AbaLJBtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 20:49:20 -0500
Received: from bl7-115-75.dsl.telepac.pt ([85.240.115.75]:57746 helo=[192.168.1.67])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1XyWOu-002gfi-LG; Wed, 10 Dec 2014 01:49:17 +0000
In-Reply-To: <xmqqoarcjpv3.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261186>

On Ter, 2014-12-09 at 16:44 -0800, Junio C Hamano wrote:=20
> S=E9rgio Basto <sergio@serjux.com> writes:
>=20
> > Also don't understand why --assumed-untracked shouldn't deal with
> > changed files instead fallback in "the user promises not to change =
the
> > file" and sometimes works others not.=20
> >
> > Also if this is the contract when a file is different from commit,
> > should warning the user that is not in contract (modify files that =
are
> > assumed-untracked )=20
>=20
> Unfortunately, that is not even possible in the case where
> assume-untracked is meant to be used without breaking the use case
> it was invented to support.=20

OK, but when we do: git --assumed-untracked <file> and file is already
modified. we could do an warning .

May also should mention in documentation that --assumed-untracked  is
not to deal with "local versions of tracked config files in git" (if yo=
u
don't)=20

Meanwhile I read https://gist.github.com/canton7/1423106=20
I adopt
https://gist.github.com/canton7/1423106#if-you-cant-modify-your-applica=
tion=20
item 1=20

Thanks for your patience


>  The user flips the bit so that Git does
> not have to traverse the working tree to run lstat(2) on all of them
> in order to see if some have changes relative to the index.
>=20
> If we cannot trust that bit and need to verify, how would we do
> that?
>=20
> Think.
>=20
> Yes, by running lstat(2) on these files that the user promised not
> to touch.  That just defeats the sole objective the feature was
> invented for in the first place.
>=20
> Having said all that, I know what you wish to have, and I am not
> fundamentally opposed to a change to add a new feature to order Git
> to pretend that changes that may exist in the working tree are not
> there.=20
> It's just that assume-unchanged bit is not that.  It is a
> way to allow Git that it can assume the files in the working tree
> are not changed.  It is a permission, not a command.
>=20
> This is a tangent, but somebody may want to check the "Git will fail
> (gracefully)" bit in the documentation Philip's documentation patch
> did not remove.  Such a detection is not absolutely necessary, and
> the paragraph may be describing a wishful thinking by somebody who
> misunderstood --assume-unchanged with a cursory observation of what
> happened for limited test cases back when the documentation was
> added, in which case that paragraph may also want to go.
>=20
>=20
>=20
>=20
>=20
>=20

--=20
S=E9rgio M. B.
