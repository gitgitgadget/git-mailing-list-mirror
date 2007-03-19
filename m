From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 13:09:07 -0300
Organization: Mandriva
Message-ID: <20070319130907.23b73273@localhost>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
	<20070316153822.5c842e69@localhost>
	<20070316231646.GB4508@spearce.org>
	<20070317195832.2af87c06@home.brethil>
	<20070318052332.GC15885@spearce.org>
	<7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
	<20070318161854.5a6a34e0@home.brethil>
	<7v4poimjr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKQ8-00073e-Ue
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXCSQJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbXCSQJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:09:16 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:54291 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbXCSQJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 717002AE77;
	Mon, 19 Mar 2007 13:09:12 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Yx-wmDaETf0N; Mon, 19 Mar 2007 13:09:08 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 1439F2AE75;
	Mon, 19 Mar 2007 13:09:08 -0300 (BRT)
In-Reply-To: <7v4poimjr2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42634>

Em Sun, 18 Mar 2007 12:31:13 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| >  I mean, if the information needed to print the error message (packfile
| > name and version in this example) is available to the caller, or the
| > caller can get it someway, then the caller could check which error
| > he got and build the message himself.
| >
| >  That seems simpler to me, considering the caller has the needed
| > info, of course...
| 
| It's a possibility, but that would make it much less nice to
| diagnose and debug problems, as the caller does not usually have
| necessary information.
| 
| The caller may ask for object A, and the error is triggered
| because a different object C is missing, which is the delta base
| of object B which in turn is the delta base of object A.  The
| best your "caller" can say is "cannot read object A for some
| reason", and it cannot say "cannot read object A because object
| C is missing".

 Okay, you're right. I'm going to let the low-level functions
fill the error buffer then.

 Thanks,

-- 
Luiz Fernando N. Capitulino
