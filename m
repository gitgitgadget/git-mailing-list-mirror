From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 19:11:48 -0600
Message-ID: <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org> <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 03:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us0kx-0001za-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 03:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3F0BML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 21:12:11 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50436 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3F0BMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 21:12:10 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so354525iej.15
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qmCCaFUHOC4Vno+/QgbP0IG/djh7OcbjgBfq35povSM=;
        b=NYKD1aAJZEFo81drSbS1kff01E5y6jeCK9DP6HHXb4azQ09e4SlLJpJ313G/UEbk2S
         3R3dfFBf0kWNYwsedK8V3YqHlq2VlHNRyQdFz6AEAtrPoO57HtGNejOjN2T2WjRr0RkJ
         rEE6HtQgYBvqLGg2JVXykzgZYKr9UVWmuteY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=qmCCaFUHOC4Vno+/QgbP0IG/djh7OcbjgBfq35povSM=;
        b=E5I6O8dLxmJWYqCJd7eGfr2nXjyJmBvF/TVCqChZ1ZXNJM0mmxRZmdt6TxavXcmS34
         t6wkEdI6LH5bBoqqzm5tCKU8+gcTtKQdQXWQTlbO9c3hE8oTi1/C5LM6fXhWaHeB+SJ8
         ESPENZoclpkni4H9v0eKvDgxbiLMSVfY19ppmd5XtPcStMiKHY5vXCKvOicu0cgrgXu8
         NeulQ5jXkPh1UhNVtweKtpXiufR914ZKXcWT53Df22EOVTKJyvx6PkDZjC22MhnBx1H9
         8NnRQcj2Bpy2uan5IQCe10+IG3WkQnHS4CFrdAHv/1Ul4dsBttSdvGb1LhqoRMxdCLey
         DYrA==
X-Received: by 10.50.44.98 with SMTP id d2mr13607970igm.15.1372295528599; Wed,
 26 Jun 2013 18:12:08 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Wed, 26 Jun 2013 18:11:48 -0700 (PDT)
In-Reply-To: <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
X-Gm-Message-State: ALoCoQmIy+bBiVo7B3LixwT5pR4U5ixfiHAR3FouW19cImoFJzC8uSsNZG4ACQnTfX+8CEBF4FK6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229078>

On Tue, Jun 25, 2013 at 4:08 PM, Vicent Mart=ED <tanoku@gmail.com> wrot=
e:
> On Tue, Jun 25, 2013 at 11:17 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> What case are you talking about?
>>
>> The n-th object must be one of these four types and can never be of
>> more than one type at the same time, so a natural expectation from
>> the reader is "If you OR them together, you will get the same set".
>> If you say "If you XOR them", that forces the reader to wonder when
>> these bitmaps ever can overlap at the same bit position.
>
> I guess this is just wording. I don't particularly care about the
> distinction, but I'll change it to OR.

Hmm, OK. If you think XOR and OR are the same operation, I also have a
bridge to sell you. Its in Brooklyn. Its a great value.

The correct operation is OR. Not XOR. OR. Drop the X.

> It cannot be mmapped not particularly because of endianness issues,
> but because the original format is not indexed and requires a full
> parse of the whole index before it can be accessed programatically.
> The wrong endianness just increases the parse time.

Wrong endianness has nothing to do with the parse time. Modern CPUs
can flip a word around very quickly. In JGit we chose to parse the
file at load time because its simpler than having an additional index
segment, and we do what you did which is to toss the object SHA-1s
into a hashtable for fast lookup. By the time we look for the SHA-1s
and toss them into a hashtable we can stride through the file and find
the bitmap regions. Simple.

In other words, the least complex solution possible that still
provides good performance. I'd say we have pretty good performance.

>>> and I'm going to try to make it run fast enough in that
>>> encoding.
>>
>> Hmph.  Is it an option to start from what JGit does, so that people
>> can use both JGit and your code on the same repository?

I'm afraid I agree here with Junio. The JGit format is already
shipping in JGit 3.0, Gerrit Code Review 2.6, and in heavy production
use for almost a year on android.googlesource.com, and Google's own
internal Git trees.

I would prefer to see a series adding bitmap support to C Git start
with the existing format, make it run, taking advantage of the
optimizations JGit uses (many of which you ignored and tried to "fix"
in other ways), and then look at improving the file format itself if
load time is still the largest low hanging fruit in upload-pack. I'm
guessing its not. You futzed around with the object table, but JGit
sped itself up considerably by simply not using the object table when
the bitmap is used. I think there are several such optimizations you
missed in your rush to redefine the file format.

>>  And then if
>> you do not succeed, after trying to optimize in-core processing
>> using that on-disk format to make it fast enough, start thinking
>> about tweaking the on-disk format?
>
> I'm afraid this is not an option. I have an old patchset that
> implements JGit v1 bitmap loading (and in fact that's how I initially
> developed these series -- by loading the bitmaps from JGit for
> debugging), but I discarded it because it simply doesn't pan out in
> production. ~3 seconds time to spawn `upload-pack` is not an option
> for us. I did not develop a tweaked on-disk format out of boredom.

I think your code or experiments are bogus. Even on our systems with
JGit a cold start for the Linux kernel doesn't take 3s. And this is
JGit where Java is slow because "Jesus it has a lot of factories", and
without mmap'ing the file into the server's address space. Hell the
file has to come over the network from a remote disk array.

> I could dig up the patch if you're particularly interested in
> backwards compatibility, but since it was several times slower than
> the current iteration, I have no interest (time, actually) to maintai=
n
> it, brush it up, and so on. I have already offered myself to port the
> v2 format to JGit as soon as it's settled. It sounds like a better
> investment of all our times.

Actually, I think the format you propose here is inferior to the JGit
format. In particular the idx-ordering means the EWAH code is useless.
You might as well not use the EWAH format and just store 2.6M bits per
commit. The idx-ordering also makes *much* harder to emit a pack file
a reasonable order for the client. Colby and I tried idx-ordering and
discarded it when it didn't perform as well as the pack-ordering that
JGit uses.

> Following up on Shawn's comments, I removed the little-endian support
> from the on-disk format and implemented lazy loading of the bitmaps t=
o
> make up for it. The result is decent (slowed down from 250ms to 300ms=
)
> and it lets us keep the whole format as NWO on disk. I think it's a
> good tradeback.

The maintenance burden of two endian formats in a single file is too
high to justify. I'm glad to see you saw that.

> As it stands right now, the only two changes from v1 of the on-disk f=
ormat are:
>
> - There is an index at the end. This is a good idea.

I don't think the index is necessary if you plan to build a hashtable
at runtime anyway. If you mmap the file you can quickly skip over a
bitmap and find the next SHA-1 using this thing called "pointer
arithmetic". I am not sure if you are familiar with the term, perhaps
you could search the web for it.

> - The bitmaps are sorted in packfile-index order, not in packfile
> order. This is a good idea.

As Colby and I have repeatedly tried to explain, this is not a good ide=
a.

> German kisses,

Strawberry and now German kisses? What's next, Mango kisses?
