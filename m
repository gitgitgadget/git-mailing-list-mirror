From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 03:02:27 -0700
Message-ID: <CAJsNXTmJo6UXYS4AXygSLq2+T8MV0Sp0KhUt_mvgMqxC_k27ig@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John S. Urban" <urbanjost@comcast.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R09dg-0002hN-QF
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 12:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab1IDKJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 06:09:13 -0400
Received: from p3plsmtpa08-08.prod.phx3.secureserver.net ([173.201.193.109]:36540
	"HELO p3plsmtpa08-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753558Ab1IDKJL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 06:09:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Sep 2011 06:09:11 EDT
Received: (qmail 12777 invoked from network); 4 Sep 2011 10:02:30 -0000
Received: from unknown (209.85.161.46)
  by p3plsmtpa08-08.prod.phx3.secureserver.net (173.201.193.109) with ESMTP; 04 Sep 2011 10:02:30 -0000
Received: by fxh19 with SMTP id 19so2994402fxh.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 03:02:27 -0700 (PDT)
Received: by 10.223.13.196 with SMTP id d4mr1638504faa.59.1315130547451; Sun,
 04 Sep 2011 03:02:27 -0700 (PDT)
Received: by 10.223.96.7 with HTTP; Sun, 4 Sep 2011 03:02:27 -0700 (PDT)
In-Reply-To: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180674>

On Sat, Sep 3, 2011 at 6:32 PM, John S. Urban <urbanjost@comcast.net> w=
rote:
> With my first use of git(1) I =A0created a small project with about 2=
00
> "commits". =A0When this was complete, I needed to label each commit w=
ith
> information pointing it to a section of a document. I used tags for t=
his. So
> far, everything was fine. I was then asked to merge two commits
> into one. I then did a "rebase" (for the first time). I then appear t=
o have
> lost all association between the tags and the effected commits; as al=
l
> commits after
> the ones I modified no longer see "their" tags. Was there a way to ha=
ve kept
> the tags associated with the original commits as they were "rebased"?

When Old Biff Tannen traveled back to the year 1955 and gave his
younger self a copy of Grays Sports Almanac, which listed the outcomes
of every major sporting event from the years 1950-2000, the timeline
skewed, creating an alternate reality in which he had won enough money
through gambling to take over the town of Hill Valley.  If Marty McFly
had kept a reflog, like Git does, he could have backtracked in his
personal history and just not left the almanac and the time machine
where Biff could find them.  Instead, he had to go back to 1955 and
steal the almanac from young Biff after old Biff had given it to him.
But this metaphor is getting silly, and alienating anyone who wasn't
watching American movies in the late 1980s.

My point is that the tags are still there, and they still point to the
same commits they always pointed to.  It's just that those commits are
part of the original history, not the alternate history created by the
rebase.  People say that Git can "rewrite" history, but really it
creates a new history for the branch.  The old history is still around
as long as there are references to it, until the garbage collector
picks it up.

Once a tag points to a commit, it isn't meant to be easy to make it
point to a different commit.  For the same reason that you wouldn't
release version 1.8.3 of some software, and then later make a new
release also called 1.8.3.

> Also, I have some commits with multiple tags pointing to them. It has=
 come
> to my attention that might not be an intentional feature. I could fin=
d
> nothing in the documentation explicitly stating multiple tags were al=
lowed
> to point to a commit; but the tags seem to be unique "objects" so I
> see no reason this should not be an expected feature?

There's no reason you can't have multiple tags pointing to the same com=
mit.

> Thanks for any insights. Other than loosing association between the t=
ags and
> the commits with rebase (which I was hesitant to use; and am now
> doubly so) I found git(1) to be the first version control system bett=
er than
> "be careful and make tar-balls of major releases"; although I am just
> starting to get an idea of how the pieces work.

It's generally accepted that rebasing commits that other people have
had access to is a bad idea. :-)

-PJ
