From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Sat, 23 Feb 2008 09:18:23 +0100
Message-ID: <47BFD6CF.3040300@op5.se>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <47BF80EC.4080608@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSpbO-0004Jc-SB
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 09:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935272AbYBWISb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 03:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934999AbYBWISa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 03:18:30 -0500
Received: from mail.op5.se ([193.201.96.20]:38835 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934574AbYBWIS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 03:18:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 373B91F08050;
	Sat, 23 Feb 2008 09:18:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3+NH7EZCgn4; Sat, 23 Feb 2008 09:18:25 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 854A51F08046;
	Sat, 23 Feb 2008 09:18:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <47BF80EC.4080608@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74804>

Brandon Casey wrote:
> From: Andreas Ericsson <ae@op5.se>
> 
> Packing objects can be done in parallell nowadays, but it's
> only done if the config option pack.threads is set to a value
> above 1. Because of that, the code-path used is often not the
> most optimal one.
> 
> This patch adds a routine to detect the number of online CPU's
> at runtime (online_cpus()). When pack.threads (or --threads=) is
> given a value of 0, the number of threads is set to the number of
> online CPU's. This feature is also documented.
> 
> As per Nicolas Pitre's recommendations, the default is still to
> run pack-objects single-threaded unless explicitly activated,
> either by configuration or by command line parameter.
> 
> The routine online_cpus() is a rework of "numcpus.c", written by
> one Philip Willoughby <pgw99@doc.ic.ac.uk>. numcpus.c is in the
> public domain and can presently be downloaded from
> http://csgsoft.doc.ic.ac.uk/numcpus/
> 
> Signed-off-by: Andreas Ericsson <ae@op5.se>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> I reworked this patch from Andreas for detecting the number of online CPU's.
> I kept the commit message and the Signed-off-by and added my own. I'm not sure
> what the procedure is here.
> 

The changes are small enough that maintaining original authorship is probably
the right thing to do. For anything larger it would probably have made sense
to send something on top of it. For a rewrite or when implementing a feature
that was thought up by someone else, mentioning in the message who the original
idea was from is enough.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
