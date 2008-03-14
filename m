From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Simplify MSGFMT setting in Makefile
Date: Fri, 14 Mar 2008 14:07:27 +0100
Message-ID: <47DA788F.6070406@op5.se>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>	<46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>	<20080222065836.GE8410@spearce.org>	<46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>	<47C5A974.7080207@gmail.com>	<alpine.LSU.1.00.0802271825330.22527@racer.site>	<47C5AEFA.5020004@gmail.com>	<alpine.LSU.1.00.0802272203270.22527@racer.site>	<7vablmqc7q.fsf@gitster.siamese.dyndns.org>	<47C7000C.1000809@gmail.com>	<20080305071915.GI8410@spearce.org>	<7v63w0gs87.fsf@gitster.siamese.dyndns.org>	<7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org> <18394.671.630499.836160@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9ds-0008Fj-GD
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYCNNHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYCNNHa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:07:30 -0400
Received: from mail.op5.se ([193.201.96.20]:59024 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418AbYCNNHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:07:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CDA301F0802A;
	Fri, 14 Mar 2008 14:08:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aD3xHeongGkH; Fri, 14 Mar 2008 14:08:42 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 2A0AF1F08020;
	Fri, 14 Mar 2008 14:08:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <18394.671.630499.836160@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77220>

Paul Mackerras wrote:
> Junio C Hamano writes:
> 
>>  * I am planning to close 'master' for -rc1 by the end of this week, so
>>    please plan to tell me to pull if you have accumulated changes,
>>    thanks.
> 
> I have a few commits for you to pull, but I am about to push a patch
> for gitk like the one you sent for git-gui, so I'll send you a pull
> request when I've done that.  However, I found that in this line:
> 
>>  else
>>  	MSGFMT ?= msgfmt
>> -	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
>> +	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)
> 
> I had to put "echo $$?" for it to work rather than "echo $?".
> 

$$ is the way to pass a literal $ to the shell in Makefiles, so that
seems in order.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
