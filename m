From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.81
Date: Sun, 7 Aug 2005 00:37:09 -0700 (PDT)
Message-ID: <20050807073709.8962.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 09:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1fij-0003QZ-Ng
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 09:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVHGHhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 03:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVHGHhT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 03:37:19 -0400
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:49548 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751196AbVHGHhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 03:37:19 -0400
Received: (qmail 8964 invoked by uid 60001); 7 Aug 2005 07:37:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vjsNofx2MxuQxDhxMAQ7k2iPJ35JZ9dhu/KpvNUSxBweno2DqMdt0GWq5Dlo+Jk2KRbPt8/TDcJCnUlmUVSRzJcfTuUMI+OzQVO5M4Oe11owYg8FXh0zXTemqU2Is/IJJ+NHYIRXlSOIELtFseblTHUUgbn7CMYhwdlXJSCEAJk=  ;
Received: from [151.38.109.179] by web26302.mail.ukl.yahoo.com via HTTP; Sun, 07 Aug 2005 00:37:09 PDT
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>Ok, this is nicer than gitk, with the parents showing up in the commit
>message and thus easy to go to. You might add children too: it's not
>something git itself knows about intrisically, but since you've already 
>built the graph, at least you see what children are part of that graph..
>

I don't know if this is what you mean, but if you right click on a free 
lane (i.e. not a bullet but a vertical line) on the graph you should see a
pop-up with selectable childs and parent.

> - Any chance of having a git archive of qgit? I realize that sourceforge 
>   doesn't have git archives, but (a) maybe you can ask and (b) maybe 
>   there are alternate places you could put it. It's just sad having to 
>   download tar-balls.
>

I will try to proceed from (a) to, eventually, (b).


> - The qgit graph is not as pretty as the gitk one. Any chance of making 
>   the bullets a bit smaller, and having an option to not do the
>   "jump-over-bumps"?
>

Ok, I will try to use straight horizontal lines instead of jump-over-bumps. If
this seems not enough clear I will add an option to switch visualization.

> - the "file annotation" window is nice, but it _really_ shouldn't do line
>   wrapping. If you make the window narrower, you'll see it wrap and look 
>   horrible.. Are all text windows always wrapped in QT?
>

No, just a setting. Not a problem to set "No wrap" behaviour. I will set this
also in diff viewer window.

> - You edit the commit comments heavily, and have no options to unedit. 
>   For example, I need the emails in the sign-offs if I ever cut-and-paste 
>   to an email client when I sent a "hey, this commit broke so-and-so.."
>

You discover a real bug ;-). I never intended to modify commit comments in any way.


> - the "format a patch to be sent as email" thing says "at least two 
>   revisions needed" when you only have one. Why? One of my more common 
>   cases is that I send one commit as a patch, and now I do
>
>	git-diff-tree -p --pretty [commit-id] > ~/diff
>
>   and then just send that. A single commit _does_ describe a valid patch, 
>   after all.
>

The logic here is to specify a range. As example if you have following commits

      A
      B
      C
      D
      E
      F

and you select B and E then 3 patches will be created: 
 
     patch_1(diff between D-E)
     patch_2(diff between C-D)
     patch_3(diff between B-C) 

So you need at least 2 selected revs. Put in other words, the base is always explicit.

 
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
