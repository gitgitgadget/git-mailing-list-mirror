From: Junio C Hamano <gitster@pobox.com>
Subject: Re: STGIT: Deathpatch in linus tree
Date: Tue, 07 Feb 2012 09:37:01 -0800
Message-ID: <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
References: <4F3120D4.1050604@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?QW5keSBHcmVlbiAoGyRCTlMwQlcvGyhCKQ==?= 
	<andy@warmcat.com>, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:37:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruoye-0005Oi-M2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab2BGRhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:37:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338Ab2BGRhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:37:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A20CC5FC7;
	Tue,  7 Feb 2012 12:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ShovYRvQXafKqW0dtr3btvdnvQ=; b=ZOSM/f
	tZwdcYCO1rrKdKDn/DPksG8C748504W9/poN3OpYfvUddRM2FvcQMPExHo4HetUN
	RhmaMnb1Nw8QyTe6xH45L2DzOMa9ElM+m1lcpxxveRK/F6YwhDaaS0vjRbw0RNWO
	2XsvxxGh3o3xlIO20I9oiDRj+AEH5oiJNG7FU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=guas5r1q7MqspdAJVCu8kK+lm9xlUA36
	qoKFKP1ht9fUKkCY2jvJq2qMDBwlEF47mnmonrzsu68uemYJpU3gngJWEfOieCWz
	kYVv7IdyaHjN6Nq8xjIOHqNEH+yOil93J3h0LyMRUxgq7orpDpy3O3kmDV/BL0pt
	ENEHuLDMoiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967E35FC6;
	Tue,  7 Feb 2012 12:37:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB6715FC5; Tue,  7 Feb 2012
 12:37:02 -0500 (EST)
In-Reply-To: <4F3120D4.1050604@warmcat.com> ("Andy Green
 =?iso-2022-jp?B?KBskQk5TMEJXLxsoQikiJ3M=?= message of "Tue, 07 Feb 2012
 05:02:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5890F666-51B2-11E1-AE63-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190189>

"Andy Green (林安廸)" <andy@warmcat.com> writes:

> [agreen@build linux-2.6]$ git reset --hard 105e518
> HEAD is now at 105e518 Merge tag 'hwmon-fixes-for-3.3-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> [agreen@build linux-2.6]$ stg push
> Error: Unhandled exception:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/site-packages/stgit/main.py", line 152, in _main
>     ret = command.func(parser, options, args)
>   File "/usr/lib/python2.7/site-packages/stgit/commands/push.py", line
> 68, in func
>     check_clean_iw = clean_iw)
>   File "/usr/lib/python2.7/site-packages/stgit/lib/transaction.py", line
> 95, in __init__
>     self.__current_tree = self.__stack.head.data.tree
>   File "/usr/lib/python2.7/site-packages/stgit/lib/git.py", line 426, in
> data
>     self.__repository.cat_object(self.sha1))
>   File "/usr/lib/python2.7/site-packages/stgit/lib/git.py", line 408, in
> parse
>     assert False
> AssertionError

Stgit at least at version 0.15 (which is you used, and which is what I
checked its source for) assumes it knows every possible kind of header
that can be recorded in the commit object and hits this assert when it
seems something it does not understand.

Version 0.16 seems to have removed this assert, like this hunk on the file
between 0.15 and 0.16:

@@ -404,8 +404,6 @@ class CommitData(Immutable, Repr):
                 cd = cd.set_author(Person.parse(value))
             elif key == 'committer':
                 cd = cd.set_committer(Person.parse(value))
-            else:
-                assert False
         assert False

The above code in StGit that tries to parse commit object header is
broken, and I am surprised that nobody caught it back in late 2006 when
the optional encoding header was added to the commit object, which the
above does not understand.

I am not sure if that removal of the extra assertion is enough, though.
It does not skip lines that it does not understand until the first blank
line, i.e. the end of the header, as it should.  Instead it has this
before starting to inspect if a line in the header is what it knows about:

            line = lines[i].strip()
            if not line:
                return cd.set_message(''.join(lines[i+1:]))
            key, value = line.split(None, 1)

I do not think this will work on a continuation line inside a header that
has only one token, and it will also ignore the leading whitespace that
protects the continuation line.

I think the loop should at least changed line this, until StGit starts
caring about multi-line headers with continuation lines.

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 56287f6..f2b284d 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -392,18 +392,20 @@ class CommitData(Immutable, Repr):
         cd = cls(parents = [])
         lines = list(s.splitlines(True))
         for i in xrange(len(lines)):
-            line = lines[i].strip()
+            line = lines[i]
             if not line:
                 return cd.set_message(''.join(lines[i+1:]))
-            key, value = line.split(None, 1)
-            if key == 'tree':
-                cd = cd.set_tree(repository.get_tree(value))
-            elif key == 'parent':
-                cd = cd.add_parent(repository.get_commit(value))
-            elif key == 'author':
-                cd = cd.set_author(Person.parse(value))
-            elif key == 'committer':
-                cd = cd.set_committer(Person.parse(value))
+	    ix = line.find(' ')
+	    if 0 < ix:
+		key, value = line[0:ix], line[ix+1:]
+		if key == 'tree':
+		    cd = cd.set_tree(repository.get_tree(value))
+		elif key == 'parent':
+		    cd = cd.add_parent(repository.get_commit(value))
+		elif key == 'author':
+		    cd = cd.set_author(Person.parse(value))
+		elif key == 'committer':
+		    cd = cd.set_committer(Person.parse(value))
         assert False
 
 class Commit(GitObject):
