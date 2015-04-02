From: Jeff King <peff@peff.net>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 15:35:24 -0400
Message-ID: <20150402193524.GA21555@peff.net>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
 <20150402180914.GA19081@peff.net>
 <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
 <20150402191452.GA20420@peff.net>
 <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
 <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydktq-0004nc-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbbDBTfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:35:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:41513 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752985AbbDBTf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:35:26 -0400
Received: (qmail 15716 invoked by uid 102); 2 Apr 2015 19:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 14:35:26 -0500
Received: (qmail 14760 invoked by uid 107); 2 Apr 2015 19:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 15:35:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 15:35:24 -0400
Content-Disposition: inline
In-Reply-To: <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266663>

On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:

> Ah, understand. Here's my project URL for 'remote "origin"' with a
> more meaningful representation of their internal FQDN:
> 
> 	url = ssh://rwoodbury@systemname.groupname.online:/opt/git/inventory.git
> 
> The "online" is their literal internal TLD.

Thanks. The problem is the extra ":" after "online"; your URL is
malformed. You can just drop that colon entirely.

I do not think we need to support this syntax going forward (the colon
is meaningless here, and our documentation is clear that it should go
with a port number), but on the other hand, it might be nice to be more
liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten to see
whether supporting that would hurt some of the other cases, or whether
it would make the code too awkward.

-Peff
