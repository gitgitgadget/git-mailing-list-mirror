From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: exit with non-zero status upon error from
 fsck_obj()
Date: Tue, 9 Sep 2014 18:07:09 -0400
Message-ID: <20140909220709.GA14029@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTZH-00057T-H5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaIIWHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:07:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:46207 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751387AbaIIWHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:07:12 -0400
Received: (qmail 19038 invoked by uid 102); 9 Sep 2014 22:07:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:07:12 -0500
Received: (qmail 11173 invoked by uid 107); 9 Sep 2014 22:07:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 18:07:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 18:07:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256713>

On Tue, Sep 09, 2014 at 03:03:33PM -0700, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> Date: Fri, 29 Aug 2014 16:31:46 -0400
> 
> Upon finding a corrupt loose object, we forgot to note the error to
> signal it with the exit status of the entire process.
> 
> [jc: adjusted t1450 and added another test]
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I think your fix is a right one that catches all the "we can
>    parse minimally for the purpose of 'struct object' class system,
>    but the object is semantically broken" cases, as fsck_obj() is
>    where such a validation should all happen.
> 
>    I can haz a sign off?  Thanks.

Thanks, I think this is a step forward regardless of other conversation
on the exit code, as it is just harmonizing loose and packed object
behavior.

Signed-off-by: Jeff King <peff@peff.net>

-Peff
