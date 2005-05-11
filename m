From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 20:30:29 +0000
Organization: linutronix
Message-ID: <1115843429.22180.90.camel@tglx>
References: <1115839456.22180.79.camel@tglx>
	 <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 22:24:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVxin-0003vH-0p
	for gcvg-git@gmane.org; Wed, 11 May 2005 22:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVEKU3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 16:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVEKU3p
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 16:29:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52353
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261284AbVEKU3i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 16:29:38 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 4CBAF65C003;
	Wed, 11 May 2005 22:29:37 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id C1B812807D;
	Wed, 11 May 2005 22:29:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 13:03 -0700, Junio C Hamano wrote:
> Suggestion.  How about renaming "--to_sha1" to "--since"?  If
> you do not like "--since", then "--stop-at" would also be good.

No preference here :)

> Suggestion.  Instead of running sha1_to_hex on the SHA1 of the
> commit and comparing strings for every commit you encounter, how
> about keeping 20-byte raw SHA1 of to_sha1 and doing memcmp of
> 20-byte?  That way you would also detect malformed --to-sha1
> parameter when you do the initial conversion upon argument
> parsing.  Also the argument parsing using get_sha1() would give
> you an added benefit of using mnemonics (tag and heads).

Makes sense. I just used the sha1_to_hex as it is called anyway for the
printf 

> What do you think about this revision?

You moved the stop behind the printf which is inconsistent to the other
stop conditions, but thats a pure cosmetic question as long as it stays
that way for ever. 

Otherwise not objections.

tglx


