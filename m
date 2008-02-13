From: Paul Gardiner <osronline@glidos.net>
Subject: Re: All I wanted was git-fast-export
Date: Wed, 13 Feb 2008 09:10:18 +0000
Message-ID: <47B2B3FA.4060809@glidos.net>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net> <alpine.LSU.1.00.0802100054490.11591@racer.site> <47AECCDC.3050500@glidos.net> <alpine.LSU.1.00.0802101248260.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, osronline@glidos.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDe2-00047C-3t
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbYBMJKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbYBMJKh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:10:37 -0500
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:59451
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932294AbYBMJK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 04:10:28 -0500
X-Trace: 5347098/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAC9Dskc+8aIg/2dsb2JhbACtIw
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 13 Feb 2008 09:10:25 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by ranger.systems.pipex.net (Postfix) with ESMTP id 65850E000091;
	Wed, 13 Feb 2008 09:10:23 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802101248260.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73760>

Johannes Schindelin wrote:
> Hi,
> 
> [please do not look the other way when you respond to me, i.e. do not cull 
> me from the Cc: list.  Thankyouverymuch]
> 
> On Sun, 10 Feb 2008, Paul Gardiner wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> The thing is, filter-branch was _written for this purpose_.  So if you 
>>> know what commit you rewrote last, you can make the process 
>>> faster/safer by issuing
>>>
>>> 	$ git filter-branch --msg-filter="<blabla>" <old-commit>..master
>> That does look just what I need, but did you see the reason I thought I 
>> couldn't use it? I need to repeatedly sync the git repository from a 
>> live cvs repository, and repeatedly filter the new commit messages.
> 
> Oh, I thought you saw why I put in that "<old-commit>...".  You do not 
> really need it, as filter-branch will come up with the _same_ commit 
> hashes, unless _something_ was changed.

Thanks, that indeed works. Using filter-branch, using just --msg-filter
does the job without altering hashes, and fromcvs/togit syncs up
ignoring the alteration. My message filter is idempotent, so I can
rerun it after every sync (or I might try your suggestion above
to make it more efficient).

P.
