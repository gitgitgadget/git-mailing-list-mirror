From: Bruno Haible <bruno@clisp.org>
Subject: Re: request for documentation about branch surgery
Date: Tue, 7 Jul 2009 11:51:02 +0200
Message-ID: <200907071151.03567.bruno@clisp.org>
References: <200907070105.12821.bruno@clisp.org> <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 11:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO7Kp-0002f3-26
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 11:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZGGJvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 05:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbZGGJvX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 05:51:23 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:10295 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbZGGJvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 05:51:22 -0400
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRbfU4489asA==
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
	(dslb-088-068-043-109.pools.arcor-ip.net [88.68.43.109])
	by post.strato.de (mrclete mo15) (RZmta 18.49)
	with ESMTP id U00494l679YqtU ; Tue, 7 Jul 2009 11:51:24 +0200 (MEST)
User-Agent: KMail/1.9.9
In-Reply-To: <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122831>

Hi Elijah,

> When the cost of certain activities changes dramatically (which git
> does by making lots new things possible and fast), formerly "exotic"
> usecases can become natural and common -- and really helpful.

Yes. With cvs, I would not never have dared to do branch surgery. With
git, I can - assuming some documentation. "git clone", "git checkout",
"git commit" each serves a particular purpose, so one can understand
when to use which command. But for branch surgery, several commands
are available:
  - "git reset --hard"
  - "git rebase"
  - "git rebase --onto"
  - "git merge" (simple case, no merge commit)
The mapping from "How do I ..." questions to command is not easy,
therefore a user's manual like
  <http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#rewriting-one-commit>
is needed.

Thanks for correcting me and showing simpler alternatives to what
I said.

Still, can someone please extend the cited chapter of the user's manual,
so that it answers these questions?
  - How do I change the last commit in a branch?       [DONE]
  - How do I change an older commit in a branch?       [DONE]
  - How do I insert some commits between other commits in a branch?
                                                       [TODO]
  - How do I reorder commits in a branch?              [TODO - mention "git rebase -i"]
  - How do I copy selected commits from a branch to another?
                                                       [DONE]
  - How do I cut a branch?                             [TODO]
  - How do I replace a branch tip with the contents of another branch?
                                                       [TODO]
  - How do I reconnect a branch to another branch point?
                                                       [TODO]

> I think
> the rebase command would be much easier to understand for new users if
> it used an "--against" before the first reference(*).

Don't know, this is just a cosmetic change. The thing that confused me
about "git rebase" is that its thinking is focused on the current branch.
Whereas when I'm doing branch surgery, I'm creating a new branch
bottom-up, so my thinking is "here I have some commits, what can I do
with them". It requires a good user's manual to map this to the right
"git rebase" command.

Bruno
