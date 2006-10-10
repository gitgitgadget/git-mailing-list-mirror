From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 10 Oct 2006 10:54:54 +0200
Message-ID: <200610101054.54948.jnareb@gmail.com>
References: <20061010014743.80094.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 10:54:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXDN6-0002fP-Tu
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 10:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWJJIxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 04:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWJJIxy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 04:53:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:15347 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965112AbWJJIxx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 04:53:53 -0400
Received: by ug-out-1314.google.com with SMTP id o38so712055ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 01:53:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=neSfqmB9zFctr/9G/+tkLJb7M9aYOH9x3NNFtJBfrGhtJwHFPW6uBmP/QzOcyUZNjdDQQm851jAR2RiMM+QCVGL3m6eRUP+2bFv9Al9ZWhRbnDOhcRXXgWjzhxYlCsYOUaeST2Yl2nmHY17Qn1BdvhjDx1VOVMPsrGg8ZglUE5Y=
Received: by 10.67.105.19 with SMTP id h19mr7973684ugm;
        Tue, 10 Oct 2006 01:53:51 -0700 (PDT)
Received: from host-81-190-27-91.torun.mm.pl ( [81.190.27.91])
        by mx.google.com with ESMTP id k28sm2477180ugd.2006.10.10.01.53.51;
        Tue, 10 Oct 2006 01:53:51 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010014743.80094.qmail@web31801.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28619>

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> >  * Improve blame view, making use of --porcelain option to git-blame (for
> >    later). Perhaps change blame view from table based one to div based one.
> 
> >    Use different colors for different commits (graph coloring problem).
> 
> Oh, no please no.
> 
> Why do you think I left the color list as a list?  I did try to use
> more colors when I wrote it, and it was ugly as h3ll and very distracting
> when doing real work.  So I ended up with the two color (shades) we have
> now and this is what I submitted.
> 
> Also, any kind of "graph coloring problem" would make blame slow.

One of ideas (without having some nice _mathematical_ solution, i.e. not
having for to try and check different coloring but calculating coloring, 
of a blame graph coloring problem[*1*]) was to use few colors, 3, 6, 8
based on some hash of sha1 of commit (for example first character) plus
alternating "darkness" of those colors to ensure that neighbours would
have different colors. Another was to use first 6 characters of sha1 as
a color, then flatten the color to suitable for background (perhaps also
with some kind of ensuring that neigbour blames would have different color). 

Junio idea of basing color/brighness (of some part of blame output at
least) on the _age_ of region (perhaps using two altrenating _colors_)
has also it's merit.

Nevertheless, such change would be preceded by an RFC, and discussion.

> In any way, if you/someone does implement this "coloring" can you please
> make it an option, because I'll never turn it on.  Thanks!

Not a problem to make blame coloring a feature.


Footnotes:
[*1*] Blame graph coloring problem: 1) regions blamed on the same commit
should have the same color 2) neighbour blame regions should have different
colors.
-- 
Jakub Narebski
Poland
