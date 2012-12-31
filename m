From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Mon, 31 Dec 2012 10:06:15 -0800
Message-ID: <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com> <20121230213124.GA15946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 31 19:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpjlP-0005Fj-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab2LaSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 13:06:37 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33006 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2LaSGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 13:06:36 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so15360804ieb.33
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qIQbOA8+lokIFJ5iwwRRXK28ce+qMNcD97zJkvwMjXc=;
        b=d4XTa0sLq/M4lyS1UJ1ZMcLeXMZIVaFI+R93aHke5nkvfZiU/+odCCiBUJSWeCTUZK
         l1/sfUv+GylxauaO+8vOVF0ZCNAT2jYEKQCX8J9Kqt43gxp2VifXbOBLnL52NZ9lXM2q
         DkN5hRimV5g72dMn0KXo0XBQ/z2dcTE3c+5mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=qIQbOA8+lokIFJ5iwwRRXK28ce+qMNcD97zJkvwMjXc=;
        b=cbfGvAcLn4MVyZooBOfmWRl3TEinK6LcYBV1isSqne8zftkKdXILeI++Z+sqkr+qm0
         dwZsoyDmhwR6s1Pz6eq4EHmQuxt/N2vZVYV2GWiOE+WMI8BxgI85aAIYbZrqjaNywOOc
         Av0Oew7C2N0vCqPEcZPWSw6Z2SY76rETtJEGcdKbSwrYsgpzvTJCXDYRSgCQh4RjxFFS
         1SMuKTFX/QZ7/PXQi7C/bwUKyn3WVm4ob853SVeUqfTo4XpE4SBiVA9V6wdKE1GVtRsp
         yzjheumcI4R3qZWBghc6D0LgdTU5mAE58hXgDBKhc7H55K+z5mim7hK3IBCmwJEhoPFl
         Hunw==
Received: by 10.50.169.106 with SMTP id ad10mr31548621igc.88.1356977195713;
 Mon, 31 Dec 2012 10:06:35 -0800 (PST)
Received: by 10.64.11.101 with HTTP; Mon, 31 Dec 2012 10:06:15 -0800 (PST)
In-Reply-To: <20121230213124.GA15946@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmrSYjzBhGs3w+p/9POjp5d/JChNsVg8KQzkgfnbDmfqxhsITmMTqBxWuq938AeNZ+sUfuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212355>

This thread is pretty interesting. Unfortunately the holidays have
kept me busy. But I am excited by the work David and Peff are doing.
:-)

On Sun, Dec 30, 2012 at 1:31 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 30, 2012 at 07:53:48PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> >   $ cd objects/pack && ls
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.commits
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.idx
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.pack
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.parents
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.timestamps
>> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.trees
>> >
>> > Each file describes the objects in the matching pack. If a new pack is
>> > generated, you'd throw away the old cache files along with the old pack,
>> > and generate new ones. Or not. These are totally optional, and an older
>> > version of git will just ignore them. A newer version will use them if
>> > they're available, and otherwise fallback to the existing code (i.e.,
>> > reading the whole object from the pack). So you can generate them at
>>
>> You have probably thought about this (and I don't have the source to
>> check first), but we may need to version these extra files so we can
>> change the format later if needed. Git versions that do not recognize
>> new versions simply ignore the cahce.
>
> Agreed. The current code has a 4-byte magic, followed by a 4-byte
> version number, followed by a 4-byte record size[1]. Then the data,
> followed by the pack sha1, followed by a sha1 of all of the preceding
> data.  So you can verify the validity of any cache file (both its
> checksum, and that it matches the right packfile), just as you can with
> a ".idx" file.

