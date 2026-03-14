Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB632BA21
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509471; cv=pass; b=ZfKatfoVQe/wSCR6E3Iv+QIUtnyY8CQoTfR5o5f2nF3yMkR9i/8FtgtiVHbG2SglptVBhsGXhF2kAoE5ORBHyaINjmfxUK+M6KIj4Z/LdZ1n+6bm5VM9eIFgCX7p1HwLM6P9ymAKrG9UxrjyCAE1LKHOuyCiZMfRnii/DnqgrU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509471; c=relaxed/simple;
	bh=h7U8qaUphioOXZ4aoZvw2IPkpo40yF/t2fYsxrXHZdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha927FE0/wjWTTqI/WMBGhq2aevIJv/bu9RXsMgG/4HMDmR7lueQoQwqOt5Zs1J0nNH4yrxpQgtXBpKI/eKT4avpmZSm3Wi/rE+THet+4phHzpLaEVYFazCYqoqJFejlMBVcmsnPLk0LsLDpmz6NcRPkcFisoQxfK7hNBRSh8bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMeh+//i; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMeh+//i"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4e9694so1487942c88.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 10:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773509469; cv=none;
        d=google.com; s=arc-20240605;
        b=SmCrWnLg5uyJenlU+YctPtEYkH/80/k73IhKUqY2BKI9GA7vhwKWP5ZNbRajoclLIa
         b60OKmBm5w2udZVUI6FHxkux4exBOvdgJm1I2i+eDeTjvsRC2vl90DleD2wndhvocXgN
         a6pXwRTfiuhNeqdyULL1mkUDur0VqXZJll5DQaG0uHEXiw93SFpnajM9dalgK2ljwneY
         hGA9svKRm7SPiJMmEZCXSHcsj23DXBKJY2QKGRuVVXqSg7XSuf6B1ihxQXT3Le0wKmkM
         dDwSbtbm513nwCJ4j79A7VBg1s2nPChNopyprvU/hHul/I0hRuqsGP+3TLKRQaFfpelQ
         31dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5QPP3jQzB48pjBJXZzSZBckz0iH5C24zFOFXXS1IP0=;
        fh=asi59c9VfdKo4Rf1HsCg02tSuyGwUhLZilakXMs8gTs=;
        b=kh3+x40wRlLhQ3lY8kAqfc4rf0L5JCD7kkPsZQWRMHmB19xmjktpnY60M4aq5AOB60
         FxOo0lBCJEoPZXV+JOHUhX2frJlTeMLuBpg92XBX5haLo3eRHdgEGErVpkBuqGAe8A3Q
         AF38gqccPtx9iC1gdT71T3ls+dlLreYl0lWCvP5eYMD2G0aW46BJK2lblBongKlWy+G7
         1c/UJgoI99/qmenwk0JTB9rvluy5sMW6GNutjc7Eai52iZDAr6HM9QzW9fRwcJA+R1f1
         ce9lVOI3HQX9/GzyG2A9Xvwo8Xw0q+YRB2UorwxwXW35gToAwQUs8BPqG1z2XYNRSZIH
         fMEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773509469; x=1774114269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5QPP3jQzB48pjBJXZzSZBckz0iH5C24zFOFXXS1IP0=;
        b=IMeh+//iNRgVjD40uruPVsKKpDcpUkO9bGbYL7iuRi7o2h68p/Q8vM/1Khg0x06fvJ
         4+jwn2AMZgR8MDvosmFCmi3NYG2qdYNR0L33EvCvsW3dIHoJlf621NSuuH4hbgtEdV7D
         LvZT4PdK+wQxru5b3jTHruGTh5nTZXrJTgNSyruo8dNdC+YGGbkRjAiGexDYVc1lJCN9
         yHblPYq1jCQ5G1yOdGryuttsgSCoBJ3L1Cw0jCbXd4hxS1Cz+Kxbsr4/E/cc3WK11w5H
         OU59wN3IRUu4cKSR8zIsXX1dAo31O366723ZXAEuPXnd4YuE0Usfd+OyEiUrjs23Owno
         pirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773509469; x=1774114269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5QPP3jQzB48pjBJXZzSZBckz0iH5C24zFOFXXS1IP0=;
        b=b4p/INGyTRg7wxN3wNabZAN8Boggg4YOqeiZq3fTD3JR/67vngx0ZY9CLdzvnhOzrt
         yTLieVvsyrCk3fcEkyZLquSQ096sE9ItGw7dPXnA6F6im5m72bKcBAfPOPv3z62aofri
         lSBunUR8O53SHo9IAEgq6nvNm3GedqbpO62wAWZKd/+/qryOY2Bl+VaoswfcrEfoWdFA
         8n8zamXKc/nucMhncwtPboQqbridsoJBBj4Pok/gPpkfrosnmQS2rv9sdpKhSwbVooS2
         ZPeL7dXPahf7m+tl45HlNDgwKsPIj5sb7Zm6f9UEJgU/FQbci/AcFiIXB/7rAhUAWwE0
         h2bg==
