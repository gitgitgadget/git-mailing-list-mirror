From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Wed, 22 Apr 2015 16:11:26 -0400
Message-ID: <20150422201126.GB29282@peff.net>
References: <xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
 <xmqqsibyo141.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
 <CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
 <CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
 <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
 <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
 <20150421232112.GA28316@peff.net>
 <CAGZ79kY_1JqKBiAL14me8ktqdQMJ1UuTy1_MgBY4jy5i_qX0uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:11:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0ze-0002zH-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbDVULa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:11:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:48832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751533AbbDVUL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:11:29 -0400
Received: (qmail 14671 invoked by uid 102); 22 Apr 2015 20:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:11:29 -0500
Received: (qmail 13713 invoked by uid 107); 22 Apr 2015 20:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:11:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 16:11:26 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kY_1JqKBiAL14me8ktqdQMJ1UuTy1_MgBY4jy5i_qX0uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267634>

On Wed, Apr 22, 2015 at 12:14:08PM -0700, Stefan Beller wrote:

> > FWIW, we already use a magic value of "25 extra" in open_packed_git_1. I
> > don't know if that means the number has been proven in practice, or if
> > it is simply that nobody actually exercises the pack_max_fds code. I
> > suspect it is the latter, especially since d131b7a (sha1_file.c: Don't
> > retain open fds on small packs, 2011-03-02).
> 
> 25 is equally sound as I could not find any hard calculation on that
> number in the
> history or code. I will change it to 25 in the next version of the patch.

FWIW, I think 32 is just fine, too, and the patch doesn't need re-rolled
because of this. I mostly wanted to point out that yes, indeed, we use
this "eh, a few dozen is probably enough" strategy elsewhere. Which
maybe, sort-of validates it. :)

-Peff
