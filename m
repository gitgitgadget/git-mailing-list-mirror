From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2 0/3] Update compat/regex
Date: Tue, 17 Aug 2010 03:03:22 -0500
Message-ID: <20100817080322.GA28476@burratino>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
 <1282022233-32692-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 10:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlHAa-0003w8-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 10:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab0HQIFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 04:05:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62759 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab0HQIFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 04:05:04 -0400
Received: by gxk23 with SMTP id 23so2312265gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KqTHnenY9L0J8eOkr+xb+OQp7RYdFDLrXWeHX2a3e34=;
        b=XCulXaR2zmWVm32cMTldcujyonxAqaabOhu0A4ZSGtG6VphjwofF2fBXOz36cdTAWn
         FL1MWYEOph7PBVN0kRWQx/W3dpPl80Ehwiq8vIYb9qm8D7kmhOb8vfvyWinseV+5DSTc
         N/vFFmmE1P8wf43mJF/hdVp24EEVgDwV1M5rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LSVlIxqI9XEouo3GGU3aGu46sy1VtA6K5Cr7tC68aHAdepNKyE1/WhefzdDFCjdd4r
         o1Ms76FmLDA8CRTuDYgVGfQ2WXqf4rLfzBr5tAdmIo/DoSpYTOEUtEzAtWO5O9ugctbG
         WEu56/XYUWYuKE7y+bj/PZ4nWV43lg3w+ONF4=
Received: by 10.100.9.4 with SMTP id 4mr3294631ani.245.1282032303946;
        Tue, 17 Aug 2010 01:05:03 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c6sm11852426anj.11.2010.08.17.01.05.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 01:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282022233-32692-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153732>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   compat/regex: use the regex engine from gawk for compat
>   compat/regex: get the gawk regex engine to compile within git
>   t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND

=46or what it=E2=80=99s worth:

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Here=E2=80=99s a patch to go on top.  I am not sure what platf=
orms
support REG_STARTEND, but we can always update the makefile as reports
come in.

-- 8< --
Subject: autoconf: don't use platform regex if it lacks REG_STARTEND

If the platform regex cannot match null bytes, we might as well
use the glibc version instead.

Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Cc: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b4e65c3..67dbd3b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -58,6 +58,7 @@ NO_INET_NTOP=3D@NO_INET_NTOP@
 NO_INET_PTON=3D@NO_INET_PTON@
 NO_ICONV=3D@NO_ICONV@
 OLD_ICONV=3D@OLD_ICONV@
+NO_REGEX=3D@NO_REGEX@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
 INLINE=3D@INLINE@
 SOCKLEN_T=3D@SOCKLEN_T@
diff --git a/configure.ac b/configure.ac
index 5601e8b..71ac89f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -706,6 +706,27 @@ else
 fi
 AC_SUBST(NO_C99_FORMAT)
 #
+# Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
+AC_CACHE_CHECK([whether the platform regex can handle null bytes],
+ [ac_cv_c_excellent_regex], [
+AC_EGREP_CPP(yippeeyeswehaveit,
+	AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
+#include <regex.h>
+],
+[#ifdef REG_STARTEND
+yippeeyeswehaveit
+#endif
+]),
+	[ac_cv_c_excellent_regex=3Dyes],
+	[ac_cv_c_excellent_regex=3Dyes])
+])
+if test $ac_cv_c_excellent_regex =3D yes; then
+	NO_REGEX=3D
+else
+	NO_REGEX=3DYesPlease
+fi
+AC_SUBST(NO_REGEX)
+#
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeed=
s
 # when attempting to read from an fopen'ed directory.
 AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
--=20
1.7.2.1.544.ga752d.dirty
