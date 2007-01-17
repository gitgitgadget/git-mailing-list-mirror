From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 14:51:57 -0500
Message-ID: <D085A8A2-F1EC-47EC-8D96-B8A06E483BDB@silverinsanity.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net> <45AE7710.40503@shadowen.org> <7vzm8hqws4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GpM-0007yA-9O
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbXAQTwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbXAQTwF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:52:05 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:42914 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXAQTwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:52:04 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AD7581FFD0EE;
	Wed, 17 Jan 2007 19:52:03 +0000 (UTC)
In-Reply-To: <7vzm8hqws4.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37032>


On Jan 17, 2007, at 2:27 PM, Junio C Hamano wrote:

> Andy Whitcroft <apw@shadowen.org> writes:
>
>>> -	strcpy(filename + len, ".txt");
>>> +	sprintf(filename + len, ".%s", fmt_patch_suffix);
>>
>> This doesn't give us any possibility of not having a suffix.  Can  
>> we not
>> include the . in the suffix here so that we can specify it as "".
>
> I've considered it, but I do not think it is worth it.

I think that the best form of DWIM is that if the suffix is "", then  
you simply skip the entire sprintf.  Then any suffix has to have the  
'.', but no suffix doesn't have it.  Additional DWIMMmery could  
remove an initial '.' from the suffix so that users expecting it to  
be there don't get ".." in their file.

Patch (on top of yours) should follow shortly.

~~ Brian
