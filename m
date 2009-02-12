From: Jeffrey Chupp <jeff@semanticart.com>
Subject: git filter-branch examples on man page are outdated
Date: Thu, 12 Feb 2009 10:33:34 -0600
Message-ID: <AB13D1C5-4464-49B5-8314-FCB1E249BF22@semanticart.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 17:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXeWr-0008Da-3f
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 17:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbZBLQdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 11:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbZBLQdk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 11:33:40 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:46500 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbZBLQdk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 11:33:40 -0500
Received: by an-out-0708.google.com with SMTP id c2so435171anc.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 08:33:38 -0800 (PST)
Received: by 10.100.216.12 with SMTP id o12mr1245676ang.92.1234456418785;
        Thu, 12 Feb 2009 08:33:38 -0800 (PST)
Received: from ?192.168.0.104? (adsl-068-213-191-097.sip.mgm.bellsouth.net [68.213.191.97])
        by mx.google.com with ESMTPS id c29sm213198anc.3.2009.02.12.08.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 08:33:37 -0800 (PST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109628>

http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
mb:repo jeff$ ls db/data/us_cities.data.insert.sql
db/data/us_cities.data.insert.sql
mb:repo jeff$ git filter-branch --index-filter 'git rm -f --cached db/ 
data/us_cities.data.insert.sql' HEAD
Rewrite d54d3041d7d5739b3093f802fc1ef45f3c8e5e16 (1/2713)fatal:  
pathspec 'db/data/us_cities.data.insert.sql' did not match any files
index filter failed: git rm -f --cached db/data/ 
us_cities.data.insert.sql

ekidd speculated that since the file wasn't in the first version of  
the repo, it was borking.  He was right.  Next he told me to try

git filter-branch --index-filter 'git rm -f --cached db/data/ 
us_cities.data.insert.sql || true'

which worked.  He also asked me to point this out on this list:

ekidd:semanticart: Commit 8c1ce0f46b85d40f215084eed7313896300082df  
changed the behavior without updating the example in the man page. If  
you're feeling inspired, you may want to post this to git@vger.

Thanks and apologies for any etiquette breaches, I don't know what I'm  
doing :)

-jeff
