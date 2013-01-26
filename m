From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 1/2] mergetools: Added support for TortoiseGitMerge
Date: Sat, 26 Jan 2013 02:15:57 +0100
Message-ID: <51032E4D.7060705@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com> <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 02:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyuNT-0004py-SX
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 02:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab3AZBPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 20:15:55 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:23319 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629Ab3AZBPx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 20:15:53 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 90138289CFC;
	Sat, 26 Jan 2013 02:15:52 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 7204E272D7E;
	Sat, 26 Jan 2013 02:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=8A8Y61dB7hVTh6osYnM+znHyPpY=; b=M+qrKDF/efd1CP0wXO95NyiF0EDh
	rVN3aWhiQQV+bYqnK/PAbmp9fMOzxbEFuPf2bxS6D+8+6Ah8+z6aHrAOzWvpsHt6
	9kgcWvSWAee5xza24vrMuIK4SxuCSZsOX9ZiXvDKp5zqmvuLLoMaa+rn+fV34KF3
	ep/bNNqiTMsh+vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=vEq4Yj6IwDJQgEfRZliGT/xPOsj22AxlczIBZ3k7RfsjQRY9TcqO5qC
	EL/sj9JMHZ0INOlIbjLQylWP/7VEYVdIaJc/MBo1z7h2TCQgvVxV3tFDwqVBnY4h
	3vqocHcJimXNyKATfe/aDsvN6InQdmj73BOIxN71c1P4g2Y+vIy4=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 3B30E272D5A;
	Sat, 26 Jan 2013 02:15:52 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43384687; Sat, 26 Jan 2013 02:15:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v622l5d87.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_1099 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214607>

The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
(starting with 1.8.0) in order to make clear that this one has special
support for git and prevent confusion with the TortoiseSVN TortoiseMerge
version.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 mergetools/tortoisemerge | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index ed7db49..8476afa 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -11,7 +11,16 @@ merge_cmd () {
 			-theirs:"$REMOTE" -merged:"$MERGED"
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
