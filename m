Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEF61FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbdC1XTh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:19:37 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33876 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdC1XTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:19:35 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so85865480pgg.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hUfTdF1qw/dRBF6ZbkFKZWt2yYvnKVi1yF63AckbYt4=;
        b=dtT04zAlVBqH5utmFP4ysBEbaxPXmOfBgRayzZosX4+oGarssTfnZhHrjCbIoXK4NR
         8SqvjY9wiow3pVCBdTa4bp8+f/doz09n5aGqG9hjBAEmnG8yC8SN8X9W7iaMNrTOloLe
         u65Y6ob+V+G1ImZ1SnLkQc4iVezRMmZnVDzTyXD2mn4qjrgbl5TmSKn6urHInNc9rs8M
         37e4sb6y6N5mA9MO9e+W/Pktzq8a99bfW49dVL7k+sdg54bwimQI/bovu+xJ5HACCrd4
         Jl0ndThIv/9kFCWBmf0ROfabjpiC6Sh3JX9etTw6i432S+Hm3E3os+bZ/Qb8O5O2t4Lx
         tEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hUfTdF1qw/dRBF6ZbkFKZWt2yYvnKVi1yF63AckbYt4=;
        b=KzVKyBXvVzotiMbr/tz03M4YR+NKWPlF+HAHb+SHofg52cGBuoXUO8DgVI7uPSP6lv
         bz3YxKsiMV2/mITpY3+IexYszLmnA9SETVbp5CUYToXHXoHA3ukWP63XONzAzEH8J3W5
         QT3gp9fRx01XAKlxR4uEjh7176cfy6OmTFDFow2bl6k6K+3Z87ET6My8/95K/wKG7F+8
         3e81u42/ncOhgxVqu/Yw+WQvUqG2WxeySzvaFwhA4MMzjQfO/TkArpyKGCDwLwrCGPQ0
         QGgwTp1Xy0oyQbRR2Mg10BULhvYDR+61yKNOh1JWmbRkU37yttc4AFs8MuOF2+K5Yw9L
         yf4A==
X-Gm-Message-State: AFeK/H1+9Gn2536LvTEnRnj1ObPLvb5W/8NEOHEwVZ+cTp1ZdzHpXbenNtZqGgOYF3LQ8K3z5C09ubXoHN8IdDMe
X-Received: by 10.84.254.5 with SMTP id b5mr25026347plm.76.1490743173984; Tue,
 28 Mar 2017 16:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 16:19:33 -0700 (PDT)
In-Reply-To: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 16:19:33 -0700
Message-ID: <CAGZ79ka-YaF5dBXJmhXsfwwrwSBy0tkun0yDysG581E0mpqDVw@mail.gmail.com>
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
To:     Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Ben Peart, who sent
"[RFC] Add support for downloading blobs on demand" to the list recently.
This proposal here seems like it has the same goal, so maybe your review
could go a long way here?

Thanks,
Stefan

On Tue, Mar 14, 2017 at 3:57 PM, Jonathan Tan <jonathantanmy@google.com> wr=
ote:
> As described in "Background" below, there have been at least 2 patch sets=
 to
