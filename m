From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 17:53:17 -0400
Message-ID: <20071010215317.GC2963@fieldses.org>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> <20071010213925.GB2963@fieldses.org> <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com> <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Oct 10 23:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjVC-0005Hk-Jd
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450AbXJJVxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbXJJVxW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:53:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37990 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450AbXJJVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:53:20 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IfjUT-0006zQ-Sn; Wed, 10 Oct 2007 17:53:17 -0400
Content-Disposition: inline
In-Reply-To: <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60555>

On Wed, Oct 10, 2007 at 06:49:19PM -0300, Han-Wen Nienhuys wrote:
> 2007/10/10, Lars Hjemli <hjemli@gmail.com>:
> > On 10/10/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
> > > > could it be that GC does not handle cyclic alternates correctly?
> > >
> > > Does it handle alternates at all?  If you run git-gc on a repository
> > > which other repositories get objects from, then my impression was that
> > > bad things happen.
> > >
> >
> > AFAIK 'git gc' is safe, while 'git gc --prune' will remove loose
> > (unreferenced) objects.
> 
> Yes, I think that in this case, gc --prune was run accidentally, but
> given that the history of the program invoking git just died, I'm not
> sure how to figure that out.
> 
> Maybe gc --prune could follow the alternates and abort if a cycle was detected?

Don't the alternates point in the wrong direction?  You'd need pointers
back from the main repository to the repositories that depend on it for
objects.

Which would be nice....

--b.
