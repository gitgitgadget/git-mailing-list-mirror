From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 01:22:32 +0100
Message-ID: <97c45128ddeb8269273a4431b3941478@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
 <201109261812.31738.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:22:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8LRZ-0003gz-7x
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 02:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab1I0AWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 20:22:34 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:34172 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835Ab1I0AWd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 20:22:33 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 1494BC0602;
	Tue, 27 Sep 2011 01:22:33 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id E2E3A36A825;
	Tue, 27 Sep 2011 01:22:32 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J00fCWq4PW0g; Tue, 27 Sep 2011 01:22:32 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 31F0136A74D;
	Tue, 27 Sep 2011 01:22:32 +0100 (BST)
In-Reply-To: <201109261812.31738.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182199>

On Mon, 26 Sep 2011 18:12:31 -0600, Martin Fick wrote:
> On Monday, September 26, 2011 05:26:55 pm Julian Phillips
> wrote:
-- snip --
>> Back when I made that change, I failed to notice that
>> get_ref_dir was recursive for subdirectories ... sorry
>> ...
>>
>> Hopefully this should speed things up.  My test repo went
>> from ~17m user time, to ~2.5s.
>> Packing still make things much faster of course.
>
> Excellent!  This works (almost, in my refs.c it is called
> sort_ref_list, not sort_refs_list).

Yeah, in mine too ;)  It's late and I got the compile/send mail 
sequence backwards. :$
It's fixed in the proper patch email.

>  So, on the non garbage
> collected repo, git branch now takes ~.5s, and in the
> garbage collected one it takes only ~.05s!

That sounds a lot better.  Hopefully other commands should be faster 
now too.

> Thanks way much!!!

No problem.  Thank you for all the time you've put in to help chase 
this down.  Makes it so much easier when the person with original 
problem mucks in with the investigation.
Just think how much time you've saved for anyone with a large number of 
those Gerrit change refs ;)

-- 
Julian
