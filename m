From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] rev-list and friends: --min-parents, --max-parents
Date: Fri, 18 Mar 2011 15:54:32 +0100
Message-ID: <4D837228.4070102@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net> <cover.1300459016.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Mar 18 15:58:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b7w-00035m-Br
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1CRO6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:58:01 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37415 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953Ab1CRO6A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:58:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B7CC020432;
	Fri, 18 Mar 2011 10:57:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 18 Mar 2011 10:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=yJ+dBB/amQnmAcIuyCzuBUZ2A3E=; b=FYsr/g5qigdkl4LzoZ+lNKKquc4il+7X7y3Lu1uQX2alHWkMRLXBPB+cVd0gPYCzTgcEXAzpWjLFbZlYfWXUTAvfaBf7zO0PFWRIV4Co4T1jDjtBDUOR+BbhJG2lFZAm/04BLSxymhOY5bnYcKY4uu2yhf3US61KlT6DB3fojLY=
X-Sasl-enc: 7cFOOzsBm64sgy///2jLehujrvc9n+We74Ytz7qYg44K 1300460279
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F1891444CE5;
	Fri, 18 Mar 2011 10:57:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <cover.1300459016.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169328>

Michael J Gruber venit, vidit, dixit 18.03.2011 15:50:
> As opposed to the RFD it replaces, this is a real patch series with
> documentation and tests, and it even comes with boiler plate. It should
> make all of Jeff's and Junio's dreams come true (as far as revision
> limiting by parent number goes).
> 
> 1/3 introduces the new options (and has a proper commit message)
> 2/3 I noted along the way and could be applied earlier
> 3/3 depends on 1 and 2 and is the candy (doc, tests, completion)
> 
> *** BLURB HERE ***

Hmpf. I guess this should say "NO MORE BLURB HERE". Gosh!

This comes from filling in the cover letter by using

:r! git notes show ref:HEAD

in vim and partially failing to delete the place holders. Longing for
that format-patch option "--note-cover".

> 
> Michael J Gruber (3):
>   revision.c: introduce --min-parents and --max-parents
>   t6009: use test_commit() from test-lib.sh
>   rev-list --min-parents,--max-parents: doc and test and completion
> 
>  Documentation/git-rev-list.txt         |    2 +
>  Documentation/rev-list-options.txt     |   13 +++++
>  builtin/log.c                          |    2 +-
>  builtin/rev-list.c                     |    2 +
>  builtin/rev-parse.c                    |    2 +
>  contrib/completion/git-completion.bash |    1 +
>  revision.c                             |   23 ++++++---
>  revision.h                             |    9 +++-
>  t/t6009-rev-list-parent.sh             |   85 +++++++++++++++++++++++++++-----
>  9 files changed, 117 insertions(+), 22 deletions(-)
> 
