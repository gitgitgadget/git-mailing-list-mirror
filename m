From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 13:44:46 +0000 (UTC)
Message-ID: <loom.20060703T153349-582@post.gmane.org>
References: <loom.20060703T124601-969@post.gmane.org> <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com> <loom.20060703T143544-407@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 03 15:45:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxOk1-0007Qh-20
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 15:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGCNpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 09:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWGCNpO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 09:45:14 -0400
Received: from main.gmane.org ([80.91.229.2]:62604 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750826AbWGCNpN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 09:45:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxOjU-0007JN-Nc
	for git@vger.kernel.org; Mon, 03 Jul 2006 15:45:01 +0200
Received: from fnasa.simula.no ([129.240.228.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 15:45:00 +0200
Received: from cjhaga by fnasa.simula.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 15:45:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 129.240.228.53 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060608 Ubuntu/dapper-security Firefox/1.5.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23176>

Elrond <elrond+kernel.org <at> samba-tng.org> writes:

> 
> Joachim B Haga <cjhaga <at> fys.uio.no> writes:
> [...]
> > In this case Z_BEST_COMPRESSION also compresses worse,
> [...]
> 
> I personally find that very interesting, is this a known "issue" with zlib?
> It suggests, that with different options, it's possible to create smaller
> repositories, despite the 'advertised' (by zlib, not git) "best" compression.

There are also other tunables in zlib, such as the balance between Huffman
coding (good for data files) and string matching (good for text files). So with
more knowledge of the data it should be possible to compress even better. I'm
not advocating tuning this in git though ;)

> 
> Alex Riesen <raa.lkml <at> gmail.com> writes:
> [...]
> > Probably yes, as a per-repo config option.
> 
> The option probably should be the size for which to start using
> "default" compression.

That is possible, too. I'm open to any decision or consensus, as long as I get
my commits in less than 10s :)

-j.
