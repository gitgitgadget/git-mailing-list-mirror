From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 10:07:03 -0500
Message-ID: <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUMt9-0005d8-47
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbZBCPHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZBCPHK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:07:10 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:49124 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZBCPHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:07:08 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 7EE581FFC27F; Tue,  3 Feb 2009 15:07:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 520E21FFC271;
	Tue,  3 Feb 2009 15:07:03 +0000 (UTC)
In-Reply-To: <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108196>

This change appears to have been forgotten, but does fix the problems  
I was having.  Junio, can this make it into the official repo instead  
of floating around in my local?  I'd send in a patch, but it was your  
code and I don't want to take credit for it.

~~ Brian

On Jan 29, 2009, at 2:10 PM, Brian Gernhardt wrote:

>
> On Jan 29, 2009, at 12:19 PM, Junio C Hamano wrote:
>
>> If we really wanted to care about case-folding file systems,  
>> shouldn't we
>> make test_commit shell function a bit more than the downcasing?   
>> How about
>> this patch instead?
>
> That's a good point.  Always good to prevent future issues.
>
>> test_commit () {
>> -	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
>> +	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}
>> 	echo "${3-$1}" > "$file" &&
>> 	git add "$file" &&
>> 	test_tick &&
>
> Added this and ran through the tests.  Works for me. :-D
>
> Tested-by: Brian Gernhardt <benji@silverinsanity.com> (HFS+ on Mac  
> OS 10.5.6)
