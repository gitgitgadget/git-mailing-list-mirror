From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Sat, 21 Feb 2009 00:24:11 +0100
Message-ID: <499F3B9B.3020709@pelagic.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl> <20090220172918.GB4636@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laekx-0007iE-1n
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 00:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZBTXYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbZBTXYR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 18:24:17 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:50550 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754049AbZBTXYR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 18:24:17 -0500
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 70BDA58BD88;
	Sat, 21 Feb 2009 00:24:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090220172918.GB4636@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110903>

Jeff King wrote:
> On Fri, Feb 20, 2009 at 05:25:43PM +0100, Ferry Huberts (Pelagic) wrote:
>
>   
>> I replied in the thread with something comparable:
>> http://article.gmane.org/gmane.comp.version-control.git/110358
>>
>> My suggestion is make sure that safecrlf is set to false (see the end
>> part of the mail)
>>     
>
> Oh, sorry, I missed that bit. You said:
>
>   
>> Back to the issue:
>> I think requiring autocrlf = false is too strict.  Requiring autocrlf
>> = false should be enough. That combined with a bit of text in the
>> manual page about these settings: autocrlf = false is strongly
>> recommended. Also, safecrlf is required to be set to false.
>>     
>
> Assuming there is a typo and you meant to say "Requiring safecrlf =
> false should be enough", then yes, I agree. But if you are recommending
>   
yes that was a typo.
> to put that into the "git cvsimport" manpage, I'm not sure that makes
> sense. Setting autocrlf to input and turning on safecrlf breaks much
> more than that; you can't add any file that has a CRLF in it.  So such a
> warning should probably go in the config description for those options.
>
>   
I meant that I would add a patch that makes sure that a new repository 
is created with that option set to 'off' and that an existing repository 
would be checked for that option set to 'off'. I suggested to _also_ add 
remarks about this in the man page of cvsimport. Johannes already 
suggested a patch but that was for the autocrlf option (trivially 
converted to the safecrlf option)
> I still think safecrlf could probably be made more useful in this case
> to differentiate between "this will corrupt your data if you do a
> checkout with your current config settings" and "this will corrupt your
> data forever".  But I am not a user of either config variable, so maybe
> there is some subtlety I'm missing.
>
> -Peff
>   
I'm a user of these options myself. I maintain several large 
repositories that contain data that is used both on Unix and Windows 
platforms and that have the autocrlf=input and safecrlf=true. This makes 
sure that everything is in Unix format.
Your remark about corrupting your data is a bit strong for my taste. 
Corruption from one point of view, making sure that everybody handles 
the same content from another :-)

Ferry
