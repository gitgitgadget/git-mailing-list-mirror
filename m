From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 07:36:51 -0700
Message-ID: <20090911143651.GE1033@spearce.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com> <20090911133313.GF2582@inocybe.localdomain> <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com> <20090911141730.GA384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 16:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm7FC-0000J1-1j
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 16:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZIKOgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 10:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZIKOgs
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 10:36:48 -0400
Received: from george.spearce.org ([209.20.77.23]:48920 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZIKOgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 10:36:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 978713815E; Fri, 11 Sep 2009 14:36:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090911141730.GA384@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128196>

Jeff King <peff@peff.net> wrote:
> I also question why it is using "git config --list" at all in snippets
> like this:
> 
>         for i in $(git --git-dir="$d" config --list); do
>                 case "$i" in
>                 remote.*.url=*)
>                         i="${i#remote.}"
>                         echo "${i/.url=*/}"
>                         ;;
>                 esac
>         done
> 
> instead of just using "git config --get-regexp 'remote\..*\.url'", which
> would be slightly more efficient, and also doesn't have this bug. ;)

F'king oversight.  You are right, this should be --get-regexp.
There isn't a reason here, probably other than "I forgot about
--get-regexp when I wrote the original code".

-- 
Shawn.
