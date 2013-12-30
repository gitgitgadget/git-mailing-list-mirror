From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 12:20:42 -0800
Message-ID: <20131230202042.GJ27213@leaf>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
 <20131224063726.19560.61859.chriscool@tuxfamily.org>
 <xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 21:21:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxjKc-00085r-AM
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 21:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab3L3UUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 15:20:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59945 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab3L3UUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 15:20:53 -0500
Received: from mfilter6-d.gandi.net (mfilter6-d.gandi.net [217.70.178.135])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id BE69141C05D;
	Mon, 30 Dec 2013 21:20:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter6-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter6-d.gandi.net (mfilter6-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id ntUY2DbrIYaA; Mon, 30 Dec 2013 21:20:50 +0100 (CET)
X-Originating-IP: 50.43.14.201
Received: from leaf (static-50-43-14-201.bvtn.or.frontiernet.net [50.43.14.201])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0315A41C04F;
	Mon, 30 Dec 2013 21:20:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239821>

On Mon, Dec 30, 2013 at 09:19:55AM -0800, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > +# Do not remove trailing spaces below!
> > +cat >complex_message_trailers <<'EOF'
> > +Fixes: 
> > +Acked-by: 
> > +Reviewed-by: 
> > +Signed-off-by: 
> > +EOF
> 
> Just a hint.  I think it is far safer and robust over time to do
> something like this:
> 
> 	sed -e 's/ Z$/ /' <<-\EOF
>         Fixes: Z
>         Acked-by: Z
>         EOF
> 
> instead of a comment, which can warn human developers but does not
> do anything to prevent their editors' auto-fix features from kicking
> in.

This, but for simplicity, since every line needs the trailing space, why
not just use 's/$/ /' and drop the ' Z' on every line?

</bikeshed>

- Josh Triplett
