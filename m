From: Jonathan Rogers <jrogers@socialserve.com>
Subject: Qgit should use "git config" instead of "git repo-config"
Date: Mon, 09 May 2011 17:20:39 -0400
Message-ID: <4DC85AA7.2090502@socialserve.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040808090402080709050904"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 23:21:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJXsw-00022t-Mv
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab1EIVUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 17:20:49 -0400
Received: from mail2.socialserve.com ([66.129.73.133]:58955 "EHLO
	mail.socialserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab1EIVUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:20:48 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 May 2011 17:20:47 EDT
Received: from jrogers.socialserve.com (jrogers.socialserve.com [10.1.1.118])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jrogers)
	by mail.socialserve.com (Postfix) with ESMTP id 89C5C1717B9
	for <git@vger.kernel.org>; Mon,  9 May 2011 17:20:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173253>

This is a multi-part message in MIME format.
--------------040808090402080709050904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a small patch to cause qgit to use "git config" instead of "git 
repo-config" in a couple of places.

-- 
Jonathan Ross Rogers



--------------040808090402080709050904
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="qgit_config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qgit_config.patch"

diff --git a/src/git.cpp b/src/git.cpp
index 50e6dd3..8e9365c 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -427,7 +427,7 @@ void Git::setTextCodec(QTextCodec* tc) {
 	if (name == "Big5-HKSCS")
 		name = "Big5";
 
-	run("git repo-config i18n.commitencoding " + name);
+	run("git config i18n.commitencoding " + name);
 }
 
 QTextCodec* Git::getTextCodec(bool* isGitArchive) {
@@ -437,7 +437,7 @@ QTextCodec* Git::getTextCodec(bool* isGitArchive) {
 		return NULL;
 
 	QString runOutput;
-	if (!run("git repo-config --get i18n.commitencoding", &runOutput))
+	if (!run("git config --get i18n.commitencoding", &runOutput))
 		return NULL;
 
 	if (runOutput.isEmpty()) // git docs says default is utf-8


--------------040808090402080709050904--
