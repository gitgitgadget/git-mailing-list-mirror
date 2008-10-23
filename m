From: Andreas Ericsson <ae@op5.se>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 09:11:21 +0200
Message-ID: <49002399.20303@op5.se>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 11:45:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kswl3-0004Ok-00
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 11:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYJWJoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 05:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYJWJoT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 05:44:19 -0400
Received: from mail.op5.se ([193.201.96.20]:38187 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYJWJoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 05:44:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EBB0E1B800A6;
	Thu, 23 Oct 2008 11:38:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.931
X-Spam-Level: 
X-Spam-Status: No, score=-3.931 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.468, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxzpBRfcLpJ0; Thu, 23 Oct 2008 11:37:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B5D6F1B8004D;
	Thu, 23 Oct 2008 11:37:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98949>

Edward Ned Harvey wrote:
>> Yes, it does stat all the files. How many files are you talking about,
>> and what platform?  From a warm cache on Linux, the 23,000 files kernel
>> repo takes about a tenth of a second to stat all files for me (and this
>> on a several year-old machine). And of course many operations don't
>> require stat'ing at all (like looking at logs, or diffs that don't
>> involve the working tree).
> 
> No worries.  No solution can meet everyone's needs.
> 
> I'm talking about 40-50,000 files, on multi-user production linux, which means the cache is never warm, except when I'm benchmarking.  Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn st" takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me, performance was approx the same for files on local disk versus NFS.  Probably the best solution for us is perforce, we just don't like the pricetag.
> 
> Out of curiosity, what are they talking about, when they say "git is fast?"  Just the fact that it's all local disk, or is there more to it than that?  I could see - git would probably outperform perforce for versioning of large files (let's say iso files) to benefit from sustained local disk IO, while perforce would probably outperform anything I can think of, operating on thousands of tiny files, because it will never walk the tree.
> 



> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
