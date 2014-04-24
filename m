From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Thu, 24 Apr 2014 10:02:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1404240949440.28469@ds9.cixit.se>
References: <201404072130.15686.tboegi@web.de> <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se> <534E0B84.6070602@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 24 11:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdFY7-0001UK-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbaDXJCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2014 05:02:25 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:44871 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753121AbaDXJCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 05:02:21 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s3O92Ie0000409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Apr 2014 11:02:18 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s3O92HWn000405;
	Thu, 24 Apr 2014 11:02:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <534E0B84.6070602@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 24 Apr 2014 11:02:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246951>

Torsten B=C3=B6gershausen:

> Some of the code points which have "0 length on the display" are call=
ed
> "combining", others are called "vowels" or "accents".
> E.g. 5BF is not marked any of them, but if you look at the glyph, it =
should
> be combining (please correct me if that is wrong).

All combining characters has a non-zero combining class in=20
http://www.unicode.org/Public/UNIDATA/UnicodeData.txt (fourth field,=20
called Canonical_Combining_Class in=20
http://www.unicode.org/reports/tr44/ ). For instance, the aforementione=
d=20
U+05BF is defined as follows:

   05BF;HEBREW POINT RAFE;Mn;23;NSM;;;;;N;;;;;

The combining class is 23, so this is a combining character.

There is a difference between non-spacing combining marks ("Mn" in the=20
third column (General_Category)) and others ("Mc" for spacing marks=20
and "Me" for enclosing marks), so they might need specifial handling.=20
Additionally, you have the "zero-width" characters, such as U+200B=20
Zero Width Space. These have the "Cf" class, although it also contains=20
visible characters IIRC.

--=20
\\// Peter - http://www.softwolves.pp.se/
