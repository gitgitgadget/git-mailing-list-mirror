From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Mon, 13 Aug 2012 17:46:56 -0700
Message-ID: <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org> <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com> <7v8vdjfddk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 02:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T15I4-0000Fq-Va
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 02:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab2HNArS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 20:47:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54497 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2HNArR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 20:47:17 -0400
Received: by yhmm54 with SMTP id m54so3944266yhm.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Gy0piPeSCwkgf83qYvP1WnC/XlGLsVX9rqBizYmEQ7U=;
        b=UQDg5o+K+SFMUFCIIXZ9f1jJ63M/9BBpBHFBG/vbQpJ9ffzjWIoKY6YFHKe5hMZgbQ
         Eb0i3eJF/hW0QaNPTwxxoH3fdn6SkMdP6Ckw7n0ZO4GfEqI6dSpPeq2yUHuBYrwee25y
         5HP/ngf/UG2dVaG8pmPizRx1PrSzGZSeeID3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=Gy0piPeSCwkgf83qYvP1WnC/XlGLsVX9rqBizYmEQ7U=;
        b=R7f1X+Y5M5Rg+WwMVQQH+YAFuW/yh1X29J+2+LmEaZVAdS8Hh0vNtwU6jQdPV5wlR3
         k4jC9nKj1yhKLyqObKQFcWV4iXE2gxkw6whH/ln1q0ePhRnqNvffVIboGeyjkks9DDQz
         4yOF4Gu+rVk4XYd10LntXbA7SWOB2V1zeRY5rg82vT7SmIC9HaDDvTdZxKKhgBOXY7jG
         vltWxFq43DVe5pvA3JnMRKLSeUeeWRFDZAd0EtRzbqFn087g7gchtwbX/TnoBdA+TA7I
         klMm1OCpetPcjR6D4YqDbkS5anhXjT8S2Hcm0L/eJSoQIjhrry0KLuOcuCQ03cHB1o/n
         SE2Q==
Received: by 10.50.236.4 with SMTP id uq4mr8375887igc.18.1344905236675; Mon,
 13 Aug 2012 17:47:16 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Mon, 13 Aug 2012 17:46:56 -0700 (PDT)
In-Reply-To: <7v8vdjfddk.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlUiy6+QVI2Nfvi12dUdnZFG6BaTGRIQgCQsRPCgzyZuu07v80Vi10jbPfLz0IZl2RRVS08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203377>

Let me start by echoing Junio's remark... "lacks sufficient
justification". You don't give enough evidence to support even why it
is worth looking at this commit, let alone why it should be included
and cause a format change in the idx file format.

At some point you start to hand-wave about how it may benefit my
bitmap reachability index idea, but you don't seem to fully understand
that idea. And some of what you do here sounds like it actively hurts
doing the bitmap reachability project. So again this doesn't really
help.

Colby is nearly done prototyping the bitmap reachability
implementation in JGit and will release the code under the BSD license
there soon. I can't promise when yet because Colby will soon be
heading out for some (much deserved) vacation time, and doesn't want
to publish something until he is ready to stand behind the code. So it
might not show up until mid-September. But I think its worth giving
him a few weeks to finish getting the code ready, vs. rushing
something in that someone else thinks might help. We have waited more
than 6 years or whatever to improve packing. Colby's experiments are
showing massive improvements (40s enumeration cut to 100ms) with low
disk usage increase (<10%) and no pack file format changes. Its OK to
wait 4 more weeks.

On Mon, Aug 13, 2012 at 12:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Aug 13, 2012 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> For example, the reachability bitmap would want to say something
>>> like "Traversing from commit A, these objects in this pack are
>>> reachable."  The bitmap for one commit A would logically consist of
>>> N bits for a packfile that stores N objects (the resulting bitmap
>>> needs to be compressed before going to disk, perhaps with RLE or
>>> something).  With the single "sorted by SHA-1" table, we can use the
>>> index in that single table to enumerate all reachable objects of any
>>> type in one go.  With four separate tables, on the other hand, we
>>> would need four bitmaps per commit.
>>
>> No we still need one per commit. The n-th bit is in the order of the
>> object in the pack, not the index. How sha-1 is sorted does not
>> matter.

Yes, for RLE encoding to work well it is important that the bits are
assigned using pack offset ordering, not SHA-1 ordering. The object at
bit 0 is the object at offset 12 in the pack file, not the object that
has the lowest SHA-1. The RLE encoding is relying on the packer to
store objects closely reachable by time near each other in the pack
file. Which the packer already does because we have roughly proven
though the years that this ordering works sufficiently well enough for
nobody to propose another ordering.  :-)

