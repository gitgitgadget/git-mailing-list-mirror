From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:49:44 -0700
Message-ID: <7vveql38zr.fsf@assigned-by-dhcp.cox.net>
References: <20060628093322.GA29036@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:49:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWgA-0006UO-0X
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWF1Jtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWF1Jtq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:49:46 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35806 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161016AbWF1Jtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:49:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628094945.YNGR554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:49:45 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060628093322.GA29036@hand.yhbt.net> (Eric Wong's message of
	"Wed, 28 Jun 2006 02:33:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22791>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> Anticipating failure from "git-commit" is the right thing to do,
>> but this is a "Now what?" situation.  What is the expected
>> course of action to recover from this for the end user, and how
>> can we phrase the error message to help that process?
>
> I would expect git-commit to show the correct error message (or the
> pre-commit hook), die "$RESOLVEMSG" might be a better option, though.

It would say 'resolve conflicts, mark them with update-index as
necessary, and say git-commit' or somesuch.  I am not sure you
would want the user to make a commit like suggested -- instead
you would want him to say 'git rebase --continue' wouldn't you?
