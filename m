Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109CA20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdAQVuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:50:19 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33931 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdAQVuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:50:16 -0500
Received: by mail-qt0-f194.google.com with SMTP id a29so24653320qtb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=xA6dNawKAjOr+U6un6xukHshpGHOUMq+NdzFdHn5diQ=;
        b=NHqrgTo2DUfQzQckHX4nBt/Q4ePMI0XDdF2U9841ex6KrWclJbQ1dtR1UXgaKO2IVR
         hhj9V7DXWudYI3fIsnOp3IIQW/0vOCK+/BhEDc94J7ToGkvmG7u87OhtUbiCa8eiCIJt
         KBheHMzpvgp34h1Hsr1+a96ShiT9YrQuXIHMzV5/F5pV1x030zPhjBTqS6SKUaPzf81y
         oX90uaYSOVNim49bjdmHPtynzLNJjSwzMCqrqBre2qOuzy0JMSj4b/Hci9oXztn/OhFt
         qaUrxdHn2FP9PvdN/pIBsfflJ59tycDLT10KtvOsc+kNFAmg4wJWXx9Wu3xEn1e3y1ip
         rvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=xA6dNawKAjOr+U6un6xukHshpGHOUMq+NdzFdHn5diQ=;
        b=FEOku4K7evsmd+Bkoqg+KiIQBpk3sxtaeL35TxmDyLUbphOTKoFoz3CwXs8HhLeL+k
         aEbdJuif19FBIFEfyqwNiwXOGjl0JAjEh8CWmKMlXTfjrxOeE3wh6kzYUeGEY9hNVmA4
         bnfxBN6YAXTNox3dIeNRfu1/PtXcKul+7nupIX2DmEjmmByCqJEv3Ry9TXrrzgoToi1w
         S1ki5bAPVMhQHrwdmFKuE6OHad0y9P8EQ1pPDxNaOLb2/qelTJRUKtUnSRhWYKIjZWve
         FWe67Ag5HUoZEkx2edfqMMNsqwkCu98kUzMYYlC6g6bKRcMdMmMotLaM6nto0YAvL7oW
         Q7YA==
X-Gm-Message-State: AIkVDXIpB0QiYIh9z+efKM9pogjdIA0qEBWsSqReB7+h/1FypYPcjVNKvRU1Q9BgMdDe9Q==
X-Received: by 10.200.42.200 with SMTP id c8mr15026348qta.156.1484689815142;
        Tue, 17 Jan 2017 13:50:15 -0800 (PST)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f130sm19764838qkb.1.2017.01.17.13.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 13:50:13 -0800 (PST)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Shawn Pearce'" <spearce@spearce.org>
Cc:     "'git'" <git@vger.kernel.org>, <benpeart@microsoft.com>
References: <20170113155253.1644-1-benpeart@microsoft.com> <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com>
In-Reply-To: <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com>
Subject: RE: [RFC] Add support for downloading blobs on demand
Date:   Tue, 17 Jan 2017 16:50:13 -0500
Message-ID: <002501d2710b$af74c4d0$0e5e4e70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHeqv64Rhj1j9YcMHkE7nrdCUWdigLJzk+joQ5nFxA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the encouragement, support, and good ideas to look into.

Ben

> -----Original Message-----
> From: Shawn Pearce [mailto:spearce@spearce.org]
> Sent: Friday, January 13, 2017 4:07 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git <git@vger.kernel.org>; benpeart@microsoft.com
> Subject: Re: [RFC] Add support for downloading blobs on demand
>=20
> On Fri, Jan 13, 2017 at 7:52 AM, Ben Peart <peartben@gmail.com> wrote:
> >
> > Goal
> > ~~~~
> >
> > To be able to better handle repos with many files that any =
individual
> > developer doesn=E2=80=99t need it would be nice if clone/fetch only =
brought
> > down those files that were actually needed.
> >
> > To enable that, we are proposing adding a flag to clone/fetch that
> > will instruct the server to limit the objects it sends to commits =
and
> > trees and to not send any blobs.
> >
> > When git performs an operation that requires a blob that =
isn=E2=80=99t
> > currently available locally, it will download the missing blob and =
add
> > it to the local object store.
>=20
> Interesting. This is also an area I want to work on with my team at =
$DAY_JOB.
> Repositories are growing along multiple dimensions, and developers or
> editors don't always need all blobs for all time available locally to =
successfully
> perform their work.
>=20
> > Design
> > ~~~~~~
> >
> > Clone and fetch will pass a =E2=80=9C--lazy-clone=E2=80=9D flag =
(open to a better name
> > here) similar to =E2=80=9C--depth=E2=80=9D that instructs the server =
to only return
> > commits and trees and to ignore blobs.
>=20
> My group at $DAY_JOB hasn't talked about it yet, but I want to add a
> protocol capability that lets clone/fetch ask only for blobs smaller =
than a
> specified byte count. This could be set to a reasonable text file size =
(e.g. <=3D 5
> MiB) to predominately download only source files and text =
documentation,
> omitting larger binaries.
>=20
> If the limit was set to 0, its the same as your idea to ignore all =
blobs.
>=20

