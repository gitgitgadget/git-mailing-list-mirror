From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 10:13:21 -0700
Message-ID: <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
	<alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
	<20130312041641.GE18595@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus <torvalds@linux-foundation.org>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 18:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFSlx-0004MA-4z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 18:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab3CLRNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 13:13:24 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:39150 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab3CLRNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 13:13:22 -0400
Received: by mail-ve0-f172.google.com with SMTP id cz11so70235veb.3
        for <multiple recipients>; Tue, 12 Mar 2013 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=Gj16CJPwOfts37i+06PHEdP06jgPhn2XmYzfKuHizL0=;
        b=WDKWB9U3T9sKrVHE04IYal+vOletuvokgvWJ8aB70+66PvREnNAVPr6xImR3WmahzP
         1NH7/rr9DViAAhFLQt8jkMsY14OEtaXGadNR+NflUAL7D4vfG1bn9edpROgajs8V7fVj
         ea1D3yNuYteCr+egTNVb2xLyBiCSC5CK50nZfmeGpzAVHesUxUAgHdV8v8VTwv+8TonY
         yv8FyFBAoLmMA+fvdxIkouSQkdRsmUOQ6WVnK13ojKNh+FbJPk7NT8911eu3vCJLOOmH
         onkyNLZAJym3LUkCQ/9mgTglyeyHwosVSJjFHvuzsQB8tGkVD3+VC0l+IWIgG2oKk1lR
         MmrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=Gj16CJPwOfts37i+06PHEdP06jgPhn2XmYzfKuHizL0=;
        b=Icqu+LkalRnEIz+c9hstwTK0msISoV6J0KrpkYCNWIENZqJeDsFCI97vndPMIkDAqg
         AxAqxLBvG3+JY4auHJlVDYCianLTkaXRKXFbQBgOriaAQbtSmu5Sc2rWbYTRis1as5R6
         AX7anTcCLoktnLcgXUCWF16L47zgQQZ6x3nLw=
X-Received: by 10.52.231.162 with SMTP id th2mr3121622vdc.74.1363108401813;
 Tue, 12 Mar 2013 10:13:21 -0700 (PDT)
Received: by 10.220.145.131 with HTTP; Tue, 12 Mar 2013 10:13:21 -0700 (PDT)
In-Reply-To: <20130312041641.GE18595@thunk.org>
X-Google-Sender-Auth: J2NAV1Qi3LqJNrnDGhTe-I98UyY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217976>

[ Added Junio and git to the recipients, and leaving a lot of stuff
quoted due to that... ]

On Mon, Mar 11, 2013 at 9:16 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Mar 12, 2013 at 03:10:53PM +1100, James Morris wrote:
>> On Tue, 12 Mar 2013, Stephen Rothwell wrote:
>> > The top commit in the security tree today is a merge of v3.9-rc2.  This
>> > is a completely unnecessary merge as the tree before the merge was a
>> > subset of v3.9-rc1 and so if the merge had been done using anything but
>> > the tag, it would have just been a fast forward.  I know that this is now
>> > deliberate behaviour on git's behalf, but isn't there some way we can
>> > make this easier on maintainers who are just really just trying to pick a
>> > new starting point for their trees after a release?  (at least I assume
>> > that is what James was trying to do)
>>
>> Yes, and I was merging to a tag as required by Linus.

Now, quite frankly, I'd prefer people not merge -rc tags either, just
real releases. -rc tags are certainly *much* better than merging
random daily stuff, but the basic rule should be "don't back-merge AT
ALL" rather than "back-merge tags".

That said, you didn't really want a merge at all, you just wanted to
sync up and start development. Which is different (but should still
prefer real releases, and only use rc tags if it's fixing stuff that
happened in the merge window - which may be the case here).

> Why not just force the head of the security tree to be v3.9-rc2?  Then
> you don't end up creating a completely unnecessary merge commit, and
> users who were at the previous head of the security tree will
> experience a fast forward when they pull your new head.

So I think that may *technically* be the right solution, but it's a
rather annoying UI issue, partly because you can't just do it in a
single operation (you can't do a pull of the tag to both fetch and
fast-forward it), but partly because "git reset --hard" is also an
operation that can lose history, so it's something that people should
be nervous about, and shouldn't use as some kind of standard "let's
just fast-forward to Linus' tree" thing.

At the same time, it's absolutely true that when *I* pull a signed tag
from a downstream developer, I don't want a fast-forward, because then
I'd lose the signature. So when a maintainer pulls a submaintainer
tree, you want the signature to come upstream, but when a
submaintainer wants to just sync up with upstream, you don't want to
generate the pointless signed merge commit, because the signature is
already upstream because it's a public tag. So gthe behavior of "git
pull" is fundamentally ambiguous.

But git doesn't know the difference between "official public upstream
tag" and "signed tag used to verify the pull request".

I'm adding the git list just to get this issue out there and see if
people have any ideas. I've got a couple of workarounds, but they
aren't wonderful..

One is simple:

    git config alias.sync="pull --ff-only"

which works fine, but forces submaintainers to be careful when doing
things like this, and using a special command to do back-merges.

And maybe that's the right thing to do? Back-merges *are* special,
after all. But the above alias is particularly fragile, in that
there's both "pull" and "merge" that people want to use this for, and
it doesn't really handle both. And --ff-only will obviously fail if
you actually have some work in your tree, and want to do a real merge,
so then you have to do that differently. So I'm mentioning this as a
better model than "git reset", but not really a *solution*.

That said, the fact that "--ff-only" errors out if you have local
development may actually be a big bonus - because you really shouldn't
do merges at all if you have local development, but syncing up to my
tree if you don't have it (and are going to start it) may be something
reasonable.

Now, the other approach - and perhaps preferable, but requiring actual
changes to git itself - is to do the non-fast-forward merge *only* for
FETCH_HEAD, which already has magic semantics in other ways. So if
somebody does

    git fetch linus
    git merge v3.8

to sync with me, they would *not* get a merge commit with a signature,
just a fast-forward. But if you do

    git pull linus v3.8

or a

    git fetch linus v3.8
    git merge FETCH_HEAD

it would look like a "maintainer merge" and stash the signature in the
merge commit rather than fast-forward. It would probably work in
practice.

The final approach might be to make it like the "merge summary" and
simply make it configurable _and_ have a command line flag for it,
defaulting to our current behavior or to the above suggested "default
on for FETCH_HEAD, off for anything else".

Hmm?

            Linus
