From: Bill Lear <rael@zopyra.com>
Subject: Re: Decoding git show-branch output
Date: Fri, 19 Jan 2007 15:19:27 -0600
Message-ID: <17841.13791.627478.602602@lisa.zopyra.com>
References: <17840.50115.999227.260259@lisa.zopyra.com>
	<8aa486160701190613j6493daccofc259a8b17c0f1d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 22:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8195-0003uT-CE
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 22:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbXASVTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbXASVTc
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 16:19:32 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60384 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964865AbXASVTb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 16:19:31 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0JLJVY05130;
	Fri, 19 Jan 2007 15:19:31 -0600
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
In-Reply-To: <8aa486160701190613j6493daccofc259a8b17c0f1d1@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37203>

On Friday, January 19, 2007 at 15:13:30 (+0100) Santi B=E9jar writes:
>On 1/19/07, Bill Lear <rael@zopyra.com> wrote:
>
>[...]
>
>> I'm very confused by the syntax above.  What does "[master^2^]" mean=
?
>> Ditto with things like "[master~3^2^2]" and "[master~3^2~2]".
>
>They explain the relation between commits:
>
>^ -> first parent
>^n -> n-th parent
>~n -> <n>th generation parent, following only the first parent.
>
>See the manual page of git-rev-parse (or the tutorial for some simple =
examples).

I did.  Still don't understand.  So, following your explanation,

master~3 ^2 ~2

Means the 2nd (first generation) parent of the second parent of the
3rd (first generation) parent?  Is there a way to simply state this in
plain words, say in terms of commits/merges?  I'm unsure how to
interpret the above, especially since none of us has been developing
on a branch (I see no other branch names except master, also).

I'm currently running qgit/gitk to try to figure this all out.  It
appears that somehow we generated way more branches than we thought we
were.

Our basic work-flow for a developer is to set up one or more "private"
repositories on our machines, by issuing a git-clone of our company rep=
o.

Then we set up a "public" repo on our machine by issuing a "git --bare
init-db --shared".  We then push into this repo when ready, and from
there other developers pull.

Then, it seems that we push to our company repository both from our
private repos and our public ones, as we see fit.

I'm not sure if this is sane: is it ok to clone the company repo,
then push from that clone into a bare repo, then from there to
the company one?  Is git doing some sort of weird, silent pseudo-merge
that we don't understand, thus generated what appears to be a very
tangled, albeit brief, history, when we examine it?

I have read about 8 documents on git, experimented with it
extensively, and, at our company, I am arguably the "git expert"; I
thought that I had done all of my work on my local repo's master
branch, and only pushed from that branch up to our company repo.  Yet,
qgit shows that one of my first commits (to fix a few simply typos in
documentation) goes off onto another branch.  git-show-branch shows
"[master~3^2~9] Fix a few typos" for this.  I'm very confused how this
could have happened, and I want to ensure we are doing things in a way
that is predictable...

Thank you again.


Bill
