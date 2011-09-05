From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable
 expansion
Date: Mon, 05 Sep 2011 09:54:25 +0200
Message-ID: <4E648031.6050607@viscovery.net>
References: <8762l73758.fsf@elisp.net> <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0U0q-0006Sb-Dz
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab1IEHyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:54:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62231 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab1IEHya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:54:30 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0U0i-0003Zn-35; Mon, 05 Sep 2011 09:54:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8E3541660F;
	Mon,  5 Sep 2011 09:54:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180724>

Am 9/5/2011 9:09, schrieb Junio C Hamano:
> By the way, t9010 uses ${#parameter} (strlen) which is bashism we forbid,
> and it needs to be rewritten (David CC'ed).

Actually, no. It is perfectly valid POSIX. So we would need this patch.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] CodingGuidelines: ${#parameter} is POSIX and should be allowed

See http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/CodingGuidelines |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index fe1c1e5..df0b620 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -52,8 +52,6 @@ For shell scripts specifically (not exhaustive):
 
    - No shell arrays.
 
-   - No strlen ${#parameter}.
-
    - No pattern replacement ${parameter/pattern/string}.
 
  - We use Arithmetic Expansion $(( ... )).
-- 
1.7.7.rc0.211.g5ac7e
