From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 08/14] mention different variations around $GIT_URL
Date: Wed, 11 Sep 2013 01:07:52 +0800
Message-ID: <1378832878-12811-9-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
 <1378832878-12811-8-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Alex Blewitt <Alex.Blewitt@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQp-0003Wj-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab3IJRIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:37 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38123 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3IJRIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:36 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so7862975pbc.37
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rZCg+w2dw9CmJxb5IQVo4iSF4BOt4syyT2R4QPL66nk=;
        b=VZosxpqtAGO+5JWUZCehedCUL/d6mfkkqSu8uWkGz4RcOTBFu4/t1ClZFZIuJ9CRwW
         xNWXiE8E9wiGy/RnIozUzQAqp5QZWADOYSyLqTd2Sr7VAL6SClbQwJwRLbZqCE9gQ8Sv
         cDPg8q3nTQePBOsQ6Ar8pGg3/4hFVCcbh4ylfd9REn1zuDNBrc7wuzbJ9Z9nanhJ0oGn
         +lqQXHxBxMqIbpejLOb7OzfQAF8sAeve//5nmQjS3PsgTV9xCCg0ujnf8c+MBCaAUvLj
         epmp0s4afsKekre3gpfc42n5Muhyy48PX+kBo4z0DlozrQOGDB2rzW/5n4ektGaUy8SO
         ok6w==
X-Received: by 10.68.76.101 with SMTP id j5mr26636143pbw.67.1378832915205;
        Tue, 10 Sep 2013 10:08:35 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-8-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234450>

Based on

  From:	Alex Blewitt <Alex.Blewitt@gmail.com>
  Message-ID: <loom.20091009T104530-586@post.gmane.org>

  Shawn O. Pearce <spearce <at> spearce.org> writes:

  > +URL Format
  > +----------
  > +
  > +URLs for Git repositories accessed by HTTP use the standard HTTP
  > +URL syntax documented by RFC 1738, so they are of the form:
  > +
  > +  http://<host>:<port>/<path>
  > +
  > +Within this documentation the placeholder $GIT_URL will stand for
  > +the http:// repository URL entered by the end-user.

  It's worth making clear here that $GIT_URL will be the path to the repository,
  rather than necessarily just the host upon which the server sits. Perhaps
  including an example, like http://example:8080/repos/example.git
  would make it clearer that there can be a path (and so leading to
  a request like http://example:8080/repos/example.git/info/refs?service=...

  It's also worth clarifying, therefore, that multiple repositories can be served
  by the same process (as with the git server today) by using different path(s).
  And for those that are interested in submodules, it's worth confirming that
  http://example/repos/master.git/child.git/info/refs?service= will ensure
  that the repository is the 'child' git rather than anything else.

The submodule example (/master.git/child.git) seems potentially
confusing - it suggests a setup where the server has a route to a git
repo (child.git) with a parent path containing another git repo
(master.git). It is excluded lest we be seen as encouraging such
mind-boggling setups.

While providing an example $GIT_URL containing a '?' (the catch-all
gateway one), also mention a possible contradiction between the
exactly-one-param requirement and the http client implementation in Git.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 2382384..d0955c2 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -22,15 +22,28 @@ URL Format
 URLs for Git repositories accessed by HTTP use the standard HTTP
 URL syntax documented by RFC 1738, so they are of the form:
 
-  http://<host>:<port>/<path>
+  http://<host>:<port>/<path>?<searchpart>
 
 Within this documentation the placeholder $GIT_URL will stand for
 the http:// repository URL entered by the end-user.
 
-Both the "smart" and "dumb" HTTP protocols used by Git operate
+Servers SHOULD handle all requests to locations matching $GIT_URL, as
+both the "smart" and "dumb" HTTP protocols used by Git operate
 by appending additional path components onto the end of the user
 supplied $GIT_URL string.
 
+An example of a dumb client requesting for a loose object:
+
+  $GIT_URL:     http://example.com:8080/git/repo.git
+  URL request:  http://example.com:8080/git/repo.git/objects/d0/49f6c27a2244e12041955e262a404c7faba355
+
+An example of a smart request to a catch-all gateway (notice how the
+'service' parameter is passed with '&', since a '?' was detected in
+$GIT_URL):
+
+  $GIT_URL:     http://example.com/daemon.cgi?svc=git&q=
+  URL request:  http://example.com/daemon.cgi?svc=git&q=/info/refs&service=git-receive-pack
+
 Clients MUST strip a trailing '/', if present, from the user supplied
 $GIT_URL string to prevent empty path tokens ('//') from appearing
 in any URL sent to a server.  Compatible clients MUST expand
@@ -186,6 +199,11 @@ The request MUST contain exactly one query parameter,
 name the client wishes to contact to complete the operation.
 The request MUST NOT contain additional query parameters.
 
+TODO: "exactly" one query parameter may be too strict; see the catch-all
+gateway $GIT_URL for an example where more than one parameter is passed.
+In fact, the http client implementation in Git can handle similar
+$GIT_URLs, and thus may pass more than parameter to the server.
+
    C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
 
    dumb server reply:
-- 
1.8.4.rc4.527.g303b16c