This is an interesting idea that may be an easier way to help mitigate=20
the cost of very large files.  While our primary issue today is the=20
sheer number of files, I'm sure at some point we'll run into issues with =

file size as well. =20

> > Later during git operations like checkout, when a blob cannot be =
found
> > after checking all the regular places (loose, pack, alternates, =
etc),
> > git will download the missing object and place it into the local
> > object store (currently as a loose object) then resume the =
operation.
>=20
> Right. I'd like to have this object retrieval be inside the native Git =
wire
> protocol, reusing the remote configuration and authentication setup. =
That
> requires expanding the server side of the protocol implementation =
slightly
> allowing any reachable object to be retrieved by SHA-1 alone. Bitmap =
indexes
> can significantly reduce the computational complexity for the server.
>=20

Agree. =20

> > To prevent git from accidentally downloading all missing blobs, some
> > git operations are updated to be aware of the potential for missing =
blobs.
> > The most obvious being check_connected which will return success as =
if
> > everything in the requested commits is available locally.
>=20
> This ... sounds risky for the developer, as the repository may be =
corrupt due
> to a missing object, and the user cannot determine it.
>=20
> Would it be reasonable for the server to return a list of SHA-1s it =
knows
> should exist, but has omitted due to the blob threshold (above), and =
the
> local repository store this in a binary searchable file?
> During connectivity checking its assumed OK if an object is not =
present in the
> object store, but is listed in this omitted objects file.
>=20

Corrupt repos due to missing blobs must be pretty rare as I've never=20
seen anyone report that error but for this and other reasons (see Peff's =

suggestion on how to minimize downloading unnecessary blobs) having this =

data could be valuable.  I'll add it to the list of things to look into.

> > To minimize the impact on the server, the existing dumb HTTP =
protocol
> > endpoint =E2=80=9Cobjects/<sha>=E2=80=9D can be used to retrieve the =
individual
> > missing blobs when needed.
>=20
> I'd prefer this to be in the native wire protocol, where the objects =
are in pack
> format (which unfortunately differs from loose format). I assume =
servers
> would combine many objects into pack files, potentially isolating =
large
> uncompressable binaries into their own packs, stored separately from
> commits/trees/small-text-blobs.
>=20
> I get the value of this being in HTTP, where HTTP caching inside =
proxies can
> be leveraged to reduce master server load. I wonder if the native wire
> protocol could be taught to use a variation of an HTTP GET that =
includes the
> object SHA-1 in the URL line, to retrieve a one-object pack file.
>=20

You make a good point. I don't think the benefit of hitting this=20
"existing" end point outweighs the many drawbacks.  Adding the ability=20
to retrieve an individual blob via the native wire protocol seems a=20
better plan.

