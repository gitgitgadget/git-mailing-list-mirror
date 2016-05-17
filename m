From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Tue, 17 May 2016 13:30:52 -0700
Message-ID: <xmqqinycv343.fsf@gitster.mtv.corp.google.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
	<xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
	<xmqqtwhwwp0c.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ-XwEhTRwoNhrBH=NCQhpsHR=PfgtDrfJs23j6hkBWRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 22:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ldt-0008GO-3F
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 22:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbcEQUa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 16:30:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750792AbcEQUa4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 16:30:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CF461AA99;
	Tue, 17 May 2016 16:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=s238ZQBiOSUUMFHnNFxJUx9mX
	+Q=; b=Yq56xr2zElUZow5zSqblK8j20+UCP791fcqON85qyD9T2QShDfVt2tGJL
	yCefEsdPzNdFOTz5WCLerGMr41F40fDJEn2aVsBZPvOUj4oNdVPJNbxclrYv9C/T
	+9IagtnGvYs4IbQE9msc2se9/sSAaiS/qrv17Dark4nqGXtJFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=x/QLJvrczB97r/LzE3f
	MbzbomhUMWDnVQhpMK3034o3bl4Ey8QWmu7RHmdqKTRtqhkOAPZUN0Dsff0EB/0c
	rTvUjN5abrhSXRyJBJp2tnrb9ggM4EuFxcZ05R30Ds4dFJ8bE4MAR3MFxYsvVTcG
	Bj1oCC7FWOnFApPLNnHB3fBg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 749681AA98;
	Tue, 17 May 2016 16:30:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB9E11AA97;
	Tue, 17 May 2016 16:30:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 415013C0-1C6E-11E6-A093-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294911>

Karthik Nayak <karthik.188@gmail.com> writes:

> Sorry for that.
> The only reason I haven't based it on 'master' is because it doesn't =
contain
> 'f307218'.
>
> =E2=9E=94 git branch --contains=3Df307218
>   next
>   ref-filter

It is not clear from the above what your local ref-filter contains
beyond 'master', so it is not very useful to me when I am trying to
help you to avoid taking this topic hostage to all the topics in
'next' (if I queued this directly on 'next', I have to hold this
series until all the topics in 'next' graduates to 'master).

The series certainly would not apply to f307218 at all; it depends
on other stuff you have either in your local 'ref-filter' or 'next'.
It does not apply to the result of a merge of 'es/test-gpg-tags' topic=20
into 'master', either, but the above does not make it clear what
else you are using from 'next' at all.

In any case, I think I managed to reduce the dependency on only
'es/test-gpg-tags' and 'master', and that is what I'll be queuing.
Please double check the patches in kn/ref-filter-branch-list topic
and also the merge of it into 'pu' for mismerges.

The difference between the result of merging the previously queued
one to 'pu', and the result of merging this round to 'pu', looks
like the attached.

Thanks.

 builtin/branch.c               |  2 +-
 ref-filter.c                   |  6 ++++--
 t/t6302-for-each-ref-filter.sh | 30 +++++++++++++++---------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0bbb4de..2412738 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -293,7 +293,7 @@ static int calc_maxwidth(struct ref_array *refs, in=
t remote_bonus)
 		skip_prefix(it->refname, "refs/remotes/", &desc);
 		if (it->kind =3D=3D FILTER_REFS_DETACHED_HEAD) {
 			char *head_desc =3D get_head_description();
-			w =3D strlen(head_desc);
+			w =3D utf8_strwidth(head_desc);
 			free(head_desc);
 		} else
 			w =3D utf8_strwidth(desc);
diff --git a/ref-filter.c b/ref-filter.c
index 74c4869..f25671c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1196,12 +1196,14 @@ char *get_head_description(void)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
 		if (state.detached_at)
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached at " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
 				state.detached_from);
 		else
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached from " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached from %s)"),
 				state.detached_from);
 	}
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
index 331d978..a09a1a4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -342,22 +342,22 @@ test_expect_success 'improper usage of %(if), %(t=
hen), %(else) and %(end) atoms'
 '
=20
 test_expect_success 'check %(if)...%(then)...%(end) atoms' '
-	git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname): =
%(refname)%(end)" >actual &&
+	git for-each-ref --format=3D"%(refname)%(if)%(authorname)%(then) Auth=
or: %(authorname)%(end)" >actual &&
 	cat >expect <<-\EOF &&
-	A U Thor: refs/heads/master
-	A U Thor: refs/heads/side
-	A U Thor: refs/odd/spot
-
-
-
-	A U Thor: refs/tags/foo1.10
-	A U Thor: refs/tags/foo1.3
-	A U Thor: refs/tags/foo1.6
-	A U Thor: refs/tags/four
-	A U Thor: refs/tags/one
-
-	A U Thor: refs/tags/three
-	A U Thor: refs/tags/two
+	refs/heads/master Author: A U Thor
+	refs/heads/side Author: A U Thor
+	refs/odd/spot Author: A U Thor
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10 Author: A U Thor
+	refs/tags/foo1.3 Author: A U Thor
+	refs/tags/foo1.6 Author: A U Thor
+	refs/tags/four Author: A U Thor
+	refs/tags/one Author: A U Thor
+	refs/tags/signed-tag
+	refs/tags/three Author: A U Thor
+	refs/tags/two Author: A U Thor
 	EOF
 	test_cmp expect actual
 '
