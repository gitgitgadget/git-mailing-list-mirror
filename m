Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070401F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdHCSid convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Aug 2017 14:38:33 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50551 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbdHCSib (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2017 14:38:31 -0400
X-AuditID: 1207440c-c4bff70000000b4f-3f-59836da6bddd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 03.CA.02895.6AD63895; Thu,  3 Aug 2017 14:38:30 -0400 (EDT)
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com [209.85.223.178])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v73IcTiD030979
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 3 Aug 2017 14:38:29 -0400
Received: by mail-io0-f178.google.com with SMTP id c74so10222967iod.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:38:29 -0700 (PDT)
X-Gm-Message-State: AIVw112WSHuD9j+ZzelwiPUmb/kC85dViUDjh1RWXaBuFSsQag0rZFKF
        jDbnBl6Os2xZa2DX0cNEzzQ4j12+Jg==
X-Received: by 10.107.187.135 with SMTP id l129mr2838284iof.122.1501785508687;
 Thu, 03 Aug 2017 11:38:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 3 Aug 2017 11:38:27 -0700 (PDT)
In-Reply-To: <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com> <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 3 Aug 2017 11:38:27 -0700
X-Gmail-Original-Message-ID: <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com>
Message-ID: <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLsstznSYNlNNYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGX0/FjMWHAoouLn960sDYyfXbsYOTkkBEwkPp7fzAxiCwnsYJK4
        cTq4i5ELyH7CJPHywEt2CKefUaLtyFpGiI58iVm3lzJB2GUSTb/msIHYvAKCEidnPmGBmCQn
        8WrDDUYI20viyNFFYDWcAoESb1feYIMY+opJYvLsg2Cr2QR0JRb1NIMNZRFQkfi1+TE7xIJE
        ialL+5khFgRIzPvXBTZIWMBIouPCPrC4iICaxPYLPawgQ5kFpjJKHJtxDKyIWUBTonX7b3YI
        W1ti2cLXzBMYRWYhOXYWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFL
        TSndxAgJfJ4djN/WyRxiFOBgVOLh7bjRGCnEmlhWXJl7iFGSg0lJlLf6WFOkEF9SfkplRmJx
        RnxRaU5q8SFGCQ5mJRFetYzmSCHelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpis
        DAeHkgRvWQ5Qo2BRanpqRVpmTglCmomDE2Q4D9Bwc5Aa3uKCxNzizHSI/ClGY44rV9Z9YeKY
        cmD7FyYhlrz8vFQpcd70bKBSAZDSjNI8uGmw5PWKURzoOWHegyADeYCJD27eK6BVTECr/tQ1
        gqwqSURISTUwcvy76eCe8PHiqzW5M69e2nD+ls5FVdaF7hxRa38Ez3hbsyZrEUv8osfGoqKa
        oou/uK32mvRyq6fK82+CIZMfrww2ef375LlTjW56WxyuP+q4+anK8s/8G43FW7nO9opZbAo9
        bb2ntd6bpSvGl1/9mNa+pbOf3JJZof/3uMS89drrPxhdus7jU6LEUpyRaKjFXFScCABgdDnI
        OQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 7:38 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, Aug 1, 2017 at 6:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> [...]
