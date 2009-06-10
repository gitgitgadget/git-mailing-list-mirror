From: Sam Vilain <sam@vilain.net>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 13:25:30 +1200
Message-ID: <4A2F0B8A.9010203@vilain.net>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:26:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MECaQ-0006vk-Fd
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 03:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZFJB0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 21:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZFJB0d
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 21:26:33 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:44731 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbZFJB0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 21:26:32 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 78A8221C2DD; Wed, 10 Jun 2009 13:26:18 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id E272421C2DD;
	Wed, 10 Jun 2009 13:25:44 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121241>

Linus Torvalds wrote:
> On Tue, 9 Jun 2009, Scott Chacon wrote:
>   
>> * breaks the various things that 'checkout' does into separate
>> commands - moves 'revert' to doing what 'checkout -- path' does
>>     
>
> No.
>
> NAK on this one. 
>
> The fact that some idiotic SVN usage exists is not an excuse to break 
> long-standing git users. "revert" comes from bk, and quite frankly, I 
> object _very_ strongly to taking naming from something that is very 
> obviously the inferior system (SVN) over something very obviously superior 
> (BK and git).
>   

We talked about this much at GitTogether '08. It's true that for
'reverting' a change in the past, that is the right thing to do. However
I don't think there is a first principles case that this is always what
people mean by 'revert'. And it is not just SVN - Mercurial, Monotone,
Bazaar, Darcs all use 'revert' in this way. By comparison with those
systems, the number of users coming from BK is quite low.

We talked about making a 'git revert-file' and 'git revert-commit', with
'git revert' printing a message encouraging the user to specify which
one they wanted (or potentially pointing them to the correct
incantations of 'git checkout' or 'git cherry-pick').

I think as long as there is a deprecation cycle, and that users can
select the old behaviour (either via an alias or a config option), then
we shouldn't upset many long-time users of revert. Do you agree?

Sam.
