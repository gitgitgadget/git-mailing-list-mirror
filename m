From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Deleting remote branches
Date: Fri, 26 Mar 2010 07:16:52 +0100
Message-ID: <20100326061652.GA28279@m62s10.vlinux.de>
References: <1269582415273-4802262.post@n2.nabble.com> <f3271551003252300u387f6081seaa03d4eb7194486@mail.gmail.com> <1269583743012-4802313.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 07:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv2qr-0002uV-PS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 07:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab0CZGQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 02:16:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:57844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753068Ab0CZGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 02:16:56 -0400
Received: (qmail invoked by alias); 26 Mar 2010 06:16:54 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp070) with SMTP; 26 Mar 2010 07:16:54 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+Sjrt6rdGSaseWpheRrJtc7b7Efe3+aKFH/pI67j
	tH8+y5t87mJ3qu
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A6BD0D4006; Fri, 26 Mar 2010 07:16:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269583743012-4802313.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143212>

On Thu, Mar 25, 2010 at 10:09:03PM -0800, jhapk wrote:
> 
> Hi,
> 
> I have tried that and I get the following message
> 
> [pradeep@scaramanga cffc]$ git push origin:test
                                      ^^^^^^^^^^^

Notice the missing space. From the git push manpage:

git push origin :experimental
               ^
    Find a ref that matches experimental in the origin repository (e.g.
    refs/heads/experimental), and delete it.


The syntax (with all the unused stuff removed) is 'git push <repository> <refspec>'
If you don't supply any repository (as you did with your cmdline), the default 
remote repository is used. Your command tried to push the local branch 'origin' into
the remote branch 'test' of your default remote repository. Correct would be

git push :test   # or git push origin :test

The refspec :test means push empy/nothingness into the branch 'test', which will delete it.

--
Peter
