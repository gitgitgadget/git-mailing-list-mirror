From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Wed, 6 Apr 2016 20:16:20 +0300
Message-ID: <20160406201509-mutt-send-email-mst@redhat.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
 <vpqlh4qbrnt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anr4A-0002x2-No
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbcDFRQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 13:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbcDFRQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 13:16:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CB03C000B2A;
	Wed,  6 Apr 2016 17:16:23 +0000 (UTC)
Received: from redhat.com (vpn1-7-173.ams2.redhat.com [10.36.7.173])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u36HGLCa009761;
	Wed, 6 Apr 2016 13:16:21 -0400
Content-Disposition: inline
In-Reply-To: <vpqlh4qbrnt.fsf@anie.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290856>

On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > I have this in .git/config
> >
> > [trailer "r"]
> >         key = Reviewed-by
> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> > [trailer "s"]
> >         key = Signed-off-by
> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> >
> > whenever I run git interpret-trailers -t r I see these lines added:
> >
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >
> > Why is Reviewed-by repeated?  Bug or feature?
> 
> The first two lines are added unconditionally:
> 
> $ echo | git interpret-trailers 
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> 
> The last line is added because you've asked for it with --trailer r.
> 
> I don't think it's currently possible to get the behavior you seem to
> expect, ie. to define trailer tokens fully (key and value) in your
> config file but use them only on request.
> 
> (BTW, I think you wanted a closing > at the end)

Is this worth fixing? It doesn't look like a behaviour anyone
would want...

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
