From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] name-hash.c: always initialize dir_next pointer
Date: Tue, 1 Nov 2011 18:39:49 -0400
Message-ID: <20111101223949.GA15578@sigill.intra.peff.net>
References: <4EB070D2.4040709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLMzt-0002G8-10
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab1KAWjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 18:39:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab1KAWjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 18:39:52 -0400
Received: (qmail 8958 invoked by uid 107); 1 Nov 2011 22:45:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Nov 2011 18:45:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2011 18:39:49 -0400
Content-Disposition: inline
In-Reply-To: <4EB070D2.4040709@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184603>

On Tue, Nov 01, 2011 at 11:21:06PM +0100, Johannes Sixt wrote:

> Test t2021-checkout-overwrite.sh reveals a segfault in 'git add' on a
> case-insensitive file system when git is compiled with XMALLOC_POISON
> defined. The reason is that 2548183b (fix phantom untracked files when
> core.ignorecase is set) added a new member dir_next to struct cache_entry,
> but forgot to initialize it in all cases.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  You can also insert git config core.ignorecase true before the first
>  test script in t2021 to see the segfault.

Yikes, thanks.

-Peff
