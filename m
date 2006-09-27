From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix nextfile() and add prevfile()
Date: Wed, 27 Sep 2006 10:15:45 +1000
Message-ID: <17689.49841.913304.878599@cargo.ozlabs.ibm.com>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
	<7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
	<873bae3b5x.fsf_-_@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 02:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSN5j-0000dy-Tr
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 02:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWI0APz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 20:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWI0APz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 20:15:55 -0400
Received: from ozlabs.org ([203.10.76.45]:60867 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750778AbWI0APy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 20:15:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2A47267B6D; Wed, 27 Sep 2006 10:15:53 +1000 (EST)
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
In-Reply-To: <873bae3b5x.fsf_-_@duaron.myhome.or.jp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27840>

OGAWA Hirofumi writes:

> The current nextfile() jumps to last hunk, but I think this is not
> intention, probably, it's forgetting to add "break;". And this
> patch also adds prevfile(), it jumps to previous hunk.

I think your prevfile isn't quite right - I don't think it will do the
right thing if $loc is past the last entry in $difffilestart.  Don't
you want the "$ctext yview $prev" after the loop?

Paul.