> > Performance considerations
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > We found that downloading commits and trees on demand had a
> > significant negative performance impact.  In addition, many git
> > commands assume all commits and trees are available locally so they
> > quickly got pulled down anyway.  Even in very large repos the =
commits
> > and trees are relatively small so bringing them down with the =
initial
> > commit and subsequent fetch commands was reasonable.
> >
> > After cloning, the developer can use sparse-checkout to limit the =
set
> > of files to the subset they need (typically only 1-10% in these =
large
> > repos).  This allows the initial checkout to only download the set =
of
> > files actually needed to complete their task.  At any point, the
> > sparse-checkout file can be updated to include additional files =
which
> > will be fetched transparently on demand.
> >
> > Typical source files are relatively small so the overhead of
> > connecting and authenticating to the server for a single file at a
> > time is substantial.  As a result, having a long running process =
that
> > is started with the first request and can cache connection =
information
> > between requests is a significant performance win.
>=20
> Junio and I talked years ago (offline, sorry no mailing list archive) =
about
> "narrow checkout", which is the idea of the client being able to ask =
for a pack
> file from the server that only includes objects along specific path =
names. This
> would allow a client to amortize the setup costs, and even delta =
compress
> source files against each other (e.g.
> boilerplate across Makefiles or license headers).
>=20
> If the paths of interest can be determined as a batch before starting =
the
> connection, this may be easier than maintaining a cross platform =
connection
> cache in a separate process.
>=20

We looked into sparse/narrow-clone but for a variety of reasons it=20
didn't work well for our usage patterns (see my response to Peff's=20
feedback for more details).

> > Now some numbers
> > ~~~~~~~~~~~~~~~~
> >
> > One repo has 3+ million files at tip across 500K folders with 5-6K
> > active developers.  They have done a lot of work to remove large =
files
> > from the repo so it is down to < 100GB.
> >
> > Before changes: clone took hours to transfer the 87GB .pack + 119MB
> > .idx
> >
> > After changes: clone took 4 minutes to transfer 305MB .pack + 37MB
> > .idx
> >
> > After hydrating 35K files (the typical number any individual =
developer
> > needs to do their work), there was an additional 460 MB of loose =
files
> > downloaded.
> >
> > Total savings: 86.24 GB * 6000 developers =3D 517 Terabytes saved!
> >
> > We have another repo (3.1 M files, 618 GB at tip with no history =
with
> > 3K+ active developers) where the savings are even greater.
>=20
> This is quite impressive, and shows this strategy has a lot of =
promise.
>=20
>=20
> > Future Work
> > ~~~~~~~~~~~
> >
> > The current prototype calls a new hook proc in
> > sha1_object_info_extended and read_object, to download each missing
> > blob.  A better solution would be to implement this via a long =
running
> > process that is spawned on the first download and listens for =
requests
> > to download additional objects until it terminates when the parent =
git
> > operation exits (similar to the recent long running smudge and clean =
filter
> work).
>=20
> Or batching these up in advance. checkout should be able to determine
> which path entries from the index it wants to write to the working =
tree. Once
> it has that set of paths it wants to write, it should be fast to =
construct a
> subset of paths for which the blobs are not present locally, and then =
pass the
> entire group off for download.
>=20

Yes, I'm optimistic that we can optimize for the checkout case (which is =

a _very_ common case!).

> > Need to do more investigation into possible code paths that can
> > trigger unnecessary blobs to be downloaded.  For example, we have
> > determined that the rename detection logic in status can also =
trigger
> > unnecessary blobs to be downloaded making status slow.
>=20
> There isn't much of a workaround here. Only options I can see are =
disabling
> rename detection when objects are above a certain size, or removing =
entries
> from the rename table when the blob isn't already local, which may =
yield
> different results than if the blob(s) were local.
>=20
> Another is to try to have actual source files always be local, and =
thus we only
> punt on rename detection for bigger files that are more likely to be =
binary,
> and thus less likely to match for rename[1] unless it was SHA-1 =
identity
> match, which can be done without the
> blob(s) present.
>=20

While large files can be a real problem, our biggest issue today is=20
having a lot (millions!) of source files when any individual developer=20
only needs a small percentage of them.  Git with 3+ million local files=20
just doesn't perform well.

We'll see what we can come up with here - especially if we had some=20
information _about_ the blob, even though we didn't have the blob =
itself.

>=20
> [1] I assume most really big files are some sort of media asset (e.g.
> JPEG), where a change inside the source data may result in large =
difference in
> bytes due to the compression applied by the media file format.
>=20
> > Need to investigate an alternate batching scheme where we can make a
> > single request for a set of "related" blobs and receive single a
> > packfile (especially during checkout).
>=20
> Heh, what I just said above. Glad to see you already thought of it.
>=20
> > Need to investigate adding a new endpoint in the smart protocol that
> > can download both individual blobs as well as a batch of blobs.
>=20
> Agreed, I said as much above. Again, glad to see you have similar =
ideas. :)

