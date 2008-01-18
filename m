From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 10:42:36 +0100
Message-ID: <200801181042.37391.robin.rosenberg.lists@dewire.com>
References: <478E1FED.5010801@web.de> <200801180205.28742.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pedro Melo <melo@simplicidade.org>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 10:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFnkf-0008RR-Qi
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbYARJmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 04:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbYARJmg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:42:36 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10583 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbYARJmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 04:42:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B8E5A80286C;
	Fri, 18 Jan 2008 10:42:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtM26w7Rt0HL; Fri, 18 Jan 2008 10:42:32 +0100 (CET)
Received: from lathund.dewire.com.dewire.com (lathund.dewire.com.dewire.com [10.1.2.238])
	by dewire.com (Postfix) with ESMTP id DFBDD802662;
	Fri, 18 Jan 2008 10:42:32 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70984>

fredagen den 18 januari 2008 skrev Linus Torvalds:
> > > translation to UTF-8, and since we use C strings, I'd assume/hope=
 Windows=20
> > > actually uses that unambiguous translation for any filenames).
> >=20
> > It uses the local 8-bit codepage, which is not UTF-8, often some la=
tin-inspired
> > thingy, but in Asia multi-byte encodings are used. In western Europ=
e it is
> > Windows-1252, which is almost, but not exactly iso-8859-1. Oh, and =
then we
> > have the cmd prompt which has another encoding in 8-bit mode.
>=20
> Well, if it uses a 8-bit codepage, then that means that as far as the=
=20
> POSIX filename interface is concerned, it has nothing what-so-ever to=
 do=20
> with Unicode (ie unicode is just a totally invisible internal encodin=
g=20
> issue, not externally visible).

I just had to investigate this a bit, so on a Vista machine I started a=
 cmd
prompt and typed mode con: cp select=3D65001, selected the lucida font =
and then
echo =E5 >x.txt and opened it in notepad and it was UTF-8 encoded. So t=
here might
be some hope after all. I don't know how to change the encoding for non=
-console
apps. I leave that as an excercise for the list.

-- robin
