From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: [darcs-devel] Re: Darcs-git pulling from the Linux repo: a
 Linux VM question
Date: Thu, 28 Apr 2005 17:36:01 +0200
Message-ID: <7ir7guj4m6.fsf@lanthane.pps.jussieu.fr>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr>
	<Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org>
	<7iu0lskyfb.fsf@lanthane.pps.jussieu.fr>
	<Pine.LNX.4.58.0504270910510.18901@ppc970.osdl.org>
	<20050428113947.GC9422@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 28 17:31:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRAyJ-0005EE-E6
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 17:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVD1PgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVD1PgG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 11:36:06 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:40403 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262151AbVD1PgF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 11:36:05 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3SFZubr079998
          ; Thu, 28 Apr 2005 17:35:56 +0200 (CEST)
X-Ids: 166
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3SFa1u8004665
          ; Thu, 28 Apr 2005 17:36:01 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DRB3Z-00054O-LD; Thu, 28 Apr 2005 17:36:01 +0200
To: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
In-Reply-To: <20050428113947.GC9422@abridgegame.org> (David Roundy's message
 of "Thu, 28 Apr 2005 07:39:52 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.166]); Thu, 28 Apr 2005 17:35:56 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427102DC.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> When we're desperate, we'll special-case the initial commit, but currently
> I'm sure we can pretty easily adjust things by making the git-tree-reading
> lazy,

Just to make it clear: reading the git tree is lazy.  The problem is
somewhere in the higher layers, probably in pull_cmd.

There's also another problem: reading the git tree takes 220MB.  Then
Darcs allocates a further 500MB without calling my code at all.  (Some
of it is doubtless due to linesPS, that should be more than a handful
of megabytes.)

                                        Juliusz
