From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git adds some text file as binary file by mistake
Date: Fri, 24 Oct 2008 15:51:25 +0200
Message-ID: <4901D2DD.8050704@drmicha.warpmail.net>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>	 <4901C58D.4010309@drmicha.warpmail.net> <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 15:53:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtN6Q-0003I6-P4
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbYJXNva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYJXNva
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:51:30 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42989 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbYJXNv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 09:51:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A2C32181D1F;
	Fri, 24 Oct 2008 09:51:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 24 Oct 2008 09:51:28 -0400
X-Sasl-enc: bhkuaLOC57MzueJXTGNnGaSv9jReaFH+nB8tcn6gvyBF 1224856287
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B45ED81A8;
	Fri, 24 Oct 2008 09:51:27 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99037>

Ping Yin venit, vidit, dixit 24.10.2008 15:30:
> On Fri, Oct 24, 2008 at 8:54 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Ping Yin venit, vidit, dixit 24.10.2008 14:37:
>>> So what should i do if i want it added as text file?
>> You should give us more detail on the file ;)
>> What's the extension, what's the typical content? It may be a simple
>> matter of specifying attributes.
>> Do ordinary diff and grep recognize your files as text?
>>
>> Michael
>>
> 
> It's just an xml file. I guess maybe there are some hidden characters
> at the beginning. I will figure it out later because i have no access
> to that file right now.

Maybe it's in an encoding which is not available on the machine you're
using git on?

> I'm just ask this problem in general sense. So is there a general way
> to specify whether  a file is text or binary?

Bruce suggested a good read. To save you some time: You want to say

*.xml diff

or

*.xml diff crlf

in one of the attributes files, depending on whether you want git to
possibly translate line endings (which depends on other settings also).
Note that the "content type" of the file plays a role only for diffs and
stats, not for the actual storage (except for, possibly, crlf conversion).

Cheers,
Michael
