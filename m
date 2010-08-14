From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Do not build i18n on Windows.
Date: Sat, 14 Aug 2010 10:24:41 +0200
Message-ID: <201008141024.42093.j6t@kdbg.org>
References: <201008140002.40587.j6t@kdbg.org> <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 10:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkC2u-0000gb-8W
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 10:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895Ab0HNIYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 04:24:46 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19225 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932788Ab0HNIYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 04:24:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EAD13CDF88;
	Sat, 14 Aug 2010 10:24:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5D20619F5FD;
	Sat, 14 Aug 2010 10:24:42 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153548>

On Samstag, 14. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wro=
te:
> On Fri, Aug 13, 2010 at 22:02, Johannes Sixt <j6t@kdbg.org> wrote:
> > We do not have the necessary libraries and tools.
>
> Just curious, do you mean Windows / MINGW can't build gettext, or tha=
t
> you just haven't done so in your build process yet? At least
> http://www.mingw.org/wiki/LibrariesAndTools seems to indicate that
> libintl has been ported to Windows.

The msysgit build environment that I am using does not have libintl. Th=
e=20
reason *might* be that I haven't updated it since months. Upstream msys=
git=20
could already have it.

The MSVC build environment doesn't have libintl in any case. Even if ms=
ysgit=20
gains libintl, the MSVC does *not* automatically gain it as well. Hence=
,=20
setting NO_GETTEXT in the MSVC section of the Makefile makes sense for =
now.

BTW, libintl is not the only obstacle: the gettext tools are needed as =
well.

> If you're just not interested in building gettext by default on
> Windows I think it's completely reasonable to add it to the Makefile
> (given that you're probably pretty much the only one doing so). It
> would just be useful to clarify the "why".

As long as libintl and the gettext tools are not in msysgit, we should =
set=20
NO_GETTEXT for MinGW builds. Once we have them, I don't care that much=20
whether we set it by default or not.

-- Hannes
