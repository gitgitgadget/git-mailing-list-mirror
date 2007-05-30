From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Wed, 30 May 2007 12:40:35 +0300
Message-ID: <465D4693.5070006@qumranet.com>
References: <20070529071622.GA8905@spearce.org> <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com> <465C52D3.3010605@qumranet.com> <alpine.LFD.0.99.0705291227010.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Dana How <danahow@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 30 11:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtKfe-0004Ry-PF
	for gcvg-git@gmane.org; Wed, 30 May 2007 11:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbXE3Jkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXE3Jkj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 05:40:39 -0400
Received: from il.qumranet.com ([82.166.9.18]:57249 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbXE3Jki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 05:40:38 -0400
Received: from blast.qumranet.com (blast.qumranet.com [10.0.1.228])
	by il.qumranet.com (Postfix) with ESMTP id 007FD250037;
	Wed, 30 May 2007 12:40:35 +0300 (IDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <alpine.LFD.0.99.0705291227010.11491@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48751>

Nicolas Pitre wrote:
>>
>> Another way to achieve that is to place objects that are accessed together
>> nearby, and issue a larger read so as to bring them into cache.  I imagine
>> that placing commit objects and associated tree and blobs in history order
>> should help here (but maybe git already does that, I'm not familiar with the
>> internals).
>>     
>
> GIT already does that indeed, except for commit objects which are all 
> together for better performances on history traversal operations.
>
> After a fresh repack, the checkout of the latest revision should produce 
> a nearly perfect linear and contigous access into the early portion of 
> the same pack.  Things will get more random with access to objects 
> further back in history of course, but those objects are less likely to 
> be accessed as often.
>
>   

Thanks.  Actually I should have deduced this from the speed of 'git log' ;-)

-- 
error compiling committee.c: too many arguments to function
