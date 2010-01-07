From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick problem - directory not touched by commit is 
 marked "added by us"
Date: Wed, 06 Jan 2010 19:30:46 -0800
Message-ID: <7v4omyfv6h.fsf@alter.siamese.dyndns.org>
References: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
 <1262727434.22597.8.camel@denix>
 <82cfa8031001060328r21aa8de3s5c2dd5dac005b679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Hakim Cassimally <hakim.cassimally@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 04:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSj5Y-0002RM-RB
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 04:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab0AGDbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 22:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919Ab0AGDbB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 22:31:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351Ab0AGDa7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 22:30:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F648E196;
	Wed,  6 Jan 2010 22:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vPdp2V6OWHXQ
	PrcKjJy2zhcvLLA=; b=R5acgiPKumTq/xVl+xikTqpqHShtcR/O6u/CFw7AyqDq
	HchkhLe9y8N6D8U0L1B8kt0+TlAA6Nf9M5cwyYUzxEUqvKt+ka2hE0xJsHho+q0O
	2210xreD24bOOyea6HwFWfKX6a9JWXpm5Hme4AHUtqCqhPOe2RipEX0KBOwXtNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Yg2dUe
	4qZhijQ9GIhYWzdaDuTzLoiCxITVhHxSydJKaraGsym/GbZxB9IFUVNtG8rwyd1m
	n0fKBIUnU2KQJV/48v6JQrj15+QQyEC4RmzXVElFWVlTgnDk0YHwmaQx8UN7c+Xi
	MorpDF3LlqVd4t7ArK/iDJrBOdhmsV4IaJXgc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EEECF8E18D;
	Wed,  6 Jan 2010 22:30:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2CD18E17F; Wed,  6 Jan
 2010 22:30:47 -0500 (EST)
In-Reply-To: <82cfa8031001060328r21aa8de3s5c2dd5dac005b679@mail.gmail.com>
 (Hakim Cassimally's message of "Wed\, 6 Jan 2010 11\:28\:44 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E50C6C6-FB3D-11DE-BF21-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136319>

Hakim Cassimally <hakim.cassimally@gmail.com> writes:

>>> =C2=A0 =C2=A0 (stable) $ git cherry-pick 301afce1
>>> =C2=A0 =C2=A0 Finished one cherry-pick.
>>> =C2=A0 =C2=A0 www/client/css/admin.css: needs merge
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 <...snip>
>>> =C2=A0 =C2=A0 www/client/css/admin.css: unmerged (8e7cd850bf40d1a92=
1b1f62ce0945abd374fa55d)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 <...snip>
>>> =C2=A0 =C2=A0 ...
>>> =C2=A0 =C2=A0 error: Error building trees
>>
>  $ git ls-files -s -u www/client/css/admin.css # only staged/unmerged
>   100755 8e7cd850bf40d1a921b1f62ce0945abd374fa55d 2
> www/client/css/admin.css
>
> (i.e. when run after the failed cherry-pick)
>
>> Also take the 'git ls-tree -r HEAD', 'git ls-tree -r 301afce1' and '=
git
>> ls-tree -r 301afce1^' output, and grep for the files in question. =C2=
=A0The
>> answer (or at least a bug triage) should be in the output of those
>> commands.
>
>   $ git ls-tree HEAD | grep www/client/css/admin.css
>   100755 blob 8e7cd850bf40d1a921b1f62ce0945abd374fa55d
> www/client/css/admin.css
>
> There's no entry in git ls-tree 301afce1 or 301afce1^1 though.  I'd
> guess that's significant, but I don't know what answer it suggests...
>
> (However the file exists in both (stable) and (experimental)...
> and is identical in both).
> ....

So in short:

 * commit 301a added a new path bin/upload_module.pl;

 * the state you cherry-picked this commit to was clean (i.e. before
   running cherry-pick, "git status" reported no local changes to the
   index nor to the work tree);

 * the commit, the index, and the work tree before running this
   cherry-pick had www/client/css/admin.css file, which also existed in
   301a and 301a^, but all of these three commits had the same contents=
=2E

A simple minded attempt to reproduce this (attached below) by preparing=
 a
commit that adds one new file and attempting to transplant to an unrela=
ted
commit that doesn't have the file didn't work; I have been scratching m=
y
head.

What "cherry-pick" internally does is to run:

    git merge-recursive 301a^ -- HEAD 301a

That is, "We are at HEAD; consolidate the change since 301a^ to 301a in=
to
our state, and leave the result in the index and the work tree".  Then =
it
commits the result.  One thing to try is to see if this gives the same
kind of breakage.

The only other thing that _may_ be involved is if there are paths that
turned between directories and files on the two histories, or perhaps
there are paths like "www-frotz", "www.frotz", etc (i.e. "www" followed=
 by
a byte whose ASCII value comes before '/') involved, and unpack_trees()
machinery the merge-recursive internally uses are getting confused abou=
t
D/F conflicts.  To diagnose it, it would be helpful to get the full out=
put
from these two commands:

    git ls-tree -r -t HEAD (before cherry-pick)
    git ls-tree -r -t 301a (the commit you are transplanting)

Thanks

---

diff --git a/t/t3506-cherry-pick-addremove.sh b/t/t3506-cherry-pick-add=
remove.sh
new file mode 100755
index 0000000..e7dcd77
--- /dev/null
+++ b/t/t3506-cherry-pick-addremove.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description=3D'unrelated files added by our side'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	git branch side &&
+	test_commit B &&
+	test_commit C &&
+
+	git checkout side &&
+	test_commit D &&
+	test_commit E &&
+
+	git checkout master
+'
+
+test_expect_success 'cherry-pick' '
+	git reset --hard C &&
+	git cherry-pick side &&
+	git grep E E.t
+'
+
+test_done
