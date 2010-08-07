From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sat, 07 Aug 2010 11:29:44 -0600
Message-ID: <1281202184.4815.1.camel@compaq.olson.home>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
	 <AANLkTinyohKaACbheGR2Q=-K5sWwv+y1u1-3b2WPzxVh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 19:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhnNs-0008Q4-5k
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 19:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab0HGRkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 13:40:31 -0400
Received: from 28dayslater.mr.itd.umich.edu ([141.211.12.118]:44005 "EHLO
	28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294Ab0HGRka convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 13:40:30 -0400
Received: FROM hackers.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.14.81])
	By 28dayslater.mr.itd.umich.edu ID 4C5D9885.6D5AF.22000 ;
	 7 Aug 2010 13:31:49 EDT
Received: FROM [192.168.1.5] (174-28-223-52.albq.qwest.net [174.28.223.52])
	By hackers.mr.itd.umich.edu ID 4C5D9880.7BF22.27088 ;
	Authuser olsonse;
	 7 Aug 2010 13:31:45 EDT
In-Reply-To: <AANLkTinyohKaACbheGR2Q=-K5sWwv+y1u1-3b2WPzxVh@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152860>

I would have no problem doing that.  I was just trying to match the
style already present in http.c.  All the other pointer tests in that
function/file are done the same.


On Sat, 2010-08-07 at 08:34 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Sat, Aug 7, 2010 at 03:34, Spencer E. Olson <olsonse@umich.edu> wr=
ote:
>=20
> > -       curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT)=
;
> > +       if (user_agent !=3D NULL)
> > +               curl_easy_setopt(result, CURLOPT_USERAGENT, user_ag=
ent);
> > +       else
> > +               curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USE=
R_AGENT);
>=20
> Can't you just skip the !=3D NULL?:
>=20
>        if (user_agent)
>                curl_easy_setopt(result, CURLOPT_USERAGENT, user_agent=
);
>        else
>                curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_A=
GENT);
>=20
>=20
