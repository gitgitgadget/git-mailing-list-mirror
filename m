From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH 2/2] Documentation: git-clean: make description more readable
Date: Sat, 25 Apr 2009 19:23:43 -0600
Organization: icecavern.net
Message-ID: <200904251923.46448.wjl@icecavern.net>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net> <1240672421-10309-3-git-send-email-wjl@icecavern.net> <49F35833.5070005@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 03:31:53 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxtDj-0004GB-EO
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 03:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZDZBX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 21:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZDZBX4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 21:23:56 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:36773 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751411AbZDZBX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 21:23:56 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 60EAF364B9;
	Sat, 25 Apr 2009 19:23:50 -0600 (MDT)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <49F35833.5070005@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117579>

On Saturday 25 April 2009 12:36:35 Stephen Boyd wrote:
> Wesley J. Landaker wrote:
> >  DESCRIPTION
> >  -----------
> > -Removes files unknown to git.  This allows cleaning the working tree
> > -of files that are not under version control.  If the '-x' option is
> > -specified, ignored files are also removed, allowing the removal of all
> > -build products.
> > +
> > +This allows cleaning the working tree by removing files that are not
> > +under version control.
> > +
>
> Why is the "Removes files unknown to git" part lost? Maybe it should be
> replaced with a copy of the Name section, similar to log and diff. For
> example:

The main reason I took that out in my patch was because I think the second 
sentence more says the same thing, except more clearly, and the exact 
semantics of "files unknown to git" versus "ignored files", etc seem to not have 
good definitions anyway, so I left that for the second paragraph that talks 
about how '-x' changes things.

Also, the NAME section already says "Remove untracked files from the working 
tree", and most other git command documentation pages do not repeat the 
summary in the description, but start right in to the behavioral details.

> > +Normally, only files unknown to git are removed, but if the '-x'
> > +option is specified, ignored files are also removed. This can, for
> > +example, be useful to remove all build products.
>
> This seems overly wordy. Maybe:
>
> Specifying the '-x' option will also remove ignored files. This is
> useful to remove generated files.
>
> Better?

I agree more concise is usually better. But I do think keeping the "for 
example" is important so that the user doesn't think that "generated files" is 
something special (ignore rules are used for lots of different things).

So I might edit yours to say:

Specifying the '-x' option will also remove ignored files. This is useful to 
remove, for example, generated files that are normally ignored.

> On a side note, why is -x getting special treatment here but not -X or
> -d? You might want to just describe the general usefulness of the
> command and let the reader move onto the options to learn more.

I left the part about '-x' there mostly because it was already in there, so I 
figured someone at some point thought it was special enough. I didn't want to 
undo any good decisions that had already been made. =) That said, both -x and 
-X are somewhat special because they change the behavior a LOT compared to, 
say, -d.
