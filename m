From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 13:19:32 +0200
Message-ID: <4DAD6FC4.6060004@drmicha.warpmail.net>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name> <vpqhb9vplu4.fsf@bauges.imag.fr> <7v39lfa1h5.fsf@alter.siamese.dyndns.org> <20110419093108.GA7440@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Stefan Sperling <stsp@stsp.name>
X-From: git-owner@vger.kernel.org Tue Apr 19 13:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC8y5-0007Yj-7P
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 13:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab1DSLTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 07:19:37 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49692 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571Ab1DSLTf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 07:19:35 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 499AE20A46;
	Tue, 19 Apr 2011 07:19:35 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 19 Apr 2011 07:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4rL0dMwIM6XfxNC10/AgJPU5hCc=; b=T0PuZn3vh3YCjRNOoE5EjCwwSlzc0QDq6gkvbnPJxqsQewlxJLlOyhcHUBzJgNql/Yz4FAHl61+HIWtUYbLYWYSYCKzQaEFo6MPlZn58Z50w9tMpBCXKdkFgum0UaKA9N1t5KqscSQVnC8Zs62WTeid7+hAINz3DLEaj4Lux42k=
X-Sasl-enc: PcAHNzt10KQQtxB3BhF/Rv6/e4GKkm6qYh5a+8vYQboN 1303211975
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8290D446FDA;
	Tue, 19 Apr 2011 07:19:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110419093108.GA7440@ted.stsp.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171791>

Stefan Sperling venit, vidit, dixit 19.04.2011 11:31:
> On Mon, Apr 18, 2011 at 10:55:18AM -0700, Junio C Hamano wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Stefan Sperling <stsp@stsp.name> writes:
>>>
>>>> -DESIGN PHILOSOPHY
>>>> ------------------
>>>> -Merge tracking in Subversion is lacking and doing branched development
>>>> -with Subversion can be cumbersome as a result.  While 'git svn' can
>>>> track
>>>
>>> Agreed (this and the rest of the patch). Users reading git-svn's doc
>>> don't want a dissertation about how bad SVN is, and if they do, they can
>>> read whygitisbetterthanx ;-)
> 
> Exactly :)
> 
> And they might rather want to learn more about how Subversion has improved
> since version 1.4. It seems that these parts of the text were written
> before Subversion's 1.5 release. SVN is a lot more capable now than the
> git-svn docs suggest and I'm surprised that git-svn's development seems
> to have gotten stuck at the 1.4 level of functionality. Not even CentOS
> ships with 1.4 anymore these days.
> 
> E.g. git-svn could be taught to generate svn mergeinfo compatible with other
> Subversion clients. It's not easy to come up with a generic mapping between
> the two systems but for some use cases it should be reasonably straightforward.
> This would be a nice improvement towards making git-svn a proper drop-in
> replacement for the standard svn client. Currently, git-svn cannot be
> used without disturbing other users doing merges with Subversion itself
> which is a pity.

6abd933 (git-svn: allow the mergeinfo property to be set, 2010-09-24)

made a first step in that direction so that you can at least add
mergeinfo manually. But, git-svn.perl is basically in maintenance mode
it seems, and more work is being done to implement a new svn remote helper.

Also, I think merge tracking wasn't that reliable in svn 1.5 before svn
1.6, and we try to support older versions. In particular, we want to
support the versions on typical svn hosting sites which are not always
that recent.

> 
> I don't have time to work on this myself but I would be more than happy
> to assist with design and review.
> 
>> I agree the change in the patch is good.  It needs to be signed-off,
>> though.
> 
> I've sent a signed-off version with git send-email. Thanks!
