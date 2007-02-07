From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 18:01:22 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070207170122.GB18704@informatik.uni-freiburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqAl-0004uc-E4
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbXBGRB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbXBGRB2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:01:28 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46278 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161434AbXBGRB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 12:01:27 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HEqAg-0001BY-EZ; Wed, 07 Feb 2007 18:01:26 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l17H1NSv019368;
	Wed, 7 Feb 2007 18:01:23 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l17H1NhS019367;
	Wed, 7 Feb 2007 18:01:23 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38939>

Don Zickus wrote:
> I was curious to know what is the easiest way to filter info inside a
> commit message.
>=20
> For example say I wanted to find out what patches Joe User has
> submitted to the git project.
> I know I can do something like ' git log |grep -B2 "^Author: Joe User=
"
What about

	git log --author=3D"Joe User"

> ' and it will output the matches and the commit id.  However, if I
> wanted to filter on something like "Signed-off-by: Joe User", then it
> is a little harder to dig for the commit id.
>=20
> Is there a better way of doing this?  Or should I accept the fact tha=
t
> git wasn't designed to filter info like this very quickly?
>=20
> I guess what I was looking to do was embed some metadata inside the
> commit message and parse through it at a later time (ie like a
> bugzilla number or something).
>=20
> Any thoughts/tips/tricks would be helpful.

Maybe:

	git log | awk -v sob=3D"Joe User" '$1 =3D=3D "commit" {commit =3D $2} =
/Signed-off-by:/ {if (match($0, sob)) print commit}'

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D2004+in+roman+numerals
