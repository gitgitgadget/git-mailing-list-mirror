From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/13] t3070: disable unreliable fnmatch tests
Date: Mon, 15 Oct 2012 13:25:56 +0700
Message-ID: <1350282362-4505-7-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8z-0007qy-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab2JOG1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CxZP2OOAinStTMtu0you7CwDzAnk3NeBrqLohiCO3XQ=;
        b=yV7mbbSUiRkAfEOiOou3JkVnyfx39KCHiB+p1CwkBiXUXdCztj9zPxBLxArwuQzHui
         ziwRrVnYvkF3yhoV9nV6mIdZC9VF5Ec6vWauq9tsTz+/fVz3o8WD7A2QOn7x4ELcTVfz
         40cOu4zl4ccKqjFJb+cwGbI0+rfMctOIspuoPqLX/rRb+jslcJGPhNQMoHQPhFUN4Pb6
         MhZcVrr7pCb7/5ZUb0t5FkwXLqVJUxU15tWJ1Uu3xYvXN4q4GvU0imcDZg1kgFqWB689
         V8A0vUhLYB76X+pQCPeeRROm+NhH11mfd/A/vCzJw/GSz+95txAw3InC5QkbIK+DGowT
         BRfg==
Received: by 10.66.79.65 with SMTP id h1mr6210195pax.71.1350282425094;
        Sun, 14 Oct 2012 23:27:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id vi9sm8575727pbc.41.2012.10.14.23.27.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:55 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207705>

These tests show different results on different fnmatch() versions. We
don't want to test fnmatch here. We want to make sure wildmatch
behavior matches fnmatch and that only makes sense in cases when
fnmatch() behaves consistently.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh | 86 ++++++++++++++++++++++++++------------------=
--------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index dbd3c8b..dd95b00 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -52,11 +52,11 @@ match 1 1 ten 't[a-g]n'
 match 0 0 ten 't[!a-g]n'
 match 1 1 ton 't[!a-g]n'
 match 1 1 ton 't[^a-g]n'
-match 1 1 'a]b' 'a[]]b'
-match 1 1 a-b 'a[]-]b'
-match 1 1 'a]b' 'a[]-]b'
-match 0 0 aab 'a[]-]b'
-match 1 1 aab 'a[]a-]b'
+match 1 x 'a]b' 'a[]]b'
+match 1 x a-b 'a[]-]b'
+match 1 x 'a]b' 'a[]-]b'
+match 0 x aab 'a[]-]b'
+match 1 x aab 'a[]a-]b'
 match 1 1 ']' ']'
=20
 # Extended slash-matching features
@@ -67,7 +67,7 @@ match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 0 0 'foo' '**/foo'
-match 1 1 '/foo' '**/foo'
+match 1 x '/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
 match 0 0 'foo/bar/baz' '**/bar*'
@@ -85,77 +85,77 @@ match 1 0 'deep/foo/bar/baz/x' '**/bar/*/*'
 match 0 0 'acrt' 'a[c-c]st'
 match 1 1 'acrt' 'a[c-c]rt'
 match 0 0 ']' '[!]-]'
-match 1 1 'a' '[!]-]'
+match 1 x 'a' '[!]-]'
 match 0 0 '' '\'
-match 0 0 '\' '\'
-match 0 0 '/\' '*/\'
-match 1 1 '/\' '*/\\'
+match 0 x '\' '\'
+match 0 x '/\' '*/\'
+match 1 x '/\' '*/\\'
 match 1 1 'foo' 'foo'
 match 1 1 '@foo' '@foo'
 match 0 0 'foo' '@foo'
 match 1 1 '[ab]' '\[ab]'
 match 1 1 '[ab]' '[[]ab]'
-match 1 1 '[ab]' '[[:]ab]'
-match 0 0 '[ab]' '[[::]ab]'
-match 1 1 '[ab]' '[[:digit]ab]'
-match 1 1 '[ab]' '[\[:]ab]'
+match 1 x '[ab]' '[[:]ab]'
+match 0 x '[ab]' '[[::]ab]'
+match 1 x '[ab]' '[[:digit]ab]'
+match 1 x '[ab]' '[\[:]ab]'
 match 1 1 '?a?b' '\??\?b'
 match 1 1 'abc' '\a\b\c'
 match 0 0 'foo' ''
 match 1 0 'foo/bar/baz/to' '**/t[o]'
