From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/14] reword behaviour on missing repository or objects
Date: Wed, 11 Sep 2013 01:07:50 +0800
Message-ID: <1378832878-12811-7-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	"H. Peter Anvin" <hpa@zytor.com>, Mike Hommey <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQo-0003Wj-8B
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab3IJRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:33 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34149 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3IJRIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:31 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so8022869pad.16
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPY7bNw2VyyL1BRelLAbUeE9P/6XKVWRGkn7an9gHsc=;
        b=bZjkaWN94XC9loT/FM7id33HlXy+HH3116IjuAJoHv55MGNelAS5mbI0ki2oB819zR
         ZkDt4VH+w0O7AMtnkgAaZziHL2c3X8wu6jtVU/rzE0enwknr/xJkndT9aEnZXy3CLXfj
         SFtBo3gSxuJytLQKcPTP0oXMTA1g+hZQAV3Z3EH2hFB7uWwRLrT8XFfEJJkJDvaEDxtn
         Wb3Iy+2VWtZApMnYUrsKkIYnqOEqgtCQITsDXjEERRZiHcJrceoufm7E5/iDBwgb+out
         8w6h6CmB2kXfzvcQVqf+RXDhIlUb3Y3uTsXozNlRfaM87U9DWKW9pM0H6HE9CyNGsXPU
         XB3Q==
X-Received: by 10.67.30.70 with SMTP id kc6mr27092546pad.32.1378832911031;
        Tue, 10 Sep 2013 10:08:31 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234451>

From: "Shawn O. Pearce" <spearce@spearce.org>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
--
To Shawn: sign-off-by needed.

Based on:

  From: "Shawn O. Pearce" <spearce@spearce.org>
  Message-ID: <20091016142135.GR10505@spearce.org>

  Mike Hommey <mh@glandium.org> wrote:
  > On Thu, Oct 15, 2009 at 10:59:25PM -0700, H. Peter Anvin wrote:
  > > On 10/10/2009 03:12 AM, Antti-Juhani Kaijanaho wrote:
  > > > On 2009-10-09, Junio C Hamano <gitster@pobox.com> wrote:
  > > >>> +If there is no repository at $GIT_URL, the server MUST respond with
  > > >>> +the '404 Not Found' HTTP status code.
  > > >>
  > > >> We may also want to add
  > > >>
  > > >>     If there is no object at $GIT_URL/some/path, the server MUST respond
  > > >>     with the '404 Not Found' HTTP status code.
  > > >>
  > > >> to help dumb clients.
  > > >
  > > > In both cases - is it really necessary to forbid the use of 410 (Gone)?

  My original text got taken a bit out of context here.  I guess MUST
  was too strong of a word.  I more ment something like:

    If there is no repository at $GIT_URL, the server MUST NOT respond
    with '200 OK' and a valid info/refs response.  A server SHOULD
    respond with '404 Not Found', '410 Gone', or any other suitable
    HTTP status code which does not imply the resource exists as
    requested.

In addition, address behaviour on missing objects, as suggested by
Junio. His text (see quote in above excerpt) was not used, in favour of
a more general treatment (locations matching $GIT_URL, not just
objects).
---
 Documentation/technical/http-protocol.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index a8d28ba..412b898 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -91,8 +91,12 @@ Except where noted, all standard HTTP behavior SHOULD be assumed
 by both client and server.  This includes (but is not necessarily
 limited to):
 
-If there is no repository at $GIT_URL, the server MUST respond with
-the '404 Not Found' HTTP status code.
+If there is no repository at $GIT_URL, the server MUST NOT respond with
+'200 OK' and a valid info/refs response.  Also, if the resource pointed
+to by a location matching $GIT_URL does not exist, the server MUST NOT
+respond with '200 OK'.  A server SHOULD respond with
+'404 Not Found', '410 Gone', or any other suitable HTTP status code
+which does not imply the resource exists as requested.
 
 If there is a repository at $GIT_URL, but access is not currently
 permitted, the server MUST respond with the '403 Forbidden' HTTP
-- 
1.8.4.rc4.527.g303b16c