Put the pack sha1 into the header, rather than the trailer. Its really
annoying that you read the header, determine you probably understand
this file, and then have to seek to END-40 to read the pack sha1 and
verify it matches the pack. In an ideal world the pack sha1 would have
been the file name, making this less of an issue, but someone didn't
anticipate repacking the same object set with possibly different
results. :-(

The idx format is kind of wrong here, I wish we had put the pack sha1
into the header. Given that we mmap the files the 20 bytes in front
vs. 20 bytes in the trailer wouldn't have made any difference on
access cost.

>> > Each file is a set of fixed-length records. The "commits" file contains
>> > the sha1 of every commit in the pack (sorted). A binary search of the
>> > mmap'd file gives the position of a particular commit within the list,
>>
>> I think we could avoid storing sha-1 in the cache with Shawn's idea
>> [1]. But now I read it again I fail to see it :(
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/206485
>
> Right. My implementation is very similar to what Shawn said there. I.e.,
> the timestamps file is literally 4 bytes times the number of commits.
> The parents file is 40 bytes per commit (2 parents, with a marker to
> indicate "more or less than 2"), though a lot of it is zero bytes.

Hmm, after re-reading [1] I still like my idea better. But I won't
find the time to code it myself, so I'll have to go with whatever
someone else writes. :-)

Since tree pointers are also required when parsing a commit (even if
they might not get used e.g. `git log master`) maybe this should be 16
bytes per commit storing the commit time, tree pointer, and 2 parents,
with the last 3 fields using the N-th object in the sorted sha1 list
in the idx. Sorting the file by pack stream ordering gives you good
locality during rev-list operations and makes it compact if
pack-objects adheres to writing commits before other objects.

Unfortunately this ordering requires the pack reverse index in memory
to translate from sha1 to position in the cache file. Making the
reverse index is a non-trivial cost that may dominate the running time
for smaller traversals, or the startup time for `git log` outputting
to the pager.

> Some alternatives I'm thinking about are:
>
>   1. Using non-fixed-size records, which would allow trivial compression
>      of entries like null sha1s. This would mean adding a separate
>      lookup table, though, mapping sha1s to offsets. Still, even a
>      32-bit offset is only 4 bytes per commit. If it meant dropping 40
>      bytes of zeroes from the 2nd parent field out of half of all
>      commits, that would be a win space-wise. It would be a
>      double-indirect lookup, but it's constant effort, and only two page
>      hits (which would be warm after the first lookup anyway).

Or use a 16 byte fixed width record (see above).

>   2. Storing offsets to objects in the packfile rather than their sha1s.
>      This would save a lot of space, but would mean we couldn't refer to
>      parents outside of the pack, but that may be OK. This is an
>      optimization, and the case we want to target is a fully (or mostly)
>      packed repo. It's OK to have the lookup fail and fallback to
>      accessing the object.

I glossed over this in both [1] and this message. I think its
perfectly reasonable to require parsing the commit when the commit's
parents are outside of the pack. These edge commits are infrequent
compared to the number of commits within the pack. Just mark them the
same way you mark an octopus merge, so the reader knows the parent
data is not available in the cache. For most repositories the bulk of
the commits will be in a single giant pack that contains history to
the root.

I wouldn't store the byte offsets here, those are possibly 8 bytes
wide on bigger packs. Instead store the Nth position in the pack
stream. Even if you store byte offsets you need to use the pack
reverse index to recover the SHA-1 in log N time. If you store the Nth
position you also use the pack reverse index, but you can fit all
objects from that pack in 4 bytes rather than 8 bytes per reference.

>   3. Dropping the "commits" file and just using the pack-*.idx as the
>      index. The problem is that it is sparse in the commit space. So
>      just naively storing 40 bytes per entry is going to waste a lot of
>      space. If we had a separate index as in (1) above, that could be
>      dropped to (say) 4 bytes of offset per object. But still, right now
>      the commits file for linux-2.6 is about 7.2M (20 bytes times ~376K
>      commits). There are almost 3 million total objects, so even storing
>      4 bytes per object is going to be worse.

Fix pack-objects to behave the way JGit does, cluster commits first in
the pack stream. Now you have a dense space of commits. If I remember
right this has a tiny positive improvement for most rev-list
operations with very little downside.

>   4. Making a new index version that stores the sha1s separated by type.
>      This means we can piggy-back on the regular index to get a packed
>      list of just commits. But it also means that regular sha1 lookups
>      of the objects have to look in several places (unless the caller
>      annotates the call to read_sha1_object with "I am expecting this
>      sha1 to be a commit"). And of course it means bumping the index
>      version, which is a pain. The external index means it can be
>      completely optional on top of the current index/pack.

I don't think this is worthwhile.

>> Depending on the use case, we could just generate packv4-like cache
>> for recently-used trees only. I'm not sure how tree cache impact a
>> merge operation on a very large worktree (iow, a lot of trees
>> referenced from HEAD to be inflated). This is something a cache can
>> do, but a new pack version cannot.
>
> I do not care too much about the cost of running merge on a large
> working tree. Of course it's better to make our optimizations as
> generally applicable as possible, but there is a lot of other work going
> on in a merge. The really painful, noticeable, repetitive bits right now
> are:
>
>   1. Running git-prune.
>
>   2. Creating a pack from git-upload-pack.
>
> Which are both just reachability problems. Something like "git log --
> <pathspec>" would also be helped by packv4-ish tree access patterns,
> though, but not by reachability bitmaps. And that may be something
> worth caring about.

blame would also benefit from a packv4-ish tree.

But upload-pack and prune can make massive improvements through
bitmaps, while packv4-ish tree would be only a marginal incremental
improvement. In the case of upload-pack having a bitmap gives you much
more knowledge of the remote's have set, and allows making a smaller
pack, in a lot less time, and a smaller server memory footprint. Now
that we have implemented bitmaps in our servers, I can say you really
don't want to ignore the gains we can get from them. packv4-ish tree
might help some other workloads, but bitmaps provide a better solution
to these reachability problems than anything else we know.

>> Yes. And if narrow clone ever comes, which needs --objects limited by
>> pathspec, we could just produce extra bitmaps for frequently-used
>> pathspecs and only allow narrow clone with those pathspecs.
>
> I hadn't thought about that. But yeah, because of the optional, external
> nature, there's no reason you couldn't have extra bitmap sets for
> specialized situations.

Right. We still need to redo the JGit patch series to eject the
bitmaps into an extension file. :-(
