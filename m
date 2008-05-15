From: Robin Luckey <robin@ohloh.net>
Subject: Re: How can I tell if a SHA1 is a submodule reference?
Date: Thu, 15 May 2008 13:56:02 -0700
Message-ID: <90B9CF74-40E1-4469-AFF9-D8D349F6C80D@ohloh.net>
References: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net> <7vabirgvyg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 22:57:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwkWB-0000QO-Ta
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 22:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbYEOU4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 16:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYEOU4l
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 16:56:41 -0400
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:48442 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYEOU4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 16:56:41 -0400
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id ECAAE1B549A;
	Thu, 15 May 2008 16:56:04 -0400 (EDT)
Received: by relay10.relay.iad.mlsrvr.com (Authenticated sender: robin-AT-ohloh.net) with ESMTP id 4544A1B524E;
	Thu, 15 May 2008 16:56:04 -0400 (EDT)
In-Reply-To: <7vabirgvyg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82232>

Thanks for the replies -- checking the mode bits was the ticket.

Robin

On May 15, 2008, at 1:21 PM, Junio C Hamano wrote:

> Robin Luckey <robin@ohloh.net> writes:
>
>> I am parsing the output of git-diff-tree to create some code analysis
>> reports.
>>
>> When a user adds a submodule to a repository, git-diff-tree reports
>> the SHA1 of the commit from the submodule.
>>
>> However, if I subsequently try to pass this SHA1 to git-cat-file, or
>> indeed any other git command I have tried, I receive an error:
>>
>> error: unable to find b0f8c354b142e27333abd0f175544b71a0cc444e
>> fatal: Not a valid object name  
>> b0f8c354b142e27333abd0f175544b71a0cc444e
>>
>> This makes sense to me, since these objects are not stored locally;
>> they are stored in the submodule repository.
>>
>> However, is there a simple and reliable way for me to know which SHA1
>> hashes refer to such submodule objects? I'd like to simply ignore  
>> them.
>
> I presume you are reading "diff-tree --raw" format output.  The mode  
> bits
> for submodules (aka gitlinks) are 160000, as opposed to either  
> 100644 or
> 100755 for regular files and 120000 for symbolic links.
>
>
