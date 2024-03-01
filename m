Received: from impout009.msg.chrl.nc.charter.net (impout009aa.msg.chrl.nc.charter.net [47.43.20.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42855C2E
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326293; cv=none; b=EHE77YBLsg7YLyLhuoeOlzf+1k4zHB7YF9QE0Xkxf7mb429WhofSPvQdPhtXuVbkIw+jSXF4hyCTn2DsqIQ5ShY2zDxGW9XoUrovh029TDYaciG2sW8DDxki43b8iPUP/OvvmJtRjZ4GRQeGY8dD5R+3fU6y7KEpTIdCL7rjnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326293; c=relaxed/simple;
	bh=08VHloWJw5yHVRv6pnhS+XyCHBpRg+ycvWm8f/tJiAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkM41Jod4nLfmCAdKUqqCF6NnaUbmUj7We8N7Rg+ERpywCxiirv5wJSCDMzA3DgSyuXbBBe53TMujBqGo7yAIU25VGe3cjqCOOi7mVdx05Cp+zkDbHx6/UjIg8lAFa63v5O3NQo3GYkVdP9veN0G7yphzvgZCsxJlAFd1phnJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=Z/EJEcbv; arc=none smtp.client-ip=47.43.20.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="Z/EJEcbv"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id g9pErOPMqqTrhg9pJr5KdW; Fri, 01 Mar 2024 20:49:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1709326194;
	bh=08VHloWJw5yHVRv6pnhS+XyCHBpRg+ycvWm8f/tJiAo=;
	h=From:To:Cc:Subject:Date;
	b=Z/EJEcbvEhAcPsdyCCCTsw5/A7cVwjDBvnyQe4zNQY26mcFvwPbPoCfeyQY4Acuw8
	 Fl1XKWslTup5ctOFVIkYOCWK7wLfiy4QwkII0WgVpUmMK2ieWZ899O7iCSX27LMmaH
	 oBuSQc7/mIZ4C5FETTEdXu4SdQwUJGbU6eUOSptApqL68YfCm8pOHgZthxO9jdszoM
	 kA5niXhuz4JgEPvmnvq/vd2QjS6dijyHgmlpSGY70hAIeq5mX+4ibp/h1d42RYGXMR
	 Lu0nfYLnQ2KUl3Mpez9iNzqrCGWhZOv86kMH7mG9kI+TQGSTw6s5Sq6smnALGtCaJQ
	 OXy+aqxruv2pQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Cue5cG4D c=1 sm=1 tr=0 ts=65e23f72
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Oh1dYBxbD8gYMEriIqMA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aryan Gupta <garyan447@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] test-lib-functions: simplify `test_file_not_empty` failure message
Date: Fri,  1 Mar 2024 15:49:22 -0500
Message-ID: <20240301204922.40304-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM0hwpUYGCLhU3Lb66CTXXhrPbAwxMu8KO9kwKPxhlkuPYYjbBI4lxsAPx19d6EXfLY957M6CIODeuXI3gEOIPnaSv5SlXIcv5zrrmz6fVk7Y1wSBUE4
 itSf+Gvf05he5gAPD1xPxt5g/llCf4fWxFR75C8kNRVVLFYM5Gsc11JowaKeC7Z+hioXOsr0zIUv9tLCzHc2AllVo9mWIOV46gvzVqS2Ie8wo8Z7iH9Bk54q
 gBNAlLYUpuEuL4nx8j1aHcPdUO0sXl3/pZ5qxa+UnJpKEOU+7xZDKzJ1vlsSfxGV

From: Eric Sunshine <sunshine@sunshineco.com>

The function `test_file_not_empty` asserts that a file exists and is not
empty. When the assertion fails, it complains:

    'foo' is not a non-empty file.

which is difficult to interpret due to the double-negative. To make it
easier to understand the problem, simplify the message by dropping the
double-negative and stating the problem more directly:

    'foo' is empty but should not be

(The full-stop is also dropped from the message to reflect the style of
messages issued by other `test_path_*` functions.)

Note: Technically, the revised message is slightly less accurate since
the function asserts both that the file exists and that it is non-empty,
but the new message talks only about the emptiness of the file, not
whether it exists. A more accurate message might be "'foo' is empty but
should not be (or doesn't exist)", but that's unnecessarily long-winded
and adds little information that the test author couldn't discover by
noticing the file's absence.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a tangential follow-up to the discussion at [1].

[1]: https://lore.kernel.org/git/CAPig+cQ+JNBwydUq0CsTZGs8mHs3L3fJDuSosd+-WdKwWWw=gg@mail.gmail.com/

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b5eaf7fdc1..9e97b324c5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -991,7 +991,7 @@ test_file_not_empty () {
 	test "$#" = 2 && BUG "2 param"
 	if ! test -s "$1"
 	then
-		echo "'$1' is not a non-empty file."
+		echo "'$1' is empty but should not be"
 		false
 	fi
 }
-- 
2.44.0

