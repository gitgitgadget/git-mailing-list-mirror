Received: from 15.mo581.mail-out.ovh.net (15.mo581.mail-out.ovh.net [87.98.180.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73891F1902
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.180.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506819; cv=none; b=pEGyWolA5+i2+DBueRLRSLz67U8Ulc/bExKUgr0PdozcsMIqDnU4JHyx6vKUNozpyBBAq3pWBDGut8fYignKdg75c5txE+oHezo075Hq4561mVY4g6ySQaNNPjQDgGtkWGsBA0moL7wazcL/iJkhIkl9YklKwyWsgsPr27B9ARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506819; c=relaxed/simple;
	bh=Tl/xrvFsl3tbQDPx2x4hA5KeqmpqAVECFaaI4ov0QkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sknKyzOt2eMyOYCM1FMOpsIUb7dn2HYTGdzAmsLcp+WxlSjwrZDSVZlGVzfMkSRNwTBmTM1PngD5UZajd6TinOOy+tJKRujxnjracIkI3m1+aZLtlDLcNuGwMU2gytMkiawAjjXEqiPU7jMHrJi3a2JGwFykp7hDNVu5KBdTyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=free.fr; spf=fail smtp.mailfrom=free.fr; arc=none smtp.client-ip=87.98.180.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=free.fr
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.140.88])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4ZRld218G0z1QTY
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 11:09:26 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-ln7vr (unknown [10.110.113.149])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A83921FECD;
	Tue,  1 Apr 2025 11:09:25 +0000 (UTC)
Received: from scantech.com ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-ln7vr with ESMTPSA
	id deUOI2XJ62cq+gYAQfn7Mg
	(envelope-from <jn.avila@free.fr>); Tue, 01 Apr 2025 11:09:25 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R005f46b71ef-d320-4cf6-845f-98c7d5fd312b,
                    6DECD37ECDB00104AC403732D8C6E2B6AAE8D13B) smtp.auth=jean-noel.avila@scantech.com
X-OVh-ClientIp:141.255.129.53
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
Date: Tue,  1 Apr 2025 13:08:11 +0200
Message-ID: <20250401110811.117851-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <Z+rUsCW0zEb8kAK8@szeder.dev>
References: <Z+rUsCW0zEb8kAK8@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14512286850094147367
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedviedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflvggrnhdqpfhotohlucetvhhilhgruceojhhnrdgrvhhilhgrsehfrhgvvgdrfhhrqeenucggtffrrghtthgvrhhnpeelieeujeelgffhlefgleelleffudeggfefgfdtteeuffekvdehkefhvefggffhieenucffohhmrghinheprhgsrdhinhdplhhinhgvshdrmhgrphenucfkphepuddvjedrtddrtddruddpudeguddrvdehhedruddvledrheefpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjnhdrrghvihhlrgesfhhrvggvrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedumgdpmhhouggvpehsmhhtphhouhht

The processing of triple dot notation is tricky because it can be
mis-interpreted as an ellipsis.

Another issue is that the formatting of synopsis paragraph in
Asciidoctor spits out another asciidoc formatted text where verbatim
text formatted with backquotes must have surrounding separators in
order to be properly detected, even if they are sticking to another
text.

The special processing of the ellipsis is now complete and takes into
account the case of `git-mv <source>... <dest>`

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoctor-extensions.rb.in | 8 +++++---
 Documentation/diff-generate-patch.adoc     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index 2494f17a51..0ded90c28b 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -49,7 +49,7 @@ module Git
 
       def process parent, reader, attrs
         outlines = reader.lines.map do |l|
-          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
+          l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
            .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
            .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
            .gsub(']', ']{empty}')
@@ -72,6 +72,7 @@ module Git
           %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
         elsif type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
+              .gsub(/^\.\.\.?$/, '<literal>\0</literal>\2')
               .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
@@ -100,8 +101,9 @@ module Git
       def convert_inline_quoted node
         if node.type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
-              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
+            .gsub(/^\.\.\.?$/, '<code>\0</code>')
+            .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
+            .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
 
         else
           open, close, tag = QUOTE_TAGS[node.type]
diff --git a/Documentation/diff-generate-patch.adoc b/Documentation/diff-generate-patch.adoc
index e5c813c96f..7b6cdd1980 100644
--- a/Documentation/diff-generate-patch.adoc
+++ b/Documentation/diff-generate-patch.adoc
@@ -138,7 +138,7 @@ or like this (when the `--cc` option is used):
 +
 [synopsis]
 index <hash>,<hash>..<hash>
-mode <mode>,<mode>`..`<mode>
+mode <mode>,<mode>..<mode>
 new file mode <mode>
 deleted file mode <mode>,<mode>
 +
-- 
2.49.0

