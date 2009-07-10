From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 19:34:11 +0200
Message-ID: <cb7bb73a0907101034v3e6d655btd28018d24ef6de63@mail.gmail.com>
References: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJzc-0005e0-OI
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZGJRef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZGJRee
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:34:34 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:51950 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZGJRee convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 13:34:34 -0400
Received: by bwz25 with SMTP id 25so1032026bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LkEpjPVTS8aU65nJgaXgNFMY8QalgJXEQX7fejmK0xU=;
        b=bf1ShTr50H2/pYWCeo+LzR6QlikEMMY6BL9pLOeWgEYVWfiMUgkkJluJKCfHjPGuI3
         817n1bKqIgat2ybWjZeq7F3zfCQ3f3pSM6cuQZI6ycjOdjBLXB8WOkHkcU+n2Qpqjk41
         uTZGjtqAMVdlDGEYlZaJ9xCgAk1NA8WEwFEEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IDJUG37KF2GPQlJeGtG54TBvnxzhLqDPloiFCj9dpfs0itdsn2P1HiG1FizVAK3nC3
         HN8zoAOWauDm6QLImaVox5nxS38AkhTmLFy0/UZ9F8V1ZUlXIL2etTaLmtpIDRa1Fk1z
         yFXQ2TwqOQB0YtOunSNp6PBKDXjJki6TuwAwQ=
Received: by 10.204.70.19 with SMTP id b19mr2131400bkj.62.1247247271120; Fri, 
	10 Jul 2009 10:34:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123072>

On Fri, Jul 10, 2009 at 7:04 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
> I complained to the CIFS people about their crazy duplicated commit
> message headers: see for example
>
> =A0 =A0[torvalds@nehalem linux]$ git show --stat aeaaf253c4dee7ff9af2=
f3f0595f3bb66964e944
> =A0 =A0commit aeaaf253c4dee7ff9af2f3f0595f3bb66964e944
> =A0 =A0Author: Jeff Layton <jlayton@redhat.com>
> =A0 =A0Date: =A0 Thu Jul 9 01:46:39 2009 -0400
>
> =A0 =A0 =A0 =A0cifs: remove cifsInodeInfo->inUse counter
>
> =A0 =A0 =A0 =A0cifs: remove cifsInodeInfo->inUse counter
>
> =A0 =A0 =A0 =A0It was purported to be a refcounter of some sort, but =
was never
> =A0 =A0 =A0 =A0used that way. It never served any purpose that wasn't=
 served equally well
> =A0 =A0 =A0 =A0by the I_NEW flag.
>
> =A0 =A0 =A0 =A0Signed-off-by: Jeff Layton <jlayton@redhat.com>
> =A0 =A0 =A0 =A0Reviewed-by: Christoph Hellwig <hch@lst.de>
> =A0 =A0 =A0 =A0Signed-off-by: Steve French <sfrench@us.ibm.com>
>
> =A0 =A0 fs/cifs/cifsfs.c =A0 | =A0 =A01 -
> =A0 =A0 fs/cifs/cifsglob.h | =A0 =A01 -
> =A0 =A0 2 files changed, 0 insertions(+), 2 deletions(-)
>
> and note the duplicated "cifs: remove cifsInodeInfo->inUse counter" l=
ine.
>
> It turns out that that duplication is because they use gitweb as a st=
range
> patch distribution system (rather than emailing each other patches), =
and
> download the 'commitdiff_plain' version of the diff and then apply it=
 with
> 'git am -s'.
>
> Ok, so it's a really odd way of doing things, but hey, that gitweb fe=
ature
> clearly does try to support that exact workflow, or why would that
> commitdiff_plain output try to look like an email?
>
> But gitweb is a totally buggy piece of trash when it comes to exporti=
ng
> commits that way.
>
> Why? Because it first has a 'Subject:' line, and then the "body" of t=
he
> email repeats the raw commit message output. So _of_course_ you get t=
he
> header duplicated.
>
> Now, I asked Steve to not use gitweb (or edit the result some way), b=
ut
> this really is a gitweb bug. And since I don't do perl, I can't fix i=
t,
> even though I can pinpoint exactly where the bug is (lines 5732 - 575=
2 in
> gitweb/gitweb.perl).
>
> I totally untested patch written by a monkey who doesn't actually do =
perl
> is appended as a purely theoretical pointer in the right direction. B=
ut I
> really have no clue about perl, so what the heck do I know? This is l=
ike
> my tcl programming - pattern matching rather than any real understand=
ing.
>
> I'm sure there are smarter ways to do this with some simple mapping
> function or whatever.

The smarter way is called the 'patches' ('patch' for single ones, e.g.
http://git.example.com/project.git/patch/master, whereas /patches/
would display the latest N with N configurable) view that just spouts
out the git format-patch output in a git-am friendly way. I'm pretty
sure my patches to implement that view are already upstream ... yes,
yes it is:

http://git.oblomov.eu/git/patches/9872cd..75bf2cb2

To understand the differences between this and commitdiff_plain, see

http://git.oblomov.eu/git/commitdiff_plain/9872cd..75bf2cb2

for comparison.

And yes, commitdiff is just TOTALLY not what you expect it to be,
ESPECIALLY with multiple commits, where it only displays the commit
message for the FIRST commit.

So tell the CIFS people to use the patch(es) view if they plan to use
gitweb for patch exchange (which I do all the time, and in fact was
the reason why I implemented this view in the first place).

--=20
Giuseppe "Oblomov" Bilotta
