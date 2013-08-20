From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: Re: [GUILT] add FreeBSD support
Date: Tue, 20 Aug 2013 15:44:16 +0800
Message-ID: <20130820074415.GA27247@gmail.com>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
 <20130809144641.GK22686@poseidon.cudanet.local>
 <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
 <20130809152046.GL22686@poseidon.cudanet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Aug 20 09:43:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBgbE-0004yR-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 09:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab3HTHn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 03:43:29 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34541 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3HTHn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 03:43:28 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so81076pbb.28
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B0MAovQtCq6tpIKRTvHIg2S/L8yhg+uub8curPFIZFI=;
        b=qwuw+9wIr4lpw3JADN2RbYbsrIjWGNbjE9FqpX2TrPbBd3Votafmmk/eqjPabaECzY
         qH7ivqHRUX8p9Qs0umNUVGNC3p+ruvNKJ71Ilxf7ZxEw5NaFHVX6J3t0KxBbhUZ2oV2B
         Rxg5kDWw6HnwGP+6CkxatgpdQvVgnFjUwTW+3ZcvbbZVWG521njGdI5zEwxBeAqd2E1O
         VCOYMqwJ2ktAXDwOb0JCcYLmCY5F1BSyo73ALdjFtc+xqzz2bahcYtz8XY2EcZXbjatf
         EiiVti0IM92lQg5AY771vkEt0ciNPduL0B4o06qIpEIRD7URQ42ApiOrDlGgljcJOL5y
         oAcA==
X-Received: by 10.68.219.33 with SMTP id pl1mr205582pbc.147.1376984607971;
        Tue, 20 Aug 2013 00:43:27 -0700 (PDT)
Received: from gmail.com ([182.92.247.2])
        by mx.google.com with ESMTPSA id xs1sm2105020pac.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 00:43:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130809152046.GL22686@poseidon.cudanet.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232587>

Hi Josef,

On Fri, Aug 09, 2013 at 11:20:46AM -0400, Josef 'Jeff' Sipek wrote:
> On Fri, Aug 09, 2013 at 11:04:45PM +0800, gnehzuil.liu wrote:
> > ?? 2013-8-9??????10:46??Josef 'Jeff' Sipek <jeffpc@josefsipek.net> =
=D0=B4????
> >=20
> > > On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
> > >> From: Zheng Liu <gnehzuil.liu@gmail.com>
> > >>=20
> > >> Currently guilt doesn't support FreeBSD platform.  This commit t=
ries to
> > >> add this support.  The file called 'os.FreeBSD' is copied from o=
s.Darwin
> > >> due to these two platforms have almost the same command tools.
> > >=20
> > > Out of curiosity, is it identical?  I eyeballed it, and they do l=
ook
> > > identical.  There's probably a better way to do this whole os-spe=
cific
> > > thing, but this will work well enough for now.
> >=20
> > Yes, it is identical.  Sorry, I am a newbie for guilt, but I am hap=
py to
> > improve this os-specific thing.    Any idea?
>=20
> So, I'm a bit torn between some "build-time" checking that generates
> something like an "os" file based on what it detects and something th=
at
> happens at runtime.  I like that currently there's nothing to do - yo=
u just
> clone the repo and you're set.  At the same time, the more code can b=
e
> avoided executing the faster (in theory) guilt gets.

Sorry for the late reply.  I did a simple experiment that tries to fold
all os.* files into one file and uses a if statement to export function=
s
according to different platforms.  But frankly I don't like this becaus=
e
it is not very clearly.  So IMHO we'd better add a 'os.FreeBSD' file to
support FreeBSD platform.

I attach the patch in this mail.  It is not very mature.  If you think
it is worthwhile improving this patch.  Please review it.  All feedback=
s
are always welcome.

Regards,
                                                - Zheng

---
 Makefile            |   2 +-
 guilt               |   8 ++--
 os                  | 134 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 os.Darwin           |  70 ---------------------------
 os.Linux            |  57 ----------------------
 os.SunOS            |  57 ----------------------
 regression/scaffold |   4 +-
 7 files changed, 141 insertions(+), 191 deletions(-)
 create mode 100644 os
 delete mode 100644 os.Darwin
 delete mode 100644 os.Linux
 delete mode 100644 os.SunOS

diff --git a/Makefile b/Makefile
index b38c1e4..395abc1 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ PREFIX?=3D/usr/local
 DESTDIR?=3D
 INSTALL?=3Dinstall
=20
-OSFILES =3D $(filter-out $(wildcard *~),$(wildcard os.*))
+OSFILES =3D os
 SCRIPTS =3D $(filter-out $(wildcard *~),$(wildcard guilt-*))
=20
 .PHONY: all=20
diff --git a/guilt b/guilt
index e9b2aab..718bed0 100755
--- a/guilt
+++ b/guilt
@@ -906,10 +906,10 @@ pager=3D"more"
=20
 UNAME_S=3D`uname -s`