X-Gm-Message-State: AOJu0YzHG6+wnv3mSuxbpbSAcnP9+LN/8iwFW3FlJ/Cvn7dtbtyv/0Nc
	ccHheTKJzWVyzv5GRl+UERNvCyTLqPccDhHtChkEY54Sqotf25wFTnWCYcAjtvafk/qCsGC5FcP
	r8H08dLdYOAFNSU9AZKkK5CdmwG+CXbk=
X-Gm-Gg: ATEYQzzR4+jGvy5Z/6gz++HN1RmqSV79KSthPPvMCG8SaUHPpEXf0THjLK/aj3Cs4E3
	0LTp9Cfm+vmJVv024ZrgDcXpYqHOXKoq7wS3asV5icZx+H8Shp/yGO2Da2lu0jNxTWqqn3Hp1cl
	mmJEvGDibCaGrkqTSRXgl82QR0NVy/sAd9tP4UJvbtBEruwgJUCczbMqsFfKSqQOTmQ2zGziG69
	lT5sIzPE2/dEvy6jSs78pB34X4EUauE5FecUlyxrACCZaArbMyETgMubsoOqHber4fG89NUQeVO
	3v5BKIQ4IxV4AsPgsKgDn+uy8qQNawUqMeDrUgUgHjPX6j2hoikZ84Kc/QYWycdjwQ9b
X-Received: by 2002:a05:7022:684:b0:11a:3734:3db3 with SMTP id
 a92af1059eb24-128f3e1d21cmr3425918c88.32.1773509468662; Sat, 14 Mar 2026
 10:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBh__zmlWXY-yjI@lorenzo-VM>
In-Reply-To: <abBh__zmlWXY-yjI@lorenzo-VM>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 14 Mar 2026 18:30:57 +0100
X-Gm-Features: AaiRm52nqWD6Hp1DUcsKUWWkuytRNU-tkVnTQ0pzQnyCrYHmbLBi0odarz0F3_k
Message-ID: <CAP8UFD1=Ow6NNFKK6y5csmneVaS0J+e5z9pGjFmaVoJ2g1OPFg@mail.gmail.com>
Subject: Re: [GSoC Proposal] Implement promisor remote fetch ordering
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 7:25=E2=80=AFPM Lorenzo Pegorari
<lorenzo.pegorari2002@gmail.com> wrote:
>
> The following is my proposal for the GSoC'26 for the project "Implement
> promisor remote fetch ordering".

Thank you for your interest in Git and this project.

> As soon as the the contributor application period begins, I will submit
> the proposal in PDF format to the official GSoC website.

Good idea.

> I have dedicated a large section (about 40%) of the proposal to
> explaining the current situation and the tests that I have done to gain a
> lot of hands-on experience. I consider this section important, but if it
> too long-winded, please let me know.

[...]

