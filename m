From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Tue, 9 Apr 2013 00:33:23 +0530
Message-ID: <CALkWK0m4o=F=bh_mt9NGDfXKExgVtLhaZ7uxA_XFhpF5AN5-Fg@mail.gmail.com>
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
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
 <7v1ual12pj.fsf@alter.siamese.dyndns.org> <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
 <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHMe-00016L-MN
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935363Ab3DHTEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:04:09 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38908 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935236Ab3DHTEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:04:05 -0400
Received: by mail-ie0-f171.google.com with SMTP id e14so7472150iej.30
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GdTCrA6EI2cQeC9ayzjyscbpNupQ2Tm/3Wo4GEtpWDA=;
        b=Kq6QDUqGOwJqG6hPvLTAC2hrMu0egXqWMSu75Tl8fENH6n0Y8T9nF9ZGwXXPZH/G3p
         7dIYCct5DwVM81Uw1bo9u/eI20Gxm2/YZNRy4mcyEvQFwI+k8Z9ybqteLO7QLyUZcMaM
         8938kMsxe+FkQJrfNhhUrZQyMkdVRBADZOg8iNHIwbEUR2FGOIOPSdfAkUZosEVTGe6j
         NMqohzctSMpKh4X82XNQDW70To7JyPbHHviKl1ewLC2/4SNAK/0B4MLh2IrHXyHZ5VIz
         9+aljJpTchItMDJMgDaPNQMU5xQ7Ikv1KCcIkugyG0wOeqya2C66N02ANu0sn/2YeckX
         woGg==
X-Received: by 10.43.9.68 with SMTP id ov4mr13085445icb.22.1365447843720; Mon,
 08 Apr 2013 12:04:03 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 12:03:23 -0700 (PDT)
In-Reply-To: <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220495>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> 1. Having a toplevel .gitmodules means that any git-core command like
>> add/ rm/ mv will be burdened with looking for the .gitmodules at the
>> toplevel of the worktree and editing it appropriately along with
>> whatever it was built to do (ie. writing to the index and committing
>> it).
>
> Burdened is a subjective word.  What's bad about having a single place
> you know you can read and find out information about things?  You
> have to learn about them to do anything specific to them anyway.

"Burden" refers to the extra work of looking for a file in the
worktree, when this is completely unnecessary if you use a link
object.

>> This is highly unnatural.
>
> Unnatural is a subjective word, and there is no justification I see
> here in your message.

git's design follows along the lines of the UNIX philosophy: do one
thing, do it well.  git add/ rm/ mv have a very sharply defined task:
they first lock the index file, read the_index using read_cache(),
build a cache_entry struct using user-supplied data (this might
involve worktree code from dir.c to recurse subdirectories, for
example), write that cache_entry to the_index (removing existing
entries with cache_tree_invalidate_path() if necessary), and finally
write the_index to the index file, releasing the lock.  Would you
agree that any operation that doesn't follow along this line is
unnatural?  What then, does writing a special file in the worktree
(aka .gitmodules) have to do with this entire process?

Does git diff/ commit/ add/ rm or any other command you can think of
rely on a special file in the worktree (aka .gitmodules) to be checked
out?  Then why does git submodule require it?  Isn't this a
requirement that is inconsistent with the rest of git-core?

>> Putting the information in link
>> objects means that we get a more natural UI + warts like
>> cd-to-toplevel disappear with no extra code.
>
> I do not see how "link objects" _means_ "natural UI", yet, without
> an explanation how one leads to the other.

I should've said "means an easy route to get the existing UI to work
with little or no additional code".  Making the submodule information
available to git-core is precisely what leads to this.  In
index_path(), you can inject a case for S_IFDIR to write a link object
to the database, writing the sha1 to the supplied argument.  This is
not unnatural in any way, because we're just following along the lines
of the S_IFLNK codepath, which writes a blob object to the database.
Now index_path() is called by add_to_index(), which is the master
function for adding anything to the index.  Therefore, git add just
works.  git rm is much simpler: it calls remove_file_from_index()
which in turn calls cache_tree_invalidate() and
remove_index_entry_at().  Once the entry is removed from the cache,
our job is done.  The link object will be cleaned up at gc-time.  git
mv is just a combination of git rm and git add: it invalidates an
existing entry and adds a new one with a different name.

There is no special .gitmodules to take care of.

> What does cd-to-toplevel have anything to do with it?  In case you
> did not notice, all the core commands internally cd-to-toplevel and
> carry the "prefix" information while doing so, and prepend the
> prefix to user-supplied paths to find which path the user is talking
> about.  So "cd to toplevel before starting to carry the operation out"
> is a natural pattern inside Git.  As many people already told you,
> "the user has to run 'git submodule' from the top-level of the
> submodule working tree" is a simple oversight of the implementation.

Yes, I am aware.  I'm piggy-banking on the mature parts of git-core to
get functionality that I would otherwise have to write by hand.  The
current implementation needs to hand-code this, and hasn't done it yet
(presumably because it's non-trivial).

>> 2. If we want to make git-submodule a part of git-core (which I think
>> everyone agrees with), we will need to make the information in
>> .gitmodules available more easily to the rest of git-core.
>
> Care to define "more easily" which is another subjective word?  The
> .gitmodules file uses the bog-standard configuration format that can
> be easily read with the config.c infrastructure.  It is a separate
> matter that git_config() API is cumbersome to use, but improving it
> would help not just .gitmodules but also the regular non-submodule
> users of Git.  There is a topic in the works to read data in that
> format from core Heiko is working on.

This goes both ways: the information is both easier to read and write.
 I can easily create a link object from anywhere: index_path() or
cmd_edit_link().  To do this, I just have to call write_sha1_file()
with the buffer filled out and with the parameter link_type (which is
already defined).  To access the data in a link, I have to fill out a
tree_desc with "HEAD", an unpack_tree_opts with a custom callback, and
pass it to unpack_trees().  An example of a custom callback:
cmd_cat_link() which simply calls get_stat_data() to fill in the
SHA-1, and read_sha1_file() to read that object into a buffer.

I don't have to rely on a worktree with toplevel .gitmodules checked
out.  The information is easily readable/ writeable by default when
I'm working with git, irrespective of my the state of my worktree.

Why must we use the git_config() API when it was never designed to do
this?  Why not leverage the mature part of git that was intended for
this, where our new object fits in snugly?

Can you now present a counter-argument about why .gitmodules is
_better_ suited for the task of managing submodules?  (Hint: No, you
can't; because it isn't).  Can you give me an example of one thing
that will become more complex if we were to follow my approach (I've
already acknowledged foreach, so that's out)?  Do you have any
concrete objections to the new design, apart from the fact that it
breaks what already "works"?  Do you acknowledge that the new design
will remove a lot of existing complexity (if "complex" is too
subjective for you: result in a significant negative overall
diffstat)?
