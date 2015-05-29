From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Fri, 29 May 2015 17:00:20 +0200
Message-ID: <vpq4mmvv37f.fsf@anie.imag.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqiobcy9yt.fsf@anie.imag.fr>
	<xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com>
	<vpqlhg8pk1o.fsf@anie.imag.fr>
	<xmqq382gh465.fsf@gitster.dls.corp.google.com>
	<12496325.145058.1432896023146.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 17:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyLm4-0004lb-G0
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbbE2PAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:00:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44631 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756200AbbE2PA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:00:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4TF0IpO023516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 17:00:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4TF0KPJ003040;
	Fri, 29 May 2015 17:00:20 +0200
In-Reply-To: <12496325.145058.1432896023146.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Guillaume Pages's message of "Fri, 29 May 2015 12:40:23 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 17:00:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4TF0IpO023516
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433516420.2257@FHdfy9ysO0XvUbc35umeOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270241>

Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> rebase in progress; onto d9d448a You are currently rebasing branch
> 'branche1' on 'd9d448a'.  (fix conflicts and then run "git rebase
> --continue") (use "git rebase --skip" to skip this patch) (use "git
> rebase --abort" to check out the original branch) (5 commits applied,
> 3 remainings) Failed to apply:
>
> 252c273 commit message

You messed-up something with the formatting, but I agree that this would
be nice. I'd reverse order between the hints ("(use ... to ...)") and
the "Failed to apply: ...".

> And during an interactive rebase:
>
> rebase in progress;

This could even become "interactive rebase in progress".

Most of the time, you're supposed to remember whether you ran "git
rebase" with -i, but a typical use-case is when a newbie requests help
like "I don't know what I did, but can you fix it?", and then any
information can be valuable.

> Last commands done (5 commands done) :
>
> pick 62609785 commit message1 reword 85ae9001 new commit message2
>
> (See more at .git/rebase-merge/done)
>
> Next commands to do (3 remainings commands) :
>
> squash 62609785 commit message3 pick 85ae9001 commit message4
>
> (See more at .git/rebase-merge/git-rebase-todo)

Not sure the blank lines are meant to be there, but I wouldn't put them
in the actual output. I'd format it as

Last commands done (5 commands done) :
  pick 62609785 commit message1
  (see more at .git/rebase-merge/done)

(lower-case "see" to be consistant with other hints)

> Is it a good practice to send the user find information in the .git
> directory?

We usually avoid doing that and provide commands to do this (e.g. "git
rebase --edit-todo" instead of asking the user to do $EDITOR
.git/rebase-merge/git-rebase-todo), but the ones you show seem OK to me.

There's already at least one instance of this when a rebase fails:

  Patch failed at 0001 foo
  The copy of the patch that failed is found in:
     /tmp/clone/.git/rebase-apply/patch

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
