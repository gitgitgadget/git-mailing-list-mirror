From: Jeff King <peff@peff.net>
Subject: Re: Bug: .gitconfig folder
Date: Thu, 28 May 2015 02:13:27 -0400
Message-ID: <20150528061327.GA3688@peff.net>
References: <5565C6A7.60007@gmx.es>
 <xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
 <20150527221813.GF23259@peff.net>
 <CAGZ79kbGyZLx=UYCi5JeSLj7keMhcX_eH3qtWs3O+PidRjye4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jorge <griffin@gmx.es>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 08:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxr4R-0007Fw-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 08:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbbE1GNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 02:13:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:37074 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751515AbbE1GNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 02:13:30 -0400
Received: (qmail 11063 invoked by uid 102); 28 May 2015 06:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 01:13:30 -0500
Received: (qmail 13747 invoked by uid 107); 28 May 2015 06:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 02:13:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 02:13:27 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbGyZLx=UYCi5JeSLj7keMhcX_eH3qtWs3O+PidRjye4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270125>

On Wed, May 27, 2015 at 03:24:47PM -0700, Stefan Beller wrote:

> What is our thinking for after-fact recovery attempts?
> Like we try the mmap first, if that fails we just use open to get the
> contents of
> the file. And when open fails, we can still print a nice error message?

For config, I think we could just open and read the file in the first
place. The data is not typically very big (and if you have a 3G config
file and git barfs with "out of memory", I can live with that).

-Peff
