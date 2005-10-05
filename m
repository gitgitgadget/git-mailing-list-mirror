From: Junio C Hamano <junkio@cox.net>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 05 Oct 2005 14:38:42 -0700
Message-ID: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
	<7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
	<7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 23:40:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENGyO-0002HV-9E
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVJEVip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVJEVip
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:38:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:65183 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030384AbVJEVio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:38:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005213834.PPGY29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 17:38:34 -0400
To: git@vger.kernel.org
In-Reply-To: <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 05 Oct 2005 14:16:04 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9734>

Junio C Hamano <junkio@cox.net> writes:

> 1. As a stop gap measure, so that your Linux kernel work can
>    continue, please bump MAX_NEEDS definition in upload-pack.c
>    from 256 to a bit higher.  That controls the number of
>    40-letter SHA1 given to underlying rev-list via execvp(), so
>    it cannot be _too_ big like 1M, lest it exceeds the exec
>    argument buffer limit.

Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
do not see any such size limit (other than exceeding the total
machine memory size, probably reported by alloc_page() failing)
imposed there.  Am I looking at the wrong place?
