From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 14:23:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004241413030.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <m3633hdw9u.fsf_-_@localhost.localdomain> <87fx2li36m.fsf@catnip.gol.com>
 <201004241226.34884.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 20:23:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5k0j-00081h-HP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 20:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab0DXSXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 14:23:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33375 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0DXSXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 14:23:02 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L1E00L1E8ECHM40@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Apr 2010 14:23:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <201004241226.34884.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145693>

On Sat, 24 Apr 2010, Jakub Narebski wrote:

> First, this is to be optional safety, by default turned off.  So if you
> do not have problems with situation where you accidentally use 
> 'git commit -a' instead of 'git commit', committing not what you wanted
> and prepared, you simply do not turn it on.

In which case it is worthless.  No one will turn this feature on if they 
don't fully understand what it entails, and those who do understand it 
are probably not the people who would actually benefit from it.

> Second, to be more exact the safety would be triggered only if staged
> change _differs_ from what is in working area.  Therefore
> 
>   $ git add file
>   $ git commit -a
> 
> would not trigger this safety, while
> 
>   $ git add file
>   $ edit file
>   $ git commit -a
>   fatal: There are staged changes
> 
> would trigger it.

Much better yet would be a warning at the top of the summary message in 
the commit text editor.  This way you won't introduce an incompatible 
and potentially annoying behavior that no one is likely to opt-in for, 
and the warning will give a hint that you might be losing some 
intermediate state if you don't abort the commit.


Nicolas
