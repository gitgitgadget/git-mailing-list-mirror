From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 06:16:05 +0200
Message-ID: <53B23605.40705@web.de>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 06:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1pUw-0001Ig-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 06:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaGAEQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 00:16:46 -0400
Received: from mout.web.de ([212.227.17.12]:63665 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaGAEQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 00:16:45 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MF3jD-1WqVkn4AsV-00GJ8R; Tue, 01 Jul 2014 06:16:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1404173597-24713-1-git-send-email-dturner@twitter.com>
X-Provags-ID: V03:K0:APIsyUEVajILccIop8LfwZe413Lvot9LdzqwAqyP7+AEVs03Xcf
 Z2NoD1sp8/vrzanz+NZRiPHMb/QXq3tSRbYmNwCZmTh6iWIoNN78qVG7f5acMkJEanrNFEx
 LSBT7hAQ5PNyor9zn/YcAGRZkqU9Mq/k/B9so8DJL8p4ttQ+FZ8zqg+hKFGwAIwgVUVNz8o
 t+6EuWCxyZq0fI9gEpWpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252707>


diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 6c33e28..7c60675 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
  	test_shallow_cache_tree
  '
  
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout gives cache-tree' '
+	git tag current
  	git checkout HEAD^ &&
  	test_shallow_cache_tree

The && chainis broken here.
Does the test now pass, because "git tag" is added ?
In this case: does it may make sense the keep the old one as it is
an  add a new test case  like this ?

+test_expect_success 'tag and checkout gives cache-tree' '

[]
