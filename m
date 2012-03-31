From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: rebase -p loses amended changes
Date: Sat, 31 Mar 2012 11:35:02 +0200
Message-ID: <87fwcpun95.fsf@thomas.inf.ethz.ch>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, <jrobertray@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 11:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDuik-0001gX-Tk
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 11:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab2CaJfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 05:35:10 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16352 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967Ab2CaJfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 05:35:08 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Sat, 31 Mar
 2012 11:35:05 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 31 Mar
 2012 11:35:05 +0200
In-Reply-To: <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	(Jon Seymour's message of "Sat, 31 Mar 2012 16:55:22 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194443>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Sat, Mar 31, 2012 at 9:49 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>> J Robert Ray <jrobertray@gmail.com> writes:
>>
>>> If a merge is amended to add changes to a file unaffected by the
>>> merge, these changes are lost after a rebase. Attached is a script to
>>> demonstrate the problem.
>>
>> That's pretty much expected. rebase -p attempts to (conflicts will
>> happen again) replay the merge.  I don't think anybody's come up with a
>> clear idea of how to apply the conflicted or evil parts of the merge
>> mechanically.
>
> I wonder if there are any really good justifications for changing the
> content, as distinct from the comments of a merge during an amendment?

Semantic conflicts do not necessarily show up as
conflicts-to-be-resolved.  The canonical example is when you change the
signature of a function on one side of the merge, and introduce new
callers on the other side.  The merge must then patch all new callers
too.

> If not, perhaps git could be a little bit noisy about the circumstance
> at the point of the --amend commit?

That could still be done of course.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
