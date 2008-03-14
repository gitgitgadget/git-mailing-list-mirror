From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 09:35:15 +0100
Message-ID: <20080314083515.GX10103@mail-vs.djpig.de>
References: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 09:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja5Oi-00019p-Jh
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 09:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYCNIfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 04:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYCNIfb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 04:35:31 -0400
Received: from pauli.djpig.de ([78.46.38.139]:41237 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbYCNIfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 04:35:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 5A8E190073;
	Fri, 14 Mar 2008 09:35:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sb-nfd69e3KT; Fri, 14 Mar 2008 09:35:16 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 852AC9006E;
	Fri, 14 Mar 2008 09:35:16 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Ja5Nj-0005i6-Eu; Fri, 14 Mar 2008 09:35:15 +0100
Content-Disposition: inline
In-Reply-To: <20080313231413.27966.3383.stgit@rover>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77191>

On Fri, Mar 14, 2008 at 12:14:14AM +0100, Petr Baudis wrote:
> +# projects list cache for busy sites with many projects;
> +# if you set this to non-zero, it will be used as the cached
> +# index lifetime in minutes
> +# the cached list version is stored in /tmp and can be tweaked
> +# by other scripts running with the same uid as gitweb - use this
> +# only at secure installations; only single gitweb project root per
> +# system is supported!
> +our $projlist_cache_lifetime = 0;

I think that would a situation where a uppercase disclaimer would be
appropriate ;)

In addition to the race condition problem mentioned in other mails it
also has a symlink vulnerability.

I think one should seriously consider reusing an existing caching
solution instead of reinventing the wheel here.
There are a lot of CPAN modules to do that and at least apache also
has modules for that which you could use without any code changes
at all...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
