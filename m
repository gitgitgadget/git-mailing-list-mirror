From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix buffer overflow in ce_flush().
Date: Sun, 11 Sep 2005 11:43:45 -0700
Message-ID: <7vpsrfsavy.fsf@assigned-by-dhcp.cox.net>
References: <20050911132747.GA26401@mayhq.zapto.org>
	<Pine.LNX.4.58.0509111050040.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Qingning Huo <qhuo@mayhq.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 20:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWnt-000266-E3
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVIKSnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVIKSnr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:43:47 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19906 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965018AbVIKSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 14:43:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911184346.SJPG7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 14:43:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111050040.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 10:54:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8319>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 11 Sep 2005, Qingning Huo wrote:
>>
>> Fix buffer overflow in ce_flush().
>
> Thanks, good find. However, I'd almost prefer the simpler patch below..
>
> 		Linus

Hmph.  I thought ce_flush is not in the fast path so the extra
check would not hurt...
