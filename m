From: Jakub Narebski <jnareb@gmail.com>
Subject: [WORKAROUND] gitk lower pane scrollbar extends past gitk window
Date: Thu, 22 Jun 2006 09:48:52 +0200
Organization: At home
Message-ID: <e7di0n$7hh$1@sea.gmane.org>
References: <e7ber7$qh9$1@sea.gmane.org> <20060622023546.28cb4291.froese@gmx.de> <81b0412b0606220010p6c2e62ffv3914abafd95e4bb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 09:49:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJw1-0002Yy-Mi
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWFVHtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWFVHtB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:49:01 -0400
Received: from main.gmane.org ([80.91.229.2]:50068 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932490AbWFVHtA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 03:49:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtJvl-0002Ww-Tt
	for git@vger.kernel.org; Thu, 22 Jun 2006 09:48:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 09:48:49 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 09:48:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22308>

Alex Riesen wrote:

> On 6/22/06, Edgar Toernig <froese@gmx.de> wrote:
>> Jakub Narebski wrote:
>>>
>>> In gitk from the current 'next' branch, post git version 1.4.0
>>> (blob ba4644f) scrollbar for lower pane, i.e. for commitdiff and files
>>> (Comments) views extends past the bottom of the gitk window. Therefore
>>> I cannnot see lower part of commit diff if it is larger than 
>>> window height. 
>>
>> Yes, and the search field at the bottom is invisible too.  Removing
>> line 431:
>>
>>         .ctop conf -width $geometry(width) -height $geometry(height)
>>
>> seems to fix it and the window still gets the right size.
>>
> 
> No, it does not. It gets the default geometry, not the one it had last time.

Now I see. It is the case when I used gitk from a computer with a desktop
with larger screen height, then on computer with screen height smaller than 
gitk height was I had mentioned problem.

Workaround for now is to delete old geometry info from ~/.gitk file 
(or just delete whole file).

I don't know Tcl/Tk to make proper fix, i.e. check if restored size is not
larger than available screen size, and use min(saved size, screen size).
Another improvement would be to save the fact that gitk window is maximized
as a symbol, e.g. as equivalent of 

  set geometry(height) screen(height)

in ~/.gitk

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
