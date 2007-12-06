From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Wed, 5 Dec 2007 21:41:19 -0500
Message-ID: <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> 	 <20071205.182815.249974508.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "David Miller" <davem@davemloft.net>
X-From: gcc-return-142711-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 03:41:50 2007
Return-path: <gcc-return-142711-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J06gM-0005Q1-7t
	for gcc@gmane.org; Thu, 06 Dec 2007 03:41:46 +0100
Received: (qmail 7046 invoked by alias); 6 Dec 2007 02:41:27 -0000
Received: (qmail 7032 invoked by uid 22791); 6 Dec 2007 02:41:25 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.191)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 02:41:21 +0000
Received: by rv-out-0910.google.com with SMTP id f5so53365rvb         for <gcc@gcc.gnu.org>; Wed, 05 Dec 2007 18:41:19 -0800 (PST)
Received: by 10.142.52.9 with SMTP id z9mr1450303wfz.1196908879456;         Wed, 05 Dec 2007 18:41:19 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 5 Dec 2007 18:41:19 -0800 (PST)
In-Reply-To: <20071205.182815.249974508.davem@davemloft.net>
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67224>

On 12/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 14:08:41 -0500
>
> > So I tried a full history conversion using git-svn of the gcc
> > repository (IE every trunk revision from 1-HEAD as of yesterday)
> > The git-svn import was done using repacks every 1000 revisions.
> > After it finished, I used git-gc --aggressive --prune.  Two hours
> > later, it finished.
> > The final size after this is 1.5 gig for all of the history of gcc for
> > just trunk.
> >
> > dberlin@home:/compilerstuff/gitgcc/gccrepo/.git/objects/pack$ ls -trl
> > total 1568899
> > -r--r--r-- 1 dberlin dberlin 1585972834 2007-12-05 14:01
> > pack-cd328fcf0bd673d8f2f72c42fbe67da64cbcd218.pack
> > -r--r--r-- 1 dberlin dberlin   19008488 2007-12-05 14:01
> > pack-cd328fcf0bd673d8f2f72c42fbe67da64cbcd218.idx
> >
> > This is 3x bigger than hg *and* hg doesn't require me to waste my life
> > repacking every so often.
> > The hg operations run roughly as fast as the git ones
> >
> > I'm sure there are magic options, magic command lines, etc, i could
> > use to make it smaller.
> >
> > I'm sure if i spent the next few weeks fucking around with git, it may
> > even be usable!
> >
> > But given that git is harder to use, requires manual repacking to get
> > any kind of sane space usage, and is 3x bigger anyway, i don't see any
> > advantage to continuing to experiment with git and gcc.
>
> I would really appreciate it if you would share experiences
> like this with the GIT community, who have been now CC:'d.
>
> That's the only way this situation is going to improve.
>
> When you don't CC: the people who can fix the problem, I can only
> speculate that perhaps at least subconsciously you don't care if
> the situation improves or not.
>
I didn't cc the git community for three reasons

1. It's not the nicest message in the world, and thus, more likely to
get bad responses than constructive ones.

2. Based on the level of usability, I simply assume it is too young
for regular developers to use.  At least, I hope this is the case.

3. People i know have had bad experiences talking usability issues
with the git community in the past.  I am not likely to fare any
better, so I would rather have someone who is involved with both our
community and theirs, raise these issues, rather than a complete
newcomer.

But hey, whatever floats your boat :)

It is true I gave up quickly, but this is mainly because i don't like
to fight with my tools.
I am quite fine with a distributed workflow, I now use 8 or so gcc
branches in mercurial (auto synced from svn) and merge a lot between
them. I wanted to see if git would sanely let me manage the commits
back to svn.  After fighting with it, i gave up and just wrote a
python extension to hg that lets me commit non-svn changesets back to
svn directly from hg.

--Dan
