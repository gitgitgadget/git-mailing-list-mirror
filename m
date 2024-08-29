Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52418DF79
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923108; cv=none; b=FVV9pskb7nx4ZqdfkFdy0r5dHrxzDhoFPJKv2ukWoT6IGX4VVBn9fz3fwX/TJZNDrkrmRUpk7pQ1vofMpn7ikqT7bBCJtN+nfPQRzTYNitqURApVkEYL1PnROI16j2UHr4W7j4f+8VKEA/Fo0j99l1LT+1pI9h+Zt23DPXlH82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923108; c=relaxed/simple;
	bh=1GLPbkcNZz6Q9WBnO4Rha/iX8xuuocST9NfHodaiXQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzMpGFMaX0UklKszjvvCvsDv1bEHmENFx83AfwxLljPyv6gnxO08/P06h5BdcRjhPzIzAYorWCvzuEzboD1TtfxxxFATCFDvVYPCfKoovXc+sq8zslyJUkVppXatp0FKzixIZWCUAUhS04uwxye+0D1EK+GVeGd/I4pMivA1Ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=sXaV27CR; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="sXaV27CR"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id jbGiswlxTYUSUjbGpsPmjV; Thu, 29 Aug 2024 09:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1724923008;
	bh=1GLPbkcNZz6Q9WBnO4Rha/iX8xuuocST9NfHodaiXQQ=;
	h=From:To:Cc:Subject:Date;
	b=sXaV27CRvOcAp7c/31ZwO8m6Nat6D7xaKDfBsBoKxxUCvdNtWojT5cVPlGgkBJLLW
	 KxYbsjcgnrR57tYbVveR8Y1i/xf8sxhI0rLoh+SGyaBibUYrnxehfIRdhfI6jC2NJB
	 MZ8EJUHRiarmYwnQgEIK+TR0PhBbCFvUJ9KnwesrtI/L7GgHxuVMb+iZw0DteqJAwP
	 h5Yhy5pOVoSD2Sl6BVaBSfdmtIPWUMP9+rKbYgjJSatRJwZQW9OTM45BZX7kzGPuMu
	 S6Q/OTo3sZWnunEsmQ1Bwi3NmrXGWJc2wBINVnfq8RzhejmIrdfQQIA+JO2BIBsfXT
	 luY7XDvCbQkOw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=A99qPbWG c=1 sm=1 tr=0 ts=66d03c80
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ovBSteCl7yC8hWqpu0wA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] make chainlint output more newcomer-friendly
Date: Thu, 29 Aug 2024 05:16:23 -0400
Message-ID: <20240829091625.41297-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBNFnaK9tSUHwZOmrThQ3IhI5taYzIZuaCk3WO3qPam704d3d+Lk++w36d7hhnLCvFM1u+JIluNsN0EUgGdvHlSENEm3YbDdrtZeaDmDJkuqj+IILrkF
 3Gijq+NsRBbetOy3371tLfFFslHdcM6vNkNyvQhD0BJS8aWUvEUBovbll7qosQS/0Hyxst+9eJK9yDPV4exibCVRKo11z3ntxccSlFah+i6MZb6Frza3sG/E
 P76rD+h2SYp1SxJQWSi/SFA5hq0UEDQ/JV/R9jJFBng=

From: Eric Sunshine <sunshine@sunshineco.com>

For the sake of newcomers to the project, I have several times over the
last couple years thought to update t/README to explain the rather
cryptic and terse problem annotations emitted by chainlint (i.e.
"?!FOO?!"), but I never got around to it. However, a review comment[*] I
posted recently suggesting an update to CodingGuidelines reminded me of
the need to update t/README.

As such, I set about to do so but quickly realized that it would be far
more useful to newcomers for chainlint to emit friendly problem
descriptions rather than expecting users to know to consult t/README to
interpret the existing cryptic annotations. This patch series, which
improves chainlint's output, is the result of that epiphany.

[*]: https://lore.kernel.org/git/CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com/

Eric Sunshine (2):
  chainlint: make error messages self-explanatory
  chainlint: reduce annotation noise-factor

 t/chainlint.pl                                | 33 ++++++++++++++-----
 t/chainlint/arithmetic-expansion.expect       |  2 +-
 t/chainlint/block.expect                      |  8 ++---
 t/chainlint/broken-chain.expect               |  2 +-
 t/chainlint/case.expect                       |  4 +--
 t/chainlint/chain-break-false.expect          |  2 +-
 t/chainlint/chained-block.expect              |  2 +-
 t/chainlint/chained-subshell.expect           |  4 +--
 t/chainlint/command-substitution.expect       |  2 +-
 t/chainlint/complex-if-in-cuddled-loop.expect |  2 +-
 t/chainlint/cuddled.expect                    |  4 +--
 t/chainlint/for-loop.expect                   |  8 ++---
 t/chainlint/function.expect                   |  4 +--
 t/chainlint/here-doc-body-indent.expect       |  2 +-
 t/chainlint/here-doc-body-pathological.expect |  4 +--
 t/chainlint/here-doc-body.expect              |  4 +--
 t/chainlint/here-doc-double.expect            |  2 +-
 t/chainlint/here-doc-indent-operator.expect   |  2 +-
 .../here-doc-multi-line-command-subst.expect  |  2 +-
 t/chainlint/here-doc-multi-line-string.expect |  2 +-
 t/chainlint/if-condition-split.expect         |  2 +-
 t/chainlint/if-in-loop.expect                 |  4 +--
 t/chainlint/if-then-else.expect               |  4 +--
 t/chainlint/inline-comment.expect             |  2 +-
 t/chainlint/loop-detect-failure.expect        |  2 +-
 t/chainlint/loop-in-if.expect                 |  8 ++---
 t/chainlint/multi-line-string.expect          |  2 +-
 t/chainlint/negated-one-liner.expect          |  4 +--
 t/chainlint/nested-cuddled-subshell.expect    |  6 ++--
 t/chainlint/nested-here-doc.expect            |  2 +-
 t/chainlint/nested-loop-detect-failure.expect |  6 ++--
 t/chainlint/nested-subshell-comment.expect    |  2 +-
 t/chainlint/nested-subshell.expect            |  2 +-
 t/chainlint/not-heredoc.expect                |  2 +-
 t/chainlint/one-liner-for-loop.expect         |  2 +-
 t/chainlint/one-liner.expect                  |  6 ++--
 t/chainlint/pipe.expect                       |  2 +-
 t/chainlint/semicolon.expect                  | 12 +++----
 t/chainlint/subshell-here-doc.expect          |  2 +-
 t/chainlint/subshell-one-liner.expect         | 10 +++---
 t/chainlint/token-pasting.expect              |  8 ++---
 t/chainlint/unclosed-here-doc-indent.expect   |  2 +-
 t/chainlint/unclosed-here-doc.expect          |  2 +-
 t/chainlint/while-loop.expect                 |  8 ++---
 t/test-lib.sh                                 |  2 +-
 45 files changed, 108 insertions(+), 91 deletions(-)

-- 
2.46.0

