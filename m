From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Issue with 'git diff' and non ascii characters
Date: Fri, 12 Sep 2014 21:34:52 +0200
Message-ID: <54134ADC.6000504@web.de>
References: <5DEE05EE-B302-44D1-9B1D-0B475EF4E96B@solaroli.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Giulio Cesare Solaroli <giulio.cesare@solaroli.it>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 21:35:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWcf-0003QF-5Z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbaILTfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2014 15:35:01 -0400
Received: from mout.web.de ([212.227.15.3]:53542 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaILTfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:35:00 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MC6ZE-1XbMK71d2G-008pVK; Fri, 12 Sep 2014 21:34:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <5DEE05EE-B302-44D1-9B1D-0B475EF4E96B@solaroli.it>
X-Provags-ID: V03:K0:uc2ETZNOHVVmUaDzSlzOHcDAt0YcmENWH8Q4hyR/UlLvBsuNRfn
 J6vxYg8LN/4ZUDwCP0lBWEeYTzKOW1AC8lnz1sJbI2QCIFJSduZDOev9/eDu+/UHZiAM1DI
 BtEKPdKcSZiChZLqwDgGyenyjSn4R1X9ejO4H2FB7JoXOpcujiNXD02NFPe02OJZ2K12lMY
 Zb7QMo+Tl0vnCC5iN/PsA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256946>

On 2014-09-12 08.53, Giulio Cesare Solaroli wrote:
> Hello,
>=20
> I have spotted a problem using 'git diff' when non ascii characters a=
re involved.
> Not sure if the problem is due to the name of the file, or its conten=
t.
>=20
> Cheers,
>=20
> Giulio Cesare
>=20
> Steps to reproduce the problem:
>=20
> $ sw_vers
> ProductName:	Mac OS X
> ProductVersion:	10.9.4
> BuildVersion:	13E28
> $ git --version
> git version 1.8.5.2 (Apple Git-48)
> $ mkdir test
> $ cd test
> $ echo prova > t=E8st.md
> $ git init
> Initialized empty Git repository in /private/tmp/test/.git/
> $ git add *
> $ git commit -m "first commit"
> [master (root-commit) ebbe2a3] first commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 "t\303\250st.md"
> $ echo prov=E0 > t=E8st.md=20
> $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>=20
> 	modified:   "t\303\250st.md"
>=20
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git diff t=E8st.md=20
> $=20
The problem is not the contents of the file, but the file name.

The following should help:

git config core.quotepath false
