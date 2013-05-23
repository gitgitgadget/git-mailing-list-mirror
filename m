From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Bug report: git grep seems to use the wrong .gitattributes when
 invoked in a subdirectory
Date: Thu, 23 May 2013 17:49:35 +0200
Message-ID: <519E3A8F.9070600@lsrfire.ath.cx>
References: <CAK=EYX51G57borL_Hy2XzqJVML4wmAgOCBPwFLa+miDDY30O7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Joel Kaasinen <joel.kaasinen@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 17:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXly-0001NL-O2
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416Ab3EWPtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 May 2013 11:49:42 -0400
Received: from india601.server4you.de ([85.25.151.105]:56763 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab3EWPtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:49:42 -0400
Received: from [192.168.2.105] (p4FFDBDD0.dip0.t-ipconnect.de [79.253.189.208])
	by india601.server4you.de (Postfix) with ESMTPSA id 13700FD;
	Thu, 23 May 2013 17:49:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAK=EYX51G57borL_Hy2XzqJVML4wmAgOCBPwFLa+miDDY30O7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225263>

Am 23.05.2013 14:44, schrieb Joel Kaasinen:
> [pseudo:~/tmp]% git --version
> git version 1.7.10.4
> [pseudo:~/tmp]% git init git-test
> Initialized empty Git repository in/home/opqdonut/tmp/git-test/.git/
> [pseudo:~/tmp]% cd git-test
> [pseudo:~/tmp/git-test:master()]% mkdir -p a/data
> [pseudo:~/tmp/git-test:master()]% mkdir data
> [pseudo:~/tmp/git-test:master()]% echo '* binary' > data/.gitattribut=
es
> [pseudo:~/tmp/git-test:master()]% echo foo > a/data/foo
> [pseudo:~/tmp/git-test:master()]% git add -A
> [pseudo:~/tmp/git-test:master()]% git commit -m "foo"
> [master (root-commit) 20fafbb] foo
>   2 files changed, 1 insertion(+)
>   create mode 100644 a/data/foo
>   create mode 100644 data/.gitattributes
> [pseudo:~/tmp/git-test:master()]% git grep foo
> a/data/foo:foo
> [pseudo:~/tmp/git-test:master()]% cd a
> [pseudo:~/tmp/git-test/a:master()]% git grep foo
> Binary file data/foo matches

Just checked, with git 1.8.2.3 the last command shows a matching line.

The issue has probably been fixed by 55c6168 (grep: stop looking at=20
random places for .gitattributes).  The lowest release with that patch=20
is git 1.8.0.1.

Ren=C3=A9
