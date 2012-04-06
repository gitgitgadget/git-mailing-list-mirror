From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 6 Apr 2012 22:11:49 +0700
Message-ID: <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 17:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGApv-00018b-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 17:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab2DFPMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 11:12:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58215 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab2DFPMV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 11:12:21 -0400
Received: by wejx9 with SMTP id x9so1509162wej.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oYnlvy6t5WDc3qrmb1tBE0H+/fZQpWoh57QzGYx8BOg=;
        b=e35EuFvJOMeG70UcEmtyEMsj95wQxoqj/5zWdIhPiAcWsqbPbye3xZq0BSuUKwT3S/
         qAFKYUTSRQlGg5JztQ+5L2RXX9woD2BkcP62gWUff5FidJbjOlqCBialBZJd/fzRDIXk
         CaAeg0T+qkuxOUepYG1Imy7y5tNL9MLUtSX2qtSvVCDilqf76UrL/uXhZHMal9mtH/4L
         oc7841GZjfRB4gMmjKlDehsJrdFGZ78f6ytmCjRLaNNEy0EjfkmXA/9uIjoThg9TSaL+
         pzh1tQS5wgpIjCrMIPl6HyEl8jVOjwDOsbHFb3b3JhskDa6vogXrepbPUL98NeCXTole
         T/+w==
Received: by 10.180.97.41 with SMTP id dx9mr19939615wib.9.1333725139996; Fri,
 06 Apr 2012 08:12:19 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 6 Apr 2012 08:11:49 -0700 (PDT)
In-Reply-To: <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194873>

On Fri, Apr 6, 2012 at 10:22 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Thu, Apr 5, 2012 at 14:49, Thomas Rast <trast@inf.ethz.ch> wrote:
>> This is quite complete already, which I think is great, but it's sti=
ll
>> missing one "obvious" approach: a directory-tree based layout that u=
ses
>> "flat" storage. =C2=A0That is, the entries grouped by directory and =
thus
>> arranged into the "natural" tree, so as to allow parsing only part o=
f
>> it. =C2=A0But not pulling any tricks to make it easy to change; a no=
ntrivial
>> change would mean a rewrite. =C2=A0How good do you think that could =
be?
>
> I have been wondering this myself. Aren't most updates to the index
> just updating the stat information of an existing entry?
>
> If so we could structure the index as flat lists for each directory
> similar to a canonical tree, but with a wider field to hold not just
> the SHA-1 but also the stat information of each file. If the entry is
> just the component name ("foo.c" and not "src/foo.c") and the SHA-1
> and stat data, you can probably protect the entire entry with a CRC-3=
2
> for each entry. Updates can be performed in place by taking the write
> lock with index.lock as an empty file, then overwriting the SHA-1 and
> stat field followed, by updating the CRC-32. Readers that see the
> wrong CRC-32 for an entry can sleep for a short period, retry the
> read, and fail after some number of attempts if they cannot get a
> valid read of that entry.

But does that mean the reader can have some old entries (because the
writer has not updated them yet by the time of reading) mixed with new
ones, i.e. inconsistent data?


> Adding a new file or deleting an existing file from the index would
> require a full rewrite.
>
> Within a single tree/directory entry, it probably doesn't have to be
> binary searchable. Canonical trees aren't. Linear scans through a
> directory is OK, so long as the scans are broken up by the directory
> tree structure just like they are in canonical trees.
>
> Dealing with the conflict stages during merges (1, 2, 3) could be
> handled by appending the conflict data at the end of the index file,
> when conflicts are resolved this tail region could be truncated back
> to the real end of the file. A bit could be set on the normal entry i=
n
> the trees to denote there is a conflict, and additional stage data is
> expected in the tail region of the file.



--=20
Duy
