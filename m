From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Fri, 13 Oct 2006 21:55:25 +0200
Message-ID: <200610132155.25533.jnareb@gmail.com>
References: <egdge3$t12$1@sea.gmane.org> <7v1wpfwg92.fsf@assigned-by-dhcp.cox.net> <7vy7rlq2aq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 21:55:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYT7s-0003uT-9A
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWJMTzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWJMTzU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 15:55:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:35753 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751832AbWJMTzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 15:55:19 -0400
Received: by ug-out-1314.google.com with SMTP id o38so508948ugd
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 12:55:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d2HKoNeLToIetC/3cVuSCW7S7Mhezxdng8QLScmo+OrFLMsIazsGRX/00Dmq5Nn06zK9dmHlGbpnxIDfVjAI7ODe9p8LkCfQe69538L3Dwc7/z/Kn3kLMg/UfDx61D8X6TdeBPClOqqBG9N6dHr5G7hT7qz8Spov+z8OSaBfJA4=
Received: by 10.67.121.15 with SMTP id y15mr4770806ugm;
        Fri, 13 Oct 2006 12:55:17 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id u1sm3670686uge.2006.10.13.12.55.16;
        Fri, 13 Oct 2006 12:55:17 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7rlq2aq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28857>

Junio C Hamano wrote:
> This is only lightly tested. I haven't done test suite nor
> documentation, which the list should be able to take care of,
> now my git day for this week is over ;-).
> 
> -- >8 --
> [PATCH] diff --numstat

Does for example

	git diff-tree --numstat --patch-with-stat <tree-ish>

or

	git diff-tree --numstat -p <tree-ish>

work as expected, i.e. prepend diffstat in machine friendly (numstat)
format? What happens if one uses both --stat and --numstat?

-- >8 --
Documenting diff --numstat

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Is it enough documentation? Should we provide also numstat format
description in Documentation/diff-format.txt?

 Documentation/diff-options.txt |    5 +++++
 diff.h                         |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7b7b9e8..e112172 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -16,6 +16,11 @@
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
 
+--numstat::
+	Similar to \--stat, but shows number of added and
+	deleted lines in decimal notation and pathname without
+	abbreviation, to make it more machine friendly.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.h b/diff.h
index 435c70c..ce3058e 100644
--- a/diff.h
+++ b/diff.h
@@ -171,6 +171,7 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  --patch-with-raw\n" \
 "                output both a patch and the diff-raw format.\n" \
 "  --stat        show diffstat instead of patch.\n" \
+"  --numstat     show numeric diffstat instead of patch.\n" \
 "  --patch-with-stat\n" \
 "                output a patch and prepend its diffstat.\n" \
 "  --name-only   show only names of changed files.\n" \

-- 
Jakub Narebski
Poland
