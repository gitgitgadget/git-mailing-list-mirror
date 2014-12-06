From: Olivier Croquette <ocroquette@free.fr>
Subject: Fetching a specific commit by commit ID
Date: Sat, 6 Dec 2014 13:39:12 +0100
Message-ID: <0EA82B66-7DDD-40A9-BB9C-94D3B1B43DBB@free.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 13:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxEe2-0003hM-P1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 13:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbaLFMjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 07:39:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57393 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbaLFMjS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 07:39:18 -0500
Received: from [192.168.1.101] ([178.26.97.1]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MabU1-1YHET5119V-00KAZb for
 <git@vger.kernel.org>; Sat, 06 Dec 2014 13:39:14 +0100
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:W5Qgw9eEYZVGbr20B2RWbL8DVvy7mbRhC1ZbWeNEAD315rYIruZ
 Y0GBrtIsQ8Z336Wz28iLwL493omZ605+jc7QpWSX3E5lvajkiEsT+hp/I+0yfMGqZSHneGM
 Ty2jfArxG3OrLR9PfQG7UrA72VucQR2pX6/Yw7YmFrypQt7wtZfTqOAvS1GxziiQoQQvYza
 rLYR1EPaM5ASW2COOGBJQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260949>

Hello everyone,

I am trying to fetch a commit using a commit ID instead of a reference.=
 According to the documentation of git-fetch, this is not supported, bu=
t I found out that this is not entirely true.

If the commit is already available in the repository, I get:

$ git fetch origin 7365b1a9bd45fbf12b09381d5779b607e232a8cd
=46rom repo1
 * branch            7365b1a9bd45fbf12b09381d5779b607e232a8cd -> FETCH_=
HEAD
$ echo $?
0

If the commit is not in the repository (but it is present in the remote=
 of course), I get:
$ git fetch origin fc907b94f69b9bd710ba55b5522258b722fefb3b
$ echo $?
1


That brings up following questions/remarks:
- the documentation of git-fetch is not entirely correct, commit ids ar=
e partially supported, not only refs
- =93git fetch origin fc907=94 should print an error message on STDERR =
specifying what the problem is
- more interestingly: is there any reason why git fetch should not supp=
ort fetching by commit id? There are real world use cases where this ca=
n be very useful, for instance when references on the remote have been =
overwritten or deleted.

Olivier
