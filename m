From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: fatal: unexpected EOF
Date: Tue, 28 Feb 2006 10:43:16 -0500
Message-ID: <44046F94.3070806@didntduck.org>
References: <440449D7.3010508@didntduck.org> <Pine.LNX.4.64.0602280731210.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:43:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE70E-00009n-0F
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 16:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWB1PnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 10:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWB1PnA
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 10:43:00 -0500
Received: from quark.didntduck.org ([69.55.226.66]:13704 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751286AbWB1Pm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 10:42:59 -0500
Received: from [172.21.26.85] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id k1SFguv25952;
	Tue, 28 Feb 2006 10:42:56 -0500
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602280731210.22647@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16940>

Linus Torvalds wrote:
> 
> On Tue, 28 Feb 2006, Brian Gerst wrote:
> 
>>Lately I've been receiving this error frequently from git.kernel.org:
>>
>>Fetching pack (head and objects)...
>>fatal: unexpected EOF
>>cg-fetch: fetching pack failed
>>
>>What is causing this?
> 
> 
> Almost any error will cause the pack sending to abort, and the git:// 
> protocol only opens a single socket for data, so there is no way for the 
> other end to say _what_ failed.
> 
> With git.kernel.org, I suspect the reason for the failure is almost always 
> the same, though: the mirroring is not complete, so it doesn't have all 
> object files. The mirroring from master.kernel.org to the actual public 
> machines is just a rsync script, so there's no atomicity guarantees.
> 
> That said, it might be a load issue too - I don't know what limits 
> Peter & co put on the git daemons, and it might also be that it's set up 
> to accept at most <n> connections and will close anything else.
> 
> 		Linus
> 
> 

I doubt it is a problem with mirroring, since it affects all repos 
(kernel, git, cogito, etc.) at the same time.

--
				Brian Gerst
