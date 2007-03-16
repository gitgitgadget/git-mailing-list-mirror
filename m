From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 15:38:22 -0300
Organization: Mandriva
Message-ID: <20070316153822.5c842e69@localhost>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHKT-0008Vf-9i
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbXCPSif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbXCPSie
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:38:34 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:33524 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbXCPSid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:38:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 838392AE81;
	Fri, 16 Mar 2007 15:38:31 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ZcUgjRM6ciJt; Fri, 16 Mar 2007 15:38:25 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id DE1022AE77;
	Fri, 16 Mar 2007 15:38:24 -0300 (BRT)
In-Reply-To: <20070316140855.GE4489@pasky.or.cz>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42392>

Em Fri, 16 Mar 2007 15:08:55 +0100
Petr Baudis <pasky@suse.cz> escreveu:

| On Fri, Mar 16, 2007 at 02:47:15PM CET, Luiz Fernando N. Capitulino wrote:
| >  We could start by fixing the got-an-error-die behaivor and
| > define a _experimental_ API (just a few functions) just to get
| > data out of git.
| > 
| >  This would be enough to write the Perl binding I think?
| 
| Actually, well, I've already done this. :-)

 Not exactly, at least not the way I think it should be done.

| The trouble begins when you want to access multiple repositories from
| the same process, etc. Without that, writing the Perl binding is
| trivial; there's already a hook the binding can use to catch dies, I've
| added it.
| 
| So, the main point of the work is to define a _good_ API and get rid of
| the static state, I guess.

 Yes, the set_*_routine()s seems a workaround to me, you're only fixing
die()'s final effect.

 I think the right solution is to get rid of die() from functions that
are supposed to be an interface, set errno if needed and return -1
or NULL.

 That looks a lot of work BTW, but I'll be pleased to work on it.

 Is there more things like the set_*_routine()s added to fix
other problems?

-- 
Luiz Fernando N. Capitulino
