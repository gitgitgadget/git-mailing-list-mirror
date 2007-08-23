From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-svnimport: what to do after -i?
Date: Wed, 22 Aug 2007 21:28:36 -0400
Message-ID: <20070823012836.GA18796@falcon.digizenstudio.com>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 03:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO1VI-0005UY-Ul
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 03:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbXHWB2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 21:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbXHWB2k
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 21:28:40 -0400
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:58340
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754497AbXHWB2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 21:28:39 -0400
Received: (qmail 16978 invoked from network); 23 Aug 2007 01:28:39 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 23 Aug 2007 01:28:39 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 4CC6E100A0E
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 01:28:39 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id go5W6qQeuaIs for <git@vger.kernel.org>;
	Wed, 22 Aug 2007 21:28:38 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id A68331000A2
	for <git@vger.kernel.org>; Wed, 22 Aug 2007 21:28:38 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 63C097B51B; Wed, 22 Aug 2007 21:28:36 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56444>

OK, got it working. It had more to do with the module/trunk path than
the -i.

My svn projects are organized like:
projectFoo
    -trunk
    -tags
    -branches

So I initially used:

git svnimport -C projectFoo -r -A svn-authors -I .gitignore -T projectFoo svn://jabba trunk

which resulted in the empty working directory - with or without the -i.

What ended up working is this:

git svnimport -C projectFoo -r -A svn-authors -I .gitignore -T projectFoo -P trunk svn://jabba

Cheers.
-- 
Jing Xue
