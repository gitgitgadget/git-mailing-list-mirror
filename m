From: Perry Rajnovic <perry.rajnovic@gmail.com>
Subject: git-completion.tcsh
Date: Tue, 31 Mar 2015 14:11:28 +1100
Message-ID: <B1DA2E0C-11BE-4435-A930-1D79F50B5D1F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 05:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycmaa-0005PZ-QZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 05:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbbCaDLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 23:11:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34604 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbCaDLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 23:11:35 -0400
Received: by pactp5 with SMTP id tp5so5662704pac.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=2AM8dkCpU90AJku0g9xYSCBar8DI3XFtpwUqN4B2hMY=;
        b=kYHabaljPJ5DgDZH6Jp7015IrhB5UQHvbWM+GYk3xWcbFrfY9ZUVc0peUAI++bvvqy
         j9/ii+BW15hpF0nfc/AoAcvOefg0BeVlpmejj/2B/T7f2DsogSuUMB6jcGr8yBY0HxYP
         F2c8h2glATLDWbX63Bj2VP0ouwUuSDlGmGrwBTG9mOf2iM/mSGdMS/kmlBddpHDZciSA
         XmjoXy/5p0zN3UqHpkCHVe3PAjiB5XJfV368plUKqDfMKc7juzlg3MlBWLs8nJpHQkpO
         Qlk1EsiXDkectXvcw2NYl3wsM7azfoiCff8Z1zYXFN2H+fkZ2Y7eHDPYJXQOGiupNpGS
         PNeg==
X-Received: by 10.70.34.129 with SMTP id z1mr62991558pdi.113.1427771494849;
        Mon, 30 Mar 2015 20:11:34 -0700 (PDT)
Received: from [172.20.10.2] (pa49-180-162-223.pa.nsw.optusnet.com.au. [49.180.162.223])
        by mx.google.com with ESMTPSA id gy3sm12122724pbb.42.2015.03.30.20.11.32
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 20:11:33 -0700 (PDT)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266507>

When using the auto-completion included with git for tcsh, several comm=
ands do directly completion with an additional space appended to the en=
d, which defeats the ability to complete to a deeper sub-directory.

=46or example, if I have a git repository including the following:
basedir/foo/bar/somefile.c

(works as expected, git add)
$ cd basedir
$ git add f<tab>
$ git add foo/
$ git add foo/b<tab>
$ git add foo/bar/
$ git add foo/bar/s<tab>
$ git add foo/bar/somefile.c

(works not as expected, git rm)
$ cd basedir
$ git rm f<tab>
$ git rm foo=20
$ git rm foo<backspace>/b<tab>
$ git rm foo/bar=20
there=E2=80=99s a trailing space after foo and bar in the above lines, =
which means it=E2=80=99s not possible to initiate completion or immedia=
tely start typing, i must back-space before continuing.

I=E2=80=99m fairly certain i=E2=80=99ve seen this for other commands as=
 well, but i=E2=80=99m not sure to what extent this occurs throughout t=
he commands.

Environment info:
OS: Darwin 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:47 PST=
 2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64 (OSX 10.10.2)
Apple Terminal Version 2.5.1 (343.6)
git version 2.3.2 (via MacPorts)
tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options wide,nls=
,dl,al,kan,sm,rh,color,filec

Thanks!

Perry Rajnovic