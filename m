From: Dustin Sallings <dustin@spy.net>
Subject: Re: [PATCH] Allow local branching to set up rebase by default.
Date: Thu, 8 May 2008 10:32:59 -0700
Message-ID: <585390AA-289C-4B2F-B851-DD383C6C7A73@spy.net>
References: <1209502182-39800-1-git-send-email-dustin@spy.net> <7vprrycce9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 19:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuA0E-0002X1-Bz
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYEHRdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYEHRdI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:33:08 -0400
Received: from basket.west.spy.net ([69.230.8.154]:62462 "EHLO
	mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYEHRdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:33:05 -0400
Received: from dhcp-60.corp01.caring.com (dsl092-049-060.sfo4.dsl.speakeasy.net [66.92.49.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.west.spy.net (Postfix) with ESMTP id 6D4FF54;
	Thu,  8 May 2008 10:33:00 -0700 (PDT)
In-Reply-To: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81545>


	Hi, thanks for the response.

On May 7, 2008, at 9:22, Junio C Hamano wrote:

> You got no reactions, neither
> positive nor negative, partly due to this sentence, I suspect.

	I got one response from someone who said he had implemented the same  
thing in one of his branches.  That seemed to confirm the idea for  
me.  Some additional features were suggested to be built on top of  
this, but I didn't read it as necessary for proceeding.

> Please sign-off your patches (see Documentation/SubmittingPatches).

	Oh thanks, I hadn't seen this.  I read it as well as the  
CodingGuidelines document.

>> +	When `never`, rebase is never automatically set to true.
>> +	When `local`, rebase is set to true for tracked branches of
>> +	other local branches.
>> +	When `remote`, rebase is set to true for tracked branches of
>> +	remote branches.
>> +	When `always`, rebase will be set to true for all tracking
>> +	branches.
>> +	This option defaults to never.
>
> How does this interact with a similarly named configuration option,
> autosetupmerge, whose settings can be false, true, and always?

	I can direct the user to the autosetupmerge config documentation  
since it also documents the flags that override its behavior.  Is this  
acceptable?

>> branch.<name>.remote::
>> 	When in branch <name>, it tells `git fetch` which remote to fetch.
>> 	If this option is not given, `git fetch` defaults to remote  
>> "origin".
>
> This is not your fault, but can anybody guess what the exact command
> sequence to cause the named branch to be advanced by rebasing, only by
> reading this entry?
>
>    branch.<name>.rebase::
>            When true, rebase the branch <name> on top of the fetched  
> branch,
>            instead of merging the default branch from the default  
> remote.
>
> I can't.  Perhaps we would need "when "git pull" is run" or  
> something at
> the end.

	I'll submit this as a separate patch.

> Is this correct?

	[...]

> You might want to check how the setup_tracking() decides when to say
> remote/local in its printf().

	Oh thanks, I clearly didn't understand this and just relied on my  
tests passing by coincidence.

	I'll resubmit my patch with your recommendations, thanks.

-- 
Dustin Sallings
