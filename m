From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: feature suggestion: improve rerere
Date: Wed, 06 Mar 2013 14:24:18 +0100
Message-ID: <51374382.6050101@viscovery.net>
References: <20130306101640.GA15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 06 14:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDEKv-00009W-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 14:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab3CFNYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 08:24:23 -0500
Received: from so.liwest.at ([212.33.55.24]:13719 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab3CFNYW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 08:24:22 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UDEKQ-00010A-RI; Wed, 06 Mar 2013 14:24:19 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 82C281660F;
	Wed,  6 Mar 2013 14:24:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130306101640.GA15375@pengutronix.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217525>

Am 3/6/2013 11:16, schrieb Uwe Kleine-K=F6nig:
> 	++<<<<<<< ours
> 	 +ssize_t xread(int fd, void *buf, size_t count)
> 	 +{
> 	 +	ssize_t ret, done =3D 0;
> 	 +
> 	 +retry:
> 	 +	ret =3D read(fd, buf + done, count - done);
> 	 +	if (ret < 0)
> 	 +		return ret;
> 	 +
> 	 +	done +=3D ret;
> 	 +
> 	 +	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
> 	 +		return done;
> 	 +	else
> 	 +		goto retry;
> 	 +}
> 	 +
> 	++||||||| base
> 	++=3D=3D=3D=3D=3D=3D=3D
> 	+ #include "common.h"
> 	+=20
> 	++>>>>>>> theirs
> 	  int main(int argc,char *argv[])
> 	  {
> 		int fd, val, ret, size, wrote, len;
>=20
> This is the same conflict as the first one, just with ours and theirs
> exchanged. So my suggestion is to make rerere use the resolution
> recorded for the first conflict here.
>=20
> Sounds sensible?

Of course, and rerere already does it. But only when you use git's defa=
ult
conflict markers rather than diff3 style markers that have this extra
||||| line.

-- Hannes
