From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: Improved git-gui blame viewer
Date: Sat, 02 Jun 2007 12:44:29 +0200
Message-ID: <f3rhme$2h9$1@sea.gmane.org>
References: <20070602041723.GD7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 13:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuRZp-0004Zq-MT
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 13:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbXFBLPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 07:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbXFBLPP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 07:15:15 -0400
Received: from main.gmane.org ([80.91.229.2]:56549 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbXFBLPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 07:15:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HuRZW-0000ZV-50
	for git@vger.kernel.org; Sat, 02 Jun 2007 13:15:02 +0200
Received: from zwaan.xs4all.nl ([213.84.190.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 13:15:02 +0200
Received: from mmelchior by zwaan.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 13:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zwaan.xs4all.nl
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <20070602041723.GD7044@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48925>

Shawn O. Pearce wrote:
> A long time ago Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Sun, 18 Mar 2007, Shawn O. Pearce wrote:
>>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>> Of course, the git gui blame colorization is clearly done by somebody who 
>>>> is still actively popping LSD with both fists and didn't realize that the 
>>>> 60's are long done, but that's another issue.
>>> git-gui is open source.  I'd be happy to take a patch.  Or,
>>> since that is horribly messy Tcl/Tk code, just a better color
>>> suggestion. :-)
>> I would suggest:
>>
>>  - some special color for "currently selected" (which defaults to being 
>>    the first one coming out of the blame thing, of course). 
>>
>>    I'd suggest "black text on pale green background", but that may be just 
>>    me.
>>
>>  - some *stable* graduated color for the rest. I don't think it 
>>    necessarily needs to be "older" vs "newer", and in fact I'd suggest 
>>    just two slightly different shades of gray for the background - just 
>>    pick alternating shades for each blame entry that comes in (and leave 
>>    un-blamed lines white).
> 
> I finally got the git-gui code to the point where cleaning up the
> user interface was possible without sending myself to the nut house.
> 
> I tried out Linus' suggestions for coloring, and I like them.  Enough
> that they are now sitting in my `pu` branch on repo.or.cz/git-gui.git.
> 
> There's also a whole slew of other improvements to the blame viewer,
> like being able to dig through history by clicking on commit ids,
> and tooltips when you mouse over a region of the file.
> 
> Behavior on Windows is actually quite good; its less so on Mac
> OS X.  I'm fighting Tk there a little bit more than I should be.
> Untested on Linux, so I'd love to hear some feedback on it.
> 
>   git://repo.or.cz/git-gui.git      pu
>   http://repo.or.cz/r/git-gui.git   pu
>  

I have got this on Debian Etch and given the command 'make install'
in the pu branch while git-core 1.5.2 is installed.

About git-gui says:
	git-gui version 0.7.2.39.ge6a1
	git version 1.5.2
	Tcl/Tk version 8.4.12

The colors look much better.

The behavior has some rough edges. I don't like the following:
  When clicking on a link in the left column, the file as present in
  that commit is loaded, positioned at the top. I would like for the
  line where I clicked is to stay at the same position on the screen,
  so I do not have to find it again.

  Also, when returning I would like most lines on the screen stay the
  same.

  When clicking on a light gray line to become a green line, then
  adjacent areas are not correctly colored.  A few adjacent entries
  become all same gray... [Look around git-gui.sh:340]


  Something I want for the normal window, in the Staged and Unstaged
  file lists, high-lite the last entry selected so it becomes easy to
  click on the next one and I can see more clearly what is displayed
  in the bottom area.


Thanks for your efforts!

Regards,
	Matthijs Melchior.
