From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 3 Mar 2014 11:12:29 -0800
Message-ID: <CAJo=hJthjtsa7uuW-Zq5uWrJYfk1G6mzkEq_toPMtjATwDMKTA@mail.gmail.com>
References: <20140128060954.GA26401@sigill.intra.peff.net> <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
 <20140224082459.GA32594@sigill.intra.peff.net> <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
 <20140226101353.GA25711@sigill.intra.peff.net> <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
 <20140227112734.GC29668@sigill.intra.peff.net> <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
 <20140228085546.GA11709@sigill.intra.peff.net> <2E523500-558A-42CF-A761-618DD2821347@codeaurora.org>
 <20140301060550.GB20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nasser Grainawi <nasser@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Agarwal <sid0@fb.com>,
	Vicent Marti <tanoku@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:13:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYIO-0006JH-0i
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbaCCTMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:12:53 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:49833 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbaCCTMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:12:51 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so3829603wgh.9
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QS7Xzcgi/l+sZL0RrnFQuOb7aOwJUuaEtPXaLjM5V0Y=;
        b=dhJuz7GDZs2vesFlueAGIqHLbDYW1IAFIS2Opy6Gec7fXBR3o0mAO3QR/EslKhs1rM
         k5dOWF8EZ/k/+2JsvpJ+MLNY2O9EKFdIo9jUTWM8SR8B3FiA/QyCvZVfWUP6CDgFAjZL
         cD6J5gonKSW3a0y6ubqbUYiTRxCr2iXEV6QtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=QS7Xzcgi/l+sZL0RrnFQuOb7aOwJUuaEtPXaLjM5V0Y=;
        b=UJ7jHKdmwNkvVCAnzS2owqmrK86Gs5UxzaC6SFfc8+Yz5GUQS/7dvZ+GAIg5yLAWCO
         M/0QcMDSPaFPMo+cttwl070oOb2rfkR+G3dz76lc1K+Cj5PthQ+UlZ0wJZor8rtk0YMi
         2MBapTdqGNbqKla6ihKZzt5R4Ox1aKmI0Rj1Gb3N+E1RsmNgEoWvEYOEXTTZSMzTEGEZ
         aCOGMEii/4iLH2453G4cycVRQL2RmpCVz2RrQ8O3KXA6zF42Bw/RbxFwIrJcXIfy72Hx
         lwtP8hdXAuizjtzQyrI/d0ezTnfWPchlpFCMT1544JR1QGtN4QZ7SoQ7W7ah1+mhJm+K
         4Sug==
X-Gm-Message-State: ALoCoQnqj3N13RNozIzJir9kD79i6PwVnidPXJBxiExRjcVKx+8o6tuMyeSKL9mJcJZku3X3lnan
X-Received: by 10.194.90.196 with SMTP id by4mr20327876wjb.45.1393873969959;
 Mon, 03 Mar 2014 11:12:49 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Mon, 3 Mar 2014 11:12:29 -0800 (PST)
In-Reply-To: <20140301060550.GB20397@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243257>

On Fri, Feb 28, 2014 at 10:05 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 28, 2014 at 10:09:08AM -0700, Nasser Grainawi wrote:
>
>> > Exactly. The two features (bitmaps and .keep) are not compatible with
>> > each other, so you have to prioritize one. If you are using static .keep
>> > files, you might want them to continue being respected at the expense of
>> > using bitmaps for that repo. So I think you want a separate option from
>> > --write-bitmap-index to allow the appropriate flexibility.
>>
>> Has anyone thought about how to make them compatible?
>
> Yes, but it's complicated and not likely to happen soon.
>
> Having .keep files means that you are not including some objects in the
> newly created pack. Each bit in a commit's bitmap corresponds to one
> object in the pack, and whether it is reachable from that commit. The
> bitmap is only useful if we can calculate the full reachability from it,
> and it has no way to specify objects outside of the pack.
>
> To fix this, you would need to change the on-disk format of the bitmaps
> to somehow reference objects outside of the pack. Either by having the
> bitmaps index a repo-global set of objects, or by permitting a list of
> "edge" objects that are referenced from the pack, but not included (and
> then when assembling the full reachable list, you would have to recurse
> across "edge" objects to find their reachable list in another pack,
> etc).
>
> So it's possible, but it would complicate the scheme quite a bit, and
> would not be backwards compatible with either JGit or C Git.

Colby Ranger always wanted to add this to the bitmap scheme. Construct
a partial pack bitmap on a partial pack of "recent" objects, with edge
pointers naming objects that are not in this pack but whose closures
need to be considered part of the bitmap. Its complicated in-memory
because you need to fuse together two or more bitmaps (the partial
pack one, and the larger historical kept pack) before running the
"want AND NOT have" computation.

Colby did not find time to work on this in JGit, so it just didn't get
implemented. But we did consider it, as the servers at Google we built
bitmap for use a multi-level pack scheme and don't want to rebuild
packs all of the time.

>> We're using Martin Fick's git-exproll script which makes heavy use of
>> keeps to reduce pack file churn. In addition to the on-disk benefits
>> we get there, the driving factor behind creating exproll was to
>> prevent Gerrit from having two large (30GB+) mostly duplicated pack
>> files open in memory at the same time. Repacking in JGit would help in
>> a single-master environment, but we'd be back to having this problem
>> once we go to a multi-master setup.
>>
>> Perhaps the solution here is actually something in JGit where it could
>> aggressively try to close references to pack files
>
> In C git we don't worry about this too much, because our programs tend
> to be short-lived, and references to the old pack will go away quickly.
> Plus it is all mmap'd, so as we simply stop accessing the pages of the
> old pack, they should eventually be dropped if there is memory pressure.
>
> I seem to recall that JGit does not mmap its packfiles. Does it pread?

JGit does not mmap because you can't munmap() until the Java GC gets
around to freeing the tiny little header object that contains the
memory address of the start of the mmap segment. This can take ages,
to the point where you run out of virtual address space in the process
and s**t starts to fail left and right inside of the JVM. The GC is
just unable to prioritize finding those tiny headers and getting them
out of the heap so the munmap can take place safely.

So yea, JGit does pread() for the blocks but it holds those in its own
buffer cache inside of the Java heap. Where a 4K disk block is a 4K
memory array that puts pressure on the GC to actually wake up and free
resources that are unused. What Nasser is talking about is JGit may
take a long time to realize one pack is unused and start kicking those
blocks out of its buffer cache. Those blocks are reference counted and
the file descriptor JGit preads from is held open so long as at least
one block is in the buffer cache. By keeping the file open we force
the filesystem to keep the inode alive a lot longer, which means the
disk needs a huge amount of free space to store the unlinked but still
open 30G pack files from prior GC generations.

> In that case, I'd expect unused bits from the duplicated packfile to get
> dropped from the disk cache over time. If it loads whole packfiles into
> memory, then yes, it should probably close more aggressively.

Its more than that, its the inode being kept alive by the open file
descriptor...
