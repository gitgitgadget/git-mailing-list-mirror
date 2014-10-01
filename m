From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 09/38] lock_file(): always initialize and register
 lock_file object
Date: Wed, 01 Oct 2014 13:38:50 +0200
Message-ID: <542BE7CA.5060902@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu> <1412159322-2622-10-git-send-email-mhagger@alum.mit.edu> <542BE535.3040500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?ISO-8859-15?Q?Torsten_B=F6gershause?= =?ISO-8859-15?Q?n?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZIFK-0007Bb-59
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbaJALi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 07:38:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62926 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751148AbaJALi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 07:38:57 -0400
X-AuditID: 12074412-f792e6d000005517-ca-542be7cd7a44
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.6B.21783.DC7EB245; Wed,  1 Oct 2014 07:38:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91Bco23029617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 07:38:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <542BE535.3040500@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsUixO6iqHv2uXaIwcYJahZdV7qZLBp6rzBb
	PJl7l9ni7c0ljBZntvYzW/xo6WG2+DehxqKz4yujA4fHzll32T0WbCr1ePiqi93jWe8eRo+L
	l5Q9Pm+S87j9bBtLAHsUt01SYklZcGZ6nr5dAnfG4QNzWQrucVY07P3O0sD4g72LkZNDQsBE
	YuP1SVC2mMSFe+vZuhi5OIQELjNK/DlyhhXCOcck8fPpdzaQKl4BbYnHN76DdbAIqEo8vnuQ
	GcRmE9CVWNTTzARiiwoESHzofMAIUS8ocXLmExYQW0QgQaKpdzUzyFBmgXYmic+Ln4I1CAvE
	SNxb0sQCsW0ao0TfwXVgGzgF1CT+bFsPZHMAdehKtK2RAQkzC8hLNG+dzTyBUWAWkh2zEKpm
	IalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkJoR2MK4/KXeIUYCD
	UYmHVyFBO0SINbGsuDL3EKMkB5OSKO+qh0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzZB4By
	vCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvG+fATUKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgYrSApHqC9W0DaeYsLEnOBohCtpxh1OdZ1futn
	EmLJy89LlRLnFQEpEgApyijNg1sBS4CvGMWBPhbmPQlSxQNMnnCTXgEtYQJakrwGbElJIkJK
	qoExpF9b/99/vmVHf1ytVlmz/JOy7PsTBsW6chKaSsYm4sZRi+eoTPx12T825+2d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257745>

On 10/01/2014 01:27 PM, Ren=E9 Scharfe wrote:
> Am 01.10.2014 um 12:28 schrieb Michael Haggerty:
>> The purpose of this patch is to make the state diagram for lock_file
>> objects simpler and deterministic.
>>
>> If locking fails, lock_file() sometimes leaves the lock_file object
>> partly initialized, but sometimes not. It sometimes registers the
>> object in lock_file_list, but sometimes not. This makes the state
>> diagram for lock_file objects effectively indeterministic and hard t=
o
>> reason about. A future patch will also change the filename field int=
o
>> a strbuf, which needs more involved initialization, so it will becom=
e
>> even more important that the state of a lock_file object is
>> well-defined after a failed attempt to lock.
>>
>> The ambiguity doesn't currently have any ill effects, because
>> lock_file objects cannot be removed from the lock_file_list anyway.
>> But to make it easier to document and reason about the code, make th=
is
>> behavior inconsistent: *always* initialize the lock_file object and
>=20
> s/incon/con/, certainly?

Yes, thanks.

Junio, if another reroll is not necessary, would you mind fixing this
when applying?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
