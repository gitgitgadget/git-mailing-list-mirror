From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Documentation: update to git-merge-base --octopus
Date: Tue, 12 Apr 2011 17:46:32 +0200
Message-ID: <4DA473D8.5010001@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9fnr-0003sF-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621Ab1DLPqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 11:46:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45056 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797Ab1DLPql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 11:46:41 -0400
Received: by eyx24 with SMTP id 24so2065956eyx.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 08:46:40 -0700 (PDT)
Received: by 10.213.109.74 with SMTP id i10mr1569262ebp.5.1302623200022;
        Tue, 12 Apr 2011 08:46:40 -0700 (PDT)
Received: from [145.94.80.223] (x080223.tnw-m.tudelft.nl [145.94.80.223])
        by mx.google.com with ESMTPS id m55sm2452706eei.8.2011.04.12.08.46.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 08:46:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171398>

1) Make
it
clear
that
when
the
--octopus
parameter
is
given
to 'git
merge-base',
only a
set of
commits
is
expected as
the
parameter.
On the
other
hand,
in the
case
without
the
--octopus
parameter,
it is
necessary
to
supply
a
single
commit
and a
set.
Moreover,
in the
case of
--octopus
merging, a
single
commit
is also
valid,
which
is not
the
case
otherwise.

2) Add
a
sentence to
the
discussion
that
when
--octopus
is
used,
we do
expect
'2'
as the
result.

Signed-off-by:
Vincent
van
Ravesteijn
<vfr@lyx.org>
---
 Documentation/git-merge-base.txt |    6 +++++-
 builtin/merge-base.c             |    3 ++-
 2
files
changed, 7
insertions(+),
2
deletions(-)

diff
--git
a/Documentation/git-merge-base.txt
b/Documentation/git-merge-base.txt
index
eedef1b..1bac04f
100644
---
a/Documentation/git-merge-base.txt
+++
b/Documentation/git-merge-base.txt
@@ -9,7
+9,8 @@
git-merge-base
- Find
as good
common
ancestors
as
possible for
a merge
 SYNOPSIS
 --------
 [verse]
-'git
merge-base'
[-a|--all]
[--octopus]
<commit> <commit>...
+'git
merge-base'
[-a|--all]
<commit> <commit>...
+'git
merge-base'
[-a|--all]
--octopus
<commit>...
 'git
merge-base'
--independent
<commit>...

 DESCRIPTION
@@
-89,6
+90,9
@@ and
the
result
of `git
merge-base
A M` is
'1'.
Commit
'2' is
also a
 common
ancestor between
'A' and
'M',
but '1'
is a
better
common
ancestor,
 because '2' is an ancestor of '1'.  Hence, '2' is not a merge base.

+When
the
option
`--octopus`
is
given,
the
result
of `git
merge-base
A B C`
+is
expected to
be '2',
since
'2' is
the
common
ancestor of
all
branches.
+
 When
the
history
involves criss-cross
merges,
there
can be
more
than
one
 'best'
common
ancestor for
two
commits.
For
example, with
this
topology:

diff
--git
a/builtin/merge-base.c
b/builtin/merge-base.c
index
96dd160..4f30f1b
100644
---
a/builtin/merge-base.c
+++
b/builtin/merge-base.c
@@
-23,7
+23,8
@@
static
int
show_merge_base(struct
commit
**rev,
int
rev_nr,
int
show_all)
 }

 static
const
char *
const
merge_base_usage[]
= {
-	"git
merge-base
[-a|--all]
[--octopus]
<commit> <commit>...",
+	"git
merge-base
[-a|--all]
<commit> <commit>...",
+	"git
merge-base
[-a|--all]
--octopus
<commit>...",
 	"git
merge-base
--independent
<commit>...",
 	NULL
 };
-- 
1.7.3.1.msysgit.0
