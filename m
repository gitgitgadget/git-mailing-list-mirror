Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6864EC5
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554994; cv=none; b=YiSjmDSh7piJ5wfslnTck9V5ytyLVe5t16VGd4HVmoPAW3e5sk2my+q9ZGv173LdM7m+pxXBddFUeW4WXnzAFPkdnPVCLH68vSQzW7ohH0/F1RKnWeX2qTBxUOgpWMVZfeZOiUQ7XJO/8FXNazgREQlwcO3aSgUXz9acaBySGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554994; c=relaxed/simple;
	bh=EVXXUEVv+UWdvVXoOUGcS2j0g+p8EXivmy2Po8uQzRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHu+niY468l9lP3NY7LAfBqMKzmmdaeSOkpbgnbjw3dPrDcy7rpSAf3LSx8oAITmp6jbCakGbIu85eo42a7Wim6Ucwo2Ky3CnWOsEoUEQY9IKBMYKkB8b0gv0prsDTEIDa9FPbcSnLLrilRoPm69+m4UB8NNP0K+XcqWvUVek7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=re7Yfp6x; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="re7Yfp6x"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C89B1E7288;
	Wed, 21 Feb 2024 17:36:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EVXXUEVv+UWdvVXoOUGcS2j0g+p8EXivmy2Po8
	uQzRE=; b=re7Yfp6xZTea6HLptSd1A+NDWCt/BMZs4a9fbc9zSTFrvyEl7tuhIV
	+CChAcOtisLpUzluwu2xGeJVxQWvAYNkvPYvB7Q/EHnYU9rTvnZb4+44/gzsRYLj
	y/UO44c9DopdVgFETl5XA2ME3820lJFpF6zoJAayW4yxeVW9MnD/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2413C1E7287;
	Wed, 21 Feb 2024 17:36:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D7A61E7286;
	Wed, 21 Feb 2024 17:36:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line
 description syntax
In-Reply-To: <xmqqfrxlpvv1.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Feb 2024 09:31:30 -0800")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
	<xmqqsf1mlp6f.fsf@gitster.g>
	<67dca173-3048-430b-88a1-d3b5d853f84b@free.fr>
	<xmqqfrxlpvv1.fsf@gitster.g>
Date: Wed, 21 Feb 2024 14:36:24 -0800
Message-ID: <xmqqbk89molz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5761266-D109-11EE-8988-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> Backticks and single quotes are used indistinctively (by the way,
>> asciidoctor does not process single quotes as markup) ...

Hmph, it sounds like a bug of asciidoctor we'd need to work around?

In any case, I practiced your "_<placeholder>_" rule on git-add.txt
and here is how my local HTML rendition of the updated line in the
first hunk in the attached patch looks like with "AsciiDoc 10.2.0".

    https://pasteboard.co/6koO0h0KJAjW.png

The actual HTML for the above part looks like this:

    <div class="paragraph"><p>For more details about the
    <em>&lt;pathspec&gt;</em> syntax, see the <em>pathspec</em> entry
    in <a href="gitglossary.html">gitglossary(7)</a>.</p></div>

In the first hunk, the updated "_<pathspec>_" is enclosed inside an
<em>..</em> pair, which is made into "font-style: italic" via css,
while 'pathspec' that remains is already inside <em>..</em>.

By the way, I am getting some typesetting effect from the pair of
single quotes with AsciiDoctor.  Here is the rendition of the same
part:

    https://pasteboard.co/LbDi95G8BNGv.png

The <meta name="generator"> element in the generated HTML claims it
is "Asciidoctor 2.0.20".  The actual HTML for that piece looks like
this:

    <p>For more details about the <em>&lt;pathspec&gt;</em> syntax,
    see the <em>pathspec</em> entry
    in <a href="gitglossary.html">gitglossary(7)</a>.</p>

So, perhaps we do not have to do a lot of 'word' -> _word_
replacements, hopefully?

----- >8 --------- >8 --------- >8 --------- >8 ----

Subject: [PATCH] doc: apply the new placeholder rules to git-add documentation

Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ed44c1cb31..b73071ba47 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -63,7 +63,7 @@ OPTIONS
 	to ignore removed files; use `--no-all` option if you want
 	to add modified or new files but ignore removed ones.
 +
-For more details about the <pathspec> syntax, see the 'pathspec' entry
+For more details about the _<pathspec>_ syntax, see the 'pathspec' entry
 in linkgit:gitglossary[7].
 
 -n::
@@ -119,10 +119,10 @@ apply to the index. See EDITING PATCHES below.
 -u::
 --update::
 	Update the index just where it already has an entry matching
-	<pathspec>.  This removes as well as modifies index entries to
+	_<pathspec>_.  This removes as well as modifies index entries to
 	match the working tree, but adds no new files.
 +
-If no <pathspec> is given when `-u` option is used, all
+If no _<pathspec>_ is given when `-u` option is used, all
 tracked files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
@@ -131,11 +131,11 @@ subdirectories).
 --all::
 --no-ignore-removal::
 	Update the index not only where the working tree has a file
-	matching <pathspec> but also where the index already has an
+	matching _<pathspec>_ but also where the index already has an
 	entry. This adds, modifies, and removes index entries to
 	match the working tree.
 +
-If no <pathspec> is given when `-A` option is used, all
+If no _<pathspec>_ is given when `-A` option is used, all
 files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
@@ -145,11 +145,11 @@ subdirectories).
 	Update the index by adding new files that are unknown to the
 	index and files modified in the working tree, but ignore
 	files that have been removed from the working tree.  This
-	option is a no-op when no <pathspec> is used.
+	option is a no-op when no _<pathspec>_ is used.
 +
 This option is primarily to help users who are used to older
-versions of Git, whose "git add <pathspec>..." was a synonym
-for "git add --no-all <pathspec>...", i.e. ignored removed files.
+versions of Git, whose "git add _<pathspec>_..." was a synonym
+for "git add --no-all _<pathspec>_...", i.e. ignored removed files.
 
 -N::
 --intent-to-add::
@@ -198,8 +198,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	unchanged.
 
 --pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
+	Pathspec is passed in _<file>_ instead of commandline args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
 	elements are separated by LF or CR/LF. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
