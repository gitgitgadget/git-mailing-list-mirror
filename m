From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix attribute handling in bare repositories
Date: Sun, 08 Jun 2008 23:31:30 +0200
Message-ID: <484C4FB2.6020105@lsrfire.ath.cx>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com> <484BF7BB.1090802@lsrfire.ath.cx> <7vskvnirjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SV2-0006wk-L5
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbYFHVbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 17:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755784AbYFHVbd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:31:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:35863 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYFHVbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:31:32 -0400
Received: from [10.0.1.200] (p57B7BDB9.dip.t-dialin.net [87.183.189.185])
	by india601.server4you.de (Postfix) with ESMTPSA id 5CB262F8068;
	Sun,  8 Jun 2008 23:31:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vskvnirjm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84323>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Nguyen Thai Ngoc Duy schrieb:
>>> Hi,
>>>
>>> Currently attr.c will read .gitattributes on disk no matter there i=
s a
>>> real worktree or not. This can lead to strange behavior.
>> Yes, it probably shouldn't do that.  What about this patch?
>=20
> Hmm.  I do not know if it breaks anything, but if you are indeed in a=
 bare
> repository, the files the codepaths affected try to read would not ex=
ist
> anyway, so I am not sure what this would fix, other than changing the
> behaviour of check-attr from noticing that it was asked for nonsense =
and
> bail out to not noticing nor saying anything useful.

The patch does two things: it fixes git-check-attr to work in a bare
repository, and it makes git ignore .gitattributes files in bare
repositories.  True, the latter is fixable by simply not creating these
files in the first place.

Duy somehow ended up with them, though, and reported it as strange that
they are not ignored.  And I agree: if we don't have a work tree then w=
e
should not look at it. :-)

Ren=C3=A9
