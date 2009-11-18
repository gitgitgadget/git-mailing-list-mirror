From: Jonathan Nieder <jrnieder@gmail.com>
Subject: th/remote-usage
Date: Wed, 18 Nov 2009 05:48:08 -0600
Message-ID: <20091118114808.GA13346@progeny.tock>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAiqx-0008Gy-OV
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 12:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZKRLhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 06:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbZKRLhR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 06:37:17 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54358 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZKRLhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 06:37:14 -0500
Received: by ywh40 with SMTP id 40so206755ywh.33
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 03:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PAcRb/3lUHq2rR9VtNq/B71v0jlwGFH0u4aTps7S6gE=;
        b=lq1pzIFtwwECP4rzUgI1NUnmr2DtdkFvhnW+Ha7W4Gn3uXZqzcnfXf6zwLGosQslgZ
         x2RHmUZ2zkm7CfQghKw7GNYm1WEffy3jZmYS0JqHvdR6W8oPie9kXAOjZcgmXoJree8k
         /0/Pa4xbfhDJPVbQZOsYkQ9ZVc0tOCljNc1Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uOhSPSr8BsUo5RtklpXz4JoU3PygiG9TUdWAdbaLwrhC9TxffwBU5j+/GbLIHtrEkx
         5W1iVi99ybhbrrlUUFo1Ii4+p1pzWsc2DbZc5ym52TgDznpd7eVJafrZckvE2DdS0DjD
         z5x1cwJGW2bigJGHwvKD18sZiUQ1E1Q7U5/E8=
Received: by 10.90.217.13 with SMTP id p13mr1919389agg.108.1258544236528;
        Wed, 18 Nov 2009 03:37:16 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm446345yxe.37.2009.11.18.03.37.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 03:37:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133160>

Junio C Hamano wrote:
> [New Topics]
> 
> * th/remote-usage (2009-11-16) 1 commit.
>  - git remote: Separate usage strings for subcommands

Glancing at pu^2, I had two small nitpicks: [<options>...] is five
characters longer than strictly necessary, and the argument to git
remote set-head is not actually optional.

In other words, would it make sense to squash in something like the
following?

-- %< --
Subject: Tweak 'git remote' usage strings

The set-head argument is not optional.  <options>... is five
characters wider than it needs to be.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-remote.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ee86810..cfd8a36 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,14 +7,14 @@
 #include "run-command.h"
 #include "refs.h"
 
-#define REMOTE_BARE_USAGE "git remote [<options>...]"
-#define REMOTE_ADD_USAGE "git remote add [<options>...] <name> <url>"
+#define REMOTE_BARE_USAGE "git remote [options]"
+#define REMOTE_ADD_USAGE "git remote add [options] <name> <url>"
 #define REMOTE_RENAME_USAGE "git remote rename <old> <new>"
 #define REMOTE_RM_USAGE "git remote rm <name>"
-#define REMOTE_SETHEAD_USAGE "git remote set-head <name> [<options>...]"
-#define REMOTE_SHOW_USAGE "git remote show [<options>...] <name>"
-#define REMOTE_PRUNE_USAGE "git remote prune [<options>...] <name>"
-#define REMOTE_UPDATE_USAGE "git remote update [<options>...]"
+#define REMOTE_SETHEAD_USAGE "git remote set-head <name> (-a|-d|<branch>)"
+#define REMOTE_SHOW_USAGE "git remote show [options] <name>"
+#define REMOTE_PRUNE_USAGE "git remote prune [options] <name>"
+#define REMOTE_UPDATE_USAGE "git remote update [options]"
 
 static const char * const builtin_remote_usage[] = {
 	REMOTE_BARE_USAGE,
-- 
1.6.5.2
