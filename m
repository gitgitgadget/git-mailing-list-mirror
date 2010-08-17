From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/5] Change regerror() declaration from K&R style to ANSI C (C89)
Date: Tue, 17 Aug 2010 09:24:40 +0000
Message-ID: <1282037082-12996-4-git-send-email-avarab@gmail.com>
References: <20100817080322.GA28476@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIRN-0001Ud-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab0HQJ0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:26:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60865 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286Ab0HQJ0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:11 -0400
Received: by wyb32 with SMTP id 32so6801622wyb.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hWDtXWrzjuFf2iNW3+zDZKxdc3yjf6KslchNZSdaQ3k=;
        b=PgiEvHzbnsSjqlWRlfSGTRnIeBDBHr2N2nthUDoSgb72WtWQvDZC8neaz0M7n8JeD4
         rCeIO920nnWKiAaevlU0sh5VxAwswguwMVZQ0G0zsjUQLYKrk3cbyGTrxcn4Ck2YTaPG
         YOHzPPhqaDZDztYpRtiuwSNn/sLDV7zJ+CBfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YWnIrXDVBYDmty4KN1AgFwf/VkrNA1mvu9FqFuEm+WWwJ9A5uZ3Dv6Y/xb6zFk596k
         ExDlMztHrLWNeYnbm5GYtkmbEOOIUTWLv0ohVev1xI94jwChWno645xmpeVrHpd2uYxJ
         y8JZB048rr53vhDklaFHv4MjoWC2dOBU20k/w=
Received: by 10.227.140.154 with SMTP id i26mr5487221wbu.199.1282037170346;
        Tue, 17 Aug 2010 02:26:10 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm3916254weq.33.2010.08.17.02.26.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:26:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <20100817080322.GA28476@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153739>

=46rom: Frank Li <lznuaa@gmail.com>

The MSVC headers typedef errcode as int, and thus confused the compiler=
 in
the K&R style definition. ANSI style deconfuses it.

This patch was originally applied as v1.6.5-rc2~23 but needs to be
re-applied since compat/regex was overwritten by =C3=86var Arnfj=C3=B6r=
=C3=B0
Bjarmason with the gawk regex engine.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
Acked-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 compat/regex/regcomp.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 5115d7a..647c22a 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -546,11 +546,8 @@ weak_alias (__regcomp, regcomp)
    from either regcomp or regexec.   We don't use PREG here.  */
=20
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *__restrict preg;
-    char *__restrict errbuf;
-    size_t errbuf_size;
+regerror(int errcode, const regex_t *__restrict preg,
+         char *__restrict errbuf, size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
--=20
1.7.2.1.389.gc3d0b
