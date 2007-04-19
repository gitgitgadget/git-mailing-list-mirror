From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-config documentation
Date: Wed, 18 Apr 2007 22:03:37 -0500
Message-ID: <20070419030337.GD19402@bowser.ruder>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 05:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMy4-0005Wo-9t
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 05:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031077AbXDSDFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 23:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031095AbXDSDFt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 23:05:49 -0400
Received: from www.aeruder.net ([65.254.53.245]:3029 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031077AbXDSDFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 23:05:48 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id DDE4840164;
	Wed, 18 Apr 2007 22:05:47 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44981>

Documentation/git-config.txt: Added documentation for --system
Documentation/builtin-config.c: Added --system to the short usage

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-config.txt |   24 ++++++++++++++----------
 builtin-config.c             |    2 +-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index c759efb..280ef20 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,16 +9,16 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--global] [type] name [value [value_regex]]
-'git-config' [--global] [type] --add name value
-'git-config' [--global] [type] --replace-all name [value [value_regex]]
-'git-config' [--global] [type] --get name [value_regex]
-'git-config' [--global] [type] --get-all name [value_regex]
-'git-config' [--global] [type] --unset name [value_regex]
-'git-config' [--global] [type] --unset-all name [value_regex]
-'git-config' [--global] [type] --rename-section old_name new_name
-'git-config' [--global] [type] --remove-section name
-'git-config' [--global] -l | --list
+'git-config' [--system | --global] [type] name [value [value_regex]]
+'git-config' [--system | --global] [type] --add name value
+'git-config' [--system | --global] [type] --replace-all name [value [value_regex]]
+'git-config' [--system | --global] [type] --get name [value_regex]
+'git-config' [--system | --global] [type] --get-all name [value_regex]
+'git-config' [--system | --global] [type] --unset name [value_regex]
+'git-config' [--system | --global] [type] --unset-all name [value_regex]
+'git-config' [--system | --global] [type] --rename-section old_name new_name
+'git-config' [--system | --global] [type] --remove-section name
+'git-config' [--system | --global] -l | --list
 
 DESCRIPTION
 -----------
@@ -76,6 +76,10 @@ OPTIONS
 --global::
 	Use global ~/.gitconfig file rather than the repository .git/config.
 
+--system::
+	Use system-wide $(prefix)/etc/gitconfig rather than the repository
+	.git/config.
+
 --remove-section::
 	Remove the given section from the configuration file.
 
diff --git a/builtin-config.c b/builtin-config.c
index dfa403b..b2515f7 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
-- 
1.5.1.1.116.g8c4c
