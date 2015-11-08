From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] check-ignore: correct documentation about output
Date: Sun, 8 Nov 2015 21:10:39 +0100
Message-ID: <20151108201036.GA28434@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 21:10:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvWIe-00034V-CB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 21:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbbKHUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 15:10:47 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35697 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbbKHUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 15:10:43 -0500
Received: by wiby19 with SMTP id y19so4507101wib.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2015 12:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Kowdjdlw776vawmL1vxWVXbSOFu6ziffUGUkfAxAqhc=;
        b=Gv/klIJT9OTjMJ6gtyh48YoZJPHXLU31O/Zw608O4MhLzW9jjaGKZzgGPptIwVJEcI
         X61YGi5Je1coghxuRFATEpe552EOYFyVrxayUAiNqin5EpY3oMxx5ia5h4n3AxpNAKmM
         xzTfnYI/v1hTbHzDthSTElCV7Xu6opLwv2dmOjAKHKq7z0U7vHdHspt9gW4oopCjVu4M
         CbpVHiCOQeiP/iyW8i+GyjDIByUh+zbe4qXrDTy/zlOuUqBX+1ob1usPtobggiKun9mK
         B4H9/z9xWwNJyU4ck9VpIZc6F1qI/Qv1dBvZfa3gg5CV3I+FtB0mRDrq4TloDRbAVsli
         21mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=Kowdjdlw776vawmL1vxWVXbSOFu6ziffUGUkfAxAqhc=;
        b=jd19bTATBE3eC9qB7TAm2dfDS9f6H5svkeabLblV62izZfygCsf0r3jRMYwvIKSmRa
         VrtGZrzOxKkvT7HYJIjW3Csn5KDoiL/qoalOvrt9CUdIQ/muCStDSlSB+lQyemJ8+QL1
         LcO8sktDo+rEZOVgg10aT4dkWM1/7B6hLaeFOG4x6fqJxMMmhmT8YnuijumSla27yU3H
         F+vo4/B/XAuZsYZ1o5GDAmhbgDmW8Q4YUPAWkyzUT/GT7pFSfxSAJG464Smin8rPpga3
         mqsBil98ULMNLq2h3b/8RUbFCT/BF0ixXeW50ji2VycK7Ks3I1gBk7ZtPBsG9dUdscJ0
         s4ag==
X-Gm-Message-State: ALoCoQmuMRRjYTb4kbO0tAkjz9ripkn03pP7Xz5/m5dOLFalmxC65xphoAw9hxGbA6Wu//K4XgC3
X-Received: by 10.194.157.9 with SMTP id wi9mr26091531wjb.154.1447013441768;
        Sun, 08 Nov 2015 12:10:41 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id t126sm10372478wmd.23.2015.11.08.12.10.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2015 12:10:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281042>

By default git check-ignore shows only the filenames that will be
ignored, not the pattern that causes their exclusion.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Documentation/git-check-ignore.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 59531ab..0a628ac 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -16,10 +16,9 @@ DESCRIPTION
 -----------
 
 For each pathname given via the command-line or from a file via
-`--stdin`, show the pattern from .gitignore (or other input files to
-the exclude mechanism) that decides if the pathname is excluded or
-included.  Later patterns within a file take precedence over earlier
-ones.
+`--stdin`, check whether the file is excluded by .gitignore (or other
+input files to the exclude mechanism) and output the path if it is
+excluded.
 
 By default, tracked files are not shown at all since they are not
 subject to exclude rules; but see `--no-index'.
-- 
2.6.3-495-gf0a7f49


-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
