From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] mergetools: Enable tortoisemerge to handle filenames with
Date: Fri, 01 Feb 2013 20:33:06 +0100
Message-ID: <510C1872.3090304@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org> <51032E96.2040209@tu-clausthal.de> <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com> <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 20:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MMa-0004Tv-NS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757087Ab3BATdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:33:06 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:40377 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755768Ab3BATdE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 14:33:04 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id B3591289D43;
	Fri,  1 Feb 2013 20:33:01 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 98925299AAD;
	Fri,  1 Feb 2013 20:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=WvRjw7MEYH8MM7Tj4zLeEZ7Y2v4=; b=x5XBqxRudwMti+eJRnXgfLUk4bZo
	dfwbtsBWS9oiY7F72WLPrQmO0pO/eX8L65VnzsQIqakqlD2XVbe9D1q0zyWaI1mH
	8xAsFD96AaaimNaePWT2CxHE8lIsH2hUNlXm6hXyUi25vTGC7/CiNLfQN6fPqeM7
	jmqh2Vo67wuDRn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=Ef7tvlwzMC7yprjfIP25W6Fq2E/LGPIsic4bQiJByEPOpLjOsgOHFHj
	pDDyHm+yvp1Ok3sQXsNv1qvPTVLyLe9zK/IXeNO1aHAI2MyQzZkxINJnLZJqBjmY
	Seh/5x/vnBINyXo6Of3etv35zDf9XtWjXv7GWQDibSb6JXwulfvg=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 547492999E9;
	Fri,  1 Feb 2013 20:33:01 +0100 (CET)
Received: from [79.193.90.228] (account sstri@tu-clausthal.de HELO [192.168.0.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43698954; Fri, 01 Feb 2013 20:33:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1500_1599 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215257>

spaces with TortoiseGitMerge

TortoiseGitMerge, unlike TortoiseMerge, can be told to handle paths
with spaces in them by using -option "$FILE" (not -option:"$FILE",
which does not work for such paths) syntax. Both do not have a fully
posix compatible cli parameter parser, however, TortoiseGitMerge was
modified in order to handle filenames with spaces correctly. The
"-key value" form was choosen because this way no escaping for
quotes within quotes is necessary; see
https://github.com/msysgit/msysgit/issues/57

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/tortoisemerge | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index 8476afa..3b89f1c 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -6,9 +6,17 @@ merge_cmd () {
 	if $base_present
 	then
 		touch "$BACKUP"
-		"$merge_tool_path" \
-			-base:"$BASE" -mine:"$LOCAL" \
-			-theirs:"$REMOTE" -merged:"$MERGED"
+		basename="$(basename "$merge_tool_path" .exe)"
+		if test "$basename" = "tortoisegitmerge"
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
 		echo "$merge_tool_path cannot be used without a base" 1>&2
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
