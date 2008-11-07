From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Fri, 07 Nov 2008 09:12:09 +0100
Message-ID: <4913F859.8070500@op5.se>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil> <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil> <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil> <7v8wrwidi3.fsf@gitster.siamese.dyndns.org> <BgEXN35P6wpio928OZi_34hs22vqUQxIAIGxR5hR8LqmfPIyw565Mg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 07 09:13:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyMTC-0004CT-Nw
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 09:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYKGIMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 03:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYKGIMT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 03:12:19 -0500
Received: from mail.op5.se ([193.201.96.20]:55151 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbYKGIMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 03:12:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E346A1B800AF;
	Fri,  7 Nov 2008 09:05:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SXr18DfhSVxw; Fri,  7 Nov 2008 09:05:53 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7CB081B80005;
	Fri,  7 Nov 2008 09:05:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <BgEXN35P6wpio928OZi_34hs22vqUQxIAIGxR5hR8LqmfPIyw565Mg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey wrote:
> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>>>   <-a>
>>>     -create a new pack containing all objects required by the repository
>>>      including those accessible through alternates, but excluding objects
>>>      in _local_ packs with .keep
>> I have a feeling that it is debatable if this "fattening to dissociate
>> from alternates" is what people want.
> 
> I'm not sure I understand you here.
> 
> Andreas has suggested previously that 'repack -a' should pack everything,
> including objects in packs with .keep. Is that what you mean?
> 
> With my current understanding it seems that that would muddy the semantics
> of repack. If -a does not honor packs with .keep, then would it be intuitive
> to expect that adding -l (i.e. exclude alternate packed objects) _would_
> honor .keep?
> 

Only -d should honor .keep, imo. .keep-files is nothing about "don't copy
objects from this file" and all about "never delete this file".

The only muddying comes from you, who decided that .keep-files should
have impact on anything else than deleting the protected pack. Before that,
.keep files had a clear semantic, and repack's documentation was correct.

How do you explain .keep-files now? "protects pack-files that will forever
be used"? Then why the hell is it called ".keep" instead of "eternal"?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
