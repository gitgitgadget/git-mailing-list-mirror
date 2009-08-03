From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Have git-merge-base support multiple IDs
Date: Mon, 03 Aug 2009 23:52:32 +0200
Message-ID: <4A775C20.9070109@drmicha.warpmail.net>
References: <alpine.LSU.2.00.0907311745100.4901@fbirervta.pbzchgretzou.qr> <4A731A39.3090506@drmicha.warpmail.net> <alpine.LSU.2.00.0908031539070.2603@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJ9u-0002YA-GJ
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZHDMaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbZHDMaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:30:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48231 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755343AbZHDMaJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 08:30:09 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 44E8D3BE037;
	Tue,  4 Aug 2009 08:30:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 04 Aug 2009 08:30:09 -0400
X-Sasl-enc: t4d+22985qUCAoI+Hv7C6Fhu0orGCHuU1LjGhrmhc1zJ 1249388991
Received: from localhost.localdomain (vpn-136-102.rz.uni-augsburg.de [137.250.136.102])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5A57C110C3;
	Tue,  4 Aug 2009 08:29:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.LSU.2.00.0908031539070.2603@fbirervta.pbzchgretzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124780>

Jan Engelhardt venit, vidit, dixit 03.08.2009 15:39:
> 
> On Friday 2009-07-31 18:22, Michael J Gruber wrote:
>> Jan Engelhardt venit, vidit, dixit 31.07.2009 17:51:
>>> To determine the rebase point (i.e. first commit in a series),
>>> one can (ab)use git-merge-base:
>>>
>>>   p=$(git merge-base ab80794f faae2553)
>>>   git re -i ${p}^
>>>
>>> The twist is that merge-base in git 1.6.3.3 happens to ignore any 
>>> further arguments following two IDs. In short:
>>>
>>>   git merge-base A B C...
>>>
>>> Only yields the merge-base of A and B, and ignores C...
>>
>> Uhm, are you sure about this?
>> The first argument is special. merge-base computes the merge base between two commits:
>> - the first argument
>> - a (hypothetical) merge between all other arguments.
>> It may look a if C was ignored, though.
> 
> Hm indeed. Is there a better way to find the common ancestor of commits?

I haven't tested thorougly, but at least for the standard example

git show-branch --merge-base A B C

seems to do what you want. Note that for this command, the order of
arguments is irrelevant, whereas for git merge-base it makes a huge
difference. Also, git show-branch documentation is a bit outdated. I
expect to look into this...

Michael
