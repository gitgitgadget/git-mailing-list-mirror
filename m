From: Sam Vilain <sam@vilain.net>
Subject: Re: repo.or.cz wishes?
Date: Tue, 28 Aug 2007 10:58:01 +1200
Message-ID: <46D356F9.1010506@vilain.net>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org> <20070827004153.GN1219@pasky.or.cz> <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org> <mj+md-20070827.195605.14967.albireo@ucw.cz> <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Martin Mares <mj@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPnr4-0006F7-4X
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXH0W6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbXH0W6l
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:58:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33376 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbXH0W6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 18:58:40 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 86C2E21CFA9; Tue, 28 Aug 2007 10:58:38 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 51E0C21CFA2;
	Tue, 28 Aug 2007 10:58:33 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56892>

Linus Torvalds wrote:
>  - if you really think that the above is sensible, then explain why.
> 
>  - if you think that is TOTALLY IDIOTIC, then explain why "ssh://" is so 
>    magically special that it would somehow make sense to say "git+" for 
>    it?

This is also useful for foreign SCM support; the idea of supporting
svn+ssh:// "directly" with git remote and the likes.

I don't usually write git+ssh://, but I do consider it to be the form
which is more in the spirit of application interoperability.  It says
what it is, which is ssh tunnelled git protocol.

> As to your TLS example: if we were to do "git over TLS", it would make 
> perfect sense to use either "tls://" (although "gits://" might be more 
> natural, not because tls is wrong, but because people have gotten used to 
> "https://") if we were to have a "secure git" port. Or maybe we'd use the 
> same port number that we already have assigned for git, and just add some 
> "use TLS to authenticate/encrypt", and use "tls://" for that. It makes 
> perfect sense.

The scheme is bad because it doesn't integrate with other appliations.
Seeing the URI in a web page they have no way of knowing which
application or port this tls:// URI refers to.  It's not *universal*.

This is fine for URIs passed into git, but bad if you want to link to it
from elsewhere.

Sam.
