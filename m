From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] Rename struct diff_filespec's sha1_valid member.
Date: Tue, 7 Jun 2016 02:23:24 -0400
Message-ID: <20160607062324.GA29484@sigill.intra.peff.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
 <20160607005716.69222-5-sandals@crustytoothpaste.net>
 <575667E6.7030509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 08:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAAQG-0003OW-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 08:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbcFGGX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 02:23:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:50207 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbcFGGX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 02:23:28 -0400
Received: (qmail 20731 invoked by uid 102); 7 Jun 2016 06:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 02:23:27 -0400
Received: (qmail 26367 invoked by uid 107); 7 Jun 2016 06:23:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 02:23:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 02:23:24 -0400
Content-Disposition: inline
In-Reply-To: <575667E6.7030509@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296601>

On Tue, Jun 07, 2016 at 08:21:26AM +0200, Johannes Sixt wrote:

> > diff --git a/combine-diff.c b/combine-diff.c
> > index f39be434..a20caa80 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -1269,7 +1269,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
> >   		pair->one[i].path = p->path;
> >   		pair->one[i].mode = p->parent[i].mode;
> >   		oidcpy(&pair->one->oid, &p->parent[i].oid);
> > -		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
> > +		pair->one->oid_valid = !is_null_oid(&p->parent[i].oid);
> 
> Is this transformation correct?

Or the oidcpy() above it, which was introduced in patch 3.

-Peff
