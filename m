From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] fetch.c: Remove useless lookup_object_type() call in process()
Date: Wed, 21 Sep 2005 12:45:13 -0700
Message-ID: <7v3bnyurw6.fsf@assigned-by-dhcp.cox.net>
References: <20050921161829.GA20944@master.mivlgu.local>
	<20050921161855.896F1E010FC@center4.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 21:47:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIAWu-0001Od-6X
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 21:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVIUTpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVIUTpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 15:45:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2775 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751407AbVIUTpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 15:45:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921194515.JMMU28168.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 15:45:15 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9071>

Sergey Vlasov <vsu@altlinux.ru> writes:

> In all places where process() is called except the one in pull() (which
> is executed only once) the pointer to the object is already available,
> so pass it as the argument to process() instead of sha1 and avoid an
> unneeded call to lookup_object_type().

Agreed, except we probably would want to pass the expected type
to process() so that we can make sure the object is of that type,
perhaps?

Having said that, I am really happy that you seem to have fixed
it a lot better than my previous attempt, after which I was
really dissapointed that 'git clone' was still unusablly slow,
just walking commits in huge packs.

Thanks.
