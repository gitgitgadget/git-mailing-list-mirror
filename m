From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Thu, 01 Mar 2007 08:58:00 +0200
Message-ID: <45E67978.9030805@dawes.za.net>
References: <200702281303.11951.andyparkins@gmail.com> <45E5D0D7.5070305@dawes.za.net> <Pine.LNX.4.63.0702282042000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E5F3D4.8000509@dawes.za.net> <Pine.LNX.4.63.0703010208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 07:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMfF8-00068j-6c
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 07:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbXCAG6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 01:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbXCAG6J
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 01:58:09 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:43786 "EHLO
	spunkymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932706AbXCAG6I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 01:58:08 -0500
Received: from [192.168.201.100] (dsl-146-24-85.telkomadsl.co.za [165.146.24.85])
	by spunkymail-a7.g.dreamhost.com (Postfix) with ESMTP id 717D65C124;
	Wed, 28 Feb 2007 22:58:06 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <Pine.LNX.4.63.0703010208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41039>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Feb 2007, Rogan Dawes wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Wed, 28 Feb 2007, Rogan Dawes wrote:
>>>
>>>> How about showing the size of the changes between the 2 files via 
>>>> the libxdiff binary patch function?
>>> I briefly considered this, too. But what would it tell you in the case 
>>> of a jpg? I think it has more disadvantages than advantages...
>> It would still tell you the extent of the changes. i.e. Did we change 
>> only 10 bytes of the file, or is it a dramatic change?
> 
> I was not explicit enough, okay. I was not so worried about the case where 
> only 10 bytes changed. If you insert a single dot in a jpg image, chances 
> are that your binary content will change _a lot_.
> 
> So, no problem deducing from 10 bytes changed that it was a minor change. 
> But you cannot deduce the opposite of a 1MB change!
> 
> Hth,
> Dscho
> 

Yeah, I did understand that.

However, if we were to generalise, making a change to an XML document 
(wrapping the whole thing in an additional tag, with the associated 
indentation adjustments), we'd still see all the lines in the file 
change, even though the actual (semantic?) change is small. However, we 
would still report the full numbers of lines added and deleted regardless.

Why should a binary file be any different? It would be up to the 
observer to make a conclusion as to the significance of the numbers, 
based on their intrinsic knowledge of the file type, and its properties.

I just believe that showing bytes changed for binary files is 
_consistent_ with what we do for text.

Rogan