> support "partial clones" and on-demand blob fetches, where the server par=
t
> that supports on-demand blob fetches was treated at least in outline. Her=
e
> is a proposal treating that server part in detail.
>
> =3D=3D Background
>
> The desire for Git to support (i) missing blobs and (ii) fetching them as
> needed from a remote repository has surfaced on the mailing list a few
> times, most recently in the form of RFC patch sets [1] [2].
>
> A local repository that supports (i) will be created by a "partial clone"=
,
> that is, a clone with some special parameters (exact parameters are still
> being discussed) that does not download all blobs normally downloaded. Su=
ch
> a repository should support (ii), which is what this proposal describes.
>
> =3D=3D Design
>
> A new endpoint "server" is created. The client will send a message in the
> following format:
>
> ----
> fbp-request =3D PKT-LINE("fetch-blob-pack")
>               1*want
>               flush-pkt
> want =3D PKT-LINE("want" SP obj-id)
> ----
>
> The client may send one or more SHA-1s for which it wants blobs, then a
> flush-pkt.
>
> The server will then reply:
>
> ----
> server-reply =3D flush-pkt | PKT-LINE("ERR" SP message)
> ----
>
> If there was no error, the server will then send them in a packfile,
> formatted like described in "Packfile Data" in pack-protocol.txt with
> "side-band-64k" enabled.
>
> Any server that supports "partial clone" will also support this, and the
> client will automatically assume this. (How a client discovers "partial
> clone" is not covered by this proposal.)
>
> The server will perform reachability checks on requested blobs through th=
e
> equivalent of "git rev-list --use-bitmap-index" (like "git upload-pack" w=
hen
> using the allowreachablesha1inwant option), unless configured to suppress
> reachability checks through a config option. The server administrator is
> highly recommended to regularly regenerate the bitmap (or suppress
> reachability checks).
>
> =3D=3D=3D Endpoint support for forward compatibility
>
> This "server" endpoint requires that the first line be understood, but wi=
ll
> ignore any other lines starting with words that it does not understand. T=
his
> allows new "commands" to be added (distinguished by their first lines) an=
d
> existing commands to be "upgraded" with backwards compatibility.
>
> =3D=3D=3D Related improvements possible with new endpoint
>
> Previous protocol upgrade suggestions have had to face the difficulty of
> allowing updated clients to discover the server support while not slowing
> down (for example, through extra network round-trips) any client, whether
> non-updated or updated. The introduction of "partial clone" allows client=
s
> to rely on the guarantee that any server that supports "partial clone"
> supports "fetch-blob-pack", and we can extend the guarantee to other
> protocol upgrades that such repos would want.
>
> One such upgrade is "ref-in-want" [3]. The full details can be obtained f=
rom
> that email thread, but to summarize, the patch set eliminates the need fo=
r
> the initial ref advertisement and allows communication in ref name globs,
> making it much easier for multiple load-balanced servers to serve large
> repos to clients - this is something that would greatly benefit the Andro=
id
> project, for example, and possibly many others.
>
> Bundling support for "ref-in-want" with "fetch-blob-pack" simplifies matt=
ers
> for the client in that a client needs to only handle one "version" of ser=
ver
> (a server that supports both). If "ref-in-want" were added later, instead=
 of
> now, clients would need to be able to handle two "versions" (one with onl=
y
> "fetch-blob-pack" and one with both "fetch-blob-pack" and "ref-in-want").
>
> As for its implementation, that email thread already contains a patch set
> that makes it work with the existing "upload-pack" endpoint; I can update
> that patch set to use the proposed "server" endpoint (with a
> "fetch-commit-pack" message) if need be.
>
> =3D=3D Client behavior
>
> This proposal is concerned with server behavior only, but it is useful to
> envision how the client would use this to ensure that the server behavior=
 is
> useful.
>
> =3D=3D=3D Indication to use the proposed endpoint
>
> The client will probably already record that at least one of its remotes
> (the one that it successfully performed a "partial clone" from) supports
> this new endpoint (if not, it can=E2=80=99t determine whether a missing b=
lob was
> caused by repo corruption or by the "partial clone"). This knowledge can =
be
> used both to know that the server supports "fetch-blob-pack" and
> "fetch-commit-pack" (for the latter, the client can fall back to
> "fetch-pack"/"upload-pack" when fetching from other servers).
>
> =3D=3D=3D Multiple remotes
>
> Fetches of missing blobs should (at least by default?) go to the remote t=
hat
> sent the tree that points to them. This means that if there are multiple
> remotes, the client needs to remember which remote it learned about a giv=
en
> missing blob from.
>
> =3D=3D Alternatives considered
>
> The "fetch-blob-pack" and "fetch-commit-pack" messages could be split int=
o
> their own endpoints. It seemed more reasonable to combine them together
> since they serve similar use cases (large repos), and (for example) reduc=
es
> the number of binaries in PATH, but I do not feel strongly about this.
>
> The client could supply commit information about the blobs it wants (or
> other information that could help the reachability analysis). However, th=
ese
> lines wouldn=E2=80=99t be used by the proposed server design. And if we d=
o discover
> that these lines are useful, the protocol could be extended with new line=
s
> that contain this information (since old servers will ignore all lines th=
at
> they do not understand).
>
> We could extend "upload-pack" to allow blobs in "want" lines instead of
> having a new endpoint. Due to a quirk in the Git implementation (but
> possibly not other implementations like JGit), this is already supported
> [4]. However, each invocation would require the server to generate an
> unnecessary ref list, and would require both the server and the client to
> undergo more network traffic.
>
> Also, the new "server" endpoint might be made to be discovered through
> another mechanism (for example, a capability advertisement on another
> endpoint). It is probably simpler to tie it to the "partial clone" featur=
e,
> though, since they are so likely to be used together.
>
> [1] <20170304191901.9622-1-markbt@efaref.net>
> [2] <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
> [3] <cover.1485381677.git.jonathantanmy@google.com>
> [4] <20170309003547.6930-1-jonathantanmy@google.com>
