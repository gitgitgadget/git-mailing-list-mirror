From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 12:54:45 -0700 (PDT)
Message-ID: <20050619195446.4183.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 21:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk5n0-0007iM-Ac
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 21:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFSTyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVFSTyu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 15:54:50 -0400
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:49254 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261295AbVFSTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 15:54:46 -0400
Received: (qmail 4185 invoked by uid 60001); 19 Jun 2005 19:54:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RGoBOjrx5ymuB7hfdh+ljucXTpj/lFn3huHGVsE5KPnyctP9zxU49Da5dma+wOvhKtI2SG7TBihNq/EJhKozTGsXgQqkNsDRA4Iz2hMEM3O2IpTLDjQbupbPz5StN2g7OtejwGZEuYdtv3NpdRRpfIPcDYlorDfHjaN2QJRCfA4=  ;
Received: from [151.38.101.189] by web26302.mail.ukl.yahoo.com via HTTP; Sun, 19 Jun 2005 12:54:45 PDT
To: Ingo Molnar <mingo@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:

thanks for your feedback
>
>works fine here and is nice and fast, but there are a few minor visual 
>glitches:
>
>- annotated file contents are not properly aligned over each other. E.g.  
>  check commit 7875b50d1a9928e683299b283bfe94778b6c344e in the current 
>  git repository, and select read-tree.c and view it annotated - the 
>  lines start right after the author field ends, not in any aligned way.
>

Yes, it depends on variable spaced font, If you note the number of characters of the header of
each line is always the same and is calculated for each file (the gray color part has always a
fixed number of chars). I have already switched to a fixed font (courier) in my tree,
plus others little things like truncation if exceeds a maximum lenght with 
first name collpasing (Marco Costalba -> M. Costalba).


>- the tree visualization is hard to follow - gitk's output is much 
>  nicer. As an example of nice rendering check out the octopus merge 
>  around commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e. One glance at 
>  the gitk output shows what happened - qgit's output is in essence 
>  unreadable.
>

You are definitely right! The problem is graph is not drawed! I precalculate at startup all
the diffrents pixmaps and put in a vector, drawing a graph is just correct indexing
the vector for each lane and do some bitblt. This is because QT has good pixmaps handling in
QListView ( the main log list) but not line drawings capapility and because this way is very fast.
But in any case I definitely have to find something better. Suggestions are welcomed :-).

>and a few requests for enhancements if you dont mind:
>
more then welcomed.

> - in annotated mode, it would be nice to select a particular line 
>   and then double-click would jump to the commit that added that line.  
>   This would nicely round up annotation support.
>

Ok, I'll add this. By the way, now you can select the corresponding commit in the 
history list above file content (it's the one with the same number) and the
 main view will update. 
I can make the selection: 'line content number -> line history number' automatic and that
should be enough.


> - plaintext search capability in every window. E.g. in the annotated
>   file window i often would like to search for some code, or to jump to
>   a given line.

Ok. I'll add this.


Marco



		
__________________________________ 
Discover Yahoo! 
Stay in touch with email, IM, photo sharing and more. Check it out! 
http://discover.yahoo.com/stayintouch.html
