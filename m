From: knittl <knittl89@googlemail.com>
Subject: [PATCH v2] bash: Match lightweight tags in prompt
Date: Wed, 1 Dec 2010 14:17:00 +0100
Message-ID: <AANLkTinvAnGh6PU2bRrx_uGU81zjVHcFmZWwqpKpjO=1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 14:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmYp-0005rp-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab0LANRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 08:17:22 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:45838 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0LANRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 08:17:21 -0500
Received: by pxi15 with SMTP id 15so1063706pxi.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=NPDod4YC6f/mNbIaSft+kdHbVV5L+FHbyZm9xOMPT0s=;
        b=so0ZQRFGQbFSUruTB7vpaf6T1gcFz4zdtrf52AiBT6SAGEgcel9scg/41P0+FDqw51
         dgFrGSb3iB5GYg/Jf2lHteY/hlk0Ts1poBrY53240pdonROeVfVPuqvhvqdvo0ajwX2m
         90eajKJ+9Xw38eZFdtVGUGmj/7D7hjGwNbZ6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=RLskiLO6jNPM9aLFCgutXv2ow4ZzYrBvHNKwow4lUzoDFPFDJy/o6t4GvRUoNrB4HH
         LVTmxFfSAnJFjYCGf2S8V4Xf9F8PFDvTuFt4u7N8WGKVbgbmeJcy+JBpD1lsjI2Ee9qH
         6P17T5mXFW+frflLc+/KOryv/hW6Ix1qf40bQ=
Received: by 10.143.163.19 with SMTP id q19mr8734001wfo.289.1291209440431;
 Wed, 01 Dec 2010 05:17:20 -0800 (PST)
Received: by 10.142.70.14 with HTTP; Wed, 1 Dec 2010 05:17:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162511>

>From 6be63c5bc1a411a13a012a6508a7301bed7faec6 Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Fri, 19 Nov 2010 16:40:02 +0100
Subject: [PATCH] bash: Match lightweight tags in prompt

the bash prompt would display a commit's SHA1 when having checked out a
lightweight tag.  provide `--tags` to `git describe` in the completion
script, so it will display lightweight tag names (as it already does for
annotated tags)

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
version two of my patch, adding the missing s-o-b and extending commit message

the diff is still the same as v1

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index f710469..604fa79 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -261,7 +261,7 @@ __git_ps1 ()
 				(describe)
 					git describe HEAD ;;
 				(* | default)
-					git describe --exact-match HEAD ;;
+					git describe --tags --exact-match HEAD ;;
 				esac 2>/dev/null)" ||

 				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-- 
1.7.3.2.334.gd1031



-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
