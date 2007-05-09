From: David Miller <davem@davemloft.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 16:23:01 -0700 (PDT)
Message-ID: <20070509.162301.48802460.davem@davemloft.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu May 10 01:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlvVA-0004Hq-09
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbXEIXXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759292AbXEIXXE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:23:04 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42982
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756557AbXEIXXB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 19:23:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 69EEB290133;
	Wed,  9 May 2007 16:23:01 -0700 (PDT)
In-Reply-To: <7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46811>

From: Junio C Hamano <junkio@cox.net>
Date: Wed, 09 May 2007 15:59:23 -0700

> The above sequence is called before we create the new directory
> and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
> we need to explicitly say /bin/pwd or somesuch...

Indeed:

[davem@hera ~]$ pwd
/home/davem
[davem@hera ~]$ cd git
[davem@hera git]$ pwd
/home/davem/git
[davem@hera git]$ /bin/pwd
/home/ftp/pub/scm/linux/kernel/git/davem
[davem@hera git]$ 
