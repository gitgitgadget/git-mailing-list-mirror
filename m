From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Empty directories...
Date: Fri, 27 Jul 2007 01:33:24 +0200
Message-ID: <200707270133.25221.robin.rosenberg.lists@dewire.com>
References: <85lkdezi08.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 01:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IECoh-0007sC-E6
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 01:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765977AbXGZXcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 19:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762173AbXGZXcQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 19:32:16 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8430 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757428AbXGZXcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 19:32:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 25ABC80266C;
	Fri, 27 Jul 2007 01:24:56 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26187-02; Fri, 27 Jul 2007 01:24:55 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B8D1080264B;
	Fri, 27 Jul 2007 01:24:55 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <85lkdezi08.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53875>


(
	I don't know which mail is the best to reply to and I probably missed 
	something in the thread, so bear with me if I'm repeating anything.
)

David. Reconsider "tracking" all directories and what that would give, 
compared to explicitly tracking specific ones and the requires magic entries.

Say we have a config setting that tells git never to remove empty trees. Linus 
patches could be a start for representing trees in the index. As an 
optimization the index could prune trees from the index if they contain 
things as long as the index *effectively* remembers all trees.

Using the patches again we could add empty directories to the index and remove 
them. No directory would be removed automatically, except maybe by a merge.

We would probably have only a few empty directories and new unexpected ones
would only pop up when we remove all blobs from one. Git status could tell us
about them so we will not forget them. It could even tell us about "new" empty
directories, which is probably the most important thing you'd want to know. 

Forgetting to untrack an empty directory would not be a big deal.

Whether to retain empty trees or not should be a repository policy, but an all 
or nothing setting.

-- robin
