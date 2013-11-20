From: Matthew Cengia <mattcen@gmail.com>
Subject: Re: How to put tree into index
Date: Wed, 20 Nov 2013 23:25:38 +1100
Message-ID: <20131120122537.GE26413@debian.cengia.id.au>
References: <20131120154714.39fc5202@snail>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Cc: git@vger.kernel.org
To: Alexander GQ Gerasiov <gq@cs.msu.su>
X-From: git-owner@vger.kernel.org Wed Nov 20 13:25:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6qw-0006GQ-8v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3KTMZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:25:50 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46010 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3KTMZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:25:49 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so6595648pdi.38
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ldFKjZOWkal5A6WThBaZ1ByLkJKfo46heso0fr/7aNw=;
        b=wc5MjhVFsHTXtGCXkSI7TbsojNpGEWK2+0IHnHYn/cYJfc4UbnLRgaPg6oNqSLve0E
         CgBYXCfzbgN4cquHzzuTLd7PaoZxgXqSpnxRK7+wDQBn40GWk3e4jhMjIE85MvYqmL2u
         hFG0zi5m848RR+UcmiVZLhnv2wzszoATpT5Qv6K7CYkXm+s4nwmE5Dlarb77dfi7kS2I
         PVGZOzljZVDYVbv22xYf2vzENpNjNBcn7wIudcTeV9efMdTms9AoBJvYB2WdiNrQyYPt
         KuPvYFhBqWqoFwwGNMVf0nXJxXgqu5coJfW8gf4I6KqMYYemf5+wsWYFZEjXdaSU/Yah
         Iz5Q==
X-Received: by 10.66.147.193 with SMTP id tm1mr504456pab.56.1384950349263;
        Wed, 20 Nov 2013 04:25:49 -0800 (PST)
Received: from localhost (c110-22-201-130.sunsh4.vic.optusnet.com.au. [110.22.201.130])
        by mx.google.com with ESMTPSA id vk17sm42566719pab.5.2013.11.20.04.25.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 04:25:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131120154714.39fc5202@snail>
X-PGP-Fingerprint: DB91 CFEF 322D C608 385F  563C 2F88 1AC6 4A16 1033
X-PGP-Key: http://cengia.id.au:2080/~mattcen/pubkey.asc
X-Homepage: http://cengia.id.au:2080/~mattcen
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238074>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-20 15:47, Alexander GQ Gerasiov wrote:
[...]
> So my question is
> How to put into index tree-object with known sha1 and given name?

I was just reading about something very similar in the Git book:
http://git-scm.com/book/en/Git-Internals-Git-Objects#Tree-Objects
(read the entire Tree Objects section), and then came up with this,
which I think does what you want except it doesn't erase the previous
contents of dir2/subdir1:

mattcen@wasp:repo$ ls -la
total 8
drwxrwxr-x 2 mattcen mattcen 4096 Nov 20 23:12 .
drwx------ 3 mattcen mattcen 4096 Nov 20 23:12 ..

mattcen@wasp:repo$ git init
Initialized empty Git repository in /tmp/with-temp-dir.ZDw19F/repo/.git/

mattcen@wasp:repo(master)$ touch .gitignore

mattcen@wasp:repo(master)$ git add .gitignore

mattcen@wasp:repo(master)$ git commit -m Initial\ commit
[master (root-commit) 43d7ee6] Initial commit
 0 files changed
 create mode 100644 .gitignore

mattcen@wasp:repo(master)$ mkdir -p dir1 dir2/subdir1

mattcen@wasp:repo(master)$ touch dir1/file{1..3} dir2/subdir1/some\ files

mattcen@wasp:repo(master)$ git add -A

mattcen@wasp:repo(master)$ git commit -m Add\ files
[master 2654d91] Add files
 0 files changed
 create mode 100644 dir1/file1
 create mode 100644 dir1/file2
 create mode 100644 dir1/file3
 create mode 100644 dir2/subdir1/some files

mattcen@wasp:repo(master)$ git branch A

mattcen@wasp:repo(master)$ git checkout -b B
Switched to a new branch 'B'

mattcen@wasp:repo(B)$ git cat-file -p A^{tree} | grep dir1
040000 tree 9599fdeb034597d90d72d2f58396dee096885b79    dir1

mattcen@wasp:repo(B)$ git read-tree --prefix=3Ddir2/subdir1 9599fdeb034597d=
90d72d2f58396dee096885b79

mattcen@wasp:repo(B)$ git write-tree
e1d5abac94058d1f321a3aa087f18d796efc8a0e

mattcen@wasp:repo(B)$ git checkout .

mattcen@wasp:repo(B)$ find *
dir1
dir1/file3
dir1/file1
dir1/file2
dir2
dir2/subdir1
dir2/subdir1/some files
dir2/subdir1/file3
dir2/subdir1/file1
dir2/subdir1/file2


Hope this helps.

--=20
Regards,

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQJ8BAEBCgBmBQJSjKpAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwMjI1MjY2QUFCMThBOUQwNEMxOUQ0QjY3
QTdFMzdGMzNCMjI3MkU4AAoJEHp+N/M7InLo5rwP/1T7nY24QfFZj3gzZY9XaFWh
Oo4kZCtazC28tcn1yIxjib0DvnG+URVAgD+sMyL64Qm7RNhlNvxyB5lqcK9304Wn
1u9d6gTKE4lZoUK6x2f6xEZBIenp+bcHZomiVcRqGsM6FTWY+OhjOhV/gGDdVffU
Pdw3UCZF8OLZmch3j3rgi6EHJJXz0EeNmWLcrSsGPt+ikBcoaoRoK87/9SS62U5q
QQQToyiEJ5hhHWooA8FZtw5LjiBM8RX2npoxlbg3WZFurCGzuWsFXZAhiHmM1MOe
lra60RCzHOt6ue+UV73uql+5H7lKEchT0gwaILJ21xzSue7lctOlO8nMmocEcrsi
ZS9UMf8zHEn3yW0kyK1SzBw3WA5glVwhZF32wapR9CNC+JZXU8I+APhNq0CbMtWb
ffBagBzXO3jwhsqtfJ2an4yGkQDvEu904IP8qgUeBKZSSq/Ja52Eo0GioMSmv78B
+Z79AXxRBw+FWL52FnysbdOUp56YBGi5/5655aP2t/yw+gxsCEDawDW+0VD1Cs5z
KWXzDf6sfYstLuTtgGCx8oMIzk74SW8PVspFqXCcMnXxagxAuh1UOdz3gLgSJUUC
Z1Nm/fX5nC6ZGgP7Kc2CNoyMNbxqBwOQ42VjSfhLTEPwWdw/rUoRwYUXJTM9NXFi
O7nar/unvI6+x/fjtm/T
=FROa
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