> So far, I have made the following contributions to Git:
>
>  * [GSoC PATCH v2] diff: improve scaling of filenames in diffstat to hand=
le UTF-8 chars
>    * Link: https://lore.kernel.org/git/cover.1768520441.git.lorenzo.pegor=
ari2002@gmail.com
>    * Description: The computation of column width made by `git diff --sta=
t`
>                   was confused when pathnames contained non-ASCII chars.
>                   This issue was reported by a `NEEDSWORK` comment.
>    * Status: Merged to `master`
>
>  * [GSoC PATCH v3] diff: handle ANSI escape codes in prefix when calculat=
ing diffstat width
>    * Link: https://lore.kernel.org/git/cover.1772226209.git.lorenzo.pegor=
ari2002@gmail.com
>    * Description: Fixed `git log --graph --stat` not correctly counting
>                   the display width of colored graph part of its own
>                   output. This issue was reported by a `NEEDSWORK` commen=
t.
>    * Status: Merged to `master`.

For the patches that are merged to master, it could help if you could
give the object ID of the merge commit that merged your commits into
master, or alternatively the object ID of all your commits.

>  * [GSoC PATCH v3] doc: improve gitprotocol-pack
>    * Link: https://lore.kernel.org/git/cover.1772502209.git.lorenzo.pegor=
ari2002@gmail.com
>    * Description: Improved the `gitprotocol-pack` documentation.
>    * Status: Will merge to `master`.

Yeah, this has been merged to master after your email.

[...]

> Partial clones avoid this issue during `clone` and `fetch` operations by
> passing all the objects to download through a `--filter=3D<filter-spec>`
> specified by the user, which will limit the number of blobs and trees
> that actually get downloaded. The `<filter-spec>`, can, for example, be:
>  * `blob:none`, which will filter out all blobs.
>  * `tree:0`, which will filter out all trees.
>  * `blob:limit=3D5k`, which will filter out all blobs whose size is great=
er
>    than $5$kB.

Why are there '$' signs above?

> The filtered out objects will be lazily downloaded when the user runs a
> command that requires those missing data.
>
> This mechanism works with the following steps:
>  * When the client wants to fetch some objects from the server using a
>    filter, the client, after sending a list of capabilities it wants to
>    be in effect, sends the `filter: <filter-spec>` capability, followed
>    by a request for the objects that the client wants to retrieve. The
>    following is an example of a request (extracted using
>    `GIT_TRACE_PACKET=3D1`) made by a client to a server to fetch 1 object
>    using the `<filter-spec>=3Dblob:none`:
>
>    ```
>    [...]
>    pkt-line.c:85           packet:        fetch< 0000  # "flush-pkt"
>    pkt-line.c:85           packet:        fetch> command=3Dfetch  # Execu=
te fetch
>    pkt-line.c:85           packet:        fetch> agent=3Dgit/2.43.0
>    pkt-line.c:85           packet:        fetch> object-format=3Dsha1
>    pkt-line.c:85           packet:        fetch> 0001  # "delim-pkt"
>    pkt-line.c:85           packet:        fetch> thin-pack  # Capability
>    pkt-line.c:85           packet:        fetch> no-progress  # Capabilit=
y
>    pkt-line.c:85           packet:        fetch> ofs-delta  # Capability
>    pkt-line.c:85           packet:        fetch> filter blob:none  # Filt=
er capability
>    # OID of the object the client wants to retrieve
>    pkt-line.c:85           packet:        fetch> want 394ca7a7b5e75a57e73=
6040480f685c8b71844eb
>    pkt-line.c:85           packet:        fetch> done  # End fetch
>    pkt-line.c:85           packet:        fetch> 0000  # "flush-pkt"
>    [...]
>    ```

I think when lazy fetching like this, the filter is always blob:none.
It's not really used anyway because the objects that the client wants
are specified explicitly.

The filter is important when initially cloning or fetching from the
server to specify which objects are initially excluded, even if some
of these  objects will be lazy fetched soon. For example the checkout
part of a clone might need objects that were initially excluded, so it
might lazy fetch some.

>  * The server will apply the requested `<filter-spec>` as it creates the
>    "promisor packfile" of the requested objects.

