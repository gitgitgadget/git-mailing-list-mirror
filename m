From: Andreas Ericsson <ae@op5.se>
Subject: Re: Install issues
Date: Wed, 12 Nov 2008 09:14:15 +0100
Message-ID: <491A9057.1020305@op5.se>
References: <20081110121739.15f77a01@pc09.procura.nl> <20081110113924.GR24201@genesis.frugalware.org> <20081110173101.3d76613b@pc09.procura.nl> <20081110175123.GV24201@genesis.frugalware.org> <7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0AtF-0006Go-0C
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbYKLIOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYKLIOY
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:14:24 -0500
Received: from mail.op5.se ([193.201.96.20]:44699 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbYKLIOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:14:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 129C024B0025;
	Wed, 12 Nov 2008 09:08:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uk9XF2BZ7Qgq; Wed, 12 Nov 2008 09:08:31 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 497DA24B0023;
	Wed, 12 Nov 2008 09:08:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100719>

Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
>> On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
>>> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
>>> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
>>> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>>>  	./test-sha1.sh
>>>  
>>>  check: common-cmds.h
>>> +	@`sparse </dev/null 2>/dev/null` || (\
>>> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
>>> +	    echo "Did you mean 'make test' instead?" ;\
>>> +	    exit 1 )
>>>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
>> Please read Documentation/SubmittingPatches, your patch lacks a signoff
>> and a commit message.
> 
> Heh, for something small and obvious like this, that's asking a tad too
> much, although a properly formatted message does reduce my workload and is
> appreciated.
> 
> I said "obvious" not in the sense that it is "obviously good".  It is
> obvious what issue the patch wants to address.
> 
> Having said that, it is far from clear if special casing "make check" like
> this is a good thing, though.  The crufts resulting from "Four extra lines
> won't hurt" kind of reasoning can accumulate and snowball.  Is reading the
> Makefile when your build fails in order to see if the target was what you
> really wanted to invoke (ideally, it should rater be "_before_ running
> make, reading the Makefile to find out what you want to run") a lost art
> these days?
> 

Why not "make help" with as friendly a message as we can muster, like the
linux kernel does it?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
