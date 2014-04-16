From: Frank Ammeter <git@ammeter.ch>
Subject: Re: wrong handling of text git attribute leading to files incorrectly reported as modified
Date: Wed, 16 Apr 2014 13:49:02 +0200
Message-ID: <B3DF4E4A-F740-4588-AFD5-74D99E5299F5@ammeter.ch>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch> <534852D4.5070608@web.de> <D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch> <CANUGeEYoS+t57jfpEoZE-2u_cD1uOD5pdp=yF--Rhpb9z91qxQ@mail.gmail.com> <xmqqob02jnhk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon McCaig <bamccaig@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 13:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaOL6-0004NN-7T
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 13:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbaDPLtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 07:49:10 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:44216 "EHLO
	mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202AbaDPLtI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 07:49:08 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
	by mxout013.mail.hostpoint.ch with esmtp (Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WaOKv-0006vR-76; Wed, 16 Apr 2014 13:49:05 +0200
Received: from [91.190.10.159] (helo=[192.168.0.105])
	by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WaOKv-0003Yq-4e; Wed, 16 Apr 2014 13:49:05 +0200
X-Authenticated-Sender-Id: git@ammeter.ch
In-Reply-To: <xmqqob02jnhk.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246331>

Am 15.04.2014 um 23:23 schrieb Junio C Hamano <gitster@pobox.com>:

> Brandon McCaig <bamccaig@gmail.com> writes:
>=20
>> That is for your benefit, and for easily sharing that configuration
>> with collaborators. Git only cares that the file exists in your
>> working tree at run-time.
>=20
> It is a lot more than "for sharing".  If you made .gitignore only
> effective after it gets committed, you cannot test your updated
> version of .gitignore is correct before committing the change.

Ok, I can follow that logic for .gitignore, but I was talking about .gi=
tattributes and I always thought that .gitattributes as belonging to th=
e repository, since it affects a) how files are checked out and b) how =
they are stored inside the repository.
If committing .gitattributes were only for sharing convenience, git cou=
ldn=92t decide whether to convert line endings when checking out a file=
=2E The same behavior doesn=92t apply to .gitignore, because git will c=
heckout a file that was added even though it matches an ignore pattern =
in .gitignore.
