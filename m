From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: add `add.ginore-errors` configuration variable
Date: Tue, 27 Jan 2015 12:17:58 -0800
Message-ID: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
References: <1422291325-4332-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cT9hC=n7WkANno9Eif-+RUCeA6mQioUhOSkDEx_vdmN1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGCaO-0003Pt-D2
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 21:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759507AbbA0USD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 15:18:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755120AbbA0USB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 15:18:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5AFF31CCB;
	Tue, 27 Jan 2015 15:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vSdstxmpc4IdmwW1axsYbVw1XEE=; b=Acnk9O
	qFFThhnYA93JLbYqbIT6R/N71FFyMCCtOKVnViSqZSgircNHnOa/5Tqw87+RJTd9
	BqlepjXsCmFV8uFlJMQtJkYwa55uKuAqfY+qSpQ3k3RLcqljceGfR1l+k3IGdjND
	NybW9VMfCuO9VRMHiiDOJ4ZMnDKsWFOZ/aZcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jgLX4mb12rsR6Yn6csI70OjWfFIWm6vY
	GGF+kQWJ8AAedISPfFSp3tcTosddmwaGCg9VDcPfynP4/zZFOXXDXXA/7G83U493
	AKrCOtUHZhLchKtpfhMK2vtQn2DpON7ui6qTU8zxD51iBN8TuxTDbHMjxIpyyoKc
	iiM0e0nbACE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 708C731CCA;
	Tue, 27 Jan 2015 15:18:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBF5931CC9;
	Tue, 27 Jan 2015 15:17:59 -0500 (EST)
In-Reply-To: <CAPig+cT9hC=n7WkANno9Eif-+RUCeA6mQioUhOSkDEx_vdmN1Q@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 26 Jan 2015 16:58:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96AB15CE-A661-11E4-BE75-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263086>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jan 26, 2015 at 11:55 AM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> 'git add' supports not only `add.ignoreErrors`, but also `add.ignore-errors`
>> configuration variable.
>
> See 6b3020a2 (add: introduce add.ignoreerrors synonym for
> add.ignore-errors,  2010-12-01) for why this patch is undesirable.

We might want to do this instead, as the correction to the
misspelled configuration variable name was from the 1.7.0-era that
is sufficiently old (v1.7.0.8 was done in December 2010).

-- >8 --
Subject: doc: clarify naming rules for configuration variables

Also mark deprecated variables in the documentation more clearly.

The text for the rules are partly taken from the log message of
Jonathan's 6b3020a2 (add: introduce add.ignoreerrors synonym for
add.ignore-errors, 2010-12-01).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 25 +++++++++++++++++++++++++
 Documentation/config.txt       | 15 +++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 894546d..8fbac15 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -413,6 +413,31 @@ Error Messages
  - Say what the error is first ("cannot open %s", not "%s: cannot open")
 
 
+Externally Visible Names
+
+ - For configuration variable names, follow the existing convention:
+
+   . The section name indicates the affected subsystem.
+
+   . The subsection name, if any, indicates which of an unbounded set
+     of things to set the value for.
+
+   . The variable name describes the effect of tweaking this knob.
+
+   The section and variable names that consist of multiple words are
+   formed by concatenating the words without punctuations (e.g. `-`),
+   and are broken using bumpyCaps in documentation as a hint to the
+   reader.
+
+   When choosing the variable namespace, do not use variable name for
+   specifying possibly unbounded set of things, most notably anything
+   an end user can freely come up with (e.g. branch names), but also
+   large fixed set defined by the system that can grow over time
+   (e.g. what kind of common whitespace problems to notice).  Use
+   subsection names or variable values, like existing variables
+   branch.<name>.description and core.whitespace do, instead.
+
+
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in the
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0a4d22a..8a76d1d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -664,14 +664,13 @@ core.abbrev::
 	for abbreviated object names to stay unique for sufficiently long
 	time.
 
-add.ignore-errors::
 add.ignoreErrors::
+add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].  Older versions of Git accept only
-	`add.ignore-errors`, which does not follow the usual naming
-	convention for configuration variables.  Newer versions of Git
-	honor `add.ignoreErrors` as well.
+	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
+	as it does not follow the usual naming convention for configuration
+	variables.
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
@@ -1924,7 +1923,7 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
-pack.writebitmaps::
+pack.writebitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
 pack.writeBitmapHashCache::
@@ -2235,7 +2234,7 @@ sendemail.smtpencryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl::
+sendemail.smtpssl (deprecated)::
 	Deprecated alias for 'sendemail.smtpencryption = ssl'.
 
 sendemail.smtpsslcertpath::
@@ -2273,7 +2272,7 @@ sendemail.thread::
 sendemail.validate::
 	See linkgit:git-send-email[1] for description.
 
-sendemail.signedoffcc::
+sendemail.signedoffcc (deprecated)::
 	Deprecated alias for 'sendemail.signedoffbycc'.
 
 showbranch.default::
