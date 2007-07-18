From: Geoff Richards <qef@ungwe.org>
Subject: Re: Character set for the HTML documentation
Date: Wed, 18 Jul 2007 06:26:15 +0100
Message-ID: <20070718052615.GA4441@ungwe.org>
References: <469D516B.6030806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB23Z-0004Rq-SY
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 07:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXGRF0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 01:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXGRF0Y
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 01:26:24 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:17539 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751349AbXGRF0X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 01:26:23 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20070718052618.SKPF4.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 18 Jul 2007 06:26:18 +0100
Received: from blacktooth.laxan.com ([82.3.192.247])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20070718052618.UJFJ17393.aamtaout02-winn.ispmail.ntl.com@blacktooth.laxan.com>
          for <git@vger.kernel.org>; Wed, 18 Jul 2007 06:26:18 +0100
Received: from qef by blacktooth.laxan.com with local (Exim 4.67)
	(envelope-from <qef@laxan.com>)
	id 1IB23D-0004Bk-Uj
	for git@vger.kernel.org; Wed, 18 Jul 2007 06:26:15 +0100
Content-Disposition: inline
In-Reply-To: <469D516B.6030806@zytor.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52827>

On Tue, Jul 17, 2007 at 04:31:55PM -0700, H. Peter Anvin wrote:
> I just got the following email:
> 
> > The Git documentation at
> > <http://www.kernel.org/pub/software/scm/git/docs/user-manual.html> is
> > encoded in ISO 8859-1, but it is being served with a content-type header
> > of "text/plain; charset=UTF-8".
> > 
> > The content-type header overrides the value declared in the <meta> tag
> > of the HTML document, so this causes browsers to render the
> > documentation incorrectly.
> > 
> > Apologies if this is a well known issue and you get a lot of mail like
> > this BTW, just don't LART me too hard. ;)
> 
> The fact that browsers behave this way is of course a bug, but it's a
> common one.  Can we switch the documentation over to UTF-8, this is 2007
> after all...?

Unfortunately, it's not a bug.  The correct thing for a browser to do is
give the 'Content-Type' HTTP header priority over the <meta> element.
It's defined in an RFC somewhere.

Best thing to do is tell Apache (or whatever) not to send the HTTP
header ("AddDefaultCharset off"), and make sure all the HTML has a
correct <meta> element specifying the encoding.

And yes, putting everything in UTF-8 unless you've got a specific reason
not to is probably going to make life simpler as well.

HTH,
   geoff
