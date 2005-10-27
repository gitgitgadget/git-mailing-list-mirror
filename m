From: Junio C Hamano <junkio@cox.net>
Subject: Re: [TENTATIVE PATCH] Complain loudly, dying, when a ref is invalid
Date: Thu, 27 Oct 2005 13:45:26 -0700
Message-ID: <7voe5a1yft.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vacgu3hta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510272125580.28705@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 22:48:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVEdJ-0004Co-Px
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 22:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVJ0Upa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 16:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVJ0Up3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 16:45:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46835 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932235AbVJ0Up2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 16:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027204527.CEIK9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 16:45:27 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510272125580.28705@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 27 Oct 2005 21:28:03 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10727>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 27 Oct 2005, Junio C Hamano wrote:
>
>> Not that the current loop is any better for that purpose.  We
>> silently ignore not just dangling ref and ref not storing
>> 40-byte hex, but files starting with a period '.',  names longer
>> than 255 bytes, and unreadable ones, all of which we would
>> probably want to warn about in such a tool.
>
> Okay, how about 'fprintf(stderr, "Warning: ...\n"); continue;' instead of 
> 'die("...");' then?

Yup.  That sounds sensible.
