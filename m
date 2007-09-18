From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 23:50:50 +1200
Message-ID: <46EFBB9A.5070404@vilain.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>	 <11900461843997-git-send-email-hjemli@gmail.com>	 <20070918005013.GA6368@muzzle>	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net> <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbb6-0005lC-GT
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbXIRLt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbXIRLt6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:49:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60251 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbXIRLt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:49:58 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8278323C266; Tue, 18 Sep 2007 23:49:55 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D412A23C262;
	Tue, 18 Sep 2007 23:49:50 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58585>

Lars Hjemli wrote:
> On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
>   
>> I think that writing a real fast-forward merge should only happen on
>> dcommit, not git merge, because that is what is required for SVN.
>>     
>
> I don't think git-svn has any way of knowing that the user wanted a
> merge, unless a merge commit is present. So the user would have to
> specify the set of commits which should be considered a merge during
> dcommit (this would actually resemble how merges are performed in
> subversion).
>   

Sure it can.  If you're committing to branch X, and the current tree has
a whole lot of commits above that, then it should do the only thing you
can do with SVN.

Which is write a squash commit, and set the "svn:merge" and/or
"svk:merge" properties to represent what happened.

> Sidenote: this might be slightly controversial, but I've sometimes
> missed a --no-ff option to 'git merge' when working on plain git
> repositories; IMHO preserving the 'logical' merge history when the
> merge of a topic branch results in a fast-forward can be interesting.

If you really want one, use git commit-tree directly.

Sam.
