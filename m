From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn error "Unable to extract revision information from	commit
 ...~1"
Date: Wed, 27 Jun 2007 09:57:02 -0700
Message-ID: <468296DE.7000704@midwinter.com>
References: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>	 <4681C27B.8040009@midwinter.com> <1182947236.21320.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3apK-0008LJ-Fu
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 18:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbXF0Q5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbXF0Q5G
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 12:57:06 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:44552
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753281AbXF0Q5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 12:57:05 -0400
Received: (qmail 25194 invoked from network); 27 Jun 2007 16:57:03 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Q13a7ArURuY0L2+Tx/uTeYsMEaM1pf9UPKisUjKyHllfmrOrUZVqHrGXSSQG3luB  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 27 Jun 2007 16:57:02 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <1182947236.21320.3.camel@omicron.ep.petrobras.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51058>

Victor Bogado da Silva Lins wrote:
> I will try that, but on the other hand is it possible to commit the 
> diff between my head and the svn head with a new message? This would 
> be good enough for me.

Yes, that's pretty easy; you just have to do a squash merge to eliminate 
the nonlinear history. Assuming the svn head is called "trunk" and your 
head is called "myhead":

# start with the svn head
git checkout -b trunk tempbranch
# bring in all the changes from your branch
git merge --squash myhead
# commit with whatever message you want
git commit
# and ship it up to svn land
git svn dcommit

-Steve
