From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc0
Date: Fri, 1 Nov 2013 04:52:56 -0400
Message-ID: <20131101085256.GA28637@sigill.intra.peff.net>
References: <xmqqtxfy9zee.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 09:53:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcATY-0002ZC-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 09:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab3KAIw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 04:52:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:59818 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937Ab3KAIw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 04:52:59 -0400
Received: (qmail 28732 invoked by uid 102); 1 Nov 2013 08:52:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Nov 2013 03:52:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Nov 2013 04:52:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtxfy9zee.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237204>

On Wed, Oct 30, 2013 at 03:17:45PM -0700, Junio C Hamano wrote:

> Git v1.8.5 Release Notes (draft)
> ========================
> [...]
>  * A packfile that stores the same object more than once is broken and
>    will be rejected by "git index-pack" that is run when receiving
>    data over the wire.

We ended up scrapping the index-pack patch, in favor of just using the
existing --strict check. So the correct statement is more like '...will
be rejected by "git index-pack --strict"'. But that is not a new
behavior in v1.8.5. :)

We did fix bugs in GIT_USE_LOOKUP related to duplicates in commit
171bdac. That may not be exciting enough to mention in the release
notes, though, as the code is not even used by default.

-Peff
