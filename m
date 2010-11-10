From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Wed, 10 Nov 2010 08:43:43 +0100
Organization: Bertin Technologies
Message-ID: <20101110084343.0c519764@chalon.bertin.fr>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan> <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
 <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org> <20101108222937.GH3167@home.lan>
 <20101110014215.GA1503@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yann Dirson <ydirson@free.fr>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 08:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG5Vj-0003Ld-IO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab0KJHyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:54:22 -0500
Received: from blois.bertin.fr ([195.68.26.9]:36367 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab0KJHyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:54:21 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 916155420E
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:54:20 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 4E99454214
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:54:20 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBN003OISMJZM70@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 10 Nov 2010 08:54:20 +0100 (CET)
In-reply-to: <20101110014215.GA1503@burratino>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17756.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161136>

On Tue, 09 Nov 2010 19:42:15 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Yann Dirson wrote:
> 
> > |Keep in mind that any commit in the original todo list, that would
> > |not be there after your edits, would not be included in the
> > resulting |rebased branch.  In case you realize afterwards that you
> > need such a |commit, you can still access it as an ancestor of
> > @{1}, see |git-reflog(1) for details.
> 
> Do you mean @{-1}?
> 
> > Maybe we could list a copy of the todo list in the comments, as a
> > reference for double-checking.  Such a list could even be used for a
> > final check before applying, that would ask confirmation if the set
> > of patches has changed, and offer to edit again.  The same config
> > item (eg. advice.interactiveRebase ?) could be used to hide the
> > note and the check.
> 
> Mm, but intentionally dropping commits is common, no?

Yes, but for people new to the feature, who may not feel at ease right
away with it, it may make sense to get warned when some change will get
lost.

BTW, about people feeling at ease with "rebase -i", I often feel not
quite comfortable to explain why to reorder commits you have to use
this "rebase" feature which sounds so strange in itself to people used
to centralized VCS.  Would that make sense to have a standard command
to reduce some confusion, like (untested):

alias.reroll = rebase -i $(git merge-base HEAD @{upstream})

> What would be nice is to be able to do
> 
> 	git rebase --change-of-plans
> 
> and somehow get my editor of choice to open with the original todo
> list (read-only) and the current todo list (read/write).
> 
> Well, a person can dream. :)

Well, that's not far from my own dreams of --back, --next and the
like :)

-- 
Yann Dirson - Bertin Technologies
