From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn error "Unable to extract revision information from commit
 ...~1"
Date: Tue, 26 Jun 2007 18:50:51 -0700
Message-ID: <4681C27B.8040009@midwinter.com>
References: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MhO-0006Gj-BU
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbXF0Bu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXF0Buz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:50:55 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:44414
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1756245AbXF0Buw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:50:52 -0400
Received: (qmail 28730 invoked from network); 27 Jun 2007 01:50:52 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qgQX4+V2YbYFKOH7TR+Q0SSZNYonuUV8EDS0TX6y3CnRHqYFlBLydsTd+JB395OC  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 27 Jun 2007 01:50:52 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50999>

Victor Bogado da Silva Lins wrote:
> The problem seem to be that when I merge the head with another branch
> git-svn does not know where to follow to meet the "svn trunk". 

The current release of git-svn doesn't support committing merges. It has 
no clue how to walk nonlinear history, as you point out. The current 
practice is to do "git merge --squash" when merging into the git-svn 
branch that you want to use as the basis for your svn commit. The 
--squash option will make git merge the contents of the other branch(es) 
but record the resulting tree as a regular commit, not as a merge.

There is a work-in-progress patch which might help you if you need to 
preserve merge ancestry on the git side. Search the mailing list 
archives for "[PATCH] git-svn: allow dcommit to retain local merge 
information" if you want to try it (but be aware that it is just an 
initial implementation and may have bugs; it was posted so people could 
try it out and report back any problems to the author.)

-Steve
