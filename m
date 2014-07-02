From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 2/4] hashmap: improve struct hashmap member documentation
Date: Thu, 03 Jul 2014 00:21:21 +0200
Message-ID: <53B485E1.1070701@gmail.com>
References: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Su6-0001ft-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbaGBWVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:21:22 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57592 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbaGBWVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:21:22 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so10426577wib.17
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CzTmStjfsnXqbjlH6amx50Q4stLdmFSqP2AWz75QD0o=;
        b=QNNOrB+rRpzWSCJkdF9p36vCvGo1QSpucKVR2mBEV1z7tGt4neD3F22F8/VymG7Q8T
         SdM4NlQhWBJbQyfIq+wk4LrypCKRVE3SBfI+QFS6LgxXLM6lW5SsueRUc9pQmW4WMhPV
         jCFkJeIu9I4qP2bwIk5NhWkz+T8ybsZyzgP7aE5KshUxaIK5qjnA4rBPGEZERPQmRtVp
         clTkgt+vHMLpgGevM8M/4ckCs3aYYJp0SWiL1lWFAD7gtIi8GoqaXp2qVfuRVmgmmI+L
         +m7vqHdnG4519zPt6FsAZHoao5h9tDB1eKFX1WfphZuNdpGh3iWkeHFvpv5qyezF81+t
         WsbA==
X-Received: by 10.194.133.1 with SMTP id oy1mr544181wjb.87.1404339680848;
        Wed, 02 Jul 2014 15:21:20 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj8sm57804185wjb.5.2014.07.02.15.21.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 15:21:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B48540.5070600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252847>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hashmap.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index 4689968..dc21a7c 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -8,11 +8,19 @@ Data Structures
 
 `struct hashmap`::
 
-	The hash table structure.
+	The hash table structure. Members can be used as follows, but should
+	not be modified directly:
 +
-The `size` member keeps track of the total number of entries. The `cmpfn`
-member is a function used to compare two entries for equality. The `table` and
-`tablesize` members store the hash table and its size, respectively.
+The `size` member keeps track of the total number of entries (0 means the
+hashmap is empty).
++
+`tablesize` is the allocated size of the hash table. A non-0 value indicates
+that the hashmap is initialized. It may also be useful for statistical purposes
+(i.e. `size / tablesize` is the current load factor).
++
+`cmpfn` stores the comparison function specified in `hashmap_init()`. In
+advanced scenarios, it may be useful to change this, e.g. to switch between
+case-sensitive and case-insensitive lookup.
 
 `struct hashmap_entry`::
 
-- 
1.9.4.msysgit.0.dirty
