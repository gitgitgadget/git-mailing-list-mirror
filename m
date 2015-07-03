From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] list-object: add get_commit_count function
Date: Fri, 3 Jul 2015 14:36:53 -0400
Message-ID: <20150703183653.GA11183@peff.net>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqqtwtl3zd7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 20:37:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5pd-0000HE-UO
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 20:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbbGCSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 14:36:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:55444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755384AbbGCSg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 14:36:56 -0400
Received: (qmail 19051 invoked by uid 102); 3 Jul 2015 18:36:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 13:36:56 -0500
Received: (qmail 14885 invoked by uid 107); 3 Jul 2015 18:37:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 14:37:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jul 2015 14:36:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwtl3zd7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273309>

On Fri, Jul 03, 2015 at 10:49:40AM -0700, Junio C Hamano wrote:

> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
> 
> > Moving commit counting from rev-list into list-object which is a step
> > toward letting git log do counting as well.
> >
> > Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
> > ---
> 
> No way.  Look at the things provided by list-objects.c API.  They
> are not about formatting outputs.  printf() calls do not belong
> there.

Moreover, if we are going to provide an abstracted function to show the
commit count, we would also need to provide one to _create_ the count.
IOW, this get_commit_count, wherever it goes, should be accompanied by
the matching code that is put into "show_commit" in patch 2.

-Peff
