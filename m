From: Thomas Gummerer <italyhockeyfeed@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 4 Apr 2012 22:05:49 +0200
Message-ID: <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu> <C15BAB9A-EAFA-4EA4-
 85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Apr 04 22:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWTT-0006Rs-MV
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab2DDUGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:06:04 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65117 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2DDUGC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 16:06:02 -0400
Received: by wejx9 with SMTP id x9so414603wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=ZwSTqA/r/NziWUE1zYXbHbwvjFv68CQrvSjRFM/gtkI=;
        b=epXVcyTUk20/AetkcagcHvB+ab6BkAHdgpp3Awu19MxZRTqfVG+HP/3+Y2whf+eDFE
         +iKofIQSs5a0oPMso/9zRdfD1Fa3Qs3eI3JYiS6wUcIdZ30CxedWqQeCaZ43eyvIE4Y/
         qfNsJJ2HRjiibW+tbY3SsKCxdJwo4eIpQCWJoYQfm2YvWgvgIHaXKW1Z3XX6PCCx8hE5
         r/AJyk460hpil7+OaUXkuvQisJJ7SZNcJx8WmSRMllCJ4XLRkiunaE1qI6+lIg/md+Yj
         wuyNsGXW8xW4wN0oBsagrDgBevOEEyzhdrOQnyVBi3nRDwSMiwnDkTUFHfeUGoHo4snh
         mgVA==
Received: by 10.216.139.204 with SMTP id c54mr2191589wej.103.1333569960843;
        Wed, 04 Apr 2012 13:06:00 -0700 (PDT)
Received: from surfer-30-3-17.surfnet.iacbox ([95.171.54.129])
        by mx.google.com with ESMTPS id 6sm7430710wiz.1.2012.04.04.13.05.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 13:06:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194733>

This is another small revision of my proposal draft, taking into consideration
Michael Haggerty and David Langs comments. 

First I would again like to mention the people which helped me discussing the
ideas and gave me valuable input. 

-- Credits --
Big thanks for discussing the ideas with me on IRC goes to charon, jast,
mhagger, shruggar, GitZilla, andrew_sayers and barrbrain. Hope I didn't forget 
anyone. Thanks also to those who discussed my ideas with me on the mailing list
(Nguyen Thai Ngoc Duy, Thomas Rast, Junio C Hamano, Michael Haggerty, 
David Lang)

Designing a faster index format

-- Problem --
The current git index is pretty slow when working with large git repositories,
because the whole index has to be rewritten for nearly every operation. For
example for adding a single file with git add, even though logically only one 
single blob sha-1 is changed in the index, git has to recompute the hash over 
the whole index and rewrite the index file. In addition to that the speed up 
for writing the index can not come to the expense of the read operation, since 
it is executed more often throughout a normal developers day compared to
writing the index. The current index also doesn't allow simple partial reading,
which could help speed up some commands, like git status and git diff, which 
often don't need the whole index.

-- Proposed solution --
The proposed solution is to redesign the index to a B-tree based format. This
allows changes to the index in O(log(n)) time, with n being the number of
entries in the index. 

The sha1 hash, to verify the index isn't corrupted, will have to be computed 
over log(s) data in the worst case, where s is the size of the index, which 
will be bigger then the number of entries because of the structure of the 
b-tree.

The new index format will also save on the size of each entry, by storing each
path only once, and using it for all files in the same path. This will reduce
the amount of data we have to calculate the hash over, when both reading and
writing the index, thus having faster operations especially on repositories
with deep directory structures.

