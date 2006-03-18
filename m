From: "Marco Costalba" <mcostalba@gmail.com>
Subject: How to find a revision's branch name
Date: Sat, 18 Mar 2006 07:02:22 +0100
Message-ID: <e5bfff550603172202ia4b69f2he5562b826e491426@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 07:02:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKUWA-00036D-Of
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 07:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCRGCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 01:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWCRGCY
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 01:02:24 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:22051 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751463AbWCRGCX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 01:02:23 -0500
Received: by wproxy.gmail.com with SMTP id i5so694991wra
        for <git@vger.kernel.org>; Fri, 17 Mar 2006 22:02:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oKXt19jJqdLz/svFm5dVJICzs8R5CQKYr1YQz0j5ZwZritNcgQAT99aydXpICL9vrvE9rl1E4KCGFnq2574aooeW5sXd4bA4sMiEPDNesQTDaQh5+6TNYBRycrlcM84yl+szw+TLL1OiC4rHJ6gQ4I5/XssuYx/TZG5YGoWo9Gc=
Received: by 10.65.23.16 with SMTP id a16mr672797qbj;
        Fri, 17 Mar 2006 22:02:22 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Fri, 17 Mar 2006 22:02:22 -0800 (PST)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17684>

In today git archive, todo branch.

$ git-rev-list -n1 --header b14e2494b8a70737066f4ade4df1b5559e81b44b
b14e2494b8a70737066f4ade4df1b5559e81b44b
tree 1baa1f8405d1fef90fe95f2477133a69adec288b
parent 8158d510c641e2354cf24a10bc3e994c7a1e3125
author Junio C Hamano <junkio@cox.net> 1137562948 -0800
committer Junio C Hamano <junkio@cox.net> 1137562948 -0800

    TODO updates 2006-01-17.

    Signed-off-by: Junio C Hamano <junkio@cox.net>


Is it possible to get branch name from a revision sha?
Something like

$ git branch b14e2494b8a70737066f4ade4df1b5559e81b44b
todo

I need this to correctly annotate files not in HEAD tree. Currently qgit runs
git-rev-list --header --topo-order --parents --remove-empty HEAD -- <path>

to get a file history. But this fails if <path> is not found in HEAD. The right
command to run in our case should be:
git-rev-list --header --topo-order --parents --remove-empty todo -- <path>

So I need to get 'todo' branch name from a given revision sha's.

BTW also git blame fails (gracefully) if revision is not in HEAD:

$ git blame b14e2494b8a70737066f4ade4df1b5559e81b44b
b14e2494b8a70737066f4ade4df1b5559e81b44b not found in HEAD


Thanks
Marco
