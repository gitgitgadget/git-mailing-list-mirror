From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH] Makefile: use SHELL_PATH when running generate-cmdlist.sh
Date: Thu, 10 Sep 2015 19:37:07 -0400
Message-ID: <1441928227-830-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 01:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaBUQ-0005bd-EB
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 01:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbbIJXmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 19:42:25 -0400
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:47150 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042AbbIJXmY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 19:42:24 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2015 19:42:24 EDT
X-AuditID: 12074425-f799a6d000007db3-43-55f21433b1b7
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 23.80.32179.33412F55; Thu, 10 Sep 2015 19:37:23 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id t8ANbMA6013837;
	Thu, 10 Sep 2015 19:37:22 -0400
Received: from darkmatter.mit.edu (darkmatter.mit.edu [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id t8ANbLl2005691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Sep 2015 19:37:22 -0400
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
	id 23B2B12C5ED; Thu, 10 Sep 2015 19:37:21 -0400 (EDT)
X-Mailer: git-send-email 2.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixCmqrWss8inUYNlyCYsrizYwWXRd6WZy
	YPLYOesuu8fnTXIBTFFcNimpOZllqUX6dglcGbOb17MW/GSr2LLSqIHxI2sXIyeHhICJxJFZ
	+6FsMYkL99azdTFycQgJLGaSeNG7mwXC2cgo8bP5AhOEc4lJYuGZ5YwgLUICJRJfpn0BauHg
	YBNwkjh4SQkkLCIgLvH2+Ex2EJtZwEFi4v35YLawgJfE9DfXwVpZBFQlXj9tZwJp5RWwlVjw
	2Q3iCDmJOX0LmEBsXgFBiZMzn7CAlDALqEusnycEMVFeonnrbOYJjAKzkFTNQqiahaRqASPz
	KkbZlNwq3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjKDwZHdR3cE44ZDSIUYBDkYlHt6E
	ix9ChVgTy4orcw8xSnIwKYnyxgt8ChXiS8pPqcxILM6ILyrNSS0+xCjBwawkwpvACJTjTUms
	rEotyodJSXOwKInzbvrBFyIkkJ5YkpqdmlqQWgSTleHgUJLgvS4E1ChYlJqeWpGWmVOCkGbi
	4AQZzgM0fB1IDW9xQWJucWY6RP4Uoy7Hgh+31zIJseTl56VKifNOACkSACnKKM2DmwNLK68Y
	xYHeEuZ9D1LFA0xJcJNeAS1hAlpyVuw9yJKSRISUVAOj/rulK7hUZ13n2zO9zeq0pcrk+V/2
	b5mgb9bhfaRBoexldct1LR3WunlsT7gfrZpWHDSF46XR3lN7fvor53VoythL3DvRUufwd23O
	A67LM46dWP+q6lD5CrvS+Il7FpflSke6GFdc6lrvEyhfEjipefH8sjJbFWUGU2cm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277648>

Some /bin/sh implementations can't deal with $() arithmetic and command
substitution. If we already have a better shell on hand, we should use =
it.

=46ixes the build on SunOS, probably others.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ce0cfe2..6301cc8 100644
--- a/Makefile
+++ b/Makefile
@@ -1699,7 +1699,7 @@ $(BUILT_INS): git$X
 common-cmds.h: generate-cmdlist.sh command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+=
 && mv $@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
--=20
2.5.2
