From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/3] Move build helpers to scripts/ subdirectory
Date: Thu, 17 Feb 2011 22:55:26 -0600
Message-ID: <20110218045526.GI15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218045139.GG15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqINU-0003HV-Na
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295Ab1BREzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:55:32 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40421 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab1BREzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:55:31 -0500
Received: by iwn9 with SMTP id 9so3261429iwn.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IJXQ4lIXPQ9b/YRXQp2iEkH3OoWvZMEzcC4K8QxUTxk=;
        b=nGA7mmFHAU9QTiNMNnfPewahr2RTQbpk22hmSfZXxtkUmbLzNbzdBhp/+P8gvoq4uW
         nymMgVlFU6jNM1DA3uqBr/k3oSjX5OUy+asEnluGV76o8v44n1JHWog6oSzYzYCChwQW
         hxWCIPdrpYMyqxoaoBrzlBXrA7uism+Y7rIzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NHSOEavPPkQQxD5WOdet//jXshS+R6LkFk/qzCL8pYz8XIK5rytXGIvxNejHsNNQx5
         AGeMjWp9bTYhDev6A1BkPcQk6q+OeGZt9HciEMzGasLmvRalwWIZCq1THpqCzko/9ycb
         qoIOcNE37x//OjrQ36jsAyNdly3cHhQ2rrvM4=
Received: by 10.42.229.130 with SMTP id ji2mr357832icb.204.1298004930756;
        Thu, 17 Feb 2011 20:55:30 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id z4sm1351267ibg.19.2011.02.17.20.55.28
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:55:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218045139.GG15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167173>

So the toplevel directory can be less cluttered and new build
system hackers can know where to look to get acquainted with it.

While we're renaming things, make the names of these scripts
follow a more consistent scheme (using dashes rather than
underscores to separate words and including a .sh suffix).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I think I'd prefer to omit the .sh suffix for helpers like
generate-cmdlist but this way follows the prevailing style.

 Makefile                                           |   22 ++++++++++----------
 GIT-VERSION-GEN => scripts/GIT-VERSION-GEN         |    0
 check_bindir => scripts/check-bindir.sh            |    0
 check-builtins.sh => scripts/check-builtins.sh     |    0
 fixup-builtins => scripts/fixup-builtins.sh        |    0
 generate-cmdlist.sh => scripts/generate-cmdlist.sh |    0
 unimplemented.sh => scripts/unimplemented.sh       |    0
 wrap-for-bin.sh => scripts/wrap-for-bin.sh         |    0
 8 files changed, 11 insertions(+), 11 deletions(-)
 rename GIT-VERSION-GEN => scripts/GIT-VERSION-GEN (100%)
 rename check_bindir => scripts/check-bindir.sh (100%)
 rename check-builtins.sh => scripts/check-builtins.sh (100%)
 rename fixup-builtins => scripts/fixup-builtins.sh (100%)
 rename generate-cmdlist.sh => scripts/generate-cmdlist.sh (100%)
 rename unimplemented.sh => scripts/unimplemented.sh (100%)
 rename wrap-for-bin.sh => scripts/wrap-for-bin.sh (100%)

diff --git a/Makefile b/Makefile
index 61981e5..1c10e29 100644
--- a/Makefile
+++ b/Makefile
@@ -244,7 +244,7 @@ all::
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) scripts/GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
@@ -1697,10 +1697,10 @@ $(BUILT_INS): git$X
 	ln -s git$X $@ 2>/dev/null || \
 	cp git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: scripts/generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)scripts/generate-cmdlist.sh > $@+ && mv $@+ $@
 
 define cmd_munge_script
 $(RM) $@ $@+ && \
@@ -1785,11 +1785,11 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
+$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : scripts/unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-	    unimplemented.sh >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PERL
@@ -1808,11 +1808,11 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : scripts/unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
-	    unimplemented.sh >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PYTHON
@@ -2111,7 +2111,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
-bin-wrappers/%: wrap-for-bin.sh
+bin-wrappers/%: scripts/wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
@@ -2164,7 +2164,7 @@ check: common-cmds.h
 	fi
 
 remove-dashes:
-	./fixup-builtins $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
+	scripts/fixup-builtins.sh $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
 
 ### Installation rules
 
@@ -2236,7 +2236,7 @@ endif
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
 	done && \
-	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
+	scripts/check-bindir.sh "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
 	$(MAKE) -C gitweb install
@@ -2415,7 +2415,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	scripts/check-builtins.sh
 
 ### Test suite coverage testing
 #
diff --git a/GIT-VERSION-GEN b/scripts/GIT-VERSION-GEN
similarity index 100%
rename from GIT-VERSION-GEN
rename to scripts/GIT-VERSION-GEN
diff --git a/check_bindir b/scripts/check-bindir.sh
similarity index 100%
rename from check_bindir
rename to scripts/check-bindir.sh
diff --git a/check-builtins.sh b/scripts/check-builtins.sh
similarity index 100%
rename from check-builtins.sh
rename to scripts/check-builtins.sh
diff --git a/fixup-builtins b/scripts/fixup-builtins.sh
similarity index 100%
rename from fixup-builtins
rename to scripts/fixup-builtins.sh
diff --git a/generate-cmdlist.sh b/scripts/generate-cmdlist.sh
similarity index 100%
rename from generate-cmdlist.sh
rename to scripts/generate-cmdlist.sh
diff --git a/unimplemented.sh b/scripts/unimplemented.sh
similarity index 100%
rename from unimplemented.sh
rename to scripts/unimplemented.sh
diff --git a/wrap-for-bin.sh b/scripts/wrap-for-bin.sh
similarity index 100%
rename from wrap-for-bin.sh
rename to scripts/wrap-for-bin.sh
-- 
1.7.4.1
