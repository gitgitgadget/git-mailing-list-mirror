From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] builtin-bundle create - use lock_file
Date: Sun, 12 Aug 2007 14:22:55 -0400
Message-ID: <46BF4FFF.1090309@verizon.net>
References: <11869231822803-git-send-email-mdl123@verizon.net>
 <11869280491451-git-send-email-mdl123@verizon.net>
 <7v1we8k5qx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKI5g-0003sa-Bt
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765216AbXHLSXB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763162AbXHLSXB
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:23:01 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:43495 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761372AbXHLSXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 14:23:00 -0400
Received: from [192.168.100.117] ([71.246.233.117])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JMO00A3AB27MVB7@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 13:22:56 -0500 (CDT)
In-reply-to: <7v1we8k5qx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55696>

Junio C Hamano wrote:
> When you exit before committing lockfiles
> you hold, atexit handler rolls back and unlink them for you.
>
> The following might be a better replacement.
>
> By the way, by using lockfile's "create temporary, generate into
> it and then rename to final", we are allowing an overwrite of an
> existing bundle, which we did not allow earlier.  Is this check
> something we would want to preserve?
>   
Ack - yours is much better. Thanks for the lesson. Also, the former 
behavior of not allowing overwrite of an existing file was (at least in 
my opinion) very un-git'ish so I am happy to see that go.

Mark
