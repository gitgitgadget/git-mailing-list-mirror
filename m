From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 2/2] mergetools: Make tortoisemerge work with
Date: Sat, 26 Jan 2013 02:17:10 +0100
Message-ID: <51032E96.2040209@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 02:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyuOk-0005Mh-Uy
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 02:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab3AZBRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 20:17:14 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:55973 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629Ab3AZBRM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 20:17:12 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id E243E289CFC;
	Sat, 26 Jan 2013 02:17:05 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C429A272D7E;
	Sat, 26 Jan 2013 02:17:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=doSIvW5cOW6W+aKP42GCBLFfWAo=; b=MQq1mHeD2ItOkbMgAKhucdxyY2bp
	+EvrUA3f7Lj13dyebbdjCGq+/mALrvj9PYD4mCcd12QRfSn1tU+VdfQJSHvx5681
	EykT4Iv85uzfB/m47OgAppHDwvlgOIFWpDyTMUh8bMbo7aS89pzqzPrWmW4nvCEL
	9cT00newVUcUAs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=mjtyxQRQw/MJDOxaHiaH9Uz7HYiTpXT9jv5ViFQwUmBuEQk1Eki4gEL
	0o00JGH1wT/GaVe465sIMg+SANidLiu0pX+rMIyV22QAUXH78Ehj9LD3k4OCopuH
	HBIw3Df0z1w+tmEfCoQifh9F7jv/TB2h8XC79luimirlPRTWVnQ0=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 8B487272D5A;
	Sat, 26 Jan 2013 02:17:05 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43384591; Sat, 26 Jan 2013 02:17:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v622l5d87.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1400_1499 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214608>

tortoisegitmerge and filesnames with space

The tortoisemerge mergetool does not work with filenames which have
a space in it. Fixing this required changes in git and also in
TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.

TortoiseGitMerge now separates cli parameter key-values by space instead
of colons as TortoiseSVN TortoiseMerge does and supports filesnames
with spaces in it this way now.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/tortoisemerge | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index 8476afa..2f98829 100644
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
