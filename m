From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 17:27:56 +0200
Message-ID: <87ip47wpvn.fsf@linux-k42r.v.cablecom.net>
References: <20130331133332.GD2286@serenity.lan>
	<cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
	<51584955.40007@physik.tu-berlin.de>
	<20130331144452.GF2286@serenity.lan>
	<87mwtjwqzz.fsf@linux-k42r.v.cablecom.net>
	<51585491.1070604@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 17:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMKBM-0003X8-HE
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 17:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3CaP2D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 11:28:03 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:8025 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3CaP2C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Mar 2013 11:28:02 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 17:27:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.251) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sun, 31 Mar 2013 17:27:59 +0200
In-Reply-To: <51585491.1070604@physik.tu-berlin.de> ("Sebastian
 \=\?utf-8\?Q\?G\=C3\=B6tte\=22's\?\=
	message of "Sun, 31 Mar 2013 17:21:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219632>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> On 03/31/2013 05:03 PM, Thomas Rast wrote:
>>>>  } sigcheck_gpg_status[] =3D {
>>>>  	{ 'G', "[GNUPG:] GOODSIG " },
>>>>  	{ 'B', "[GNUPG:] BADSIG " },
>>>> +	{ 'U', "[GNUPG:] TRUST_NEVER" },
>>>> +	{ 'U', "[GNUPG:] TRUST_UNDEFINED" },
[...]
>> And furthermore, to use an enum instead of a char so that you can ea=
sily
>> spell out the details in the code?  This also has the advantage that=
 the
>> compiler can check that your 'switch'es cover all cases.
> This char is actually from Junios original code. I think we can affor=
d
> three chars. This could be changed if we ever need more than that.

*shrug*

I'm tempted to count the above as an argument in favor of the enum,
since there are in fact *four* chars... 'N' also counts. ;-)

But either way... I don't care too deeply and I don't know this corner
of the code.  I just came here because of the valgrind discovery.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
