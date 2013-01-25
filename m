From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] mergetools: Enhance tortoisemerge to work with
Date: Fri, 25 Jan 2013 10:06:10 +0100
Message-ID: <51024B02.9020400@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, davvid@gmail.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 10:06:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfEx-0000tN-TA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab3AYJGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:06:06 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:54701 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754596Ab3AYJGC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 04:06:02 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 35FAE289CFC;
	Fri, 25 Jan 2013 10:06:00 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 1B5AB295500;
	Fri, 25 Jan 2013 10:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=iuYFJzdsbwULpxjjSshiitCT78k=; b=3LdYj7fQksWvUeIhtyde0gm2fTea
	0YkGXOW8tlAq3c5sZWh0TYg4cltMFuXZjwHqyMTvezGdrpqBKB7KV/iFe9aG2PvZ
	xBOaNcwUv8srZXImNAi5wninU01bTPrBIYfqyq7lVHbuzTaDU0DaQapMHpllqhWz
	1DthJvOJlv4LTwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=G0SwPy/rbPnFe/9xdqqSFn8sTmf2cuWhYiqZXAGZS811e5qo26zpMpI
	UFoAPv1y2TQcQbdYQsET7vekrqD6Ud+d9+apdPjTYRHP7p0PEv3on0iWW0T37Ag9
	5VURzklHng5YZat+WVXu5mcy8nmwoLxnFXm+XCINyjdApxFcu6Ig=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 5E94E272FC9;
	Fri, 25 Jan 2013 10:05:59 +0100 (CET)
Received: from [139.174.101.48] (account sstri@tu-clausthal.de [139.174.101.48] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43343251; Fri, 25 Jan 2013 10:05:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <5101B0A5.1020308@tu-clausthal.de>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1800_1899 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214520>

TortoiseGitMerge and filenames with spaces

- The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
  (starting with 1.8.0) in order to make clear that this one has special
  support for git, (uses spaces as cli parameter key-value separators)
  and prevent confusion with the TortoiseSVN TortoiseMerge version.
- The tortoisemerge mergetool does not work with filenames which have
  a space in it. Fixing this required changes in git and also in
  TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/tortoisemerge | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index ed7db49..9890737 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -6,12 +6,28 @@ merge_cmd () {
 	if $base_present
 	then
 		touch "$BACKUP"
-		"$merge_tool_path" \
-			-base:"$BASE" -mine:"$LOCAL" \
-			-theirs:"$REMOTE" -merged:"$MERGED"
+		if test "$merge_tool_path" == "tortoisegitmerge"
+		then
+			"$merge_tool_path" \
+				-base "$BASE" -mine "$LOCAL" \
+				-theirs "$REMOTE" -merged "$MERGED"
+		else 
+			"$merge_tool_path" \
+				-base:"$BASE" -mine:"$LOCAL" \
+				-theirs:"$REMOTE" -merged:"$MERGED"
+		fi
 		check_unchanged
 	else
-		echo "TortoiseMerge cannot be used without a base" 1>&2
+		echo "$merge_tool_path cannot be used without a base" 1>&2
 		return 1
 	fi
 }
+
+translate_merge_tool_path() {
+	if type tortoisegitmerge >/dev/null 2>/dev/null
+	then
+		echo tortoisegitmerge
+	else
+		echo tortoisemerge
+	fi
+}
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
