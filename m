From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 00:56:50 +0200
Message-ID: <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
	<loom.20130523T185301-635@post.gmane.org>
	<87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
	<7vd2shcnx7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Greenleaf <james.a.greenleaf@gmail.com>, <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeRO-0003om-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893Ab3EWW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:56:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:8417 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759830Ab3EWW4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:56:54 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 May
 2013 00:56:48 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.208.253) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 24 May 2013 00:56:51 +0200
In-Reply-To: <7vd2shcnx7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 May 2013 15:49:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225314>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> So maybe it would be time to first make up our minds as to what
>> --assume-unchanged should actually mean:
>>
>> * Ignore changes to a tracked file, but treat them as valuable.  In
>>   this case we'd have to make sure that failures like git-stash's are
>>   handled properly.
>>
>> * Ignore changes to a tracked file, as in "who cares if it was changed".
>>
>> * A very specific optimization for users who know what they are doing.
>
> It has always been a promise the user makes to Git that the working
> tree files that are marked as such will be kept identical to what is
> in the index (hence there is no need for Git to check if they were
> modified). And by extension, Git is now free to choose reading from
> the working tree file when asked to read from blob object recorded
> in the index for that path, or vice versa, because of that promise.
>
> It is not --ignore-changes bit, and has never been.  What are the
> workflows that are helped if we had such a bit?  If we need to
> support them, I think you need a real --ignore-changes bit, not
> an abuse of --assume-unchanged.

I gather -- from #git -- that it's mostly used for config files, which
have an annoying habit of being different from the repository.

Which is wrong, really.  But we still claim that --assume-unchanged is a
solution to it in git-update-index(1).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
