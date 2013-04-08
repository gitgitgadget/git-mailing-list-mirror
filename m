From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 21:38:12 +0530
Message-ID: <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
 <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com> <7v1ual12pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF1w-0004NB-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934325Ab3DHQIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 12:08:54 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:55181 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3DHQIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 12:08:53 -0400
Received: by mail-ia0-f180.google.com with SMTP id l29so47324iag.25
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ep2YFUlMCSCt3dDZUEHaTcSA8rrVKnLCuisqVTBcy70=;
        b=UfFkV01Mihw2JO/K+8cM9W4n0oD3J3ALppmeCjGSaBNSZZEoET9fP9PbpG1/k2s5LU
         p+gxEQrd/zmggvIr1smb7xbxFEOrI6usmcJkz/Ftuz0VOCknzmpeAza1pKL3W7QP1c0z
         8khImwAbRU9Uu91lU/SMg1sbaLPE/U4WlfKAqH2aZsl2PsJZqDJKxDr13H2bxoNGPSwE
         4AAHnKEjQ7zAqgtBvtpUUFbN7DiisodOHzQoZYrDmSB8+LXzbs7LK9QiSGVt83d1FAeO
         lF4qc47w2uUZyBOzyJoW9buQoYoNRmOW3s+rAY8DEKkZUDTa6BztyVvx+26XzgNCroKu
         zrWQ==
X-Received: by 10.50.117.3 with SMTP id ka3mr6934217igb.107.1365437332506;
 Mon, 08 Apr 2013 09:08:52 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 09:08:12 -0700 (PDT)
In-Reply-To: <7v1ual12pj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220436>

Junio C Hamano wrote:
> Would it be possible that (at least some part of, or possibly all
> of) your ideas had some merit, but with all your hostility against
> the current system and the work that went behind it, you did not
> communicate well enough to make others understand you?

Agreed.  My annoyance with the current system did go a little
overboard, and I've been having a splitting headache for the last few
days.

> What I found very hard to read in this thread was that your messages
> all went like this:
>
>  1. In the current system, I have to be at the top level of a
>     submodule to work in it (or some other problems).
>
>  2. I will fix it in a more "elegant" way.
>
>  3. I have to have a new object at the submodule path, not the
>     current "submodule is a commit bound at the submodule path, and
>     information about the submodule is in .gitmodules".
>
> There was very little concrete explanation on how #3 leads to #2,
> i.e. the overall design of your new system and how it will work,
> other than you would read what we currently write in .gitmodules
> from a new kind of object.

I had no way of expressing what I wanted to do except by writing code
when I started off this thread, but am in much better shape now.  Let
me try to explain my fundamental assumptions and code in a concise way
now.

1. Having a toplevel .gitmodules means that any git-core command like
add/ rm/ mv will be burdened with looking for the .gitmodules at the
toplevel of the worktree and editing it appropriately along with
whatever it was built to do (ie. writing to the index and committing
it).  This is highly unnatural.  Putting the information in link
objects means that we get a more natural UI + warts like
cd-to-toplevel disappear with no extra code.

2. If we want to make git-submodule a part of git-core (which I think
everyone agrees with), we will need to make the information in
.gitmodules available more easily to the rest of git-core.  One way to
do it without breaking anything is to unpack the root tree, look for
an entry with the path .gitmodules and handle it different from other
blobs: ie. parse it into structured data that the rest of git-core can
consume.  However, I think it is very gross as the blob is not
inherently special in any way: it's just incidentally stored at a
specific tree path.  The alternative is to have an inherently special
kind of blob (ie. link object).  In the git-core code, I can simply
match for a link object and operate on it accordingly.  As opposed to
matching a blob object, and its tree path.  Moreover, this means that
the user can simply git edit-link <link> from anywhere in the worktree
instead of having to refer to the appropriate section in the toplevel
.gitmodules.

3. Currently diffing/ merging one huge .gitmodules file is a mess, as
it doesn't have to conform to a strict format.  This means that I can
get conflicts between these two:

    url = gh:artagnon/clayoven
    url =gh:artagnon/clayoven

Moreover, since the fields are not ordered, a simple reordering of the
fields will cause a merge conflict.  The correct way to fix this is to
split up .gitmodules into many logical files, have a git
edit-gitmodules which reduces user input to a strict format, and then
write custom diff/merge drivers.  My proposal involves having a git
edit-link, and teaching git-core to diff/merge appropriately.  The
information is already in logical bits.

4. The only seeming disadvantage of not having a file accessible via
the filesystem is that it doesn't behave like a full blob.  But it
does; the code to unstage a link object (emulation) is actually very
simple: I'm currently writing it.

5. Having a first-class link object comes with functional advantages.
It means that I can have a ref pointing to link objects and easily
initialize a nested repository without having to initialize the
containing repository (ie. essentially replacing repo). We can have
true floating submodules, which is really nice in my opinion: you can
fix a library at v3.1 and switch it to v3.2 at some point in the
future without using ugly SHA-1 hexes anywhere.

6. While it is possible to work top-down from the current system, that
approach is clearly taking too long and is too painful.  This explains
why submodules haven't come a long way in the last five years.  With
my approach, I'm trying to make life simpler for everyone: it will
suddenly become much easier to hack on submodules, and it can improve
more rapidly over the next five years.  I'm not thinking about
short-term fixes precisely for this reason: the long-term goal is
worth a little bit of short-term inconvenience.

7. I estimate that replacing the current submodule system without
feature regressions will not take a lot of effort and can be done with
minimal breakages.  It's not a lot of code or anything very complex.
We just have to follow along the lines of how git-core handles blobs,
and write a little bit of code to make links behave like blobs (I'm
halfway done with this already).
