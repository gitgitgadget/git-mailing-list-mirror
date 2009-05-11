From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: git fails with control characters in trunk directory name
Date: Mon, 11 May 2009 22:08:19 +0200
Message-ID: <200905112208.21017.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 22:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3cEw-0000Ld-SI
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbZEKUgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbZEKUgh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:36:37 -0400
Received: from mx02.qsc.de ([213.148.130.14]:48822 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbZEKUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:36:37 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx02.qsc.de (Postfix) with ESMTP id 7948B16C006A
	for <git@vger.kernel.org>; Mon, 11 May 2009 22:09:14 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118843>

Using the mouse to paste a git url from a website into a terminal session in 
order to clone the repository, I recently managed to include invisible 
control characters into the git trunk directory name. 

Consequently, I faced all sort of strange behaviour like git pull not working 
(error 2), later on a kernel make which supposedly could not finding a rule 
to create the trunk directory and more such inconsistencies. 
I then reinstalled git, rcs and so on and also tried unsuccessfully several  
git versions. The next morning I looked into the .git/config file and 
recognized that the "url" key value within the [remote "origin"] section 
contained some control characters: ^J and \n, as fas as I remember.

While this was almost entirely my fault, git could possibly apply a filter, 
reject such a name or at least issue a warning. 
