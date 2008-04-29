From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 08:05:37 +0200
Message-ID: <4816BAB1.7080601@op5.se>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:06:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqiyz-0008Bv-Pa
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbYD2GFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYD2GFn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:05:43 -0400
Received: from mail.op5.se ([193.201.96.20]:43349 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127AbYD2GFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:05:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DD3451F0807D;
	Tue, 29 Apr 2008 08:05:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHKKhqCS6hds; Tue, 29 Apr 2008 08:05:41 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 2BB2E1F08063;
	Tue, 29 Apr 2008 08:05:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080429053814.GA3332@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80649>

Alex Riesen wrote:
> Paolo Bonzini, Tue, Apr 29, 2008 06:52:25 +0200:
>> Alex Riesen wrote:
>>> Paolo Bonzini, Mon, Apr 28, 2008 20:19:48 +0200:
>>>>> my v4l2
>>>>> repo (which is a pretty collection of all kinds of remotes)
>>>> I can add a global boolean configuration to change the default value 
>>>> of  skipDefaultRemote.
>>>>
>>> With the default NOT so that current behaviour stays?
>> No, absolutely.  In fact if I were you I would set skipDefaultUpdate  
>> *now* on the remotes of that repo.
> 
> And all the others, who don't read this discussion, are just expected
> to adapt?
> 

One for Alex's side here. I have several remotes in many of the repos
I'm using. Some of them point to my colleagues laptops, where temporary
git-daemons sometimes serve content, and sometimes it doesn't.

For me no refs would be updated, but they would generate errors which
would make real errors harder to see.

If you're gonna change the default of something, make really sure it
doesn't ever destroy anything for anybody. Otherwise, make it configurable
and off by default.

How about renaming "skipDefaultUpdate" to "fetch.fetchAllRemotes" and
let it default to false?

Although when I come to think about it, you'd probably want to mark
some remotes for auto-fetching while keeping others on "manual" fetch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
