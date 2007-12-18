From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 15:03:32 -0800
Message-ID: <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:04:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lTk-0001Ll-9G
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXLRXDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbXLRXDg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:03:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:36331 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbXLRXDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:03:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1483314nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A5jSw/w0fIZl50V9C30clk16y3cC5ZpBR0Ld1gq7fGE=;
        b=U9q7Mx3aNeOw4Yz0TKbP5f/eVczRFEokzbQxlxVgO+T+AbZYjwTv8fCRqYIr7ZH0Tvq4czuw5dyu+83HIELBKQBKhvMwxCbfGxrXqKgm7y4eJaZuF4Elqu6MoBA9j3aSF4/gWQOiV441sV1P9d63jCLMdSl2A/mirXlarnv0gmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wn875g3KnswuZPFSWAFCGSBJpm51Jasex2sPSw57bYJDkReH+d3b/LWOnDhLGiQgiHcC64VSgGVv0F6PTy7rdTTkDoHaYDeLDv5iqPp5Fx0SxCUn9EuSmkhQ5koSyFtA+OJFaZm2sMiLg4KLydwEHKkCc7VcMEe+Ah0LOD2z6ds=
Received: by 10.78.204.20 with SMTP id b20mr10701294hug.33.1198019012925;
        Tue, 18 Dec 2007 15:03:32 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 15:03:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712182239500.23902@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68841>

On Dec 18, 2007 2:43 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 18 Dec 2007, Alex Riesen wrote:
> > But the act of running "git-show <tree-ish>:<path>" does have a working
> > directory relative to the project root.
>
> Not necessarily.  My primary use of "git show <tree-ish>:<path>" (yes, I
> already use the dash-less form ;-) is in _bare_ repositories.
>
> And I still maintain that expecting <tree-ish>:<path> to take the current
> relative path into account would be just like if you expected
>
>         C:\> cd WINDOWS
>         C:\WINDOWS> dir D:system32
>
> to show you the contents of D:\WINDOWS\system32.
>
> Or another, less Windowsy example:
>
>         $ cd /usr/bin
>         $ scp home:bash ./
>
> No, this does not copy home:/usr/bin/bash but home:$HOME/bash.

Both of your counterexamples use 2 disjoint directory trees:
C: vs D:,  or trees on different machines.

The cases we are talking about are all subtrees of the working tree.
There is a useful cwd suffix.

Don't you think that
  git <op> commit:./file.c
could occasionally be more convenient than
  git <op> commit:very/long/and/boring/path/equal/to/cwd/file.c
?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
