From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 15:28:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705021523290.24218@reaper.quantumfyre.co.uk>
References: <200705012346.14997.jnareb@gmail.com> <200705020955.04582.andyparkins@gmail.com>
 <Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk>
 <200705021158.04481.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjFpk-0001Sh-Uk
	for gcvg-git@gmane.org; Wed, 02 May 2007 16:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993241AbXEBO27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993243AbXEBO26
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 10:28:58 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:56032 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993241AbXEBO25 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2007 10:28:57 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AEA3210507C
	for <git@vger.kernel.org>; Wed,  2 May 2007 15:28:55 +0100 (BST)
Received: (qmail 6919 invoked by uid 103); 2 May 2007 15:27:36 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3190. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036895 secs); 02 May 2007 14:27:36 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 2 May 2007 15:27:36 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200705021158.04481.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46022>

On Wed, 2 May 2007, Andy Parkins wrote:

> On Wednesday 2007 May 02, Julian Phillips wrote:
>
>> A fully packed clone of the OOo git repo was indeed 1.3G, and the entrire
>> checkout + repo was indeed 8.5G (using git 1.5.1.2).


oops, meant 2.7G not 8.5G there ... sorry, was working from memory.

jp3@electron: ooo(unxsplash)>du -sh .git
1.3G    .git
jp3@electron: ooo(unxsplash)>du -sh .
2.7G    .
jp3@electron: ooo(unxsplash)>ls .git/objects/
info  pack


> I'm more confused now then.  I assumed the figures were accurate, but they
> cannot be:
>
>                               CVS      git      SVN
> Size of data on the server     8.5G     1.3G     n/a
> Size of checkout               1.4G     2.8G     1.5G
>
> I don't doubt the 1.3G on the server - and assume that is fully packed.  The
> checkout sizes are suspicious though.  Is that 2.8G packed?
> - If it is, then we can deduce that this is a repo+source size, since the
>   server is packed size+0 therefore the size of the source tree is
>    2.8G - 1.3G = 1.5G

the difference between 2.7G and 2.8G may be due to filesystem difference?

>   In which case the other figures are wrong:
>    - CVS checkout is 1.4G - impossible, the source tree is 1.5G. And where is
>      the overhead of the CVS directories which would make it more than 1.5G?
>    - SVN checkout overhead is always _at least_ the size of the source tree
>      because it keeps a pristine copy of HEAD.  If the source tree is 1.5G,
>      then this figure should be at least 3G.

I was wondering about the subversion figures too ...

> - If it is not, then we're back to "I don't believe that git was packed"
>
> Something smells fishy here - either the source tree size is included in some,
> but not in others or the git repository wasn't packed.

1.3G is the packed size ...

jp3@electron: ooo(unxsplash)>ls -sh .git/objects/pack/
total 1.3G
  37M pack-87efcac9bcb117328e8a1b0c1b42c88c3603c5b7.idx
1.2G pack-87efcac9bcb117328e8a1b0c1b42c88c3603c5b7.pack

-- 
Julian

  ---
To err is humor.
