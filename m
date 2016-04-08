From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Fri, 8 Apr 2016 17:09:05 +0300
Message-ID: <20160408170809-mutt-send-email-mst@redhat.com>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604071720160.2967@virtualbox>
 <20160407184026-mutt-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604081309150.2967@virtualbox>
 <vpqtwjcnx7v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:09:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoX68-00024O-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 16:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbcDHOJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 10:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbcDHOJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 10:09:11 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84CC48B;
	Fri,  8 Apr 2016 14:09:10 +0000 (UTC)
Received: from redhat.com (vpn1-6-229.ams2.redhat.com [10.36.6.229])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u38E96Zx003470;
	Fri, 8 Apr 2016 10:09:07 -0400
Content-Disposition: inline
In-Reply-To: <vpqtwjcnx7v.fsf@anie.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291036>

On Fri, Apr 08, 2016 at 01:42:12PM +0200, Matthieu Moy wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	git revert -n deadbeef
> > 	git commit --squash deadbeef
> >
> > where "deadbeef" is the placeholder for the actual commit to revert.
> >
> > And indeed, I use exactly this song and dance quite frequently, *iff* my
> > intention is to drop a patch.
> >
> > A much better idea than co-opting the "Revert" commit message would be to
> > introduce a sibling to --fixup and --squash that you could call
> > --drop.
> 
> One could also add --fixup and --squash to "git revert", so the above
> would become
> 
>     git revert --squash deadbeef
> 
> In most cases, I find it simpler to just start a rebase -i and drop the
> commit from rebase's todo-list.

Absolutely, but moving rebase to near the commit to drop also
makes it easier to spot where the commit is.
Thoughts?

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
