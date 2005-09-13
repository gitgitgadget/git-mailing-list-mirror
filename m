From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects by proxy servers
Date: Tue, 13 Sep 2005 08:59:26 -0700
Message-ID: <7vfys93qn5.fsf@assigned-by-dhcp.cox.net>
References: <20050913153858.GB24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 18:02:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFDBz-0001a9-EY
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 17:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVIMP73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 11:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVIMP72
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 11:59:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51903 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964820AbVIMP71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 11:59:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913155927.NYRR6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 11:59:27 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20050913153858.GB24405@master.mivlgu.local> (Sergey Vlasov's
	message of "Tue, 13 Sep 2005 19:38:58 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8468>

Sergey Vlasov <vsu@altlinux.ru> writes:

> This patch removes the "Pragma: no-cache" header from requests for all
> files except the pack list (objects/info/packs) and references
> (refs/*), which are really mutable and should not be cached.

Thanks.  What the patch does looks reasonable.

Do you know if we can use it for any reasonably recent version
of curl?  I seem to recall we already do things slightly
differently depending on LIBCURL_VERSION_NUM.
