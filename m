From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 21:12:39 +1200
Message-ID: <46EF9687.6070304@vilain.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>	<11900461843997-git-send-email-hjemli@gmail.com>	<20070918005013.GA6368@muzzle>	<8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com> <7v4phsxy55.fsf@gitster.siamese.dyndns.org> <46EF7EA1.6020402@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZ7d-0006zC-Pt
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXIRJLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbXIRJLr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:11:47 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58751 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbXIRJLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:11:46 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6AAB823C262; Tue, 18 Sep 2007 21:11:43 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 1BD812055B6;
	Tue, 18 Sep 2007 21:11:39 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <46EF7EA1.6020402@vilain.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58558>

Sam Vilain wrote:
>>> I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.
>>>       
>> That unfortunately does not solve the problem.
>>     
>
> I think we 'just' need to fix pushing merges back to SVN - so that they
> properly set Subversion 1.5+ (and possibly SVK) merge attributes - and
> if it is ambiguous which branch to push to, force the user to decide.
>   

Whoops, I missed the thrust of the current issue; it won't be ambiguous,
it'll be unambiguously wrong, so this doesn't apply.

In which case I'd guess the moral equivalent of --track would have to go
forward, or a per-branch basis.

I think that writing a real fast-forward merge should only happen on
dcommit, not git merge, because that is what is required for SVN. 
Ideally, it should also have the property that it doesn't cycle; null
merges between two branches should not carry on indefinitely.

Sam.
