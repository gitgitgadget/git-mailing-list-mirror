From: Andreas Ericsson <ae@op5.se>
Subject: Re: perforce import: git-p4 memory usage
Date: Fri, 23 May 2008 13:25:44 +0200
Message-ID: <4836A9B8.6070804@op5.se>
References: <H1SlcXmh.1211537268.4996380.lgd@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 23 13:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzVQ0-0002Nt-Bc
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 13:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYEWLZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 07:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYEWLZs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 07:25:48 -0400
Received: from mail.op5.se ([193.201.96.20]:46743 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbYEWLZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 07:25:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D291E1B8004F;
	Fri, 23 May 2008 13:23:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C32A2GlBBp4C; Fri, 23 May 2008 13:23:25 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id D7A321B80005;
	Fri, 23 May 2008 13:23:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <H1SlcXmh.1211537268.4996380.lgd@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82694>

Luke Diamand wrote:
> Hi!
> 
> I'm trying to import part of a perforce repo with git-p4.
> 
> However, git-p4 appears to try to read all the repo into memory (and
> moreover seems to need about twice as much memory as repo).
> 
> Once it runs out of swap, it dies (unsurprisingly).
> 
> I think it's failing in readP4Files(), where it appears to read the
> entire repository in one go with "p4 -G -x - print".
> 
> Can I just rework this function to do stuff one file at a time? Or is
> that dumb?
> 

It's probably a lot slower, and since git works with changesets it
probably won't work all that good unless you somehow construct some
middle-stage which you can then feed to git-fastimport or some such.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
