From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 11:29:49 +0200
Message-ID: <8761zce0oi.fsf@linux-k42r.v.cablecom.net>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<87zjwofken.fsf@linux-k42r.v.cablecom.net>
	<87bo94720r.fsf@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 11:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUw1W-0003tW-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 11:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249Ab3DXJ3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 05:29:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:47743 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757390Ab3DXJ3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 05:29:53 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 11:29:49 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 24 Apr 2013 11:29:50 +0200
In-Reply-To: <87bo94720r.fsf@samsung.com> (=?utf-8?Q?=22=C5=81ukasz?=
 Stelmach"'s message of
	"Wed, 24 Apr 2013 10:42:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222242>

l.stelmach@samsung.com (=C5=81ukasz Stelmach) writes:

> It was <2013-04-24 =C5=9Bro 09:38>, when Thomas Rast wrote:
>> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>>> +	if ($email_protocol eq 'nntp') {
>>> +		$header =3D "Newsgroups: $to\n" . $header;
>>> +	} else {
>>> +		$header =3D "To: $to${ccline}\n" . $header;
>>> +	}
>>
>> Are you silently ignoring any Ccs that have been set if you're in NN=
TP
>> mode?
>
> Yes.

So wouldn't it be preferable to complain and abort, at the very least i=
f
the user explicitly gave some --cc options?

And in the documentation that you should write anyway :-), you can stat=
e
that --protocol nntp does not support Cc or Bcc.  That should be good
enough.

>> At least in the git@vger world with a lot of etiquette surrounding t=
he
>> use of Ccs, NNTP mode isn't very useful if you can't also send Ccs. =
 But
>> maybe you have another use-case where that is not a problem?
>
> I've sent this patch vi NNTP :) You've got it.

However, according to the etiquette here you would e.g. send the v2
patch Cc: everyone who has reviewed the v1 patch.

Don't let that hold you up though.  I'm fine with the feature as long a=
s
its limitations are clear and documented, and it catches the obvious
user errors.  Someone who actually needs NNTP *and* Ccs in the same mai=
l
can implement the required support later.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
