From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 11:03:26 -0700
Message-ID: <426FD3EE.5000404@zytor.com>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:01:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqpH-00067G-VC
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVD0SEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVD0SEG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:04:06 -0400
Received: from terminus.zytor.com ([209.128.68.124]:46521 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261852AbVD0SDr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 14:03:47 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RI3VOx009326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 11:03:35 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 26 Apr 2005, H. Peter Anvin wrote:
> 
>>One solution to all of this would be to define a quoting standard for 
>>strings, and simply require that all free-format strings (like the 
>>author fields) or at least strings that match [0-9a-f]{20}, are always 
>>quoted.
> 
> 
> git uses more of the ".newsrc" format, in that it just knows which 
> characters are legal or not.
> 
> To find the email address, look for the first '<'. To find the date, look 
> for the first '>'. Those characters are not allowed in the name or the 
> email, so they act as well-defined delimeters.
> 

That's true for email addresses, but the point was to distinguish links 
to other git objects from any other kind of text.  Currently there is no 
such delimiter for that.  Another solution than the one I posted would 
be to define such a delimiter, for example '<' + 20 hex character + '>' 
(which would be distinguished from email addresses by the lack of an @ 
sign.)  That would be a repo change, though.

Given no prior constraints, I would probably argue for a format which 
makes the data type known as a matter of syntax, using "..." quoted 
strings for *ALL* arbitrary strings, a different syntax for numbers and 
links, and leaving the door open for new data types like lists in the 
future.

	-hpa

