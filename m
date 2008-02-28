From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Thu, 28 Feb 2008 21:43:19 +0100
Message-ID: <200802282143.19322.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpbi-00081b-E0
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbYB1UnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbYB1UnV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:43:21 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:43016 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbYB1UnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:43:21 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id C7A7913A78D;
	Thu, 28 Feb 2008 21:43:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7902D5B9E3;
	Thu, 28 Feb 2008 21:43:19 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <47C67E1A.5030304@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75448>

On Thursday 28 February 2008 10:25, Paolo Bonzini wrote:
> > +#ifdef __MINGW32__
> > +		strbuf_addch(out, ';');
> > +#else
> >  		strbuf_addch(out, ':');
> > +#endif
>
> Why not adding a PATH_SEPARATOR #define?

Because IMO it is obfuscating:

1. When you read through the code and see PATH_SEPARATOR, you still have
to go look how it's defined. Why? Because you always will ask: Is this 
about ':' vs. ';' or '/' vs. '\\'?

2. When you look for where ":" or ";" are treated, you'll end up at the
#define. Then you need an extra step to search for PATH_SEPARATOR.

-- Hannes
