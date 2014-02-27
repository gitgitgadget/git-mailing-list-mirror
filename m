From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: [PATCH] gitk: replace SHA1 entry field on keyboard paste
Date: Thu, 27 Feb 2014 01:56:52 -0800
Message-ID: <530F0BE4.1040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 10:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIxiv-0004Gj-JG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbaB0J5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 04:57:11 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59983 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaB0J5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:57:09 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so2289596pab.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Eu0M+ltr/iLAInJKCbfJKtSvYLsKY3CGxo7/RVCpez4=;
        b=KEu+waGhVF8LLuMSjUHlmtTgQMJNzBELZi0E7G4ZNzTnOFWOJjVPdwS5LLKkFSOi7b
         v9NgdcBO2wVb653ciQITCZMASuYHYsY6O0vt0snzM5NIGodvFczj6pa+B7nKTiX5CXAo
         ONTjHTou4he191A6nz2Zhmrc9TVGxaIY6i5UAHA4iqa6+q4zyTOpmUO3kwF9LIqtJI49
         ROlFLotHvizBTy2f2eRyc/eELEUS/xsFtm7fhnhG90WpWLgSg7sTO7hOFijy7vpg68bh
         ffynmReetx7lJ6uHCZL+VoSauheRsVutVnObLi24w9uhgHOXcKcrvr6WfLd/LkZNBy9i
         Xgzg==
X-Received: by 10.68.178.66 with SMTP id cw2mr12227959pbc.89.1393495028542;
        Thu, 27 Feb 2014 01:57:08 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id bz4sm11769624pbb.12.2014.02.27.01.57.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 01:57:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242797>

We already replace old SHA with the clipboard content for the mouse
paste event.  It seems reasonable to do the same when pasting from
keyboard.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
  gitk-git/gitk |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 90764e8..2f58bcf 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2585,6 +2585,7 @@ proc makewindow {} {
      bind $fstring <Key-Return> {dofind 1 1}
      bind $sha1entry <Key-Return> {gotocommit; break}
      bind $sha1entry <<PasteSelection>> clearsha1
+    bind $sha1entry <<Paste>> clearsha1
      bind $cflist <1> {sel_flist %W %x %y; break}
      bind $cflist <B1-Motion> {sel_flist %W %x %y; break}
      bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
--
1.7.9
