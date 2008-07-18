From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Move launch_editor() from builtin-tag.c to editor.c
Date: Fri, 18 Jul 2008 03:26:04 +0200
Message-ID: <20080718012604.GF8421@leksak.fem-net>
References: <1216341378-15444-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJekd-0001sD-SM
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbYGRB0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbYGRB0K
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:26:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:53094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754168AbYGRB0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:26:09 -0400
Received: (qmail invoked by alias); 18 Jul 2008 01:26:07 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp052) with SMTP; 18 Jul 2008 03:26:07 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+LqgQ1GjKLInZyi75O2jPpMq1V410dKP2j/8j6Zq
	pHqL46+wFGTVrJ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJejU-0005UN-1E; Fri, 18 Jul 2008 03:26:04 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88947>

Hi,

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 18 Jul 2008, Stephan Beyer wrote:
> 
> > launch_editor() is declared in strbuf.h but defined in builtin-tag.c. 
> > This patch moves launch_editor() into a new source file editor.c, but 
> > keeps the declaration in strbuf.h.
> 
> Sorry, but that has been tried before.  Junio pointed out that 
> launch_editor() iss too die()-happy, and that the messages are too bound 
> to the current callers.

Ah, a short note: this is not a real "libify" patch. It is more an
"Oh, launch_editor is used for git-commit and git-tag, but it is only
 defined in builtin_tag.c, but declared (as libgit.a member) in strbuf.h,
 so let's move it" patch without further changes.

But of course you and Junio are right.

> You need to at least provide an add-on patch to fix both issues.

Tomorrow, I need sleep first :)

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
