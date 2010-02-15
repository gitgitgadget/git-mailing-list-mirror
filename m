From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 02:49:22 -0500
Message-ID: <20100215074922.GA5549@coredump.intra.peff.net>
References: <4B78C4D3.90407@gmail.com>
 <7vzl3bj95l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvhq-0006hA-Vq
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab0BOHtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 02:49:18 -0500
Received: from peff.net ([208.65.91.99]:34763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab0BOHtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:49:18 -0500
Received: (qmail 15318 invoked by uid 107); 15 Feb 2010 07:49:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 02:49:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 02:49:22 -0500
Content-Disposition: inline
In-Reply-To: <7vzl3bj95l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139993>

On Sun, Feb 14, 2010 at 10:38:30PM -0800, Junio C Hamano wrote:

> > +	test git rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
> 
> I don't think this would ever work with "test" at the beginning.

Oops. I totally missed that when reviewing the patch. :-/

Thinking on this a bit more, I think Gabriel's script is a little
broken. It sets NONGIT_OK to not have a git repository, but then it
requires a working tree, which doesn't make any sense.

That being said, I think it is still a good change, as the correct error
message is better than the shell barfing.

-Peff
