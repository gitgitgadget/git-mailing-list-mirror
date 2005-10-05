From: Vincent Hanquez <vincent@snarc.org>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Thu, 6 Oct 2005 00:27:31 +0200
Message-ID: <20051005222730.GA16593@snarc.org>
References: <20051005191300.GC17475@hexapodia.org> <7virwbu4wz.fsf@assigned-by-dhcp.cox.net> <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 00:28:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENHje-00068I-Na
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 00:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVJEW1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 18:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVJEW1d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 18:27:33 -0400
Received: from darwin.snarc.org ([81.56.210.228]:30617 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1030398AbVJEW1c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 18:27:32 -0400
Received: by darwin.snarc.org (Postfix, from userid 1000)
	id 230B24BE18; Thu,  6 Oct 2005 00:27:31 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9741>

On Wed, Oct 05, 2005 at 02:38:42PM -0700, Junio C Hamano wrote:
> Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
> do not see any such size limit (other than exceeding the total
> machine memory size, probably reported by alloc_page() failing)
> imposed there.  Am I looking at the wrong place?

well at least the len of argv is limited by ~32K (i386) by: 

bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
...
bprm->argc = count(argv, bprm->p / sizeof(void *));

-- 
Vincent Hanquez
