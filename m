From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/12] Makefile: make sure test helpers are rebuilt when
 headers change
Date: Tue, 26 Jan 2010 09:45:54 -0600
Message-ID: <20100126154554.GC4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZncN-0001Eg-RP
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0AZPqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498Ab0AZPqF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:46:05 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:57470 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab0AZPqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:46:00 -0500
Received: by ywh6 with SMTP id 6so4133525ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kTx5PN44RkY1ofM7Mv3CjCOJpVZt8OWeaI+wFMHxtlY=;
        b=rvy5WJT0XjAzfGBwTmLigmusu49JsZtdp1d1HwvY6ICR8XkMK/6PY2IINTuiPfcL2/
         DBFt7LS02wQBOUlYQufBTuuDMZGQu7tGAKudCtoDuIiOQUe6X0zt/Oa2gSo99zaVQ5dc
         uD9PSUM6D64Wkd0xRHO9RS0KtPQQSTEYe500s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PC0HGnpKoW8af/RdKLiMlONIcD87NlFBDEO9tCjcC0ptAH4DYfILvS5HZZAd0gcwfJ
         R8MMBbHlc1wxJo0Yfgoo8DcU1geWhADST93GN91dp5SyYusMVE6eTVfYeSl1Pupy5SPo
         Gyoltb0fU4LOlbFuBJ7GfibNp8ie/dGkJRiV8=
Received: by 10.101.190.17 with SMTP id s17mr10068970anp.145.1264520752769;
        Tue, 26 Jan 2010 07:45:52 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2064714yxe.20.2010.01.26.07.45.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:45:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138043>

It is not worth the bother to maintain an up-to-date list of
which headers each test helper uses, so depend on $(LIB_H) to
catch them all.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This applies to maint.  Please let me know if you are interested
in the corresponding patch for master.

 Makefile |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index bad8f80..1670ee8 100644
--- a/Makefile
+++ b/Makefile
@@ -402,6 +402,18 @@ PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
 PROGRAMS += git-http-backend$X
 
+TEST_PROGRAMS += test-chmtime$X
+TEST_PROGRAMS += test-ctype$X
+TEST_PROGRAMS += test-date$X
+TEST_PROGRAMS += test-delta$X
+TEST_PROGRAMS += test-dump-cache-tree$X
+TEST_PROGRAMS += test-genrandom$X
+TEST_PROGRAMS += test-match-trees$X
+TEST_PROGRAMS += test-parse-options$X
+TEST_PROGRAMS += test-path-utils$X
+TEST_PROGRAMS += test-sha1$X
+TEST_PROGRAMS += test-sigchain$X
+
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
 BUILT_INS += $(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
@@ -695,6 +707,8 @@ BUILTIN_OBJS += builtin-verify-pack.o
 BUILTIN_OBJS += builtin-verify-tag.o
 BUILTIN_OBJS += builtin-write-tree.o
 
+TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
@@ -1642,7 +1656,7 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
+$(patsubst git-%$X,%.o,$(PROGRAMS)) $(TEST_OBJS) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
 builtin-bundle.o bundle.o transport.o: bundle.h
 builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
@@ -1732,18 +1746,6 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS += test-chmtime$X
-TEST_PROGRAMS += test-ctype$X
-TEST_PROGRAMS += test-date$X
-TEST_PROGRAMS += test-delta$X
-TEST_PROGRAMS += test-dump-cache-tree$X
-TEST_PROGRAMS += test-genrandom$X
-TEST_PROGRAMS += test-match-trees$X
-TEST_PROGRAMS += test-parse-options$X
-TEST_PROGRAMS += test-path-utils$X
-TEST_PROGRAMS += test-sha1$X
-TEST_PROGRAMS += test-sigchain$X
-
 all:: $(TEST_PROGRAMS)
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -1763,9 +1765,7 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
-test-parse-options.o: parse-options.h
-
-.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+.PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
-- 
1.6.6
