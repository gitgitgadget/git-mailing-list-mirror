From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Diff output from a rewrite of a function
Date: Thu, 8 Mar 2007 23:01:35 +0100
Organization: Dewire
Message-ID: <200703082301.35774.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Ilpo =?iso-8859-1?q?J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPQeO-0000xW-2Z
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbXCHV7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Mar 2007 16:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbXCHV7r
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 16:59:47 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10880 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030724AbXCHV7q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2007 16:59:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 54A4D802842;
	Thu,  8 Mar 2007 22:54:33 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24846-10; Thu,  8 Mar 2007 22:54:33 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id F1DE78027F8;
	Thu,  8 Mar 2007 22:54:30 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41774>

torsdag 08 mars 2007 20:04 skrev Ilpo J=E4rvinen:
> Hi,
>=20
> I have a C source file in which couple of functions are fully rewritt=
en=20
> (only a part of the file), almost no real similarities (block closing=
=20
> parents will obviously match still and couple of other keyword lines =
here=20
> and there). I wonder if there is way to produce diff that does not ge=
t=20
> confused by the empty lines / identical lines that are present in bot=
h=20
> original and the modified version. Default diff output is very bad lo=
oking=20
> (IMHO) because these identical lines cause a "synchronization point" =
to=20
> occur, that is, each identical line of the original is not considered=
 as=20
> +/- but left as is. Thus I have something like 3-6 add+del blocks per=
=20
> function with a part of the change rather than e.g., one block per=20
> function or so... I found -B from man git-diff-files, but I guess=20
> "complete rewrite changes" means whole files as it did do anything.
>=20
> Any ideas?
Increase the context size from the default three lines.  Something like
diff -U 7 old new will require larger chunks of unchanged code for diff
break up a hunk. With git you can do=20

GIT_DIFF_OPTS=3D-u7 git-diff-....

>=20
> I'm currently using 1.4.2, if that's significant.
>=20
That was 1.5, but I think that part didn't change.

-- robin
