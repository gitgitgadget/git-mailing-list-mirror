From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Pushing/fetching from/into a shallow-cloned repository
Date: Fri, 19 Apr 2013 20:02:34 +0400
Message-ID: <20130419200234.215de8c7b5dc7510025847b9@domain007.com>
References: <20130418135233.87aa23896fa48dc2d87d80fb@domain007.com>
	<8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley>
	<7vbo9b4fuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Konstantin Khomoutov" <kostix+git@007spb.ru>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTDlw-00061r-7q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab3DSQCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:02:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:45746 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab3DSQCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:02:42 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3JG2YRU024890;
	Fri, 19 Apr 2013 20:02:35 +0400
In-Reply-To: <7vbo9b4fuz.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221765>

On Thu, 18 Apr 2013 15:46:12 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> >> So I observe pushing/fetching works OK at least for a simple case
> >> like this one.
> >>
> >> Hence I'd like to ask: if the manual page is wrong or I'm observing
> >> some corner case?
> >> --
> > The manual is deliberately misleading.
> 
> Yes, it is erring on the safe side.
> 
> It was not coded with the case where the gap widens (e.g. either
> side rewinds the history) in mind as you explained; for simple cases
> the code just happens to work, but the users are encouraged not to
> rely on it to be safe than sorry.

Well, actually my question arouse during the discussion which followed
by this SO question [1] where someone asked if it's possible to update
just one file in a remote repository without cloning it first (a-la
Subversion, that is).  While I perfectly understand that Git data model
does not support such "server-side commits" I'm able to envision a case
when, say, a developer is asked to perform some minor tweak to the code
while they're in a situation with no repository clone at hand and only a
crappy/costly cellular link available for communication.  I think
shallow cloning might be a palliative solution to this kind of problem
(a one-off clone/edit/commit/push session).

Taking into account what Duy Nguyen said on this topic, it seems that
that description of the shallow cloning in the git-clone manual page
could supposedly be made somewhat less denying about what could be done
using a shallow clone.  May be a note that such a setup could be okay
for very simple things like clone/edit/push would be just enough?

1. http://stackoverflow.com/q/16077691/720999
