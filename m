From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Thu, 03 Jun 2010 10:40:12 +0200
Message-ID: <4C076A6C.601@drmicha.warpmail.net>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 10:40:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK5yp-0003W0-H4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 10:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab0FCIkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 04:40:41 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56454 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932473Ab0FCIkj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 04:40:39 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 66598F8BCD;
	Thu,  3 Jun 2010 04:40:33 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 03 Jun 2010 04:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iPyBrZMOtDmXNqSYExIUUTTIzGs=; b=Ymbq+/kHaA85fKvMQUD40P1Ja1z2ifD1qdkQ5R5Znf4VJW6edjSImp/u7jPIDk9npw1BseabdlogQWuhHdJJz1GuSYptnyQ2HIMsOTvynshANr8U8Z+ht1LkSsdJJGUjIyMdttfcknetM5ZCueTyPisYxERbZO49/1MlqbteQ3s=
X-Sasl-enc: sFQM/fRWjaNByujbPTbo85iHyNzXycg3cGWvjzM+nkca 1275554432
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8875D4E56AE;
	Thu,  3 Jun 2010 04:40:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148299>

Junio C Hamano venit, vidit, dixit 03.06.2010 01:36:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the integration branches, but I am
> still holding onto them.
> 
> Many topics that have been cooking since 1.7.1 pre-release freeze period
> are now in master; maybe it is a good time to start freezing feature
> branches for 1.7.2---I think I said I'll keep this cycle shorter, no?
> 
> --------------------------------------------------
> [New Topics]
> * mg/status-b (2010-05-25) 2 commits
>  - Documentation+t5708: document and test status -s -b
>  - Show branch information in short output of git status
> 
> There are a few style violations that snuck in, but otherwise looked
> sensible.

I tried to follow surrounding style. Or do you mean the "if(" and local
variable initialisations in David'd patch? Do you want any of us to
recheck and resubmit?

I'm running with David's -b all the time, btw, it dramatically reduced
my need for long-status. Works great.

> --------------------------------------------------
> [Stalled -- would discard unless there are some movements soon]
> 
> * jc/rev-list-ancestry-path (2010-04-20) 1 commit
>  - revision: --ancestry-path
> 
> Just an illustration patch.  merge simplification logic used when
> pathspecs are in effect interacts with this rather badly.

I think it's still useful. Do all rev-walker flags need to interact
sanely with each other? We could just discourage --ancestry-path with
merge-simplification (and later try to reconcile them).

> --------------------------------------------------
> [Cooking]
> 
> * em/checkout-orphan (2010-05-21) 5 commits
>  - bash completion: add --orphan to 'git checkout'
>  - t3200: test -l with core.logAllRefUpdates options
>  - checkout --orphan: respect -l option always
>  - refs: split log_ref_write logic into log_ref_setup
>  - Documentation: alter checkout --orphan description
> 
> In <4BFE2461.5080501@drmicha.warpmail.net>, Michael J Gruber raised a
> valid request for a better explanation of superfluous files left behind
> and then are cleaned.  Other than that I think this is a sane thing to
> do.

Got no response but had the impression that retracting myself from the
discussion may improve the willingness of the submitter :)

> * mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
>  - revlist: Introduce --lrbranches and --locals revision specifiers
>  (this branch uses mg/rev-parse-option-sifter-deprecation.)
> 
> Hmmm...

Now I know what to do ;)

Another approach would be to have something like "ref aliases". I often
use origin/next..origin/pu and origin/next@{1}..origin/next for example.
Maybe allowing something like

[refalias]
	puextra	= origin/next..origin/pu
	punew	= origin/next@{1}..origin/next
	locals	= HEAD --branches --tags
	lrbranches = --branches --remotes

would make more sense and allows for personal choices. Hmmm? ;)

> 
> * mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
>  - t6018: make sure all tested symbolic names are different revs
>  - t6018: add tests for rev-list's --branches and --tags
>  - rev-parse: deprecate use as an option sifter
>  (this branch is used by mg/rev-parse-lrbranches-locals.)
> 
> Some people might interpret "Deprecate" too strongly; the intent is that
> we shouldn't keep piling parsing of new rev-list options to it and
> discourage the use of "option sifter" in new programs.

So, s/deprecated/discouraged/? Is there an alternative we should suggest
there for scripts needing to sift their options?

Cheers,
Michael
