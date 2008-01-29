From: Max Pollard <ajaxsupremo@yahoo.com>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 11:47:20 -0800 (PST)
Message-ID: <146301.84241.qm@web45914.mail.sp1.yahoo.com>
References: <BAYC1-PASMTP0711D909B278C305D7F28AAE350@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:54:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwXV-0006OI-AO
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 20:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbYA2TyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 14:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYA2TyE
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 14:54:04 -0500
Received: from n22b.bullet.mail.sp1.yahoo.com ([69.147.65.254]:45670 "HELO
	n22b.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751100AbYA2TyD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 14:54:03 -0500
Received: from [216.252.122.219] by n22.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 19:54:01 -0000
Received: from [69.147.65.162] by t4.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 19:54:01 -0000
Received: from [127.0.0.1] by omp407.mail.sp1.yahoo.com with NNFMP; 29 Jan 2008 19:54:01 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 30709.86711.bm@omp407.mail.sp1.yahoo.com
Received: (qmail 89599 invoked by uid 60001); 29 Jan 2008 19:47:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=OqRqPrQXKcGi5imxHFMgKr+FK/nqH58cDfS946TLZnL04+8JAB7ruwbpLugoLNq7+d4RLNdSUCgYR5ogyDB0jplnXf6fSFKnB6rqQUUr7LM0K1kug5tRg3YuF9O9AUuYEl8hfOsDqIPjnuIX8LXlu0bZuF1XcQlD0gLZSq6e9l4=;
X-YMail-OSG: qToBwiIVM1kK5.3eZ5949dEjAoIqVo2nc5AGsWEBdSBMSCKIpR_4fHgUh.aBHTr38z2z6u_.rBZUhct6UGPHjTbrbg--
Received: from [66.122.195.143] by web45914.mail.sp1.yahoo.com via HTTP; Tue, 29 Jan 2008 11:47:20 PST
In-Reply-To: <BAYC1-PASMTP0711D909B278C305D7F28AAE350@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71990>


--- Sean wrote:

> On Tue, 29 Jan 2008 09:48:05 -0800 (PST)
> Max Pollard wrote:
> 
> > I only see the log corresponding to the 2nd commit (v1.5.3.5).  Is it
> > possible to have the above command keep going and show the history of
> > a.txt?  Or at least somehow indicate that b.txt originated from a.txt?
> 
> Hi Max,
> 
> Not sure it will leave you feeling totally satisfied but the
> following command will at least show you the copy which
> occurred in that commit:
> 
> $ git log --full-diff -C --find-copies-harder --stat -- b.txt
> commit 578ecbc516e70ce7178545233192a08369a07101
> Author: xyz <x@y.z>
> Date:   Tue Jan 29 13:11:16 2008 -0500
> 
>     Copy a.txt to b.txt
> 
>  a.txt => b.txt |    0 
>  1 files changed, 0 insertions(+), 0 deletions(-)
> 
> If you had done a rename instead of a copy, then "git log --follow b.txt"
> would have done what you're looking for, but there is no corresponding option
> to follow copies.

Many thanks for that Sean.  I saw all the options in the manual, but couldn't
figure out how to put them together.

This is exactly the information I wanted.  It appears to identify copies in
both text & binary files even if contents of b.txt are modified before commit
(or at least modified in ways the copy-detection logic can identify copies).


MP



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 
