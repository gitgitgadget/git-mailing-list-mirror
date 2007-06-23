From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: [PATCH] Escape some tilde characters causing spurious subscripts in documentation
Date: Sat, 23 Jun 2007 15:19:15 -0700
Message-ID: <31e9dd080706231519p25520183vb0f102a4585e17f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 00:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Dwt-0000Ev-04
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 00:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbXFWWTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXFWWTR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 18:19:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:1166 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbXFWWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 18:19:15 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1126267wxc
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 15:19:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VvBgHIWeOIdH/HUb1kcbGrc3DK4gFEJSK30calx15FOWfW5IzekHAqG470DheLl8NLmajW6KdedfgGEQzIfxnFLpV/wEQBa205a8yd7ar+XqhiUkq6AQZ0cGcfRa61UM6DdSJlmKz7FBQtrbkjPL9BwUCmkBF0hdzcvCiNmqgRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DSAMDZRkQWyBPZ5S970UHgpd1jbohjuU/0EHGhM/TeZoKgOvA8iz9SfIYrDkkLjZABqUMlNreHVNFwGgQlfn8tcUHC41NonhXKG2/mPS+q7jfVenJn9s3NfDy92dxwEpPoDLhTSAFKvdSBXfRwFCkOHH3GBTBPOQvOS+jloCJxA=
Received: by 10.90.34.3 with SMTP id h3mr3430682agh.1182637155307;
        Sat, 23 Jun 2007 15:19:15 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sat, 23 Jun 2007 15:19:15 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50754>

A few unescaped tilde characters were causing long parts of the html
documentation to be formatted as footnotes. This patch fixes them; I
think I found all of them, but no promises.

Signed-off-by: Jason Sewall <jasonsewall@gmail.com>
---
This is my first attempt at actually submitting a patch to the git
list; let me know if this is a reasonably presented patch. It is truly
trivial, but getting those docs cleaned up is important!

 Documentation/git-bundle.txt |    8 ++++----
 Documentation/git-daemon.txt |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 5051e2b..d89f350 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -61,7 +61,7 @@ unbundle <file>::
 [git-rev-list-args...]::
        A list of arguments, acceptable to git-rev-parse and
        git-rev-list, that specify the specific objects and references
-       to transport.  For example, "master~10..master" causes the
+       to transport.  For example, "master\~10..master" causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -80,12 +80,12 @@ SPECIFYING REFERENCES

 git-bundle will only package references that are shown by
 git-show-ref: this includes heads, tags, and remote heads.  References
-such as master~1 cannot be packaged, but are perfectly suitable for
+such as master\~1 cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g., ^master~10), or implicitly (e.g.,
-master~10..master, master --since=10.days.ago).
+specified explicitly (e.g., ^master\~10), or implicitly (e.g.,
+master\~10..master, master --since=10.days.ago).

 It is very important that the basis used be held by the destination.
 It is okay to err on the side of conservatism, causing the bundle file
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4b30b18..3f9cec5 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -98,7 +98,7 @@ OPTIONS
 	--verbose, thus by default only error conditions will be logged.

 --user-path, --user-path=path::
-	Allow ~user notation to be used in requests.  When
+	Allow \~user notation to be used in requests.  When
 	specified with no parameter, requests to
 	git://host/~alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
-- 
1.5.2.1.280.g38570