The tree structure will also allow for fast partial loading of the index. Since
every bucket of the tree will have it's own hash, the hash will only need to be
calculated for the parts we load. This reduces the amount of data for which the
hash will need to be calculated. Commands like git status and git diff will
benefit from this. The benefit could be fully explored by a implementation with 
inotify, of which Thomas Rast created a POC. 
(https://github.com/trast/git/commit/6c9825fdca76d01fb5a83923558831743ae477bc)

In order to be able to only rewrite the parts of the index that really changed,
the current lock file structure will have to be changed. The new lock file
will keep a journal of the changes, to be able to recover in case of a crash.
Deleting the lockfile "commits" the changes. To ensure that the readers never
read a partially mutated file, reading the index will respect the write lock.
Readers will also have a "read lock", which is respected by operations that
write on the index, but can be ignored by operations that read the index, such
that simultaneous reads are still possible.

The in-memory structure will be modified in two steps. In the first step it
will only be modified to keep track of the changes, in order to be able to only
write the changes to disk and eliminate the need to rewrite the whole tree. In 
the second step the in-memory structure will be changed to reflect the tree 
format, getting the full benefits from the new format.

To ensure backward compatibility, git shall keep the ability to read version 
2/3 of the index. The user shall also have the possibility to configure git to 
write the index in either the new or the old format. While this will produce 
some code overhead, it will make the life of git users which don't use core git 
exclusively easier in the transition phase. If the user sets the write format to
the new format and the repository is a already existing version 2/3 repository, 
the old index will be transformed to the new format. Transformations in the 
other direction will also be possible, since the in-memory format is the same.

Once the in-memory structure is changed, making git backward compatible will
still be possible, even though it will come at the expense of the 
reading/writing time of the old index, since the tree will have to be 
constructed in memory from the on disk format, and transformed back to the flat
format when writing it back to disk.

To make the project feasible for Google Summer of Code the in-meory structure
will only be modified to keep track of the changes, not making it 
tree-structured yet and the partial loading will not be implemented.


-- Solutions that were also considered --
These solutions will not be described in as much detail as the tree-structure,
but they were also considered in the process of chosing the best index format
and will be described below.

- Append-only data structure
An append-only data structure will allow for changes to the index in O(k) time, 
with k being the number of files that changed. To reach this goal, the first 
part of the index will be sorted and changes will always be written to the end, 
in the order in which the changes occured. This last part of the index will be 
merged with the rest using a heuristic, which will be the execution of git 
commit and git status.

To make sure the index isn't corrupted, without calculating the sha1 hash for
the whole index file every time something is changed, the hash is always
calculated for the whole index when merging, but when only a single entry is 
changed the sha-1 hash is only calculated for the last change. This will 
increase the cost for reading the index to log(n) + k * log(n) where n is the 
number of entries in the sorted part of the index and k is the number of entries
in the unsorted part of the index, which will have to be merged with the rest 
of the index.

The index format shall also save on file size, by storing the paths only once,
which currently are stored for every file. This can make a big difference
especially for repositories with deep directory structures. (e.g. in the webkit
repository this change can save about 10MB on the index). In addition to that it
can also give the index a structure, which in turn makes it easier to search
through. Except for the appended part, but that should never grow big enough to
make a linear search through it costly.

With this index format the lock file could be a simple empty file, since if a
operation fails, only the last entry would be corrupted making it easy to
recover.

The current in-memory structure of git would only have to be slightly changed,
adding a flag or keeping a list of the changed files. The rest of it could be
changed in an other step, to better represent the new structure of the index.

To ensure backward compatibility, git shall keep the ability able to read 
version 2/3 of the index. The user shall also have the possibility to configure
git to write the index in either the new or the old format. While this will
produce some code overhead, it will make the life of git users which don't use 
core git exclusively easier in the transition phase. If the user sets the write 
format to the new format and the repository is a already existing version 2/3 
repository, the old index will be transformed to the new format. 

This idea was dropped, because as mentioned in the problem description reads
are more common then writes and therefore trading write speed for read speed
is not a good tradeoff. The slowdown depends mostly on the size of the appended
(unsorted) part, which in most cases will be much less then the size of the
sorted part, but in other cases might grow quite big. I think it is preferrable
to have a structure that is usually faster on the read operation and where the
read speed will not depend on the way the user works. This is worth the slight
trade-off in write speed. In addition to that the tree-structure will also allow
faster partial loading, which makes it more future-proof.

- Database format
A database format as index structure will allow for changes to the index in
O(log(n)) time for a single change, with n always being the number of entries
in the index, assuming a b-tree index on the path in the database.

The check for the index corruption could be left to the database, which would
have about the same cost as the check in the tree-structure, in the read and
write direction. Partial loading with the right indices would also have the 
same cost as the tree-structure, by executing a simple select query.

The drawback of this solution however would be the introduction of a database
library (one could also write one, but that certainly would be overkill).
Another drawback would be that it's harder to read for programs like libgit2
and jgit and the codebase certainly wouldn't get any cleaner.

- Padded structure
Another index format that was taken into consideration was to create a padded
structure. Basically that would be an append-only like structure, but split into
sections, where every section would leave some space at the end for appending
changes. This would leave us with a complexity of O(k) where k is the number of
sections. 

This structure will bring advantages for faster partial loading, when splitting
the sections in the right way. 

The structure was however only briefly taken into consideration, since it would
have close to no advantages (except for the partial loading) compared to the
append-only structure, would make the index file larger due to the spaces for
appending and have the same drawbacks as the append-only structure.

-- Timeline --
24/04 - 01/05: Document the new index format.
02/05 - 21/05: Map the current internal structure to the new index format.
22/05 - 07/06: Change the current in-memory structure to keep track of the
changed files.
08/06 - 16/06: Write the index to disk in both the old and the new format
depending on the choice of the user and make sure only the changed parts are 
really written to disk in the new format.
17/06 - 21/07: Parse the index from disk to the current in-memory format.
/* Development work will be a bit slower from 18/06 to 21/07 because at my
 * University there are exams in this period. I probably will only be able to
 * work half the hours. I'll be back up to full speed after that. */
22/07 - 10/08: Read the new structure and map it to the current in meory format.
Make sure the old format still gets read correctly.
11/08 - 13/08: Test the new index and profile the gains compared to the old
format.

-- Why git --
I'm using git since about 2-3 years and wanted to contribute to it earlier, but
couldn't find the time to do it. I would also like to continue contributing
once the Summer of Code is over.

-- About me --
I'm Thomas Gummerer (@tgummerer on Twitter, tgummerer on IRC), 21 years old
from Italy. I'm currently a 3rd year Bachelor student in Applied Computer 
Science at the Free University of Bolzano. I started programming in High School 
about 8 years ago with Pascal and then learned C and Java. For some of my
projects you can visit my homepage (http://tgummerer.com/projects), most of them
were for university and some personal projects I did in my free time. My blog is
also on the same homepage, but not really active. Unfortunately I couldn't yet 
participate in any bigger open source project, although I'm interested in
it basically since I started programming. 
