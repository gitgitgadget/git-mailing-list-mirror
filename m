Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net [188.165.48.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AD18A93C
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.48.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425789; cv=none; b=bTAsQzOwcmF320tBIrOQ+7ro0jJQcQwl10+rPqMYmFuKoHPTRvYSwT1CfVSnJEC+mSizPRIXK+JVPBTxeTnw7KzcLFwFJp8JM3pdUGxtNRATzUcOafl2coursE0mwXiY1jHhaTMpQZTKe70H4cCoHcr/+HW6/N++FFPUOx4qXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425789; c=relaxed/simple;
	bh=shuRSNp5D/yMerwNi4E/V/lRu/Hu9V153v7EQyNea64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEpetKUpGXbwxvgHnsJt77ugvA5VCQCT3xlc95XmEPrOgLzPoQb3yCvX4nwdwEwCBIBKQdC28pWvzJxnCjl8UJTI8uV6fJd9U07ax5CI3BvnqhdndKvj/oErLNS6uT+F3yKzJ1KTkUNowMZauM3U+8YtThdD0phnSr0RZzQYjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=free.fr; spf=fail smtp.mailfrom=free.fr; arc=none smtp.client-ip=188.165.48.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=free.fr
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.140.140])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4ZRB2p0xHRz1Ztd
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 12:56:18 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-47c44 (unknown [10.110.178.103])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9B1C71FED7;
	Mon, 31 Mar 2025 12:56:17 +0000 (UTC)
Received: from scantech.com ([37.59.142.110])
	by ghost-submission-5b5ff79f4f-47c44 with ESMTPSA
	id w6wgHvGQ6mdkLwgARPA38Q
	(envelope-from <jn.avila@free.fr>); Mon, 31 Mar 2025 12:56:17 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S004e89b407b-a69f-4fe9-a0e5-50b5ddc606b0,
                    E7FADD8399107D4A4003697F78FE55E312EC12BD) smtp.auth=jean-noel.avila@scantech.com
X-OVh-ClientIp:141.255.129.53
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
Date: Mon, 31 Mar 2025 14:55:51 +0200
Message-ID: <20250331125608.92419-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <Z+piTsfJdx4BG2oI@szeder.dev>
References: <Z+piTsfJdx4BG2oI@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10444410486354814759
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflvggrnhdqpfhotohlucetvhhilhgruceojhhnrdgrvhhilhgrsehfrhgvvgdrfhhrqeenucggtffrrghtthgvrhhnpeelieeujeelgffhlefgleelleffudeggfefgfdtteeuffekvdehkefhvefggffhieenucffohhmrghinheprhgsrdhinhdplhhinhgvshdrmhgrphenucfkphepuddvjedrtddrtddruddpudeguddrvdehhedruddvledrheefpdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjnhdrrghvihhlrgesfhhrvggvrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtmgdpmhhouggvpehsmhhtphhouhht

The processing of triple dot notation is tricky because it can be
mis-interpreted as an ellipsis. The special processing of the ellipsis
is now complete and takes into account the case of
`git-mv <source>... <dest>`

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoctor-extensions.rb.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index 2494f17a51..f2be66c4ad 100644
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
+                        .gsub(/^\.\.\.?$/, '<literal>\0</literal>\2')
               .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
@@ -100,6 +101,7 @@ module Git
       def convert_inline_quoted node
         if node.type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
+            .gsub(/^\.\.\.?$/, '<code>\0</code>')
               .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
 
-- 
2.49.0

