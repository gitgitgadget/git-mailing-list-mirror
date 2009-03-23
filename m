From: Marcel Cary <marcel@earth.care2.com>
Subject: checkout/update boiler plate for --filter-index?
Date: Mon, 23 Mar 2009 14:33:28 -0700
Message-ID: <580660BE-FDAB-4947-B409-1E8D5CBEF8EE@earth.care2.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlrnR-0007la-Ll
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761199AbZCWVdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761182AbZCWVda
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:33:30 -0400
Received: from earth.care2.com ([38.99.18.107]:46220 "EHLO
	exchange01.earth.care2.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759888AbZCWVd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 17:33:29 -0400
Received: from [10.100.1.142] (38.99.217.18) by exchange01.earth.care2.com
 (10.102.0.107) with Microsoft SMTP Server id 8.0.813.0; Mon, 23 Mar 2009
 14:33:28 -0700
X-Mailer: Apple Mail (2.930.3)
X-PureMessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114353>

I'm trying to do a historical find-and-replace on my code:

git grep -F foo > files
git filter-branch --index-filter "
   cat `pwd`/files | xargs git checkout  --
   cat `pwd`/files | xargs sed -i 's/foo/bar/g; '
   cat `pwd`/files | xargs git update-index --
" ancestor..HEAD

When I instead use --tree-filter and skip the checkout/update-index,  
it works how I want (but it takes a while...).  But when I use --index- 
filter, the resulting history shows the "foo" to "bar" change  
happening *after* new code is added, rather than originally adding  
"bar".

How can I checkout just a few files and update them to take advantage  
of the speed of index operations?

Marcel
