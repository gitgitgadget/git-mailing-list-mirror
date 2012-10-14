From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/2] config doc: advertise GIT_CONFIG_NOSYSTEM
Date: Sun, 14 Oct 2012 01:44:37 -0700
Message-ID: <20121014084437.GB7190@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
 <20121014062218.GB13477@sigill.intra.peff.net>
 <20121014084244.GA7190@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNJoe-00031y-QM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 10:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab2JNIoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 04:44:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35701 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2JNIop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 04:44:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4076557pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8t/BWF3o1LbSTE1Ynd/52OaXvdx3ZxXsH/TU8CfY2iI=;
        b=fmn1+OetlYsBCC805590mjZh/LZ+tGafzwS05+ZaAVK5qS7bJSRUmZtkLoRYc0fgRq
         7IPb79taGJneq/byjz/w0Kenupgb5N31SGZ/t1kfHy4E/RFIXdlR/rPAmAulscTttcnc
         0WaOHMdspHo6dVW4RP9FQicZvoE7Y4ALu5eTGp+uomtBDoZ/5ICQsYI8IMgpQ9kropXL
         7GPqeyL0bGR1dFDZmU0sXEVfhU2encGAnTm2U8ivXfXhAoLI8uWA9vnf7HQvQ7TuVQSf
         WgbuN9lJslvfGJFJ/J+E3ohRWh6OMtO5bvT7PEJpLHOXvs2a3qaDIpngD1iP/hsQ/c0P
         aqcg==
Received: by 10.68.233.198 with SMTP id ty6mr27356845pbc.107.1350204284836;
        Sun, 14 Oct 2012 01:44:44 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id s10sm7191144paz.11.2012.10.14.01.44.43
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 01:44:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014084244.GA7190@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207646>

When a syntax error or other problem renders /etc/gitconfig buggy on a
multiuser system where mortals do not have write access to /etc, the
GIT_CONFIG_NOSYSTEM variable is the best tool we have to keep getting
work done until the sysadmin sorts the problem out.

Noticed while experimenting with teaching git to error out when
/etc/gitconfig is unreadable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-config.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index eaea0791..907a1fd5 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,6 +240,14 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
 
+GIT_CONFIG_NOSYSTEM::
+	Whether to skip reading settings from the system-wide
+	$(prefix)/etc/gitconfig file.  This environment variable can
+	be used along with HOME and XDG_CONFIG_HOME to create a
+	predictable environment for a picky script, or you can set it
+	temporarily to avoid using a buggy /etc/gitconfig file while
+	waiting for someone with sufficient permissions to fix it.
+
 See also <<FILES>>.
 
 
-- 
1.8.0.rc2
