Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7745974
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id EF2prKfhsAB4kEF2rrpKsz; Fri, 15 Dec 2023 20:44:29 +0000
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=LdEvVxTi c=1 sm=1 tr=0 ts=657cbaae
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=pGLkceISAAAA:8 a=ux2r5jEI9VBPf_-RbnIA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Benjamin Lehmann <ben.lehmann@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-add.txt: add missing short option -A to synopsis
Date: Fri, 15 Dec 2023 15:43:33 -0500
Message-ID: <20231215204333.1253-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
References: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMN95I1BpHDcl8Bt+xI4N7QzmgGBmdGHUVCvQdvwNyoX9ydsLqzcRrTxrVETktf5VPsThxWAscG+iyJclaRjzHcLotyYW3kVTt3J4XXNPPSGj7+Y6q8c
 1zN2j/vSz6XI7/TFXaeM9wGP/RJ1Bfm173XQvGMFMCl+GeB8Yux2XMeMISVAm6v5Oh91vOrsBds/5Lsb9cVm1aMGPn+vkk9De1e8IwcWl2PFTzGk2VVCBO3R
 DeKxIl2xMCrNHHPJ2s1B//oynpfwZgxIdGBZ76ivn7A=

From: Eric Sunshine <sunshine@sunshineco.com>

With one exception, the synopsis for `git add` consistently lists the
short counterpart alongside the long-form of each option (for instance,
"[--edit | -e]"). The exception is that -A is not mentioned alongside
--all. Fix this inconsistency

Reported-by: Benjamin Lehmann <ben.lehmann@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

An alternative would be to collapse the synopsis to:

    'git add' <options> [--] [<pathspec>...]

as has been done for other command documentation, however doing so would
throw away at-a-glance clues about which options are mutually exclusive,
so adding the missing -A to the synopsis seems preferable (for now, at
least).

 Documentation/git-add.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ed44c1cb31..3d2e670716 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--sparse]
+	  [--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	  [--] [<pathspec>...]
-- 
2.43.0

