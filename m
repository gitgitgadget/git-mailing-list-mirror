From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore gitk-wish buildproduct
Date: Wed, 23 Jan 2013 12:00:35 -0800
Message-ID: <7vehhbhdp8.fsf@alter.siamese.dyndns.org>
References: <1358967340-3642-1-git-send-email-hjemli@gmail.com>
 <7vip6nhdry.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6VS-0006Ej-0h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab3AWUAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:00:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab3AWUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:00:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C25D9C369;
	Wed, 23 Jan 2013 15:00:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X2t9tsBCzUX5EJD0hbjQq9FclMQ=; b=G7AGT4
	WdInxU6XGZhYYKOKaj4b3VxjTKfkzNv9MA5nWvErCAESL6k4edDErTWCeBxbPM1q
	QZr+uCLlk/Qmcwx41jGEka5WB69Mi7AKnjm0BOKP0lRCBgSosUDrEtDdyr/nv3RO
	dShA0xdcNaeg6zVGk5+OPupy9sPZwUIjTlrLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijoV+dvGflkAnkMschgQQjp/t794jMl2
	PGfRY3LUaqtVjokwfVMYUkdG516ipU619Q1R2vuClmkux7tg/Z8QDTvSt74vmZIc
	Q9E0m72LVfnqek+xLwttT+FJLU3yN9LovNEvrxqN4yPf/ioYyLr2N6zPGuYJopux
	AB7MuobAPb8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67E6C368;
	Wed, 23 Jan 2013 15:00:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20C67C367; Wed, 23 Jan 2013
 15:00:37 -0500 (EST)
In-Reply-To: <7vip6nhdry.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Jan 2013 11:58:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E00E366-6597-11E2-8558-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214354>

From: Christian Couder <chriscool@tuxfamily.org>

gitk, when bound into the git.git project tree, used to live at the
root level, but in 62ba514 (Move gitk to its own subdirectory,
2007-11-17) it was moved to a subdirectory.  The code used to track
changes to TCLTK_PATH (which should cause gitk to be rebuilt to
point at the new interpreter) was left in the main Makefile instead
of being moved to the new Makefile that was created for the gitk
project.

Also add .gitignore file to list build artifacts for the gitk
project.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Paul, this is relative to the tip of your tree, 386befb (gitk:
 Display important heads even when there are many, 2013-01-02).
 Could you consider applying it?

 Also I notice that you have many patches I still do not have
 there, and I'd appreciate a "Go ahead and pull from me!".

 Thanks.

 .gitignore |  2 ++
 Makefile   | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..d7ebcaf
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,2 @@
+/GIT-TCLTK-VARS
+/gitk-wish
diff --git a/Makefile b/Makefile
index e1b6045..5acdc90 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,16 @@ DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
+### Detect Tck/Tk interpreter path changes
+TRACK_TCLTK = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
+
+GIT-TCLTK-VARS: FORCE
+	@VARS='$(TRACK_TCLTK)'; \
+		if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
+			echo 1>&2 "    * new Tcl/Tk interpreter location"; \
+			echo "$$VARS" >$@; \
+		fi
+
 ## po-file creation rules
 XGETTEXT   ?= xgettext
 ifdef NO_MSGFMT
@@ -49,9 +59,9 @@ uninstall::
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 
 clean::
-	$(RM) gitk-wish po/*.msg
+	$(RM) gitk-wish po/*.msg GIT-TCLTK-VARS
 
-gitk-wish: gitk
+gitk-wish: gitk GIT-TCLTK-VARS
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
 	chmod +x $@+ && \
@@ -65,3 +75,5 @@ $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
 	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
 
+.PHONY: all install uninstall clean update-po
+.PHONY: FORCE
-- 
1.8.1.336.g866ceff
