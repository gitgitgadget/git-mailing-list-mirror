From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] Add a basic idea section for git-blame.
Date: Thu, 8 Apr 2010 18:27:22 +0200
Message-ID: <201004081827.22706.trast@student.ethz.ch>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com> <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com> <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzuZn-00028U-8H
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661Ab0DHQ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:27:26 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:3023 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758842Ab0DHQ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:27:25 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 18:27:23 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 18:27:23 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144360>

Junio C Hamano wrote:
> Bo Yang <struggleyb.nku@gmail.com> writes:
> 
> > +A call to `git-blame <rev> -- <file>` works as follows:
> > +
> > +- Look at `git diff <rev>^ <rev>` to see what the commit did.
> > +
> > +- Discard all `-` lines in the diff, since they are no longer part of
> > +  `<file>`.
> > +
> > +- Take blame for all `+` lines; i.e., the newly added lines according
> > +  to the diff are attributed to `<rev>`.
> 
> I hate to say it, but this is horrifying; it works quite the other way
> around.
> 
> The name of the game is not "take blame by looking at the diff to see what
> we introduced"; it is "avoid taking blame at all cost, by looking at the
> diff to see what we might have inherited from our parents".

"Horrifying" seems a fairly harsh word for another way to describe the
process *in linear history* and with default settings, doesn't it?

I now see that "assume linear history" is oversimplifying the process,
but I have to take blame^W^W^W^Wwill fail to shift blame for it since
I suggested that.

> For illustrated description, read the classic:
>  
>     http://thread.gmane.org/gmane.comp.version-control.git/28826
> 
> Almost all the hits in the first page from this query would help, too:
> 
> http://search.gmane.org/?query=On+blame%2Fpickaxe&author=Junio+C+Hamano&group=gmane.comp.version-control.git&sort=revdate&DEFAULTOP=and&[=2&xP=blame%09pickaxe&xFILTERS=Gcomp.version-control.git-Ac-Ahamano-Ajunio---A

Thanks.  I trust this will help Bo make a revised description for the
manpage.



[PS for the list record: while part of the patches is indeed mine, I
never signed off on them.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
