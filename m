From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] gitignore.txt: do not suggest assume-unchanged
Date: Tue,  9 Dec 2014 12:13:00 +0100
Message-ID: <fe381f27dd50afd44d451577e2315ed5580e3034.1418123458.git.git@drmicha.warpmail.net>
References: <5486B342.8090800@drmicha.warpmail.net>
Cc: =?ISO-8859-15?Q?S=E9rgio_Basto?= <sergio@serjux.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 12:13:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyIj8-0002ma-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 12:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbaLILNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 06:13:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46041 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbaLILND (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 06:13:03 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 77A87209A3
	for <git@vger.kernel.org>; Tue,  9 Dec 2014 06:13:02 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 09 Dec 2014 06:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=sl/AdMq0mFHdOl
	CIBbyT+ssKGN0=; b=KcBqizpc8pZ1YXXKKr+D90EmQperVprntGVKe13bALqIRD
	rWt2L4iPmFhoQ1gb5Q3nRyfD5DulgOWUjbBpwg7SBe+RSA61z8ESWP1SPjKrISab
	7j5GmjmFHlnPYEpafFAUeYeA+gkUqjdNWHrse4kr/f4/XTrKnRvHsnLzQbySw=
X-Sasl-enc: /yV8oeuymkEfZWbmymDnwwrFunniO1SQ/OsBmg1RhS2w 1418123582
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0E5F26800BD;
	Tue,  9 Dec 2014 06:13:01 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <5486B342.8090800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261118>

git-update-index --assume-unchanged was never meant to ignore changes
to tracked files (only to spare some stats). So do not suggest it
as a means to achieve that.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/gitignore.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 09e82c3..4fd0442 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -138,9 +138,6 @@ NOTES
 The purpose of gitignore files is to ensure that certain files
 not tracked by Git remain untracked.
 
-To ignore uncommitted changes in a file that is already tracked,
-use 'git update-index {litdd}assume-unchanged'.
-
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
@@ -203,7 +200,6 @@ everything within `foo/bar`):
 SEE ALSO
 --------
 linkgit:git-rm[1],
-linkgit:git-update-index[1],
 linkgit:gitrepository-layout[5],
 linkgit:git-check-ignore[1]
 
-- 
2.2.0.345.g7041aac
