From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 2 Apr 2012 19:31:46 +0700
Message-ID: <20120402123146.GA24813@do>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch>
 <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
 <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
 <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
 <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 14:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEgT4-0004uV-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 14:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab2DBMeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 08:34:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36913 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2DBMeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 08:34:36 -0400
Received: by pbcun15 with SMTP id un15so4484314pbc.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t3YGGjoc1ke8+h9q2EdXl45siGp4MUs2Lle/cLnPSJc=;
        b=DH5BczMhgod2JgX7LjdUVlyDB+0blHX0bDa696iLzffsgX+f7WZUqZVblhqqpUwTrv
         feDjqlamuZ7LNOZjpebLXrk2/u49gYNQtXESk1HQOe0IbO7uAFiro7l31dThSN5EV7Yy
         FruJyvjMN49WI6oV3IH0V8kE8qTqO8N0ALhX+c1HR3Kjb2GxdzlQWUDot9SH5J4A6/54
         Lq0nHhFh0gNpA/oigZOkPpRWKRvLCFi77X3jg9UcQgnljqgWKINZhaHFLVsEe1Vy1ooY
         CTwMRDEmpN69rL5ZrffDlW05BGbcEUiSI9hmIEKHD56cXIStD0jhyg2zCJRPGbVMwq1H
         dfmQ==
Received: by 10.68.190.226 with SMTP id gt2mr20991750pbc.124.1333370076006;
        Mon, 02 Apr 2012 05:34:36 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.243])
        by mx.google.com with ESMTPS id f5sm14054256pbe.26.2012.04.02.05.34.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 05:34:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 02 Apr 2012 19:31:46 +0700
Content-Disposition: inline
In-Reply-To: <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194512>

On Mon, Apr 02, 2012 at 09:50:53PM +1000, elton sky wrote:
> Hi Nguyen,
>=20
> Still have some questions on your idea:
>=20
> On Tuesday, March 27, 2012, Nguyen Thai Ngoc Duy wrote:
> > >> A block starts with a signature (a tree block, or an extension..=
=2E). A
> > >> tree block consists of:
> > >>
> > >> =A0- uint32_t tree object's size
> > >> =A0- sha-1 of tree object
> > >> =A0- crc32 of the rest of the block except tree object
> > >> =A0- maybe reference counter of a block can be refered by many b=
locks??
> > >> =A0- tree object (i.e. something that tree-walk.c can parse)
> > >
> > > Do you mean each block contains a tree and all its blobs? So the =
tree
> > > object here, effectively a dir, also contains files in the dir ? =
In
> > > this way, some blocks can be very big.
> >
> > No, the tree object contains pathname, mode and SHA-1 of its entrie=
s,
> > one level only (try "git ls-tree HEAD"). If an entry is a directory
> > and we have not built it yet, we won't have its sha-1, so it will b=
e
> > zero (similar to invalid cache-tree).
> >
>=20
> Correct me if I am wrong, I assume:
> * Although you only listed attributes in tree block, in index, we hav=
e
> both tree and blob block.

In current index, tree is implied in path names. We only store blob sha=
-1.

> * Sha1 of a tree block is computed by hashing all the Sha1s of blobs
> and sub trees in the directory.
> * Like cache tree struct, each tree object contains list of offsets t=
o
> children blocks.
>=20
> How do you store blob blocks ? Is each blob object a block? just like
> a tree object is a block? If so, each blob contains a sha1, the
> overhead is high?
>=20
> If we compute hash for a tree, and this tree happen to have 500
> children do I have to access all 500 blocks to get their Sha1s?

We don't store blobs in index. We only need their sha-1, which is
computed and content stored in object database at "git add".

By the way, I revised my new index format a little bit, see the end of
this email. It may work, or may not. Food for thoughts.

> Also I ran some quick test on git-add over kernel 2.6. When I do "tim=
e
> git add .":time git add .
>=20
> cmd_add: validate_pathspec takes : 0 ms
> read_index_from: xmmap&close takes : 0 ms
> read_index_from: verify_hdr takes : 26 ms
> read_index_from: create inmem struct takes : 4 ms
> read_index: read_index_from takes : 31 ms
> read_directory: qsort takes : 0 ms
> fill_directory: read_directory takes : 97 ms
> cmd_add: prune dir takes : 0 ms
> cmd_add: add_files_to_cache takes : 37 ms
> cmd_add: add_files takes : 0 ms
>=20
> real 0m0.172s
> user 0m0.120s
> sys 0m0.050s
>=20
> And when I ran "time git add arch/ia64" :
>=20
> cmd_add: validate_pathspec takes : 0 ms
> read_index_from: xmmap&close takes : 0 ms
> read_index_from: verify_hdr takes : 20 ms
> read_index_from: create inmem struct takes : 4 ms
> read_index: read_index_from takes : 25 ms
> read_directory: read_directory_recursive takes : 10 ms
> read_directory: qsort takes : 0 ms
> fill_directory: read_directory takes : 10 ms
> cmd_add: fill_directory takes : 10 ms
> cmd_add: prune dir takes : 0 ms
> cmd_add: add_files_to_cache takes : 1 ms
>=20
> real 0m0.043s
> user 0m0.040s
> sys 0m0.000s
>=20
> In both cases, the time for sha1 is quite stable (~20ms).
> fill_directory drops as I specify a sub directory, which make sense.
> As Junio suggested, the sha1 time (verify_hdr) is a mix a read and
> sha1. And this part is our focus to optimize, isn't it?

I think so. But until we can read just parts of index, we still have
to verify integrity for the whole index, which takes more or less the
same amount of time you see and should be proportional to index size
(or the number of entries in index). Either we shrink the index, or go
with cheaper checksum, or both.