This is important during an initial clone or fetch, not when lazy fetching.

> A packfile is a binary
>    file that is used to compress many "loose objects", and it does so by
>    containing the most recent versions of the stored objects and deltas
>    of the previous versions of those objects. A promisor packfile is a
>    filtered packfile, where the unwanted objects are not present. The
>    promisor packfile is sent to the client.


> I created a minimal example setup, mostly based on the test
> `t/t5710-promisor-remote-capability` added by `4602676` ("Add
> 'promisor-remote' capability to protocol v2", 2025-02-18), to experiment
> with multiple promisor remotes, in order to not simply rely on the
> documentation, but to actually get hands-on experience. The example setup
> creates a `server`, a 'lopm' ("Large Object Promisor medium") for blobs
> larger than 5kB, a `lopl` ("Large Object Promisor large") for blobs
> larger than 50kB, and a `client` that interfaces with all of these
> remotes. It is created in the following way:

[...]

> Now, with this setup, by slightly tweaking the configurations of each
> repository, it is possible to deeply test how multiple promisor remotes
> are handled in various situations, and actually see what is described in
> the documentation.

Yeah, it's quite complex to set up.

> ## Testing Promisor Remotes Advertisement
>
> An important thing to test is the promisor remotes advertisement feature.
> This feature is dependent on 2 main configuration options: the
> server-side option `promisor.advertise`, which enables the server to
> advertise the promisor remotes it is using to the client, and the
> client-side option `promisor.acceptFromServer`, which describes how the
> client should handle the promisor remotes advertised:
>
>  * If `promisor.advertise=3Dfalse`, when the `client` wants to fetch an
>    object that the `server` does not have,

I don't think it depends on the client fetching an object the server
does not have. It depends on the client using a filter because the
promisor-remote capability only makes sense in the case of partial
clones (or fetches).

> the `server` will not
>    advertise the `promisor-remote` capability, and so it has no other
>    choice than to first fetch the object from `lopl` and/or `lopm`, and
>    then give it to the `client`. This can be checked by doing `git -C
>    server rev-list --objects --all --missing=3Dprint`, and seeing that th=
e
>    previously missing large blobs are now present inside the `server`, or
>    by directly looking into the `GIT_TRACE_PACKET` output, and seeing
>    that there is no reference to the `promisor-remote` capability.
>
>  * If `promisor.advertise=3Dtrue`, when the `client` wants to fetch an
>    object that the `server` does not have,

Same as above, it doesn't depend on the client fetching an object the
server does not have. It depends on the client using a filter because
the promisor-remote capability only makes sense in the case of partial
clones (or fetches).

> the `server` will advertise
>    its promisor remotes, as seen by the `GIT_TRACE_PACKET` output, which
>    will contain:
>
>    ```
>    [...]
>    packet: upload-pack> promisor-remote=3D \
>        name=3Dlopl,url=3Dfile://$(pwd)/lopl; \  # Adv lopl
>        name=3Dlopm,url=3Dfile://$(pwd)/lopm  # Adv lopm
>    [...]
>    ```

[...]

> Recently, with the patch series "Implement `promisor.storeFields` and
> `--filter=3Dauto`" [5], the new client-side configuration variable
> `promisor.storeFields` was added. It contains a list of field names
> `partialCloneFilter` and/or `token`), and the values of these fields,
> when transmitted by the server, will be stored in the local configuration
> on the client.
>
> ## Testing Multiple Promisor Remotes Fetch Order

Yeah, I think this is the most relevant for the project.

> Finally, the last mechanism that is fundamental to understand is the
> fetch order when multiple promisor remotes are defined:
>
>  * When multiple remotes are configured, they are tried one after the
>    other in the order in which they appear in the configuration, until
>    all objects are fetched.

Right, but there is the exception of a remote configured with
`extensions.partialClone` that will be tried last. You mention it
later though.

