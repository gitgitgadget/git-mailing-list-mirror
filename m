From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: Problem with architecture git.
Date: Fri, 17 Jul 2015 18:10:00 +0100
Message-ID: <7C98A500-2464-4409-B3EA-8E60325674EA@bytenoise.co.uk>
References: <loom.20150717T170829-906@post.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander <samarinav1992@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:10:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG99I-0004l3-DT
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbbGQRKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 13:10:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:64173 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbGQRKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2015 13:10:05 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0LcOxi-1YZtZF0GYg-00jnVs; Fri, 17 Jul
 2015 19:10:03 +0200
In-Reply-To: <loom.20150717T170829-906@post.gmane.org>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:urGtrKTiyilbhXKhMcUa6rFeE1pmYxGcwSCIkTW15PeCue8PO4J
 XBhIYTP++GCorBvU5RSvPdoUGM1jMMJM2fETG2bqfodFWh9Zc98YvDcM4y9U0Mf6aHHsfbY
 xyVXSzm02jbTyhGH22lAW8lEAOAC7qPaE7n5NfLQARDczJ2UMSv7UPuiWhEpuIXKvON60Nc
 Z/XrW0FOjfScORjU0tp0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W04S5Zr7raY=:t85JZ4wpLpyoTrOYYL9o0H
 g54BxA2Xjdz4pXj9Ftu1X3CZ8bts8ifrnyjXQnKPFTLirdwG3KJ2QP3HDQiR74LjhaIcajctB
 EUmTuxnZvBPsG9Qzw8C3f+5i1FQ/jw21x5nKTb1AbB82t95CRgS5QUp8mdbVHAs1XE1XPJEDr
 wJAJamnTDOHO1927nvX6GG8el0mN9IX+VbMXG9EhafBWWJnQgM2VwrV8SPciDJDItp2UbDZNg
 SupukYNJst+dWQP7n6k819zsm854sdx5Q2U7OO2nChZjSVT2GtM8YCE7qmfcXG/d5OJycHWw+
 sgxh6z5E4yz0wGYNGgOe4HeaK+iNiGkMr3vOOxsb0fPadsErUCxBtZOmi0SZ9XLg3vLpkiurH
 flGKZ5sgUUWtjtTLSmSRb+EgNcZ+Khzog7ed7DAUK54ypMxXEY8Y4LFcKvbSTAZzKWFn1zSXg
 ZicEsWByHTE4G9iPm2tRch3PeQ3JBZn76/xwYRIQbghrYd1oRhGYM/woRoH189AW6pEXM54p/
 w3kM44/k94RX80VUfhP3VUsGK3aueCINyFYlsdicArGo+X3oyAsWycOIq0qUlBL8XpCdtAwPq
 lO+gzufyTWafb2/PA5TL19x3Z5vRC2M/mvUMxLHKYlKHMwbkOdXlammBbyUhgjrzSRGizeuWK
 l5BHlR3pr6NKmGc426wqg4Hrb3F/4MiTVZYbnVMtpGabNrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274088>

On 17 Jul 2015, at 16:12, Alexander <samarinav1992@gmail.com> wrote:

> Hello,
>=20
> I have problem with architecure of my project, help me to resolve pro=
blem=20
> . I want to do in my remote repo two branches with two different work=
ing=20
> folders (master , dev ) to check it . How can I do it ?
>=20
> Thank you.=20

You'll probably want something like this in your remote (presumably bar=
e) repo's post receive hook:

#!/bin/sh

GIT_WORK_TREE=3D/var/www/html/www.foo.com git checkout master -f
GIT_WORK_TREE=3D/var/www/html/www.foo.com git clean -f
GIT_WORK_TREE=3D/var/www/html/dev.foo.com git checkout dev -f
GIT_WORK_TREE=3D/var/www/html/dev.foo.com git clean -f

It's one-way, from Git to the directories only, but should do the trick=
=2E

Hope that helps,
Zo=EB.