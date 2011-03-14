From: Drew Northup <drew.northup@maine.edu>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 14:59:21 -0400
Message-ID: <1300129161.13980.4.camel@drew-northup.unet.maine.edu>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
	 <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:59:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzCzY-0008WU-6k
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 19:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1CNS7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 14:59:38 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:41917 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1CNS7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 14:59:37 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2EIxRQb016951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Mar 2011 14:59:27 -0400
In-Reply-To: <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2EIxRQb016951
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300733968.50048@rmj9t2CdezrB2biDJYxE8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169008>


On Mon, 2011-03-14 at 20:39 +0200, Alexei Sholik wrote:
> On 14 March 2011 20:29, Alexei Sholik <alcosholik@gmail.com> wrote:
> > Hi git,
> >
> > I cloned git mirror from github[1]. When I run git-status in it's
> > working directory, I see no output.
> >
> > But then, after copying the whole directory with 'cp -r' and running
> > git-status in the newly created directory, I get the following:


> Right, I've figured out the root of the change.
> 
> 'ls -l' on the original RelNotes outputs:
>   lrwxr-xr-x  1 alco  staff  32 Mar 14 20:35 RelNotes ->
> Documentation/RelNotes/1.7.5.txt
> 
> 'ls -l' on the copied RelNotes outputs:
>   -rw-r--r--  1 alco  staff  1810 Mar 14 20:10 RelNotes
> 
> So the problem is with the cp, not git. But I wonder if it is
> mentioned anywhere in the docs? Probably, git-clone's or git-status'
> manpage would be a proper place?

Quoting Jeff King <peff@peff.net>:

> "cp -r" isn't an exact copy. You probably want "cp -a" or at least "cp
> -rs".
.....
> Right. RelNotes is a symlink. But "cp -r" dereferences the symlink and
> copies the file contents themselves.

As has been said more than a few times (and is probably somewhere in the
docs), if you really want to duplicate a git repo you should probably be
using git to do it. No change to the manpages is required here.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
