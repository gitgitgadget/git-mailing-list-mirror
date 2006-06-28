From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:56:46 -0700
Message-ID: <7vmzbx38o1.fsf@assigned-by-dhcp.cox.net>
References: <20060628093322.GA29036@hand.yhbt.net>
	<7vveql38zr.fsf@assigned-by-dhcp.cox.net>
	<20060628095454.GA23948@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 28 11:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWmy-0007PA-9s
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423248AbWF1J4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423249AbWF1J4s
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:56:48 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:3488 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1423248AbWF1J4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:56:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628095647.RYBJ27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:56:47 -0400
To: git@vger.kernel.org
In-Reply-To: <20060628095454.GA23948@soma> (Eric Wong's message of "Wed, 28
	Jun 2006 02:54:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22794>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > Junio C Hamano <junkio@cox.net> wrote:
>> >
>> >> Anticipating failure from "git-commit" is the right thing to do,
>> >> but this is a "Now what?" situation.  What is the expected
>> >> course of action to recover from this for the end user, and how
>> >> can we phrase the error message to help that process?
>> >
>> > I would expect git-commit to show the correct error message (or the
>> > pre-commit hook), die "$RESOLVEMSG" might be a better option, though.
>> 
>> It would say 'resolve conflicts, mark them with update-index as
>> necessary, and say git-commit' or somesuch.  I am not sure you
>> would want the user to make a commit like suggested -- instead
>> you would want him to say 'git rebase --continue' wouldn't you?
>
> Actually RESOLVEMSG in git-rebase just tells the user about the
> --continue, --skip, --abort options.

Yup, so telling the user to disregard what commit might say (but
do not hide it by redirecting 2>/dev/null, please) and dying
with "$RESOLVEMSG" might be a better way.