> But, as growth
> of the whole repo, the processing time is getting dominated by
> fill_directory (if we use '.', it takes 97ms) rather than=A0verify_hd=
r.

{read,fill}_directory is not always used (for example, "git diff" does
not need it). Meanwhile, as working directory grows, index size grows,
verify_hdr() will take longer.

> In current system, The time complexity for fill_directory is nlogn (n
> is number of objects). git recursively go thru sub directories and
> files in it and check against current index. When searching index, it
> uses binary search which makes it lg(n). If this is the case, will us=
e
> a producer/consumer model help?

I think fill_directory is dominated by kernel time (read_dir,
stat...), there's little thing we can do there. Anyway I'm pretty sure
fill_directory is out of scope. It's just one of the code that uses
index.

-- 8< --
GIT index format
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This format replaces the old "DIRC" format. Compared to the old
format, which is essentially a sorted list of pathnames, this one:

 - is tree-based
 - use crc32 as checksum
 - only verify integrity on parts that git accesses, instead of whole
   file
 - append changes to the end
 - allow index versioning

Updates can be made directly to the index by appending to the end. The
index traversed by locating the root tree block from the trailer. When
a path is updated, all related tree blocks are updated and appended to
the end, then a new trailer (with generation increased by one) is
written to conclude the index.

The index size will increase continuously. At some point, we will need
to repack it. Let assume a tree block is 64k on average and a path
generally consists of 3 path components.  That means an entry update
adds 192k and we can do about 80 updates before index reaches 16M (in
addition to initial index size).

At 16M or when trailer generation hits a limit (the limit can be
configurable), we rewrite the index to reduce its size. Some heavy
operations can also be used to rewrite index, such as checkout or
reset.

The index integrity is verified by crc32. One crc32 covers header and
trailer. Each block has its own crc32. When the index is found
corrupt, we could try to roll back to latest good version by looking
for trailers from bottom up. Even when the index is not corrupt, users
can still look back this way for older index versions.

=3D The git index file has the following format

   - A 8-byte header consisting of

     4-byte signature:
       The signature is { 'T', 'R', 'E', 'E' }

     4-byte version number:
       The current supported versions are 1.

   - A number of blocks of variable size

      1-byte block type

      3-byte content size in byte

      block content

      4-byte crc32 of all above

   - A 18-byte trailer consisting of

      4-byte trailer signature:
        The signature is { 'R', 'O', 'O', 'T' }

      2-byte generation:
         The first trailer is 0, the second 1 and so on.

      4-byte root block offset

      4-byte extension table offset:
        Zero means no extension

      4-byte checksum:
        CRC32 of the header and the trailer (excluding this field)

=3D=3D Tree block

  A tree block contains a (maybe invalid) tree object and extra
  information of its companion in working directory. Tree block has
  block type 'T'.

  Tree block content is basically the list of non-recursive entries in
  specified path, with all attributes we store in the index now. There
  are a few changes though to intergrate cache-tree and allow
  bsearch() on mmap'd block.

  A tree block content consists of

  - 4-byte tree object size

  - 20-byte SHA-1 of the cached tree object

  - a list attributes corresponding to tree object's item, in the same
    order.  These attributes are the same as in DIRC entry format
    except that entry name is removed, and a tree block offset is
    added in case the item is a directory.

    32-bit ctime seconds, the last time a file's metadata changed
      this is stat(2) data
 =20
    32-bit ctime nanosecond fractions
      this is stat(2) data
 =20
    32-bit mtime seconds, the last time a file's data changed
      this is stat(2) data
 =20
    32-bit mtime nanosecond fractions
      this is stat(2) data
 =20
    32-bit dev
      this is stat(2) data
 =20
    32-bit ino
      this is stat(2) data
 =20
    32-bit mode, split into (high to low bits)
 =20
      4-bit object type
        valid values in binary are 1000 (regular file), 1010 (symbolic =
link)
        and 1110 (gitlink)
 =20
      3-bit unused
 =20
      9-bit unix permission. Only 0755 and 0644 are valid for regular f=
iles.
      Symbolic links and gitlinks have value 0 in this field.
 =20
    32-bit uid
      this is stat(2) data
 =20
    32-bit gid
      this is stat(2) data
 =20
    32-bit file size
      This is the on-disk size from stat(2), truncated to 32-bit.
 =20
    160-bit SHA-1 for the represented object if blobs or the offset
      to another tree block if trees

    A 32-bit 'flags' field split into (high to low bits)
 =20
      1-bit assume-valid flag
 =20
      1-bit extended flag (must be zero in version 2)
 =20
      2-bit stage (during merge)
 =20
      12-bit name length if the length is less than 0xFFF; otherwise 0x=
=46FF
      is stored in this field.
 =20
      1-bit skip-worktree flag (used by sparse checkout)
 =20
      1-bit intent-to-add flag (used by "git add -N")

      14-bit unused, must be zero

    A 16-bit offset, relative to the beginning of this block, to the
      pathname of this entry. FIXME: make it 32-bit, relative to the
      beginning of the file, so that we can reuse pathnames from other
      (old) blocks?

  - a list of NUL-terminated pathnames, pointed to from the 16-bit offs=
et
    above. This list does not have to be of the same order as the attri=
bute
    list. The reason this is separated from the attribute list is to ma=
ke
    attribute list fixed size, searchable using bsearch().

=3D=3D Extension table block

 Extension table has block type 'X'. It consists of a series of 4-byte
 extension block offset.

=3D=3D Extension block

 Extension block has block type 'E'. Extension content is the same as
 in the old format.
-- 8< --
--
Duy
