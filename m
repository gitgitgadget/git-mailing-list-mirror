From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Wed, 04 Jul 2012 09:21:52 +0200
Message-ID: <1341386512.3871.4.camel@flaca.cmartin.tk>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
	 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
	 <20120703180439.GC3294@sigill.intra.peff.net>
	 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
	 <20120703184018.GB5765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJuW-0005oU-Kn
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab2GDHV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 03:21:59 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43303 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765Ab2GDHV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:21:58 -0400
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 93CC946057;
	Wed,  4 Jul 2012 09:21:56 +0200 (CEST)
In-Reply-To: <20120703184018.GB5765@sigill.intra.peff.net>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200990>

On Tue, 2012-07-03 at 14:40 -0400, Jeff King wrote:
> On Tue, Jul 03, 2012 at 02:34:59PM -0400, jonsmirl@gmail.com wrote:
> 
> > > and now:
> > >
> > >   $ git push origin :bogus
> > >   error: unable to delete 'bogus': remote ref does not exist
> > >   error: failed to push some refs to '$URL'
> > 
> > This error return would have made my mistake obvious.
> 
> Thanks for confirming.
> 
> > Might want to add a paragraph to the doc saying this is how you delete
> > remote branches since it is not an obvious solution. I found it via
> > Google and a question asked on stackoverflow.com
> 
> It's already in git-push(1):
> 
>   OPTIONS
>      ...
>      <refspec>
>        ...
>        Pushing an empty <src> allows you to delete the <dst> ref from
>        the remote repository.
> 

There is also a flag you can pass, which you can see a few paragraphs
under it which. It explains what it does underneath but removes the need
to know that an empty source will delete the ref.

    --delete
       All listed refs are deleted from the remote repository. This is
       the same as prefixing all refs with a colon.

I suppose "delete" rather than "remove" as we have for remotes could
cause some confusion, as it's inconsistent, but it's all there in the
manpage.

   cmn