=20
-if [ -r "$GUILT_PATH/os.$UNAME_S" ]; then
-	. "$GUILT_PATH/os.$UNAME_S"
-elif [ -r "$GUILT_PATH/../lib/guilt/os.$UNAME_S" ]; then
-	. "$GUILT_PATH/../lib/guilt/os.$UNAME_S"
+if [ -r "$GUILT_PATH/os" ]; then
+	. "$GUILT_PATH/os"
+elif [ -r "$GUILT_PATH/../lib/guilt/os" ]; then
+	. "$GUILT_PATH/../lib/guilt/os"
 else
 	die "Unsupported operating system: $UNAME_S"
 fi
diff --git a/os b/os
new file mode 100644
index 0000000..6d1bc01
--- /dev/null
+++ b/os
@@ -0,0 +1,134 @@
+UNAME_S=3D`uname -s`
+
+if [ $UNAME_S =3D=3D 'FreeBSD' ] || [ $UNAME_S =3D=3D 'Darwin' ]; then
+	# usage: touch_date <unix ts> <file>
+	touch_date()
+	{
+		touch -t `date -r $1 +%Y%m%d%H%M.%S` "$2"
+	}
+
+	# usage: last_modified <file>
+	last_modified()
+	{
+		stat -f "%m" "$1"
+	}
+
+	# usage: format_last_modified <file>
+	format_last_modified()
+	{
+		stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S %z" "$1"
+	}
+
+	# usage: head_n [count]
+	head_n()
+	{
+		if [ "$1" -gt 0 ]; then
+			head -n "$1"
+		fi
+	}
+
+	# usage: sha1 [file]
+	sha1()
+	{
+		if [ $# =3D 1 ]
+		then
+			openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).=3D \(.*\),\2  \1,"
+		else
+			openssl dgst -sha1 | sed 's,\(.*=3D \)*\(.*\),\2  -,'
+		fi
+	}
+
+	# usage: cp_a <src> <dst>
+	cp_a()
+	{
+		cp -pR "$1" "$2"
+	}
+
+	# usage: _tac
+	_tac()
+	{
+		sed -e '1!G;h;$!d'
+	}
+
+	_seq()
+	{
+		(
+			if [ $# -eq 1 ]
+			then
+				/usr/bin/jot $1
+			elif [ $# -eq 2 ]
+			then
+				n1=3D$((${2} - ${1} + 1))
+				n2=3D$1
+				/usr/bin/jot $n1 $n2
+			elif [ $# -eq 3 ]
+			then
+				num1=3D$1
+				incr=3D$2
+				num2=3D$3
+				/usr/bin/awk -v n1=3D$num1 -v n2=3D$num2 -v add=3D$incr 'BEGIN{ fo=
r(i=3Dn1; i<=3Dn2; i+=3Dadd) print i;}' | /usr/bin/sed -E '/e/s/^.+e.+$=
/0/'
+			fi
+		)
+		return 0
+	}
+elif [ $UNAME_S =3D=3D 'Linux' ] || [ $UNAME_S =3D=3D 'SunOS' ]; then
+	# usage: touch_date <unix ts> <file>
+	touch_date()
+	{
+		touch -d @$1 "$2"
+	}
+
+	# usage: last_modified <file>
+	last_modified()
+	{
+		stat -c "%Y" "$1"
+	}
+
+	# usage: format_last_modified <file>
+	format_last_modified()
+	{
+		# must strip nano-second part otherwise git gets very
+		# confused, and makes up strange timestamps from the past
+		# (chances are it decides to interpret it as a unix
+		# timestamp).
+		stat -c "%y" "$1" | sed -e '
+	s/^\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\) \([0-9]\{2\}\):\([0-9=
]\{2\}\):\([0-9]\{2\}\)\.[0-9]* \(.*\)$/\1-\2-\3 \4:\5:\6 \7/'
+	}
+
+	# usage: head_n [count]
+	head_n()
+	{
+		head -n "$1"
+	}
+
+	# usage: sha1 [file]
+	sha1()
+	{
+		if [ $# =3D 1 ]
+		then
+			sha1sum "$1"
+		else
+			sha1sum
+		fi
+	}
+
+	# usage: cp_a <src> <dst>
+	cp_a()
+	{
+		cp -a "$1" "$2"
+	}
+
+	# usage: _tac
+	_tac()
+	{
+		tac
+	}
+
+	_seq()
+	{
+		seq "$@"
+		return $?
+	}
+else
+	die "Unsupported operating system: $UNAME_S"
+fi
diff --git a/os.Darwin b/os.Darwin
deleted file mode 100644
index 3f23121..0000000
--- a/os.Darwin
+++ /dev/null
@@ -1,70 +0,0 @@
-# usage: touch_date <unix ts> <file>
-touch_date()
-{
-	touch -t `date -r $1 +%Y%m%d%H%M.%S` "$2"
-}
-
-# usage: last_modified <file>
-last_modified()
-{
-	stat -f "%m" "$1"
-}
-
-# usage: format_last_modified <file>
-format_last_modified()
-{
-	stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S %z" "$1"
-}
-
-# usage: head_n [count]
-head_n()
-{
-	if [ "$1" -gt 0 ]; then
-		head -n "$1"
-	fi
-}
-
-# usage: sha1 [file]
-sha1()
-{
-	if [ $# =3D 1 ]
-	then
-		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).=3D \(.*\),\2  \1,"
-	else
-		openssl dgst -sha1 | sed 's,\(.*=3D \)*\(.*\),\2  -,'
-	fi
-}
-
-# usage: cp_a <src> <dst>
-cp_a()
-{
-	cp -pR "$1" "$2"
-}
-
-# usage: _tac
-_tac()
-{
-	sed -e '1!G;h;$!d'
-}
-
-_seq()
-{
-	(
-		if [ $# -eq 1 ]
-		then
-			/usr/bin/jot $1
-		elif [ $# -eq 2 ]
-		then
-			n1=3D$((${2} - ${1} + 1))
-			n2=3D$1
-			/usr/bin/jot $n1 $n2
-		elif [ $# -eq 3 ]
-		then
-			num1=3D$1
-			incr=3D$2
-			num2=3D$3
-			/usr/bin/awk -v n1=3D$num1 -v n2=3D$num2 -v add=3D$incr 'BEGIN{ for=
(i=3Dn1; i<=3Dn2; i+=3Dadd) print i;}' | /usr/bin/sed -E '/e/s/^.+e.+$/=
0/'
-		fi
-	)
-	return 0
-}
diff --git a/os.Linux b/os.Linux
deleted file mode 100644
index aaebf88..0000000
--- a/os.Linux
+++ /dev/null
@@ -1,57 +0,0 @@
-# usage: touch_date <unix ts> <file>
-touch_date()
-{
-	touch -d @$1 "$2"
-}
-
-# usage: last_modified <file>
-last_modified()
-{
-	stat -c "%Y" "$1"
-}
-
-# usage: format_last_modified <file>
-format_last_modified()
-{
-	# must strip nano-second part otherwise git gets very
-	# confused, and makes up strange timestamps from the past
-	# (chances are it decides to interpret it as a unix
-	# timestamp).
-	stat -c "%y" "$1" | sed -e '
-s/^\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\) \([0-9]\{2\}\):\([0-9]=
\{2\}\):\([0-9]\{2\}\)\.[0-9]* \(.*\)$/\1-\2-\3 \4:\5:\6 \7/'
-}
-
-# usage: head_n [count]
-head_n()
-{
-	head -n "$1"
-}
-
-# usage: sha1 [file]
-sha1()
-{
-	if [ $# =3D 1 ]
-	then
-		sha1sum "$1"
-	else
-		sha1sum
-	fi
-}
-
-# usage: cp_a <src> <dst>
-cp_a()
-{
-	cp -a "$1" "$2"
-}
-
-# usage: _tac
-_tac()
-{
-	tac
-}
-
-_seq()
-{
-	seq "$@"
-	return $?
-}
diff --git a/os.SunOS b/os.SunOS
deleted file mode 100644
index aaebf88..0000000
--- a/os.SunOS
+++ /dev/null
@@ -1,57 +0,0 @@
-# usage: touch_date <unix ts> <file>
-touch_date()
-{
-	touch -d @$1 "$2"
-}
-
-# usage: last_modified <file>
-last_modified()
-{
-	stat -c "%Y" "$1"
-}
-
-# usage: format_last_modified <file>
-format_last_modified()
-{
-	# must strip nano-second part otherwise git gets very
-	# confused, and makes up strange timestamps from the past
-	# (chances are it decides to interpret it as a unix
-	# timestamp).
-	stat -c "%y" "$1" | sed -e '
-s/^\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\) \([0-9]\{2\}\):\([0-9]=
\{2\}\):\([0-9]\{2\}\)\.[0-9]* \(.*\)$/\1-\2-\3 \4:\5:\6 \7/'
-}
-
-# usage: head_n [count]
-head_n()
-{
-	head -n "$1"
-}
-
-# usage: sha1 [file]
-sha1()
-{
-	if [ $# =3D 1 ]
-	then
-		sha1sum "$1"
-	else
-		sha1sum
-	fi
-}
-
-# usage: cp_a <src> <dst>
-cp_a()
-{
-	cp -a "$1" "$2"
-}
-
-# usage: _tac
-_tac()
-{
-	tac
-}
-
-_seq()
-{
-	seq "$@"
-	return $?
-}
diff --git a/regression/scaffold b/regression/scaffold
index 546d8c6..4d4613b 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -25,8 +25,8 @@ function die
=20
 UNAME_S=3D`uname -s`
=20
-if [ -r "$REG_DIR/../os.$UNAME_S" ]; then
-	. "$REG_DIR/../os.$UNAME_S"
+if [ -r "$REG_DIR/../os" ]; then
+	. "$REG_DIR/../os"
 else
 	die "Unsupported operating system: $UNAME_S"
 fi
--=20
1.8.3.4
