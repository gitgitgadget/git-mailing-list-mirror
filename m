From: "Alexey Borzenkov" <snaury@gmail.com>
Subject: [PATCH] Define linkgit macro in [macros] section
Date: Mon, 8 Dec 2008 21:29:09 +0300
Message-ID: <e2480c70812081029s36eac963t76092c09af990ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 19:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ksJ-0003MF-8x
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 19:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYLHS3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYLHS3N
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 13:29:13 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:33034 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYLHS3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 13:29:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so510253yxm.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=T1AJfTZk6yRp6xkh7WIuvfl6INumKZ1E20AZKFyfTFs=;
        b=mW8chTCEyCAxf6Zb8FtgWpILmgyPB5WzNvH6dlnWga/9wjenNHEdQ9rW4liOeMIE1K
         WFzxTdC96deLdmFeP6YzA9t96GBIuB/KsBAQEGDYIXGPGC/Y5W4uEGR+KvlMLrbJs3JL
         3QR1P7GxfOOBuEKaCHI/Z00cIcrjSpZ8+yd68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mB07Tj/9sSI0gPPn3XGMNrsEd26ZysKYequBIUJfOcSEPCi2eu2qgsAziGitITyw+g
         2ltiSqgFEkfoguwcYqhJ5ZJFyRsSGbCUWFRXoEZsPce45vHi0sTQJbRUVqyaLzm+2qjz
         N/avD6bP8eLO4x01LVDPTjAAOK9OALYUq/Xjo=
Received: by 10.103.106.1 with SMTP id i1mr1342351mum.47.1228760949476;
        Mon, 08 Dec 2008 10:29:09 -0800 (PST)
Received: by 10.103.121.15 with HTTP; Mon, 8 Dec 2008 10:29:09 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102571>

Starting with asciidoc 8.3.0 linkgit macro is no longer recognized by
asciidoc and user guide suggests
(http://www.methods.co.nz/asciidoc/userguide.html#_macro_definitions)
that macros are supposed to be defined in [macros] section. I'm not
sure whether undefined linkgit macro was working by pure chance or it
is a regression in asciidoc 8.3.0, but this patch adds proper
definition for the linkgit macro, allowing it to work on 8.3.0.

Signed-off-by: Alexey Borzenkov <snaury@gmail.com>
---
 Documentation/asciidoc.conf |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 2da867d..1e735df 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -7,6 +7,9 @@
 # Show GIT link as: <command>(<section>); if section is defined, else just show
 # the command.

+[macros]
+(?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
+
 [attributes]
 asterisk=&#42;
 plus=&#43;
-- 
1.6.0.4
