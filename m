From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 13:39:29 +1300
Message-ID: <46a038f90610231739x5beffc90u33c6a81f461974ec@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <200610221105.26421.jnareb@gmail.com>
	 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	 <87zmbozau2.wl%cworth@cworth.org>
	 <20061022185350.GW75501@over-yonder.net>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 02:41:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcAKR-0006vi-RV
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 02:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWJXAjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 20:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWJXAjg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 20:39:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:14124 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932389AbWJXAjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 20:39:36 -0400
Received: by nf-out-0910.google.com with SMTP id c2so8097nfe
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 17:39:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8taEqjRYDCtz0rnrgSTwuXKhFgFMrk1/pvbC9PK1QGhSzWvtCr8KbntW4b7msBa5l3TvvF7SNYQW3pELxCZ3iccW5dfju4/Fz+jyisKwbyd8lUUerhmR4cFZJcMVlimkjxyY8Untu688j4wiQTufMMLjiD3GPytgN7k//qhr1s=
Received: by 10.48.48.1 with SMTP id v1mr103531nfv;
        Mon, 23 Oct 2006 17:39:29 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Mon, 23 Oct 2006 17:39:29 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29909>

On 10/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 24 Oct 2006, Erik B=E5gfors wrote:
> >
> > I don't see any problem doing a "gitk --all" equivalent in bzr.
>
> The problem? How do you show a commit that is _common_ to two branche=
s,
> but has different revision names in them?

Eric,

coming from an Arch background, I understand the whole per-branch
commitids approach. After using GIT for a while, you start realising
that it tries to pin down things in the wrong place.

This is specially visible if you run `gitk --all` before and after a
merge. Or on a project with many merges (if you can, get a checkout of
git itself, and browse its history with gitk).

Before the merge, you see

 --o--o--o--o
    \
     \--o--o

and after

 --o--o--o--o
    \        \
     \--o--o--o

Now, after it's merged somewhere, both commits are part of its
history, regardless of where they come from. And it is very clear if
two branches have been merging and remerging.

Where a commit originated does not matter. And fancy
repo-and-branch-centric names get in the way. A lot. And they re
mostly meaningless as soon as you put what matters in the commit
message. Which means that that bit of metadata that you are hoping
that the revno keeps "indirectly" isn't lost on cherry picking.

I guess that's where I used to find revnos useful as they contained
some basic metadata. With bzr it seems to be author-repo-branch where
branch is hopefully "line of work" but all of that can be (and should
be) in the commit message.

You can see similar info in the first part of the commit message for
most git-hosted projects. It'll say something like

   cvsserver: fix the frobnicator to be sequential

which means that at that point, you could be working in a branch
called fix-this-fscking-thing-attempt524" and no-one would know ;-)

And in a few years (even months) time, that bit of metadata you were
hoping to keep is totally irrelevant. What you have in the commit
message remains relevant and useful.

cheers,


martin
