From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: merge: use MERGE_HEAD to refer to the
 remote branch
Date: Sat, 23 Jan 2010 16:48:40 -0600
Message-ID: <20100123224840.GA2136@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <57bddb115331a23816af772172531fb56fceace4.1263081032.git.trast@student.ethz.ch>
 <20100110041357.GF1083@progeny.tock>
 <201001101324.47025.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYomh-0002AC-Ry
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab0AWWss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776Ab0AWWss
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:48:48 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:52326 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AWWsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:48:47 -0500
Received: by iwn16 with SMTP id 16so1118111iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=J20K2fBm/N2dRTYmIL09ROF1T00lecyGEV0Tw3hiMPg=;
        b=vQA3IcXcmvG5jWNvx4X6dtVWOdAfgQC9ysGpcliz10PGbNCbhYS7wpqwzLsH4ArhOJ
         4MyqIald3t5wqVscLXFRswNBtnYYWStn7M9g6sOZH81U1EUXn6OG86D6ecx8/xZrPwak
         zZE5CCXn4UnHZ+jpYu0aNNi02eTFAn+eJyX74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NRqIYv/wM1BhsEhyJp4tWexDC3X7HQnb5kAAzWNSZth+scSCuKVBY0UAEC3w04Lak8
         y6mIUh+C2J5MlJJctZhdXdURAiSQFPn3nHGo6zOG8GOZApgGxuf2pUiBjMSkCKvS0cxD
         v32EYDTi5pe/frUMtEz0cT6Y5qjy86qFCqzNc=
Received: by 10.231.160.205 with SMTP id o13mr5677672ibx.13.1264286925732;
        Sat, 23 Jan 2010 14:48:45 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3099524iwn.10.2010.01.23.14.48.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:48:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001101324.47025.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137874>

commit 57bddb11 (Documentation/git-merge: reword references to
"remote" and "pull", 2010-01-07) fixed the manual to drop the
assumption that the other branch being merged is from a remote
repository.  Unfortunately, in a few places, to do so it
introduced the antecedentless phrase "their versions".  Worse, in
passages like the following, 'they' is playing two roles.

|   highlighting changes from both the HEAD and their versions.
|
| * Look at the diffs on their own. 'git log --merge -p <path>'

Using HEAD and MERGE_HEAD nicely assigns terminology to "our" and
"their" sides.  It also provides the reader with practice using
names that git will recognize on the command line.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thomas Rast wrote:
> Jonathan Nieder wrote:

>> Maybe:
>> 
>> |   * Look at the diffs.  'git diff' will show a three-way diff,
>> |     highlighting changes from both the HEAD and MERGE_HEAD
>> |     versions.
>
> I like this idea, as it nicely assigns terminology to the "their"
> side.  We need to explain MERGE_HEAD (it's not in the manpage yet),
> but that should fit in somewhere.

Here is a try.  This applies on top of the series to clarify 'git
merge' documentation [1] I sent earlier today, which conveniently
enough explains MERGE_HEAD a few sections earlier.

Thanks for the encouragement,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/137818

 Documentation/git-merge.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 7aa3f3f..4b1b2f5 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -215,15 +215,17 @@ You can work through the conflict with a number of tools:
    mergetool which will work you through the merge.
 
  * Look at the diffs.  `git diff` will show a three-way diff,
-   highlighting changes from both the HEAD and their versions.
+   highlighting changes from both the `HEAD` and `MERGE_HEAD`
+   versions.
 
- * Look at the diffs on their own. `git log --merge -p <path>`
-   will show diffs first for the HEAD version and then
-   their version.
+ * Look at the diffs from each branch. `git log --merge -p <path>`
+   will show diffs first for the `HEAD` version and then the
+   `MERGE_HEAD` version.
 
  * Look at the originals.  `git show :1:filename` shows the
-   common ancestor, `git show :2:filename` shows the HEAD
-   version and `git show :3:filename` shows their version.
+   common ancestor, `git show :2:filename` shows the `HEAD`
+   version, and `git show :3:filename` shows the `MERGE_HEAD`
+   version.
 
 
 EXAMPLES
-- 
1.6.6
