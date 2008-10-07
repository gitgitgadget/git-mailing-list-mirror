From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Replace xmalloc/memset(0) pairs with xcalloc
Date: Tue, 07 Oct 2008 07:12:14 +0200
Message-ID: <48EAEFAE.3010504@op5.se>
References: <48R7WYLSZ5lElWvJbfurso2ZPBQbzSCmtOgIsqTWyaA8yfW6Ndq1aA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Oct 07 07:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn4t5-0003Gg-LA
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 07:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYJGFMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 01:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYJGFMX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 01:12:23 -0400
Received: from mail.op5.se ([193.201.96.20]:43260 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbYJGFMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 01:12:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D82201B80061;
	Tue,  7 Oct 2008 07:04:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.816
X-Spam-Level: 
X-Spam-Status: No, score=-2.816 tagged_above=-10 required=6.6
	tests=[AWL=-0.317, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00O5LE3KObTJ; Tue,  7 Oct 2008 07:04:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 1495B1B80046;
	Tue,  7 Oct 2008 07:04:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48R7WYLSZ5lElWvJbfurso2ZPBQbzSCmtOgIsqTWyaA8yfW6Ndq1aA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97664>

Brandon Casey wrote:
> Many call sites immediately initialize allocated memory with zero after
> calling xmalloc. A single call to xcalloc can replace this two-call
> sequence.
> 

Nicely done. Apart from reducing LoC count, this is also a slight
optimization as we'll no longer bzero() memory handed to us directly
by the kernel (which is already nul'ed out).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
