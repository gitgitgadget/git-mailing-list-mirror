From: Sam Hocevar <sam@zoy.org>
Subject: Re: git-grep Bus Error
Date: Mon, 9 Mar 2009 00:41:41 +0100
Message-ID: <20090308234141.GJ12880@zoy.org>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 00:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgSeK-0006ge-Kk
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 00:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbZCHXlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 19:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZCHXls
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 19:41:48 -0400
Received: from poulet.zoy.org ([80.65.228.129]:49784 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbZCHXls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 19:41:48 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 3E6A01202FC; Mon,  9 Mar 2009 00:41:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112653>

On Sun, Mar 08, 2009, Brian Gernhardt wrote:

> >			printf( "%d %d %d",
> >				  match.rm_so, match.rm_eo,
> >				  match.rm_eo - match.rm_so );
> 
> .gitignore:0 0 3\033[31m\033[1m(nugit
> .mailmap:23 0 26(null)\033[31m\033[1m(nugit-shortlog to fix a few  
> botched name translations-shortlog to fix a few botched name  
> translations
> 
> And now I'm baffled.  Apparently my computer thinks 0 - 0 == 3 and 0 -  
> 23 == 26.

   rm_so and rm_eo are ints on Linux but off_t's on Darwin, hence
probably int64_t's here. You should cast the arguments.

-- 
Sam.