>>> A couple of other notes about your contrasting design:
>>>
>>>>     elif chunk_type == INDEX {
>>>>         chunk_length : varint
>>>
>>> Using a varint for the chunk length made for a complicated reader.
>>> JGit doesn't have the luxury of mmap to access the file, so we have to
>>> allocate a byte[] and read data from a file descriptor to do anything
>>> fancy like decoding a varint. For my experiment I wound up just
>>> hardcoding the IO to read 1k or 4k from whatever address.
>>>
>>> A "real" implementation would likely prefer to read a fixed width
>>> field here such that chunks have a 3 byte header (1 byte chunk_type, 2
>>> byte chunk_length), and then issue a second read to acquire the rest
>>> of the chunk. Given that encoding a chunk length of 1024 or 4096 both
>>> requires 2 bytes of varint, its always going to be 2 bytes in your
>>> design anyway. With the way chunks are scanned, I don't think you want
>>> chunks as large as 16k, which would have caused the varint to go to 3
>>> bytes (but still fits in a fixed 2-byte chunk_length).
>>
>> That's a good point for INDEX and OBJS_INDEX blocks. Though for REFS
>> blocks that include reflogs, the block size has to be large enough to
>> hold the whole reflog for a reference, which can be arbitrarily large.
>> (Maybe this is a weakness of the design?)
>
> Gah. I missed that part about the whole reflog needing to fit in the
> same chunk when I wrote the quoted text above. That is a pretty big
> downside for very busy refs.
>
> Even when you isolate logs into their own file, the reflog for a busy
> ref could be huge. A naive reader would want to "page in" the entire
> chunk_length before parsing. That isn't tenable if the reflog for a
> busy ref was say 50 MiB. It complicates the reader more. My reftable
> proposal deals with this by breaking the log up with its special key
> structure.
>
> Requiring the entire reflog of a single ref to fit into a single chunk
> does seem to have its downsides.

I was assuming that readers would uncompress the data streamily, in
which case I don't think that it would be much of a problem: reflogs
are usually read either in their entirety, or just the most recent few
entries are read, either of which could be done efficiently despite
the whole reflog being in a single zlib-compressed blob. If streamy
reading is thought to be too complicated for readers, it wouldn't be a
big deal to add a `log_type` of `REFLOG_COMPRESSED_SEGMENTED` and put
the entries into multiple, smaller zlib-compressed chunks.

>> OBJS blocks can also be
>> unbounded in size if very many references point at the same object,
>> thought that is perhaps only a theoretical problem.
>
> Gah, I missed that in reftable. The block id pointer list could cause
> a single object id to exceed what fits in a block, and that will cause
> the writer to fail unless its caller sets the block size larger. I
> basically assumed this overflow condition is very unlikely, as its not
> common to have a huge number of refs pointing to the same object.

Given what Peff pointed out, let's just leave this as a varint for OBJS blocks.

>>>>     elif chunk_type == OBJS_INDEX {
>>>>         chunk_length : varint
>>>>
>>>>         # The offset, relative to the start of this chunk, of the
>>>>         # chunk containing the next level of the obj index, for each
>>>>         # of the possible "next" bytes in the SHA-1, or zero if there
>>>>         # are no references with the given next byte.
>>>>         child_offset : varint * 256
>>>
>>> This is space saving and cute, but kind of annoying. If it was fixed
>>> width 32 bit you can address up to 4G away from this chunk's address,
>>> and you can directly jump to the byte of interest. By being varints
>>> you do save a little space, as most files will probably only need 3
>>> byte varints, and the 0s do collapse down to 1 byte, but you have to
>>> linearly walk the list to find any specific byte.
>>
>> The reason I used varint here was mostly because I expect the lowest
>> level of the OBJS_INDEX to be placed close to the OBJS chunks that it
>> refers to; hopefully within a 2-byte varint. Let me consider more
>> carefully whether that is realistic...
>
> Ah, ok. So you were expecting the writer to interleave OBJS and
> OBJS_INDEX chunks, with the OBJS_INDEX appearing every ~256 OBJS
> chunks. And then storing the next level of OBJS_INDEX consecutively.
>
> I think your math is still wrong about the lowest level OBJS_INDEX
> needing only 2-byte varint for child_offset. Given a 1k chunk size,
> you still have to address backwards about 256k, which requires a
> 3-byte varint.

I think that you would want the lowest OBJS_INDEX to be mostly
populated, meaning that the next level nodes in the tree would mostly
only have zero or one entry. The true distribution [1] would be close
to a Poisson distribution with a mean of `λ ≲ 1` (where λ is basically
the filling factor), which looks like

    P(λ, n) = λⁿ exp(-λ) / n!

For `λ = 1`, that looks like

    P(1, 0) = 36.8%
    P(1, 1) = 36.8%
    P(1, 2) = 18.4%
    P(1, 3) = 06.1%
    P(1, 4) = 01.5%
    P(1, 5) = 00.3%
    P(1, 6) = 00.1%

so almost all OBJS chunks would have fewer than five entries. And in
fact the mean number of entries would be `λ`. So the total size of the
OBJS chunks pointed at by a given OBJS_INDEX chunk should be something
like

    256 * λ * sizeof(OBJS chunk) ≲ 1800 bytes.

[1] This is assuming randomness of SHA-1s, which AFAIK is normally a
good approximation. It is of course possible that somebody would try
to grief the system by creating a repository with lots of objects that
have similar SHA-1 prefixes, but I think the worst result would be
that some operations would scale like O(number of references) rather
than O(256), which isn't all that pathological, and the distinct
pattern would be clear evidence of malice that would justify banning
the user.

> Given the uniform distribution of SHA-1, I think you still wind up
> with most of the OBJS_INDEX populated. E.g. in my 866k ref/865k obj
> example the unique object abbreviation is 6 raw bytes. The OBJS chunk
> storing 2 bytes means we have 4 levels of OBJS_INDEX to cover the
> first 4 bytes. That leaves ~844 obj_records in each OBJS chunk. If
> those are 7 bytes/obj_record, the OBJS chunk is ~5.7 KiB.
>
> Forcing the OBJS chunk to stay under say 4 KiB will absolutely cause a
> lot more holes in the OBJS_INDEX levels.

I was thinking more about how to store the objects lookup table. Let's
assume that we combine the lowest-level OBJS_INDEX chunk along with
the OBJS chunks that it points to into a new OBJS_LEAF chunk. I think
the goals are as follows:

* The lowest OBJS_LEAF nodes should have a filling factor of
approximately `λ = 1`.
* It should be possible to adjust the size of the lowest OBJS_LEAF
nodes based on the preferred read size. (This might mean that all of
the OBJS_LEAF nodes referred to by the next-higher node in the tree
fit together with it in a single 64k block.)
* That higher-level nodes also can be packed efficiently in blocks of
roughly the preferred read size.
* That false positives be the exception. If we ask a higher-level
reftable whether it might contain a reference to $sha1, it would be
nice to be able to get a "no" answer without having to read actual
references. I think that is an argument why we *don't* want to store
only the largest unique prefix of the contained SHA-1s. I think we
want to *always* store enough bits of SHA-1 prefix to make the
referred-to SHA-1s represent only a small fraction (say, 1/256th) of
the total prefix space. E.g., if references in a particular repository
point to 2ⁿ distinct SHA-1s, then we'd want the prefix to include
something like n+8 bits.

To achieve these goals, I think we it would be best to make the number
of bits used in each level of the tree be variable rather than
hard-coded to be 8. By changing the radix of different levels of the
tree, I think you could arrange for block sizes that are optimal for
your filesystem at the same time that you ensure that the OBJS_LEAF
nodes have the desired filling factor.

If anybody's interested, I can flesh out these ideas more next week
when I have time.

>> Peff and I discussed off-list whether the lookup-by-SHA-1 feature is
>> so important in the first place. Currently, all references must be
>> scanned for the advertisement anyway,
>
> Not really. You can hide refs and allow-tip-sha1 so clients can fetch
> a ref even if it wasn't in the advertisement. We really want to use
> that wire protocol capability with Gerrit Code Review to hide the
> refs/changes/ namespace from the advertisement, but allow clients to
> fetch any of those refs if they send its current SHA-1 in a want line
> anyway.
>
> So a server could scan only the refs/{heads,tags}/ prefixes for the
> advertisement, and then leverage the lookup-by-SHA1 to verify other
> SHA-1s sent by the client.
>
>> so avoiding a second scan to vet
>> SHA-1s received from the client is at best going to reduce the effort
>> by a constant factor. Do you have numbers showing that this
>> optimization is worth it?
>
> No, but I don't think I need to do much to prove it. My 866k ref
> example advertisement right now is >62 MiB. If we do what I'm
> suggesting in the paragraphs above, the advertisement is ~51 KiB.
>
>> OTOH a mythical protocol v2 might reduce the need to scan the
>> references for advertisement, so maybe this optimization will be more
>> helpful in the future?
>
> Yes, I'm hopeful we can get a v2 protocol built on the work Jonathan
> Tan is doing, and switch the advertisement around to "client speaks
> first", so that we can be smarter on the server about which refs are
> read and sent. That is a long way off, lets say 3-5 years before its
> really common in clients.

My takeaway from the discussion about whether object lookup is an
important feature is that it should very much be optional, and by
extension we should probably leave room for other optional extensions
in the file format.

> [...]
>> That's what I was thinking. But I've yet to hear anybody complain
>> about missing reflogs for symrefs if the underlying reference is
>> updated directly, so maybe we should just leave that "problem"
>> unsolved. It is certainly simpler and less brittle not to have to keep
>> backreferences like these in sync with the forward references.
>
> Yup, that is my take on it, and why I didn't try to put this into
> reftable drafts, even though it was discussed between us on the list
> in earlier messages.

Yes, let's forget the idea of including backreferences from refs to
the symrefs that refer to them.

Michael
