From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Fri, 19 Oct 2007 11:57:22 -0400
Message-ID: <9E5BD9E5-9027-4F92-8E32-BF78BA25321C@MIT.EDU>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org> <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU> <20071019021618.GE3290@coredump.intra.peff.net> <A2491F60-A00E-412A-8389-1C9EB5EDFCEF@mit.edu> <28B30BAE-9482-4219-924B-F0EDFB2936FB@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 17:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiuEE-0003W2-9P
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 17:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbXJSP51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXJSP51
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 11:57:27 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:43194 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754549AbXJSP50 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 11:57:26 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9JFvOr1001547;
	Fri, 19 Oct 2007 11:57:24 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9JFvNxA019270
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 19 Oct 2007 11:57:24 -0400 (EDT)
In-Reply-To: <28B30BAE-9482-4219-924B-F0EDFB2936FB@wincent.com>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61729>


On 19 Oct 2007, at 7:33:39 AM, Wincent Colaiuta wrote:

>> What you want to happen is the following:
>> 	
>> 	git show HEAD:A.txt > path/B.txt
>> 	git add path/B.txt
>> 	mv A.txt B.txt
>> 	git rm A.txt
>>
>> Is this correct?
>
> Here you're copying the content of A.txt as it was in the last  
> (HEAD) commit, but from what the poster said he wants the content  
> of A.txt as it is staged in the index (that is, there may be staged  
> but uncomitted changes).
>
>> Better:
>>
>>>  	mv A.txt path/B.txt
>>> 	Point the index entry for A.txt to path/B.txt
>
> Yes, that is basically what he was asking for, as I read it.

You're right.

There is the subtlety in the first case that he's already staged  
something.
