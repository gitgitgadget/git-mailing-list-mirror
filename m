From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 16:59:22 +0200
Message-ID: <20100921145922.GA14711@nibiru.local>
References: <1285080133451-5555023.post@n2.nabble.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 13:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz6VD-0000i9-UO
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352Ab0IXLbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 07:31:36 -0400
Received: from caprica.metux.de ([82.165.128.25]:39400 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751391Ab0IXLbf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 07:31:35 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8OBSKqR005578
	for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:32:21 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o8NFvIji021479
	for git@vger.kernel.org; Thu, 23 Sep 2010 17:57:18 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o8LExMCm024853
	for git@vger.kernel.org; Tue, 21 Sep 2010 16:59:22 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1285080133451-5555023.post@n2.nabble.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156976>

* FernandoBasso <FernandoBasso.br@gmail.com> wrote:

Hi,

> Why do we merge, say a testing branch into the master branch ? 
> What is the use of it ?

That heavily depends on your workflows.

I'm a big friend of topic-branches, which means that I'm alsways
working on one topic (eg. fixing one particular bug or developing
some feature) in it's own branch. When it's decided that the code
is ready to go mainline, it will be merged into there (normally
the "master" branch).

And I really advise rebasing the topic branch onto the mainline,
which means, the changes that happened in the topic branch after
the forkoff, will be applied step by step ontop the mainline,
so coming after those happend meanwhile in the mainline.
(use the -ff option on merge if it should show up in history
as merge instead of sequential additions - see "fast forward").
This can reduce the chance of conflicts dramatically and make
them easier to resolve.

> When there is a conflict when merging branches (merging the
> testing into the current branch), should I edit the 'current' 
> branch or the 'testing' branch ?

You can resolve the conflict within the merge (git will tell you
the conflicts and leave conflict markers in the source code - 
see "resolving conflicts").

As said above, I always rebase the to-be-merged branch ontop
the destination and resolve conflicts there. After this there
can be no conficts as the rebased branch is now an direct
descendant of the merge target (so, fast-forward possible).

> Should both branches have exactly the same code so that they 
> can be merged without conflicts ?

Obviously not - in this case you wouldn't even need a merge.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
