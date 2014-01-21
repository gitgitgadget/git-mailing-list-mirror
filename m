From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 20:56:06 +0100
Message-ID: <87r481p0rt.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
	<874n4xqlly.fsf@fencepost.gnu.org> <20140121174448.GG18964@google.com>
	<87zjmpp672.fsf@fencepost.gnu.org> <20140121191531.GH18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hQj-0002EA-BA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaAUT4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 14:56:10 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:43958 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaAUT4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 14:56:08 -0500
Received: from localhost ([127.0.0.1]:43000 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5hQd-0006gP-Ik; Tue, 21 Jan 2014 14:56:07 -0500
Received: by lola (Postfix, from userid 1000)
	id F3FD0E051D; Tue, 21 Jan 2014 20:56:06 +0100 (CET)
In-Reply-To: <20140121191531.GH18964@google.com> (Jonathan Nieder's message of
	"Tue, 21 Jan 2014 11:15:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240769>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Any idea how this could be made more clear?  E.g., maybe we should
>>> bite the bullet and add a line to all source files that don't alrea=
dy
>>> state a license:
>>>
>>> 	/*
>>> 	 * License: GPLv2.  See COPYING for details.
>>> 	 */
>>
>> Probably somewhat more verbose like "This file may be distributed un=
der
>> the conditions of the GPLv2.  See the file COPYING for details".
>> I=A0think there are boilerplate texts for that.
>
> All else being equal, longer is worse.

I am not sure that all else is equal.

>> Whatever the exact wording, that would be the cleanest way I think. =
 The
>> respective Documentation/SubmittingPatches text looks like it is quo=
ted
>> from somewhere else, so adapting it to the realities of files withou=
t
>> clear copyright statement seems less straightforward.
>
> Hm, the wording comes from the Linux kernel project, where it's also
> pretty normal not to have a license notice in every file (and where
> the default license is also GPLv2).
>
> Is the problem the phrase "indicated in the file",

At least that's what I perceive as a problem in combination with the
complete absence of any such notice in the file I am contributing to.

git grep -i license

actually shows a dearth of licensing information outside of subprojects
and contrib.  The README file states

    Git is an Open Source project covered by the GNU General Public
    License version 2 (some parts of it are under different licenses,
    compatible with the GPLv2). It was originally written by Linus
    Torvalds with help of a group of hackers around the net.

without mentioning _which_ parts are under different licenses.  The
license file COPYING itself does not specify which files are covered,
and there is _also_ LGPL-2.1 which has a statement

     While most of this project is under the GPL (see COPYING), the
     xdiff/ library and some libc code from compat/ are licensed under
     the GNU LGPL, version 2.1 or (at your option) any later version an=
d
     some other files are under other licenses.  Check the individual
     files to be sure.

Well, and when checking the individual files, there is really nothing
to be found for "being sure".

The net result is that when signing off on a patch according to the
rules in Documentation/SubmittingPatches, for most files you don't
really have a definite statement just _what_ license you are agreeing
your work to be distributed under.

> or is the problem
> e.g. the lack of a pointer to
> https://github.com/libgit2/libgit2/blob/development/git.git-authors?

No, not at all.  libgit2 is not in any way special among projects that
might want to have access to Git code under different licenses.  It
would be possible to state something like "Unless indicated otherwise,
consent will be assumed for contributions to Git as being
redistributable in the libgit2 project under its respective licenses" o=
r
something, but I think that would be seriously surprising, and not
noticing such a clause could not be construed as implying consent.

--=20
David Kastrup
