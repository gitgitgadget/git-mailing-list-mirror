From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 10:30:26 -0700
Message-ID: <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
	<53711AA5.4040001@web.de> <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
	<23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
	<537233CC.3050904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 19:30:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkGXH-0002p0-6k
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 19:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbaEMRag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 13:30:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57829 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaEMRae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 13:30:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F47F16D3F;
	Tue, 13 May 2014 13:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IJC1egc6w6UJ
	uEK1SyUo6QwKIJI=; b=QVYcw30utoMuxLPCTjV644UuQ+CpyVHtFzqbPngAaA22
	yb4mZIVsXwIQEPGKyoTTDhX2Y9KkkY1uUoUfWpOG2qaaTepfGI0UFYTIFKoaa9Dq
	rqI8IiQrs3/zK8Gst3FdgQKGqwEnTlDlyrcQ/8+C2JtvBZl1rQIdorTQKHNhD+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yARe73
	W8SpyzDObUHLOCDQguvWHoRuHCl6f92b1anycIzYVkg2P2TG0728hbIaLq0IxwlC
	lIrAEv1bVmkU6HVLJ0BlLus/pERmVnukSWUm1ixy0ogfGYUwR5ywJ+MV0JQyIzkb
	Mo2tD084v3+ERKVebj6M7VkxBh+/+wd1Htbt4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65A1316D3D;
	Tue, 13 May 2014 13:30:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E68AC16D27;
	Tue, 13 May 2014 13:30:28 -0400 (EDT)
In-Reply-To: <537233CC.3050904@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 13 May 2014 17:01:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46EC417A-DAC4-11E3-B824-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248792>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I did some testing with Git 2.0-rc3 + 58aee0864adeeb5363f.
> The remote-helper tests for hg-git worked OK
> with both hg version 2.9 and 3.0 under both Mac OS and Linux.
>
> Should we consider 58aee086 to be included in Git 2.0 ?

It is way too late for Git 2.0, unless we are willing to pretend
that it is before 2.0-rc1, and cut one rc release tarball or two and
delay the final release by a few weeks.  And "I tested it with 2.9
and 3.0" is not the kind of test that is sufficient before the
release (e.g. my desktop seems to have 2.0.2-1ubuntu1); it is the
kind of test we want to see before the patch is sent to the list,
which I know Felipe did.

A clarification for new people might be in order, as there seem to
be some confusions in some recent threads.

Code freeze in preparation for the next release is *not* the time to
test new code.  It is time to catch regressions by asking wider
audiences who do not normally follow Git development (i.e. those who
are not the ones that follow 'master' and rebuild/install it once or
twice a week for their daily use).

These people (and I am one of them for other projects whose products
I use myself and whose development I do not follow) may be curious
what will be in the upcoming release, but what they care more about
is that the upcoming release will *not* break their established
usage.  If the version of Git they currently run allows them to do
something, and if the upcoming release stops them from doing that
thing they care, that will prevent them from using the new version
of Git.

That is what we want to catch by announcing release candidate
tarballs; in exchange for giving an early access to those who do not
always live on the edge by having a clone of git.git and following
its development, we want them to catch regressions and report to us,
so that we can "fix" (and the fix often is to revert when deep in
the release candidate cycles).

On the other hand, if their current Git did not allow them to do
something, and if the new version still does not, it is unfortunate
but it is the same flaw they have been living with.

My understanding is that versions of remote-hg shipped with all
versions of Git did not work with Hg 3.0, so 58aee08 is not a
regression fix at all.  Is working with Hg 3.0 at such a high
priority that it makes it worth to slip the whole release schedule
by a few weeks?  I do not think so.

Another thing to consider is that fewer and fewer people test later
release candidates, so issuing a 2.0-rc4 tarball that wasn't
scheduled and giving it a soak time of two weeks will not get as
wide a testing as we would get for 2.0-rc0/rc1.

So the answer to your question is an unambiguous "no".

It is a different matter if we want a change to allow us to operate
with both older and newer version of mercurial in a release of Git
in near future.  The answer is a resounding "yes", even if the
solution may not be the exact 58aee0864 commit [*2*].  I think an
update should eventurally go to the maintenance tracks of even older
releases, perhaps maint-1.8.5 and upwards, after we merge it to
'master' in preparation for the feature release that comes after Git
2.0, which probably will be called 2.1 but do not quote me on that.

Regarding the commit in question, I asked Felipe a question and
never got a straight answer.

    Why do we "import changegroup" unconditionally, even though it
    is only used in the new codepath meant only for version 3.0 or
    higher, not inside the "if" block that decides if we need that
    module?

I had a few more questions in mind that I didn't have a chance to
ask, and the commit log message did not explain.

    Is the reason why this fix is needed is because "repo" stopped
    being a way to ask ".getbundle()" and in the new world order
    "changegroup" is the new way to ask ".getbundle()"?

    If the answer is "yes", then asking "are we with 3.0 or
    later---if so ask changegroup for ".getbundle()?", which is this
    patch does, may not be the right condition to trigger the new
    codepath.  "Does repo know how to do .getbundle()?  If not,
    import changegroup and ask that module to perform .getbundle()
    instead" may be a way to base the decision on a more directly
    relevant condition.

Answers to these questions, if they came, were meant to convince
myself that the patch 58aee0864 is the best solution to the problem,
but because I only got "Of course it is not a mistake" [*1*], seeing
it did not lead to a productive discussion, I gave up.  So I haven't
even managed to convince myself that that commit is the best
solution to the problem.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=
=3D248348

*2*
commit 58aee0864adeeb5363f2a06728596f9c9315811f
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat May 3 21:16:54 2014 -0500

    remote-hg: add support for hg v3.0
   =20
    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-help=
ers/git-remote-hg
index 34cda02..8b02803 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -13,6 +13,7 @@
 # "$GIT_DIR/hg/origin/clone/.hg/".
=20
 from mercurial import hg, ui, bookmarks, context, encoding, node, erro=
r, extensions, discovery, util
+from mercurial import changegroup
=20
 import re
 import sys
@@ -985,7 +986,10 @@ def push_unsafe(repo, remote, parsed_refs, p_revs)=
:
     if not checkheads(repo, remote, p_revs):
         return None
=20
-    cg =3D repo.getbundle('push', heads=3Dlist(p_revs), common=3Dcommo=
n)
+    if check_version(3, 0):
+        cg =3D changegroup.getbundle(repo, 'push', heads=3Dlist(p_revs=
), common=3Dcommon)
+    else:
+        cg =3D repo.getbundle('push', heads=3Dlist(p_revs), common=3Dc=
ommon)
=20
     unbundle =3D remote.capable('unbundle')
     if unbundle:
