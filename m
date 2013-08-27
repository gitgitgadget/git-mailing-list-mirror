From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH] config: do not use C function names as struct members
Date: Tue, 27 Aug 2013 02:56:01 +0200
Message-ID: <20130827005601.GA14679@blizzard>
References: <521BB643.304@gmail.com>
 <20130826201804.GB13130@blizzard>
 <521BBA98.7010102@gmail.com>
 <20130826203154.GA21357@blizzard>
 <20130826205901.GC23598@sigill.intra.peff.net>
 <20130826215718.GB6219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lance <lancethepants@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 02:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE7Zu-0001A3-4g
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 02:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3H0A4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 20:56:09 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:24335 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab3H0A4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 20:56:08 -0400
Received: from localhost (p57B4037E.dip0.t-ipconnect.de [87.180.3.126]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 7647a56e;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Tue, 27 Aug 2013 02:56:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130826215718.GB6219@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233040>

On Mon, Aug 26, 2013 at 05:57:18PM -0400, Jeff King wrote:
> On Mon, Aug 26, 2013 at 04:59:01PM -0400, Jeff King wrote:
> 
> > Hmm. I wonder if fgetc is a macro in uclibc? Just grepping their
> > stdio.h, it looks like that is a possibility.
> > 
> > I think they are probably wrong to do so (but I'd have to check the
> > standard). However, the cleaner workaround would probably be to call the
> > fgetc struct member something else.
> 
> Nope, it's allowed. I think we should do the patch below:
> 
> -- >8 --
> Subject: config: do not use C function names as struct members
> [...]
> 
> Instead, we can simply use non-colliding names.

Yes, this sounds like a better idea to me. So, FWIW, +1 from me.

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> [...]
