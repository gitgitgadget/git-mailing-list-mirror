From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 03 Mar 2014 11:11:30 +0100
Message-ID: <87y50rlhgt.fsf@fencepost.gnu.org>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	<vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu>
	<vpq7g8bfws8.fsf@anie.imag.fr>
	<CACsJy8CPhTQxpnY70PxD9zFSipaJCTQPBsmReD8E9tmEgsvTRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQDp-0000fe-8j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaCCKfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:35:41 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49174 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbaCCKfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:35:40 -0500
Received: from localhost ([127.0.0.1]:48208 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKQDi-0004rr-Ed; Mon, 03 Mar 2014 05:35:38 -0500
Received: by lola (Postfix, from userid 1000)
	id BF421E065B; Mon,  3 Mar 2014 11:11:30 +0100 (CET)
In-Reply-To: <CACsJy8CPhTQxpnY70PxD9zFSipaJCTQPBsmReD8E9tmEgsvTRg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 3 Mar 2014 17:04:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243217>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Mar 3, 2014 at 4:37 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Or perhaps "-NUM" should fail with an error message if any of the last
>>> NUM commits are merges.  In that restricted scenario (which probably
>>> accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".
>>
>> Makes sense to me. So, -NUM would actually mean "rebase the last NUM
>> commits" (as well as being an alias for HEAD~NUM), but would fail when
>> it does not make sense (with an error message explaining the situation
>> and pointing the user to HEAD~N if this is what he wanted).
>
> Agreed, but..
>
>> This would actually be a feature for me: I often want to rebase "recent
>> enough" history, and when my @{upstream} isn't well positionned, I
>> randomly type HEAD~N without remembering what N should be. When N is too
>> small, the rebase doesn't reach the interesting commit, and when N is
>> too big, it reaches a merge commit and I get a bunch of commits I'm not
>> allowed to edit in my todo-list. Then I have to abort the commit
>> manually. With -N failing on merge commits, the rebase would abort
>> itself automatically.
>
> would "git rebase -i --fork-point" be what you need instead? It's a
> new thing, but may be what we actually should use, not this -NUM..

-0 might be a good mnemonic for --fork-point, though.

Of course, when using --preserve-merges explicitly it would appear that
-NUM should not error out.

-- 
David Kastrup
