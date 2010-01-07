From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7002: set test prerequisite "external-grep" if
 supported
Date: Wed, 06 Jan 2010 20:29:16 -0800
Message-ID: <7vy6ka8rmr.fsf@alter.siamese.dyndns.org>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <1262608455-4045-1-git-send-email-pclouds@gmail.com>
 <7v4omyhc7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 05:29:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSk02-0008K6-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 05:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab0AGE30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 23:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279Ab0AGE30
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 23:29:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0AGE3Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 23:29:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F07B68E855;
	Wed,  6 Jan 2010 23:29:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oDFY2RCHiF2D
	jnNZGaQHiTThXMw=; b=Uh33pE6z2O7rXfEl6Qv7wupAC6CC3tXMx3Xm7bV2Fo36
	f7KRtFbDnVNWVHxLsIyYxst8Cf2qFr0oolb6gE0HxstBZ9cGEJ6NeClcCXfp4pnY
	dXeyCnBaOgGrB12BIlMXU83+OlLp8FLkAmmpz/a6Uoo73uxGemVYg0CcXoBfaRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aKgGEL
	3xCclhPZX0Zy1/cKweMThVVLjzDOvNTi0jssWGo5V7zvMKW26H1pNe6acsz1UPND
	OMuj5tvtIf5Gutz/RxD4PMUC+v/347u6CPS8Q0wCmsltpddcIq9SLjs7fUlmUs6z
	8KyplU641MnoTgKP5apK1ytLXch72a2sHgi/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C58188E852;
	Wed,  6 Jan 2010 23:29:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 044438E849; Wed,  6 Jan
 2010 23:29:17 -0500 (EST)
In-Reply-To: <7v4omyhc7h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 06 Jan 2010 18\:37\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39BCBDA8-FB45-11DE-84B5-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136323>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Add another test to set prerequisite "external-grep" if the current
>> build supports external grep. This can be used to skip external grep
>> only tests on builds that do not support this optimization.
>
> Thanks.  We seem to spell our prerequistes in a single-word, all-caps=
, so
> I'll change this new one to EXTGREP in both [1/2] and [2/2].

Sorry, but I had this "Sheesh, why didn't I think of that earlier befor=
e
wasting Nguy=E1=BB=85n's time" moment.

Why don't we just test what we _want to_ test?  After all what a67e281
(grep: do not do external grep on skip-worktree entries, 2009-12-30)
wanted to make sure was this:

    "git grep" (without --cached) should grep from the index for paths
    that are marked as skip-worktree.

So how about writing some string that does not appear in the version in
the index in the work tree file, and run "git grep" to make sure it
doesn't find it?

Yes, some implementations/builds of "git grep" may not even try to chea=
t
and run external grep and for them the test _should_ succeed (but your
logic to check with ce_skip_worktree() in grep_cache() may be broken by
later patch while you are looking the other way), and some will try to
cheat and the fix was about not letting them.

So by writing the test to check the desired outcome, instead of writing=
 it
for the particular implementation of using external grep optimization, =
you
will catch both kinds of breakages.

Perhaps something like this (untested, of course)?

test_expect_success 'strings in work tree files are not found for skip-=
wt paths' '
	no=3D"no such string in the index" &&
	test_must_fail git grep -e "$no" --cached file &&
	git update-index --skip-worktree file &&
	echo "$no" >file &&
	test_must_fail git grep -e "$no" file &&
	git update-index --no-skip-worktree file &&
	git grep -e "$no" file
'
