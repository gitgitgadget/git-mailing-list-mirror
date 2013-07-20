From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/16] Add document for command arguments for supporting smart http
Date: Sat, 20 Jul 2013 16:58:04 +0700
Message-ID: <1374314290-5976-11-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0TwR-0001ZF-Le
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab3GTJ7C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:02 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46853 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab3GTJ7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:00 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so11253511ieb.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YSksLylCQDJKph1dFlbIS+4IW3g6+0w8Qnno4SE1jrg=;
        b=swLBnp2N9Rc1Q8kRxzb32r3A4OwyGu+bU3V+R3wynJkn0XjGfDWphIaNcFr7+PGHRl
         n97kyTNNe9W/zMNTiuk0lwv9OiMo9rC0O91F1WoUKGBZumVzSfNWBcIYjF8nYCGS+Wzh
         Lvlbnfb9Iess3Zcy7gwEemfEFLXnDNtAnpPRe1tgeElQrMbPny2T9s6bBKGH/SJHMUy0
         LJRBcVLN/asu7mwUSnFkFwfLtg5S1QDy6iQ/LrXlWULytN6wRN/sYM3hNqNu1Mw7dOOG
         jE/VWfUvrnoiy5CIdVhVskm3fHi6GhP/kIAWrYdEx+Ylf+GTMkRVS53kBbw5cyx+8BzQ
         yFew==
X-Received: by 10.50.60.33 with SMTP id e1mr14580535igr.27.1374314340174;
        Sat, 20 Jul 2013 02:59:00 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id o14sm44207974igw.2.2013.07.20.02.58.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230888>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch-pack.txt   | 11 +++++++----
 Documentation/git-receive-pack.txt | 16 +++++++++++++++-
 Documentation/git-send-pack.txt    |  9 ++++++++-
 Documentation/git-upload-pack.txt  | 13 ++++++++++++-
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 1e71754..85a9437 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,10 +9,7 @@ git-fetch-pack - Receive missing objects from another =
repository
 SYNOPSIS
 --------
 [verse]
-'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-=
tag]
-	[--upload-pack=3D<git-upload-pack>]
-	[--depth=3D<n>] [--no-progress]
-	[-v] [<host>:]<directory> [<refs>...]
+'git fetch-pack' [options] [<host>:]<directory> [<refs>...]
=20
 DESCRIPTION
 -----------
@@ -90,6 +87,12 @@ be in a separate packet, and the list must end with =
a flush packet.
 --no-progress::
 	Do not show the progress.
=20
+--stateless-rpc::
+	Smart HTTP mode.
+
+--lock-pack::
+	Issue "lock" command to the remote helper via stdout.
+
 -v::
 	Run verbosely.
=20
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-rec=
eive-pack.txt
index b1f7dc6..b56d2eb 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repo=
sitory
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <directory>
+'git-receive-pack' [options] <directory>
=20
 DESCRIPTION
 -----------
@@ -35,6 +35,20 @@ are not fast-forwards.
=20
 OPTIONS
 -------
+--stateless-rpc::
+	git-receive-pack performs only a single read-write cycle with
+	stdin and stdout to fit with the HTTP POST request processing
+	model where a program may read the request, write a response,
+	and must exit.
+
+--advertise-refs::
+	Only the initial ref advertisement is output then exits
+	immediately to fit with the HTTP GET request model, where no
+	request content is received but a response must be produced.
+
+--quiet::
+	Make unpack-objects at the receive-pack end quiet.
+
 <directory>::
 	The repository to sync into.
=20
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-p=
ack.txt
index dc3a568..a88e7e0 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,7 @@ git-send-pack - Push objects over Git protocol to anoth=
er repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=3D<git-r=
eceive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git send-pack' [options] [<host>:]<directory> [<ref>...]
=20
 DESCRIPTION
 -----------
@@ -52,6 +52,13 @@ OPTIONS
 	Send a "thin" pack, which records objects in deltified form based
 	on objects not included in the pack to reduce network traffic.
=20
+--stateless-rpc::
+	Smart HTTP mode.
+
+--helper-status:
+	Issue status commands (e.g. "ok" or "error") to the remote
+	help via stdout.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-uplo=
ad-pack.txt
index 0abc806..98d73cc 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -9,7 +9,7 @@ git-upload-pack - Send objects packed back to git-fetch=
-pack
 SYNOPSIS
 --------
 [verse]
-'git-upload-pack' [--strict] [--timeout=3D<n>] <directory>
+'git-upload-pack' [options] <directory>
=20
 DESCRIPTION
 -----------
@@ -31,6 +31,17 @@ OPTIONS
 --timeout=3D<n>::
 	Interrupt transfer after <n> seconds of inactivity.
=20
+--stateless-rpc::
+	git-upload-pack performs only a single read-write cycle with
+	stdin and stdout to fit with the HTTP POST request processing
+	model where a program may read the request, write a response,
+	and must exit.
+
+--advertise-refs::
+	Only the initial ref advertisement is output then exits
+	immediately to fit with the HTTP GET request model, where no
+	request content is received but a response must be produced.
+
 <directory>::
 	The repository to sync from.
=20
--=20
1.8.2.83.gc99314b
