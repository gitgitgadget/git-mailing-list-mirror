Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9ABA56
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994673; cv=none; b=a94W53dcVsnO0y9Q50EPEix28s5HCBshGgu+bCYjmoT6DQSc27aWG6mwJQpKBK/Umz9v1MrmH1T4PnNXIc7Iv3t6z45m5x99oio/h90AFuZa1z0LIH/bqkN9WZyHFucRlY4xBVvezlnIm3kzDhU7Y2itHZtzkieg+IHt37y8t+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994673; c=relaxed/simple;
	bh=YIUhXW+C/JB07WLAmNfmtYhzGr2TeGfebB8K7OOzoWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBulyG88B2PYkYNMezMboe9885IO2krPGc1IACCTxRD5JZu72ycdUDSBLMoYh5jsXnY3QnpVuiKxF64WjQTGWgcAFqJxCHkNcBsFy7Uj7F8SI/vyjc/4s6wNjq25fUdrBd0bqM1L0vMgLk+GknUbpvBwCmbE/IwR5gpoDj+ekW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hyMooIn2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hyMooIn2"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710994668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUVtXqtJLdIv1lrp2qgr4PuKirzPcmYC/qK9a4RR4UM=;
	b=hyMooIn277Vw45Amr5DTcjmTjPrhxgf7HBWadObEmucdHdOtIRISSqPmpzuNkzz0T0K2ZE
	XNV9zgbbv3qAGouvJX0CmfuOugy6UUw7NqmE6pQqwuk/cABovjTPRtACXf/e2oET4FAZzY
	asXnjrZL159YWSAPrFGZu5Li+ROxpe9Y8slrHcqM2V+9QTkEclY5iegCgLk06uBPlKyVSh
	pukWk4NqG3kyUmrFNbvwFMzl7g9GXgmNkx4BwlaJK0pAOjdtt0bXb2oHcDXVsxVj0fnRom
	9Q0KBxVX0xkEr9lDN5G5+bHCHnWs5OjCra44ymIkfhcgwKJ0kNP8vG5wFSYxYQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v4 4/4] config.txt: describe handling of whitespace further
Date: Thu, 21 Mar 2024 05:17:43 +0100
Message-Id: <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710994548.git.dsimic@manjaro.org>
References: <cover.1710994548.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Make it more clear what the whitespace characters are in the context of git
configuration files, and significantly improve the description of the leading
and trailing whitespace handling, especially how it works out together with
the presence of inline comments.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v4:
        - Improved the wording and accuracy of the description of whitespace
          character handling, as discussed with Junio, [1][2] by taking a more
          radical approach and rewriting an entire paragraph, because it has
          reached the point where "patching the patchwork" no longer worked;
          I'm quite happy with the way it turned out this time
        - Expanded the patch description a tiny bit
        - Added a Helped-by tag
    
    Changes in v3:
        - Patch description was expanded a bit, to make it more on point
        - No changes to the documentation were introduced
    
    Changes in v2:
        - No changes were introduced
    
    [1] https://lore.kernel.org/git/xmqqttl1js1o.fsf@gitster.g/
    [2] https://lore.kernel.org/git/ce041191a245ff888b1710cdcaad9e61@manjaro.org/

 Documentation/config.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906c..9d4e99393530 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -22,9 +22,10 @@ multivalued.
 Syntax
 ~~~~~~
 
-The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored.  The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored.
+The syntax is fairly flexible and permissive.  Whitespace characters,
+which in this context are the space character (SP) and the horizontal
+tabulation (HT), are mostly ignored.  The '#' and ';' characters begin
+comments to the end of line.  Blank lines are ignored.
 
 The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
@@ -63,13 +64,15 @@ the variable is the boolean "true").
 The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
+
 A line that defines a value can be continued to the next line by
-ending it with a `\`; the backslash and the end-of-line are
-stripped.  Leading whitespaces after 'name =', the remainder of the
-line after the first comment character '#' or ';', and trailing
-whitespaces of the line are discarded unless they are enclosed in
-double quotes.  Internal whitespaces within the value are retained
-verbatim.
+ending it with a `\`; the backslash and the end-of-line are stripped.
+Leading whitespace characters before 'name =' are discarded.
+The portion of the line after the first comment character, including
+the comment character itself, is discarded.  Unless enclosed in double
+quotation marks (`"`), any leading or trailing whitespace characters
+surrounding 'value' are discarded.  Internal whitespace characters
+within 'value' are retained verbatim.
 
 Inside double quotes, double quote `"` and backslash `\` characters
 must be escaped: use `\"` for `"` and `\\` for `\`.
