From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/5] credential-cache: fix expiration calculation corner cases
Date: Thu, 15 Sep 2011 10:37:11 +0200
Message-ID: <201109151037.12248.trast@student.ethz.ch>
References: <20110914191704.GA23201@sigill.intra.peff.net> <20110914191757.GB28267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 10:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R47Rg-0002mO-Su
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 10:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab1IOIhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 04:37:14 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23931 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab1IOIhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 04:37:13 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 15 Sep
 2011 10:37:10 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 15 Sep
 2011 10:37:12 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110914191757.GB28267@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181448>

Jeff King wrote:
> However, there is a corner case: when we first start up, we
> have no credentials, and are waiting for a client to
> provide us with one. In this case, we ended up handing
> complete junk for the timeout argument to poll(). On some
> systems, this caused us to just wait a long time for the
> client (which usually showed up within a second or so). On
> OS X, however, the system quite reasonably complained about
> our junk value with EINVAL.

Tested, works now.  Thanks!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
