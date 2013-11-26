From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 14:18:03 -0800
Message-ID: <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
	<5294BB97.7010707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Townsend <nick.townsend@mac.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 26 23:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQxT-0000st-Da
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 23:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab3KZWSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 17:18:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab3KZWSJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 17:18:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000A556E90;
	Tue, 26 Nov 2013 17:18:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oy9YxLyPBrwx
	z66hCJk2c8K/p0k=; b=V6bl+pjXOUN1KtxT4xbbzkru14TUDlOF/G/eIyf74VKb
	mcA3+SfK+soo8MBki0CLtrc1c0qGd5kmkLuMshvCpMJVooZeVWMlJVjza+7VVuyS
	VeGuMMhBYkMvVmrhbWr+m75kbdKo8MZnQQtnGKrL/xr6IXEaGicDOaaNEviCc+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gjglbw
	t/worn16ww37WxmAQN6ruaSfbzJOOWzop/DBpE4wr6iqqk2B3pvS/TJhm0tJRJou
	p884ouyoMKx8+Uh8bocta0/zob0JYsu9OIP1JV6UKO+rvJwqmIPVQgSMbGxTH4xy
	AaORU4YjlQcsQWKros6M2tfY79l3amjlcF6SM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB18D56E8F;
	Tue, 26 Nov 2013 17:18:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5F3956E8C;
	Tue, 26 Nov 2013 17:18:07 -0500 (EST)
In-Reply-To: <5294BB97.7010707@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 26
	Nov 2013 16:17:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A09D1204-56E8-11E3-8B75-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238396>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Thanks for the patches!  Please send only one per message (the second
> one as a reply to the first one, or both as replies to a cover letter=
),
> though -- that makes commenting on them much easier.
>
> Side note: Documentation/SubmittingPatches doesn't mention that (yet)=
,
> AFAICS.

OK, how about doing this then?

 Documentation/SubmittingPatches | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 7055576..304b3c0 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -140,7 +140,12 @@ comment on the changes you are submitting.  It is =
important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
 your code.  For this reason, all patches should be submitted
-"inline".  If your log message (including your name on the
+"inline".  A patch series that consists of N commits is sent as N
+separate e-mail messages, or a cover letter message (see below) with
+N separate e-mail messages, each being a response to the cover
+letter.
+
+If your log message (including your name on the
 Signed-off-by line) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
=20

>> The feature is disabled for remote repositories as
>> the git_work_tree fails. This is a possible future
>> enhancement.
>
> Hmm, curious.  Why does it fail?  I guess that happens with bare
> repositories, only, right?  (Which are the most likely kind of remote
> repos to encounter, of course.)

Yeah, I do not think of a reason why it should fail in a bare
repository, either. "git archive" is about writing out the contents
of an already recorded tree, so there shouldn't be a reason to even
call get_git_work_tree() in the first place.

Even if the code is run inside a repository with a working tree,
when producing a tarball out of an ancient commit that had a
submodule not at its current location, --recurse-submodules option
should do the right thing, so asking for working tree location of
that submodule to find its repository is wrong, I think.  It may
happen to find one if the archived revision is close enough to what
is currently checked out, but that may not necessarily be the case.

At that point when the code discovers an S_ISGITLINK entry, it
should have both a pathname to the submodule relative to the
toplevel and the commit object name bound to that submodule
location.  What it should do, when it does not find the repository
at the given path (maybe because there is no working tree, or the
sudmodule directory has moved over time) is roughly:

 - Read from .gitmodules at the top-level from the tree it is
   creating the tarball out of;

 - Find "submodule.$name.path" entry that records that path to the
   submodule; and then

 - Using that $name, find the stashed-away location of the submodule
   repository in $GIT_DIR/modules/$name.

or something like that.

This is a related tangent, but when used in a repository that people
often use as their remote, the repository discovery may have to
interact with the relative URL.  People often ship .gitmodules with

	[submodule "bar"]
        	URL =3D ../bar.git
		path =3D barDir

for a top-level project "foo" that can be cloned thusly:

	git clone git://site.xz/foo.git

and host bar.git to be clonable with

	git clone git://site.xz/bar.git barDir/

inside the working tree of the foo project.  In such a case, when
"archive --recurse-submodules" is running, it would find the
repository for the "bar" submodule at "../bar.git", I would think.

So this part needs a bit more thought, I am afraid.

>>  'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<=
extra>]
>>  	      [-o <file> | --output=3D<file>] [--worktree-attributes]
>> +	      [--recursive|--recurse-submodules]
>
> I'd expect git archive --recurse to add subdirectories and their
> contents, which it does right now, and --no-recurse to only archive t=
he
> specified objects, which is not implemented.  IAW: I wouldn't normall=
y
> associate an option with that name with submodules.  Would
> --recurse-submodules alone suffice?

Jens already commented on this, and I agree that --recursive should
be dropped from this patch.
