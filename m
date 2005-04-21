From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 16:38:40 +0200
Message-ID: <20050421143840.GA14059@elte.hu>
References: <20050421092120.GA20626@elte.hu> <20050421.133136.78712855.oandrieu@nerim.net> <20050421130242.GA5817@elte.hu> <20050421.155519.112619323.oandrieu@nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 16:35:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOclC-0002vj-8r
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 16:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVDUOiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVDUOiy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 10:38:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30353 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261395AbVDUOiv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 10:38:51 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 15A8A318B29;
	Thu, 21 Apr 2005 16:37:39 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 555981FC2; Thu, 21 Apr 2005 16:38:43 +0200 (CEST)
To: Olivier Andrieu <oandrieu@nerim.net>
Content-Disposition: inline
In-Reply-To: <20050421.155519.112619323.oandrieu@nerim.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Olivier Andrieu <oandrieu@nerim.net> wrote:

> Yes, git-viz uses the `dot' program from the graphviz package (it's in 
> Fedora Extra too I believe).

ah - that resolved all issues and i'm now running git-viz without any 
problems.

I just checked how the kernel repository looks like with it, and i'm 
impressed! The GUI is top-notch, and the whole graph output and 
navigation is very mature visually. Kudos!

a couple of suggestions that are in the 'taste' category:

- isnt left-to-right layout the more natural thing instead of top-down 
  (as it aligns with the reading direction)? It's selectable in the 
  preferences, but you might want to make it default. OTOH, top-down
  creates a more compressed view of the graph.

- there doesnt seem to be any performance difference between non-colored 
  and colored rendering - so you might as well want to make 'color by 
  author' (or color by branch) the default coloring, instead of 
  uncolored?

- naming the boxes by key is quite meaningless. It would be more 
  informative to see the author's email shortcuts in the boxes. Also, it 
  would be nice to see some simple graphical feedback about the size and 
  scope of a changeset, without having to zoom on it.

i guess you know it, and i'm definitely not complaining about prototype 
code, but rendering is quite slow: drawing the 340 changesets in the 
current kernel repository takes 15 seconds on a 2 GHz P4. Drawing the 
full kernel history (63,000 changesets) would take more than 45 minutes 
on this box.

the current rate of kernel development is ~2000 changesets per month, so 
drawing the kernel history will get 3 seconds slower every day - it will 
exceed 1 minute in 20 days, so this will become a pressing issue quite 
soon i suspect.

	Ingo
