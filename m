From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4 08/11] connect: change the --diag-url output to
 separate user and host
Date: Wed, 4 May 2016 07:50:51 +0900
Message-ID: <20160503225051.GB21973@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-9-git-send-email-mh@glandium.org>
 <c1cc0220-d239-1589-9957-1ef8a6245d54@web.de>
 <CAPig+cTYjY7=8YqGy_4dNKK7JWinShjTR-nEMY2V6gudzS2Bgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:51:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axj9q-00081T-LA
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbcECWvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 18:51:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53040 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756519AbcECWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:51:05 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1axj9X-0005u6-GO; Wed, 04 May 2016 07:50:51 +0900
Content-Disposition: inline
In-Reply-To: <CAPig+cTYjY7=8YqGy_4dNKK7JWinShjTR-nEMY2V6gudzS2Bgw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293474>

On Tue, May 03, 2016 at 01:23:37PM -0400, Eric Sunshine wrote:
> On Tue, May 3, 2016 at 12:20 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
> > On 2016-05-03 10.50, Mike Hommey wrote:
> >> -     git fetch-pack --diag-url "$1" | grep -v host=3D | grep -v p=
ort=3D >actual &&
> >> +     git fetch-pack --diag-url "$1" | grep -v user=3D | grep -v h=
ost=3D | grep -v port=3D >actual &&
> > Running grep a couple of times is probably not optimal in terms of =
spawning a
> > process....
> > Does
> >
> > git fetch-pack --diag-url "$1" | egrep -v "user=3D|host=3D|port=3D"=
 >actual &&
> > work ?
> > or the version like this:
> > git fetch-pack --diag-url "$1" | egrep -v "(user|host|port)=3D" >ac=
tual &&
>=20
> I always worry about portability problems with these "advanced"
> expressions in grep and sed, however, both of these work fine under
> Mac OS X and FreeBSD (which is where problems often manifest).

That was my concern. But it looks like we already rely on the
egrep "(|)" form working in some other test, so I guess it's fine to us=
e
that.

Mike