=20
 # Character class tests
-match 1 1 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
-match 0 0 'a' '[[:digit:][:upper:][:space:]]'
-match 1 1 'A' '[[:digit:][:upper:][:space:]]'
-match 1 0 '1' '[[:digit:][:upper:][:space:]]'
-match 0 0 '1' '[[:digit:][:upper:][:spaci:]]'
-match 1 1 ' ' '[[:digit:][:upper:][:space:]]'
-match 0 0 '.' '[[:digit:][:upper:][:space:]]'
-match 1 1 '.' '[[:digit:][:punct:][:space:]]'
+match 1 x 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
+match 0 x 'a' '[[:digit:][:upper:][:space:]]'
+match 1 x 'A' '[[:digit:][:upper:][:space:]]'
+match 1 x '1' '[[:digit:][:upper:][:space:]]'
+match 0 x '1' '[[:digit:][:upper:][:spaci:]]'
+match 1 x ' ' '[[:digit:][:upper:][:space:]]'
+match 0 x '.' '[[:digit:][:upper:][:space:]]'
+match 1 x '.' '[[:digit:][:punct:][:space:]]'
 match 1 1 '5' '[[:xdigit:]]'
 match 1 1 'f' '[[:xdigit:]]'
 match 1 1 'D' '[[:xdigit:]]'
-match 1 0 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
-match 1 0 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
-match 1 1 '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:=
][:space:][:upper:][:xdigit:]]'
-match 1 1 '5' '[a-c[:digit:]x-z]'
-match 1 1 'b' '[a-c[:digit:]x-z]'
-match 1 1 'y' '[a-c[:digit:]x-z]'
-match 0 0 'q' '[a-c[:digit:]x-z]'
+match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+match 1 x '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:=
][:space:][:upper:][:xdigit:]]'
+match 1 x '5' '[a-c[:digit:]x-z]'
+match 1 x 'b' '[a-c[:digit:]x-z]'
+match 1 x 'y' '[a-c[:digit:]x-z]'
+match 0 x 'q' '[a-c[:digit:]x-z]'
=20
 # Additional tests, including some malformed wildmats
-match 1 1 ']' '[\\-^]'
+match 1 x ']' '[\\-^]'
 match 0 0 '[' '[\\-^]'
-match 1 1 '-' '[\-_]'
-match 1 1 ']' '[\]]'
+match 1 x '-' '[\-_]'
+match 1 x ']' '[\]]'
 match 0 0 '\]' '[\]]'
 match 0 0 '\' '[\]]'
 match 0 0 'ab' 'a[]b'
-match 0 1 'a[]b' 'a[]b'
-match 0 1 'ab[' 'ab['
+match 0 x 'a[]b' 'a[]b'
+match 0 x 'ab[' 'ab['
 match 0 0 'ab' '[!'
 match 0 0 'ab' '[-'
 match 1 1 '-' '[-]'
 match 0 0 '-' '[a-'
 match 0 0 '-' '[!a-'
-match 1 1 '-' '[--A]'
-match 1 1 '5' '[--A]'
+match 1 x '-' '[--A]'
+match 1 x '5' '[--A]'
 match 1 1 ' ' '[ --]'
 match 1 1 '$' '[ --]'
 match 1 1 '-' '[ --]'
 match 0 0 '0' '[ --]'
-match 1 1 '-' '[---]'
-match 1 1 '-' '[------]'
+match 1 x '-' '[---]'
+match 1 x '-' '[------]'
 match 0 0 'j' '[a-e-n]'
-match 1 1 '-' '[a-e-n]'
-match 1 1 'a' '[!------]'
+match 1 x '-' '[a-e-n]'
+match 1 x 'a' '[!------]'
 match 0 0 '[' '[]-a]'
-match 1 1 '^' '[]-a]'
+match 1 x '^' '[]-a]'
 match 0 0 '^' '[!]-a]'
-match 1 1 '[' '[!]-a]'
+match 1 x '[' '[!]-a]'
 match 1 1 '^' '[a^bc]'
-match 1 1 '-b]' '[a-]b]'
+match 1 x '-b]' '[a-]b]'
 match 0 0 '\' '[\]'
 match 1 1 '\' '[\\]'
 match 0 0 '\' '[!\\]'
--=20
1.8.0.rc0.29.g1fdd78f
