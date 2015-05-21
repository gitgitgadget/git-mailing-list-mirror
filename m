From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of
 "packfile"
Date: Wed, 20 May 2015 22:04:03 -0400
Message-ID: <20150521020402.GA11619@peff.net>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
 <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
 <20150519222427.GA994@peff.net>
 <xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
 <xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
 <20150520194906.GA8421@peff.net>
 <xmqqzj4ylvto.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 04:04:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvFqL-00063T-CM
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 04:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbbEUCEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 22:04:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:33606 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753452AbbEUCEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 22:04:06 -0400
Received: (qmail 21502 invoked by uid 102); 21 May 2015 02:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 21:04:06 -0500
Received: (qmail 30222 invoked by uid 107); 21 May 2015 02:04:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 22:04:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 22:04:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj4ylvto.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269536>

On Wed, May 20, 2015 at 03:37:23PM -0700, Junio C Hamano wrote:

> In any case, even though I merged these three to 'next', I think we
> need to either revert 3/3 or do s/pack-file/packfile/ throughout the
> pack-protocol documentation.  The original has something like this:
> 
>     The pack-file MUST NOT be sent if the only command used is 'delete'.
> 
>     A pack-file MUST be sent if either create or update command is used,
>     even if the server already has all the necessary objects.  In this
>     case the client MUST send an empty pack-file.   The only time this
>     is likely to happen is if the client is creating
>     a new branch or a tag that points to an existing obj-id.
> 
> and these are explicitly referring to what EBNF defines as "pack-file".
> Changing them to "packfile" is simply wrong.

Yeah, I agree they should agree with the EBNF. And my inclination is for
"packfile", as it is refering to the concept of the on-the-wire packfile
data (there is no "file ending in .pack" in this context).

Which I guess argues for a further patch.

-Peff
