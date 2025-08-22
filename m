Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C116296BD1
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888750; cv=none; b=o9VWHaWwJGab0V/9XNH+s5m8hWXNg5nAT6N53GIAtwgDG4d8RlqN9YAMHnoFHcNlil7wwP0pcNjU0BYjKUYbCPPAygZCFYzPzq0j9jeozZOUliyXO2IkbbUT+lIbU02p8R892hk1RbopkRABzP+EUrCIIlDsb3wg7cHeo5ZV2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888750; c=relaxed/simple;
	bh=Zw3itV81oO1yLP8Im10MH4HtD00Qqzqp861zZbK8KVE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=mgtJlSH6exQlboV7QLfgiO2JYHOkLUI7ar13TpbPjYL1UilhDeH+P7SdZ1kLcfZ1GX99QM56QftgHn4CeSvvrR75RtnZmRIm85CV33pHtVZTX+KH1kmXJloHMfj2SYWQipzQ9VLQhnmK6tRIfgNRGAs+aSrCyS/C1ByV8Fi+X2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4c7q7F3ppZzRnmN
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:52:25 +0200 (CEST)
Message-ID: <6ec34bbc-6811-41fa-aa06-1d54fd2acb0c@kdbg.org>
Date: Fri, 22 Aug 2025 20:52:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] doc/format-patch: adjust Thunderbird MUA hint to new add-on
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are three tips how to compose a non-line-wrapped patch with
Thunderbird. The first one suggests use of an add-on. The one
referenced has long been superseded by a different one. Update the
link to the new one. Mention that additional configuration is
required to make the add-on work.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/git-format-patch.adoc | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index a8b53db9a6..a9cf37182e 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -587,13 +587,19 @@ an external editor to keep Thunderbird from mangling the patches.
 Approach #1 (add-on)
 ^^^^^^^^^^^^^^^^^^^^
 
-Install the Toggle Word Wrap add-on that is available from
-https://addons.mozilla.org/thunderbird/addon/toggle-word-wrap/
-It adds a menu entry "Enable Word Wrap" in the composer's "Options" menu
+Install the Toggle Line Wrap add-on that is available from
+https://addons.thunderbird.net/thunderbird/addon/toggle-line-wrap
+It adds a button "Line Wrap" to the composer's toolbar
 that you can tick off. Now you can compose the message as you otherwise do
 (cut + paste, 'git format-patch' | 'git imap-send', etc), but you have to
 insert line breaks manually in any text that you type.
 
+As a bonus feature, the add-on can detect patch text in the composer
+and warns when line wrapping has not yet been turned off.
+
+The add-on requires a few tweaks of the advanced configuration
+(about:config). These are listed on the download page.
+
 Approach #2 (configuration)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Three steps:
-- 
2.51.0.205.g9a02ae2892

