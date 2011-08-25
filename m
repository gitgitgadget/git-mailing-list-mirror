From: Boaz Harrosh <bharrosh@panasas.com>
Subject: git diff annoyance / feature request
Date: Thu, 25 Aug 2011 12:14:24 -0700
Message-ID: <4E569F10.8060808@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 25 21:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwfNv-000185-88
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab1HYTOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:14:34 -0400
Received: from natasha.panasas.com ([67.152.220.90]:44926 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab1HYTOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:14:34 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7PJEX3F026678
	for <git@vger.kernel.org>; Thu, 25 Aug 2011 15:14:33 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 25 Aug
 2011 15:14:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180103>


git diff has this very annoying miss-fixture where it will state
as hunk header the closest label instead of the function name.

So I get:
@@ -675,9 +670,23 @@ try_again:
 	}
 
 	if (flag) {
-		foo();
+		bazz();
 	}
 
 
Instead of what I'd like:
@@ -563,12 +563,7 @@ static int write_exec(struct page_collect *pcol)
 	}
 
 	if (flag) {
-		foo();
+		bazz();
 	}
 

I mean. The label "try_again" is not at all unique in my file. As a
reader I would like to see where is that code going to. The function
name is a unique file identifier that tells me exactly where the change
is going. The label is not. (It's not freaking BASIC)

I bet all this was just inherited from diff. Would it be accepted if
I send a patch to fix it? What you guys think a goto label makes any
sense at all?

Thanks
Boaz
