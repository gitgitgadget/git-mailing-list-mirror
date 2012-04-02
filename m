From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 2 Apr 2012 22:12:20 +0700
Message-ID: <CACsJy8B6EODKzfLxQJWvDCrspF8zxvYw4Kx8ZPbedO-CQZawGw@mail.gmail.com>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
 <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
 <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
 <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
 <20120402123146.GA24813@do> <CAJo=hJuVZiik6J0nhO4jpzWYenerRQoREHLMmJoFY8W0bZR+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEiwD-0004FX-D6
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab2DBPMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 11:12:53 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43732 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2DBPMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 11:12:52 -0400
Received: by wgbds11 with SMTP id ds11so2540147wgb.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IQVRxdeJAJcf97eF62nUU04jt1Vo0NCicD0u6vAz0XA=;
        b=Eh/aAxc4WGcxKwd7U/8SL0bC8yl+8HIPNNAntaiPFxYQKZmj68Y8zR2N0/0WXsBkwI
         mhBDdUj1KT5cYYsXZ4qtASs1wRDpc2c97JZ58ls/z3AJq3VrVTteg984JOt14U3dH365
         kok7Wa8ZMvnFA9jV0pUfmqlfs1oMC8RVgittYH/Yn5xAubTK6uCk9iAjGSKmySmsFDxM
         YkUu7uHd5UpX9nXcbuzw0z3hS1E3eAZKw7A0xFkJlkWW6pNbCL8dr1lt+yPAHxU1JCwE
         ctMW+RtCYWgRox+b31hyknNXEa4opz+aUtwr00K+GzNKmSYEPDBRkIavZz2aIefpEl6p
         Jdfw==
Received: by 10.180.8.231 with SMTP id u7mr25861432wia.9.1333379570830; Mon,
 02 Apr 2012 08:12:50 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 2 Apr 2012 08:12:20 -0700 (PDT)
In-Reply-To: <CAJo=hJuVZiik6J0nhO4jpzWYenerRQoREHLMmJoFY8W0bZR+5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194516>

On Mon, Apr 2, 2012 at 9:27 PM, Shawn Pearce <spearce@spearce.org> wrot=
e:
> On Mon, Apr 2, 2012 at 08:31, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
>> The index size will increase continuously. At some point, we will ne=
ed
>> to repack it. Let assume a tree block is 64k on average and a path
>> generally consists of 3 path components. =C2=A0That means an entry u=
pdate
>> adds 192k and we can do about 80 updates before index reaches 16M (i=
n
>> addition to initial index size).
>
> Only 3 path components? Java sources can easily have 8-10 with a long
> Maven and Java package implied prefix. This will increase the
> frequency of rewrites of the index file.

Yes, but in java case, users could adjust the rewrite limits to make
it less often. The index will be bigger, but because we mmap it and
only access parts of it, index size does not matter much.

>> At 16M or when trailer generation hits a limit (the limit can be
>> configurable), we rewrite the index to reduce its size. Some heavy
>> operations can also be used to rewrite index, such as checkout or
>> reset.
>>
>> The index integrity is verified by crc32. One crc32 covers header an=
d
>> trailer. Each block has its own crc32. When the index is found
>> corrupt, we could try to roll back to latest good version by looking
>> for trailers from bottom up. Even when the index is not corrupt, use=
rs
>> can still look back this way for older index versions.
>
> How do you deal with a partially written append to the index file?
> E.g. if a prior update crashes or the filesystem doesn't write
> everything out before power failure, you need to find the last good
> trailer block in the file.

By looking for the trailer signature "ROOT" from bottom up, then
verify if it's still good (i.e. verifying all trees) from there.
Repeat until we find a good one.

>> =3D The git index file has the following format
>>
>> =C2=A0 - A 8-byte header consisting of
>>
>> =C2=A0 =C2=A0 4-byte signature:
>> =C2=A0 =C2=A0 =C2=A0 The signature is { 'T', 'R', 'E', 'E' }
>>
>> =C2=A0 =C2=A0 4-byte version number:
>> =C2=A0 =C2=A0 =C2=A0 The current supported versions are 1.
>
> Why not DIRC version 4?

I thought of that, but because I don't keep header format the same as
v3, I thought signature should change too. But this is really not
important at this stage.

>> =C2=A0 - A number of blocks of variable size
>>
>> =C2=A0 =C2=A0 =C2=A01-byte block type
>>
>> =C2=A0 =C2=A0 =C2=A03-byte content size in byte
>>
>> =C2=A0 =C2=A0 =C2=A0block content
>
> So you are limiting the size of a canonical tree now? Currently there
> is no limit on the size a tree. But here the entire index structure
> plus set of names must be under 16 MiB. Granted no project probably
> hits that limit, but you are painting us into a corner with an upper
> limit here that doesn't look like it will be easy to increase.

We can introduce a new block type, not a nice approach though. Not
saving block size is probably ok too. We would need something to mark
end-of-block. I wanted to save block size to do crc32 quickly without
parsing the block, but instead, we could make block parsing faster and
not worry about it.

>> =3D=3D Tree block
>>
>> =C2=A0A tree block contains a (maybe invalid) tree object and extra
>> =C2=A0information of its companion in working directory. Tree block =
has
>> =C2=A0block type 'T'.
>>
>> =C2=A0Tree block content is basically the list of non-recursive entr=
ies in
>> =C2=A0specified path, with all attributes we store in the index now.=
 There
>> =C2=A0are a few changes though to intergrate cache-tree and allow
>> =C2=A0bsearch() on mmap'd block.
>>
>> =C2=A0A tree block content consists of
>>
>> =C2=A0- 4-byte tree object size
>>
>> =C2=A0- 20-byte SHA-1 of the cached tree object
>>
>> =C2=A0- a list attributes corresponding to tree object's item, in th=
e same
>> =C2=A0 =C2=A0order. =C2=A0These attributes are the same as in DIRC e=
ntry format
>> =C2=A0 =C2=A0except that entry name is removed, and a tree block off=
set is
>> =C2=A0 =C2=A0added in case the item is a directory.
>>
>> ...
>>
>> =C2=A0 =C2=A0A 16-bit offset, relative to the beginning of this bloc=
k, to the
>> =C2=A0 =C2=A0 =C2=A0pathname of this entry. FIXME: make it 32-bit, r=
elative to the
>> =C2=A0 =C2=A0 =C2=A0beginning of the file, so that we can reuse path=
names from other
>> =C2=A0 =C2=A0 =C2=A0(old) blocks?
>
> 16 bit offset doesn't work well in a block that can be as large as 2^=
24.

No it doesn't. That's the implication of using 16-bit offsets.

> If you reuse a path name list at the start of the file, how do you
> handle new names?

We don't drop this part even if we reuse a few path names elsewhere.
New path names can be put here. But I'm not really sure if reusing
names gains us anything because at least it breaks locality and
complicates handling code. We already save quite a bit by not
duplicating parent prefix.
--=20
Duy
