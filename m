From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Any overview available on jgit codebase?
Date: Sat, 15 Nov 2008 19:21:10 -0500
Message-ID: <491F6776.8060100@wellfleetsoftware.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com>
 <491C8DBE.9080105@wellfleetsoftware.com>
 <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
 <491F2F5E.20206@wellfleetsoftware.com> <20081115231537.GD2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VRW-0000Co-0k
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYKPAVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYKPAVS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:21:18 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:53908 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKPAVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:21:18 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAE00C44GZ8Q8E4@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 15 Nov 2008 18:21:09 -0600 (CST)
In-reply-to: <20081115231537.GD2932@spearce.org>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101103>

Shawn O. Pearce wrote:
> Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>   
>> At minimum could anyone tell me what packages and classes to look at in  
>> order to make changes to jgit so it uses a database instead of  
>> filesystem to references.
>>     
>
> See RefDatabase, created by Repository.  You would want to replace
> RefDatabase with your own implementation, which means abstracting
> that class to be an abstract base class or an interface.
>
> RefUpdate and RefLogWriter are connected to RefDatabase, so you
> would likely need to modify those too in order to make the change,
> especially since RefUpdate is the "INSERT OR UPDATE OR DELETE"
> logic.  :)
>
> BTW, I want to do that RefDatabase abstraction anyway, because I'd
> like to get an in-memory only version of RefDatabase, to make unit
> testing easier.  So abstracting this code may be useful beyond just
> your desire to back Git with a JDBC-style database.
>   

This is just what I was hoping for. Thanks Shawn. I will try and do this 
next week and ask for help as needed. Thank you.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
