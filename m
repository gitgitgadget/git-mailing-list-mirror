From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] t1304: fall back to $USER if $LOGNAME is not defined
Date: Fri, 14 Oct 2011 22:54:28 +0200
Message-ID: <4E98A184.2040908@lsrfire.ath.cx>
References: <4E98750D.1020106@lsrfire.ath.cx> <7vobxjza9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 22:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REom4-0006gu-SL
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 22:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab1JNUyc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 16:54:32 -0400
Received: from india601.server4you.de ([85.25.151.105]:57161 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1JNUyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 16:54:32 -0400
Received: from [192.168.2.104] (p4FFD9258.dip.t-dialin.net [79.253.146.88])
	by india601.server4you.de (Postfix) with ESMTPSA id B72922F8057;
	Fri, 14 Oct 2011 22:54:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vobxjza9t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183609>

Am 14.10.2011 20:41, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> For some reason $LOGNAME is not set anymore for me after an upgrade =
from
>> Ubuntu 11.04 to 11.10.  Use $USER in such a case.
>>
>> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>> ---
>> The only other use of $LOGNAME is in git-cvsimport, which does the s=
ame.
>=20
> While the change to assign $USER to $LOGNAME when the latter is not s=
et is
> not wrong per-se, I have to wonder (1) why this test should use LOGNA=
ME
> not USER in the first place, and (2) why you lost LOGNAME.
>=20
> LOGNAME
> The system shall initialize this variable at the time of login to be =
the
> user's login name. See <pwd.h> . For a value of LOGNAME to be portabl=
e
> across implementations of POSIX.1-2008, the value should be composed =
of
> characters from the portable filename character set.
>=20
> Will apply anyway. Thanks.

Common practise (on Linux at least) seems to be to set both $LOGNAME
(from Sys-V) and $USER (from BSD) to the same value, so either could be
used.  The portable way is to check both.

Both were set before the upgrade on my system, and $LOGNAME is _still_
set if I log onto the console or use sudo or su, but it's _not_ set in =
a
plain Gnome Terminal with bash.  I also wonder why that may be.

Ren=C3=A9
