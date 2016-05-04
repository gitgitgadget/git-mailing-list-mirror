From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 10:36:24 -0700
Message-ID: <xmqq8tzpiv3b.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 19:36:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay0ix-0005V6-2l
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 19:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbcEDRga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 13:36:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754893AbcEDRg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 13:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D224B16AD2;
	Wed,  4 May 2016 13:36:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EodKaW7OrgSkHMb/LcbzW5g17do=; b=V1sYN4
	X6qV56VWW7QQgWvprAViAY1aD6oEiKQ2e74xyTj8JklsvYMPxVENJND9ebiSZJQN
	kdYjLsxsyL6TIrEg6mV0JnKYEgRyUWDzqkOxgyOSM3Opj1Bi1yWdlkXKooNt31cM
	dVAzuZDr52VrOvpb156BVrtZN0YN3OmqyjKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugHqCasbA7CMTRr1Ju95vr+ojcOrb3eW
	FDiEWm12Za2N3bPUq5crChjRJI5Xqp/8+XDF6mH+w9kYSxqf13zvaMnMVghFTin+
	+Wk+Jq2T7otkktrMVln5KDdobxEB6wM2HTi2Dyp0pZy/RsJ5XVBJbuNvMyXz0nYX
	HsyVMOwjsUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CACB916AD1;
	Wed,  4 May 2016 13:36:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 353AD16AD0;
	Wed,  4 May 2016 13:36:26 -0400 (EDT)
In-Reply-To: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 10:28:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA28F3CA-121E-11E6-8C10-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293555>

Junio C Hamano <gitster@pobox.com> writes:

> So I used the script attached at the bottom to audit the whole
> thing, and the result is here.
> ...

While I was at it, I just did this to make the documentation set
lint clean.

-- >8 --

There are a handful of incorrect "linkgit:<page>[<section>]"
instances in our documentation set.

 * Some have an extra colon after "linkgit:"; fix them by removing
   the extra colon;

 * Some refer to a page outside the Git suite, namely curl(1); fix
   them by using the `curl(1)` that already appears on the same page
   for the same purpose of referring the readers to its manual page.

 * Some spell the name of the page incorrectly, e.g. "rev-list" when
   they mean "git-rev-list"; fix them.

 * Some list the manual section incorrectly; fix them to make sure
   they match what is at the top of the target of the link.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                    | 4 ++--
 Documentation/diff-options.txt              | 2 +-
 Documentation/everyday.txto                 | 2 +-
 Documentation/git-check-ignore.txt          | 2 +-
 Documentation/git-filter-branch.txt         | 2 +-
 Documentation/git-for-each-ref.txt          | 2 +-
 Documentation/git-notes.txt                 | 2 +-
 Documentation/technical/api-credentials.txt | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..f37e16b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1494,7 +1494,7 @@ gui.diffContext::
 	made by the linkgit:git-gui[1]. The default is "5".
 
 gui.displayUntracked::
-	Determines if linkgit::git-gui[1] shows untracked files
+	Determines if linkgit:git-gui[1] shows untracked files
 	in the file list. The default is "true".
 
 gui.encoding::
@@ -1659,7 +1659,7 @@ http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	the Netscape/Mozilla cookie file format (see `curl(1)`).
 	NOTE that the file specified with http.cookieFile is only used as
 	input unless http.saveCookies is set.
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4b0318e..3cb3015 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -271,7 +271,7 @@ For example, `--word-diff-regex=.` will treat each character as a word
 and, correspondingly, show differences character by character.
 +
 The regex can also be set via a diff driver or configuration option, see
-linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
+linkgit:gitattributes[5] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
 
diff --git a/Documentation/everyday.txto b/Documentation/everyday.txto
index c5047d8..ae555bd 100644
--- a/Documentation/everyday.txto
+++ b/Documentation/everyday.txto
@@ -1,7 +1,7 @@
 Everyday Git With 20 Commands Or So
 ===================================
 
-This document has been moved to linkgit:giteveryday[1].
+This document has been moved to linkgit:giteveryday[7].
 
 Please let the owners of the referring site know so that they can update the
 link you clicked to get here.
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index e94367a..611754f 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -112,7 +112,7 @@ EXIT STATUS
 SEE ALSO
 --------
 linkgit:gitignore[5]
-linkgit:gitconfig[5]
+linkgit:git-config[1]
 linkgit:git-ls-files[1]
 
 GIT
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 73fd9e8..003731f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -205,7 +205,7 @@ to other tags will be rewritten to point to the underlying commit.
 Remap to ancestor
 ~~~~~~~~~~~~~~~~~
 
-By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
+By using linkgit:git-rev-list[1] arguments, e.g., path limiters, you can limit the
 set of revisions which get rewritten. However, positive refs on the command
 line are distinguished: we don't let them be excluded by such limiters. For
 this purpose, they are instead rewritten to point at the nearest ancestor that
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c52578b..d9d406d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -179,7 +179,7 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding `:` followed by date format name (see the
-values the `--date` option to linkgit::git-rev-list[1] takes).
+values the `--date` option to linkgit:git-rev-list[1] takes).
 
 
 EXAMPLES
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 8de3499..9c4fd68 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -402,4 +402,4 @@ on the `notes.rewrite.<command>` and `notes.rewriteRef` settings.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index e44426d..75368f2 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -243,7 +243,7 @@ appended to its command line, which is one of:
 The details of the credential will be provided on the helper's stdin
 stream. The exact format is the same as the input/output format of the
 `git credential` plumbing command (see the section `INPUT/OUTPUT
-FORMAT` in linkgit:git-credential[7] for a detailed specification).
+FORMAT` in linkgit:git-credential[1] for a detailed specification).
 
 For a `get` operation, the helper should produce a list of attributes
 on stdout in the same format. A helper is free to produce a subset, or
@@ -268,4 +268,4 @@ See also
 
 linkgit:gitcredentials[7]
 
-linkgit:git-config[5] (See configuration variables `credential.*`)
+linkgit:git-config[1] (See configuration variables `credential.*`)