> This can be easily seen from the output of
>    `GIT_TRACE`, which initially tries to fetch the objects from `lopl`,
>    and then from `lopm`:
>
>    ```
>    [...]
>    trace: built-in: git fetch lopl [...] --filter=3Dblob:none [...]
>    [...]
>    trace: built-in: git fetch lopm [...] --filter=3Dblob:none [...]
>    [...]
>    ```
>
>    While, if we make it so that we first define `lopm` in the `client`
>    configuration, then initially `lopm` will be used to fetch the
>    objects, and `lopl` will not be used at all (because `lopm` contains
>    all required objects:
>
>    ```
>    [...]
>    trace: built-in: git fetch lopm [...] --filter=3Dblob:none [...]
>    [...]
>    ```

Yeah, when all the needed objects have been lazy fetched, there is no
point in further fetching from any remote.

>  * If the configuration option `extensions.partialClone` is present, the
>    promisor remote that it specifies will always be the last one tried
>    when fetching objects.
>
> ------------------------------
>
> # "Implement promisor remote fetch ordering"
>
> ## Project Goal
>
> This project aims to improve Git by implementing a fetch ordering
> mechanism for multiple promisor remotes, that can be:
>
>  * Configured locally by the client.
>  * Advertised by servers through the `promisor-remote` protocol.
>
> ## Approach
>
> The bulk of the project will be the creation of a system that allows to
> define the order with which the promisor remotes will be tried when
> fetching an object.
>
> The first goal will be the creation of a `remote.<name>.promisorPriority`

Yeah, or just `remote.<name>.priority`. The name is to be discussed.

> configuration option, which will hold a number between 1 and 'UCHAR_MAX',

UCHAR_MAX could be system dependent. It might be better to have
configurations work in the same way on all machines though. So perhaps
a fixed range like 1 to 100 would be better. Or are there other ranges
of values used for similar things in Git or other well known software
that could be reused?

> and which defines the priority of that promisor remote in the fetch
> order. This means that the order in which the promisor are tried will be
> the following:
>
>  * All promisor remotes that have a valid `remote.<name>.promisorPriority=
`,
>    starting from the one with higher priority (the lower `promisorPriorit=
y`
>    value). If 2 or more promisor remotes have the same priority, they wil=
l be
>    tried following the order in which they appear in the configuration fi=
le.
>
>  * All promisor remotes that don't have or have an invalid
>    `remote.<name>.promisorPriority` configuration option. If 2 or more
>    promisor remotes don't define any priority, or have an invalid priorit=
y,
>    they will be tried following the order in which they appear in the
>    configuration file.
>
>  * The promisor remote defined inside the `extensions.partialClone`, no
>    matter their priority (which will be ignored if present). This is
>    necessary for backward compatibility.

Yeah, I think something like what you describe makes sense.

> Having already taken a look at the code, I have a general idea of th

s/of th/of the/

> major steps to take to actually introduce the
> `remote.<name>.promisorPriority` configuration option:

[...]

> # Possible Issues
>
> From my understanding, the project as it is proposed will handle all
> possible cases, except for one. Let's imagine the following situation:
>
>  * `server1` and `server2` both use the promisor remotes `lop1` and `lop2=
`.
>  * `client` has both `server1` and `server2` as remotes.
>
> In this situation, the `client` has no way to specifically say that when
> fetching from `server1`, it wants to first try `lop1` and then `lop2`, wh=
ile
> when fetching from `server2`, it wants to first try `lop2` and then `lop1=
`.

Right, but lazy fetching does not only happen as part of a clone or
fetch from a server. It happens when for some reason (like a git show
or a git blame for example) the user needs some objects it doesn't
have locally, and when that happens, this is not related to a single
server.

So global priorities are likely the most useful ones to have.

> One way to solve this very specific (and maybe unusual) issue is to
> introduce a way to associate a `promisorPriority` to a specific remote.

Yeah, but I don't think it would be used a lot. We can perhaps think
of some cases where it could be useful, but in practice it is likely
that if there is an optimal order for one server, it will be optimal
for all other servers too.

[...]

Thanks!
