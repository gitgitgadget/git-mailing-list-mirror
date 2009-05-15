From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 15 May 2009 15:05:14 -0400
Message-ID: <32541b130905151205h6ca89d85q97e72ce23bf233ee@mail.gmail.com>
References: <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> 
	<32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> 
	<20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> 
	<32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> 
	<20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com> 
	<20090514214120.GR15420@raven.wolf.lan> <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com> 
	<20090515175203.GS15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 21:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52jU-0003FG-Ib
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbZEOTFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbZEOTFf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:05:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:38884 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbZEOTFe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 15:05:34 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1202609yxj.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=fqey6GfLvB+VufFDvg+FdaaP+ozqduqQajiSReScbyw=;
        b=FkXVFbceWuPhSvjAfqGZ+61LIc6e46CCs+HnG9+lmunhDjOE6UbyACUoEva+15Fg/y
         9/LyWgW2aULbuthVG9OJktbM+WB+xGaXEizBc+DwdRtrV/NpkGdNQ645cbedOJ1apyKz
         VKgbq7c0jK+XQXLfDbqZFACUcG2tInxDErh+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=WUMCZtp6mTopDbJTOMJKGz1WJBX7X0t05eAutFFUhAiufDBG9MAerkVlgFTXXB/DEe
         eHLHVM8E5eaf0PxZN+3ZEW44sVL1st5i5ecNtcJmANQSQbwh6I6kAWTJn0kCX7cHmNIt
         fqIke1wuJDAlNieBCuZiVn3bwUJuWKMhQ41Ms=
Received: by 10.151.46.11 with SMTP id y11mr6600649ybj.325.1242414334070; Fri, 
	15 May 2009 12:05:34 -0700 (PDT)
In-Reply-To: <20090515175203.GS15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119280>

On Fri, May 15, 2009 at 1:52 PM, Josef Wolf <jw@raven.inka.de> wrote:
> On Thu, May 14, 2009 at 05:57:00PM -0400, Avery Pennarun wrote:
>> On Thu, May 14, 2009 at 5:41 PM, Josef Wolf <jw@raven.inka.de> wrote=
:
>> > So here's my second plan:
>> > 1. instead of doing the cherry-picking in a single repository, it =
might
>> > =A0 be helpful to do it in separate repositories: one repository f=
or each
>> > =A0 direction. =A0While there are still two remote svn repositorie=
s in each
>> > =A0 svn repository, there is no need for criss-cross anymore. =A0T=
he flow
>> > =A0 of the data is in one direction and it seems (at least at firs=
t glance)
>> > =A0 I can use git-svn-rebase to get a linear history.
>>
>> it's still criss-crossing, it's just less obvious that way. =A0One
>> repository is exactly the same as two repositories in git; all that
>> matters is the branch histories.
>
> Yeah, I see... =A0But this step is here _only_ to get the existing sv=
n
> repositories in sync again. =A0After cherry-picking and dcommitting, =
those
> cherry-pick repositories would be wiped. =A0They have no real history=
=2E =A0The
> steps I outlined in my previous mail wouldn't even create any files i=
n
> the .git/refs subdirectory.

Hmm, getting them in sync the first time seems to be "easy"
(relatively), in that you've already done it, right?  So it's a
one-time thing, doesn't need automation, and you already figured that
part out.  So it seems like a non-issue one way or the other.

> Once that is done, I can declare one of the existing repositories as
> public and pull it via git-svn into a freshly created repos. =A0The o=
ther
> repos can then be recreated by cloning and applying patches. =A0No sv=
n
> involved anymore here.

Yes, that works fine.  Nothing stopping you from declaring one or the
other svn repos to be identical to "public."

>> I'd say that basically none of your problems have anything to do wit=
h
>> svn's lack of merge support, and everything to do with the fact that
>> you aren't doing all your changes first on a 'public' branch and the=
n
>> merging from there into the private branches. =A0(That's really not =
so
>> hard to do in svn either, and would save a ton of confusion.)
>
> The problem here is that it does not match the work flow. =A0IMHO, my=
 work
> flow is very similar to the work flow of the kernel, so I fail to see=
 why
> it can not work. =A0See the analogies:
>
> kernel: Submodule maintainers are committing into private repositorie=
s
> me: =A0 =A0 People are committing into private repositories
>
> kernel: Those commits are forwarded to Linus's repository
> me: =A0 =A0 Those commits are forwarded to the public repository
>
> kernel: Maintainers receive commits for other submodules from linus
> me: =A0 =A0 Commits are distributed from public to private repositori=
es

There is one critical difference here: if someone merges from Linus
and then Linus merges back from them, then the two resulting
repositories will be *identical* (at least, the trees will be; if the
second merge uses --no-ff, the histories will be very slightly
different, but not importantly so).

If someone has patches that they don't want to send back to Linus, and
those patches are intermixed with ones they *do* want to send back,
then they either have to cherry pick them over to a separate branch
(which Linus can then pull), or equivalently they email individual
patches to Linus, or they need to rebase a lot, or they need to just
put their "finished" patches onto a separate branch and keep the
unfinished ones somewhere else that Linus won't pull.

Rebasing is (I think) actually the most common solution to this
problem, but it doesn't help if you're using svn.  svn has no concept
of rebasing.  (git svn rebase uses git rebase, but it's not really for
the same purpose.)

> The only differences I can see are:
> - size of the project (obviously)
> - convert from multiple svn repos instead of bitkeeper
> - private repostories have to keep local patches (but I guess maintai=
ners
> =A0do that also)

That last one is the source of all your problems.  That said, the
script I provided *does* let you do this, if you're brave.

Have fun,

Avery
