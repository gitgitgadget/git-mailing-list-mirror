From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Add matchings for csharp
Date: Mon, 22 Jun 2009 10:12:18 +0200
Message-ID: <4A3F3CE2.1070704@gnu.org>
References: <1245628369.15870.1.camel@belthazor> <4A3F238B.1020107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adam Petaccia <adam@tpetaccia.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIedq-0007sE-BB
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 10:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbZFVIM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZFVIM2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 04:12:28 -0400
Received: from mx2.redhat.com ([66.187.237.31]:42942 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbZFVIM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 04:12:28 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5M8CTYA005839;
	Mon, 22 Jun 2009 04:12:30 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5M8CS13008681;
	Mon, 22 Jun 2009 04:12:28 -0400
Received: from yakj.usersys.redhat.com (dhcp-lab-149.englab.brq.redhat.com [10.34.33.149])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5M8CQiw010871;
	Mon, 22 Jun 2009 04:12:27 -0400
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <4A3F238B.1020107@viscovery.net>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122018>


>> @@ -79,6 +79,16 @@ PATTERNS("cpp",
>>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
>>  	 "|[^[:space:]]|[\x80-\xff]+"),
>> +PATTERNS("csharp",
>> +	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>> +	 "^([ \t]*(static|public|internal|private|protected|new|unsafe|readonly|volatile)[ \t]+(class|enum|interface|struct).*)$\n"
>> +	 "^([ \t]*(namespace)[ \t]+.*)$"
> 
> I think the placement of parentheses could be improved in these two
> expressions (but I don't know for sure because I don't know the code well
> enough). Looking at the other examples in userdiff.c, I infer that the
> *first* opening parentheses defines which part is copied to the hunk
> header.

Yes.

> Since you placed everything into parentheses (unnecessarily, I
> think),

No, not unnecessarily because otherwise only "public" for example would 
be copied.  I agree though that leading whitespace should not be 
included in the parentheses.

Paolo
