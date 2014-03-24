From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] t4209: factor out helper function test_log_icase()
Date: Mon, 24 Mar 2014 17:10:06 -0400
Message-ID: <20140324211006.GA13728@sigill.intra.peff.net>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
 <1395508560-19893-4-git-send-email-l.s.r@web.de>
 <xmqqa9cfqwwp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSC8P-0002bE-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbaCXVKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:10:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:45997 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753904AbaCXVKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:10:08 -0400
Received: (qmail 7422 invoked by uid 102); 24 Mar 2014 21:10:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:10:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:10:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa9cfqwwp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244867>

On Mon, Mar 24, 2014 at 11:22:30AM -0700, Junio C Hamano wrote:

> > +test_log_icase() {
> > +	test_log $@ --regexp-ignore-case
> > +	test_log $@ -i
> 
> &&-cascade broken?  Will squash in an obvious fix.

I don't think so. This is happening outside of test_expect_success,
which is run by test_log. So adding a && means that if the first test
fails, we do not bother to run the second one at all, which is not what
we want.

-Peff