> Then what is the problem of using that same "N" that counts the
> object using the order of the objects in the pack as a short-hand to
> the object name instead, if your objective is to avoid having to
> repeat the full 20-byte object name in your secondary tables?  That
> does not call for any split in the list of SHA-1s, no?

Exactly. There is no need to store a second copy of the SHA-1s
anywhere. We can discover information about object identified by bit N
by creating the reverse pack index in memory. The N-th entry in the
reverse index will tell us the Y-th position in the normal idx file,
which gives us the SHA-1. So SHA-1 can be obtained from a bitmap in
constant time, once the reverse index is built. The reverse index
build costs O(N log N) time, but its already required by the packer to
do efficient reuse of packed objects. We already pay this O(N log N)
penalty. So its currently free to us.

The bitmap approach Colby and I are collaborating on also contains 4
RLE bitmaps indicating what type each object is. Its needed so the
packer can avoid looking up type data in the base pack file, while
also avoiding parsing of trees where the mode information normally
provides the type hint. We could instead get this by splitting the
SHA-1 table into 4 tables as this patch proposes, but it doesn't help.
Type information can be obtained fast enough from these 4 RLE bitmaps,
without muddying the read code path with needing to know what table to
search, or needing to search 4 tables rather than 1 table.

>>> Either way is _possible_, but I think the former is simpler, and the
>>> latter makes it harder to introduce new types of objects in the
>>> future, which I do not think we have examined possible use cases
>>> well enough to make that decision to say "four types is enough
>>> forever".
>>
>> New types can be put in one of those four tables, depending on its
>> purpose.

No. A new type should get a new table. We should never cram a new type
into an existing type table just because it sounds like a good idea.
Its not. We are unlikely to add a new type anytime soon. If we do its
going to take more work than just worrying about where it fits into an
idx file. But it shouldn't be combined into a bucket with an existing
type.

>> The reason I split because I care particularly about commits
>> and trees. If the new type serves the same purpose as tree, for
>> example, then it's better put in tree table...

It isn't worth speculating about this. We aren't likely to add a new
type. If we do its probably not like another type.

> And when there are multiple uses, one that wants to treat trees and
> commits more or less the same way, and another that wants to treat
> them in a distinct way, even without considering a new type, how
> would your "we have four separate tables" help?  The former user
> wants three "commits+trees", "tags" and "blobs" table while the
> latter wants four, no?

And this paragraph alone indicates why splitting the SHA-1 table is a
stupid idea. Readers who have a SHA-1 in hand shouldn't have to dig
around in 4 different tables trying to figure out what it wants. Or
maybe 3 tables if it thinks its tree-ish. Its just a stupid discussion
to have. At this level of the system the object database is a database
keyed by SHA-1s. Simple. Don't muddle it.

>>> In either way, we would have such bitmap (or a set of four bitmaps
>>> in your case) for more than one commit (it is not necessary or
>>> desirable to add the reachability bitmap to all commits), and such a
>>> "reachability extension" would need to store a sequence of "the
>>> commit object name the bitmap (or a set of four bitmaps) is about,
>>> and the bitmap (or set of four bitmaps)".  That object name does not
>>> have to be 20-byte but would be a varint representation of the
>>> offset into the "sorted by SHA-1" table.

Yes.

>> How do you reach the bitmap, given its commit sha-1?
>
> Look at the ordered list of SHA-1 in the pack idx file as an array
> of 20-byte entries, and find the commit SHA-1 in that array by
> Newton-Raphson/bisection.  You have an index into the array that
> holds the object name.  You can use it as the local object number
> in the packfile.  Then you can find that object number (that is
> shorter than 20-byte object name) in your secondary table, no?

Yes, exactly. But I am trying to steer Colby into a slightly different
direction. For ~222k commits we need only about 2k reachability
bitmaps. If these are keyed by N-th SHA-1 as Junio states, we can
lookup the object in the object map and mark a flag on it saying
"reachability bitmap exists on this commit". Later if the revision
walker hits a commit with this flag set, we know we should look at
that bitmap information. Allocating 2k commits into the revision
walking map is fairly cheap, and makes it fast for the walker to later
identify where a bitmap exists. But I don't have any data yet to prove
what the fastest way to manage finding the right bitmaps is.
