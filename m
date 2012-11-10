From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: git-reset man page
Date: Sat, 10 Nov 2012 16:57:18 +0100
Message-ID: <20121110155718.GA29321@shrek.podlesie.net>
References: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, peff@peff.net
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXDXR-0003hh-A5
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 17:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab2KJQDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 11:03:49 -0500
Received: from shrek-modem1.podlesie.net ([83.18.25.171]:55545 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751991Ab2KJQDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 11:03:49 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2012 11:03:48 EST
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id C0592707; Sat, 10 Nov 2012 16:57:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209282>

On Sat, Nov 10, 2012 at 10:55:13AM +0100, Angelo Borsotti wrote:
> Hi
>=20
> the man page of git-reset, synopsys, does not allow for an
> argumentless call, and the description does not tell either what is
> the meaning of it.

This issue was already reported by Bojan Petrovi=E6:
http://thread.gmane.org/gmane.comp.version-control.git/208505

and fixed in commit d505865be5c7d72abb74318940e8c4c52aa0db5f
(doc: git-reset: make "<mode>" optional) in master branch.

"git reset" is equivalent to "git reset --mixed".

> Suggested changes:
>=20
> first line of synopsis:
>=20
>       gitt reset [-q] [<commit>] [ [--] <pathspec> ...]
>=20
> Description: append to the end of the first paragraph:
>=20
>      "If no <pathspecs> are specified, all the index entries are rese=
t."
>=20
> I would suggest to change <paths> with <pathspec> in all the man page
> because paths in the glossary are called pathspecs.
>=20

The <paths> issue seems to be bigger - "<path>", "<paths>" and "<pathsp=
ec>"
are mixed in whole manual:

$ cat Documentation/*.txt | grep -o '<path[^>]*>' | sort | uniq -c |
sort -n -r
    125 <path>
     17 <paths>
     10 <pathspec>
      2 <pathtemplate>
      2 <path-pattern>
      1 <path_to>
      1 <path_from>

In commands it's even worse:
$ cat builtin/*.c | grep -o '<path[^>]*>' | sort | uniq -c | sort -n -r
     14 <path>
     15 <paths>

Note: <path> is not always used for pathspec.

In git-checkout manual in synopsis "<paths>" is used, but in descriptio=
n
"<pathspec>".


Maybe we should just add that <paths> is an shortcut for <pathspec>
and fix places where paths and pathspec are mixed or <path> is used as
<pathspec>.


Thanks,

Krzysiek
