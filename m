From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Tue, 3 Sep 2013 11:44:54 +0300
Message-ID: <20130903084454.GC18901@redhat.com>
References: <20130826165747.GA30788@redhat.com>
 <20130831192250.GA3823@redhat.com>
 <20130903063535.GA3608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 10:43:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGmCV-0002Nz-V8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 10:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab3ICIm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 04:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487Ab3ICIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 04:42:58 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r838gqp0017644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 3 Sep 2013 04:42:52 -0400
Received: from redhat.com (vpn1-7-77.ams2.redhat.com [10.36.7.77])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r838go1a002112;
	Tue, 3 Sep 2013 04:42:51 -0400
Content-Disposition: inline
In-Reply-To: <20130903063535.GA3608@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233710>

On Tue, Sep 03, 2013 at 02:35:35AM -0400, Jeff King wrote:
> On Sat, Aug 31, 2013 at 10:22:50PM +0300, Michael S. Tsirkin wrote:
> 
> > On Mon, Aug 26, 2013 at 07:57:47PM +0300, Michael S. Tsirkin wrote:
> > > Consider [anything]-by: a valid signature.
> > > This includes Tested-by: Acked-by: Reviewed-by: etc.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Ping.
> > Any opinion on whether this change is acceptable?
> 
> I was left confused by your commit message, as it wasn't clear to me
> what a "signature" is. But the point of it seems to be that people
> mention others in commit messages using "X-by:" pseudo-headers besides
> "signed-off-by", and you want to cc them along with the usual S-O-B.
> 
> That seems like a reasonable goal, but I have two concerns.
> 
> One, I would think the utility of this would be per-project, depending
> on what sorts of things people in a particular project put in
> pseudo-headers.  Grepping the kernel history shows that most X-by
> headers have a person on the right-hand side, though quite often it is
> not a valid email address (on the other hand, quite a few s-o-b lines in
> the kernel do not have a valid email).
> 
> And two, the existing options for enabling/disabling this code all
> explicitly mention signed-off-by, which becomes awkward. You did not
> update the documentation in your patch, but I think you would end up
> having to explain that "--supress-cc=sob" and "--signed-off-by-cc"
> really mean "all pseudo-header lines ending in -by".
> 
> So I think it might be a nicer approach to introduce a new "suppress-cc"
> class that means "all pseudo-header tokens ending in -by" or similar.
> We might even want the new behavior on by default, but it would at least
> give the user an escape hatch if their project generates a lot of false
> positives.
> 
> -Peff

I guess there's always cccmd, no?

-- 
MST
