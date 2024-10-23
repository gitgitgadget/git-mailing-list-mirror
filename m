Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E591804E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644367; cv=none; b=TEfOPcnvG5noUX7b+0vynaPP8RrHOr8M21w1qk4F2SlhYTZHJVtFjkUQWzPyKq8i5qYSmK7S2LSl4ectgzeZ7v/NlcZLGFsJ14NeywZW8fdLzlZRpkdvJ9dJ9N6NPdIACO7HXDe+E1FdB/8aRy+ClnrHZmnNhjSsxnydut2Xh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644367; c=relaxed/simple;
	bh=K/K3BaL1535mNhkVn5fu0ImoFNepTtjTMcnebYI2QIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU20hCiByqlMp+GECm28KJ2XSmtxPNE0PiM7CuzaAwy6PEA28eu1RUiCXxGjCKXAXh5mP1NrUBrlUITHORnRZYdjTNuVNY6idEXs+hBMCOlCvbVXiWQGGBQ0+voYagmp161Ruu1GFlbsuUr8b0e0j3NkD+6PYfiA3DiAVUCDcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MUxsQA2g; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MUxsQA2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=K/K3BaL1535mNhkVn5fu0ImoFNepTtjTMcnebYI2QIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=MUxsQA2g17WZueMj611pY8b9lI9hOdkK68Ha4qAhCHqvAC1Q6gF7mrHzmJgmxO8C5
	 WgEAwhB5pZJhiL0OiQgcknzdCI2cAGJ/W7m5oHM3CgrrUvEepdPok87chIIdvfVYiM
	 wZsAwDVtC+rZ6XCBS22DY3AiR5OhE9hXq3VBg92r2oWy5yYHGXuA9gBp+APwdFnlAL
	 lndFoeVJeywxhhCD+9qEU++gQ7XR8LlUGpl8EQFKL+NUo94kVLd34KmaCwPOrxpjau
	 GjTf5ZmAlTkDxLncSTElLPYBicEZeFDtn0lxP6zuRTiqwsxoEEwCJfkI0Me3QKl6xB
	 PS4tOEKoEJywohd547f2zNyfM5elnB5UF69tdl+MNHYzjIS/PXjyxYTrARaNLJgqeK
	 gxIsXXfYJVKNKxbNfrSz2WlVK13JqVraV2bDGzlMQUYWTnWQKzrWatKVO12bucPN1t
	 NNEAg3eb+3aCG6RbYa1Sat5KatwD3R9uKSZuRqutyfyXWw/uUsn
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1D1D620031;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 00/12] Update versions of libcurl and Perl
Date: Wed, 23 Oct 2024 00:45:48 +0000
Message-ID: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a long time, we ended up with protracted discussions on the mailing
list about what versions of software we should support.  Oftentimes, we
broke long-obsolete operating system versions by using something shipped
slightly more recently.

Fortunately, we now have a platform support policy to guide us in our
approach to dependencies, so we can make updates without worrying about
breaking systems that have not received security support in several
years.

This series updates our requirements for libcurl to 7.61.0 (the version
in RHEL 8) and for Perl to 5.26.0 (the version in 15.6).  I considered
the mainstream LTS versions of RHEL, Debian, Ubuntu, and SLES, but
omitted consideration of paid support extended LTS, since we cannot
expect Git developers to have to pay a large corporation lots of money
just to test functionality.  This is in conformance with our policy,
which states that versions must be "in line with the version used by
other long-term-support distributions", which does not include extended
LTS distributions.

I plan to send a future series that will add some additional CI jobs in
order to be sure that we're testing the major supported distros and
avoid regressions.

Changes from v1:
* Use require instead of use for Perl to avoid enabling features.
* Use v5.26 instead of 5.026000.
* Squash the INSTALL documentation into the Perl changes.

brian m. carlson (12):
  git-curl-compat: remove check for curl 7.21.5
  git-curl-compat: remove check for curl 7.25.0
  git-curl-compat: remove check for curl 7.34.0
  git-curl-compat: remove check for curl 7.39.0
  git-curl-compat: remove check for curl 7.43.0
  git-curl-compat: remove check for curl 7.44.0
  git-curl-compat: remove check for curl 7.52.0
  git-curl-compat: remove check for curl 7.53.0
  git-curl-compat: remove check for curl 7.56.0
  INSTALL: document requirement for libcurl 7.61.0
  Require Perl 5.26.0
  gitweb: make use of s///r

 INSTALL                                 | 13 +---
 contrib/diff-highlight/DiffHighlight.pm |  2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      |  2 +-
 git-archimport.perl                     |  2 +-
 git-curl-compat.h                       | 98 -------------------------
 git-cvsexportcommit.perl                |  2 +-
 git-cvsimport.perl                      |  2 +-
 git-cvsserver.perl                      |  2 +-
 git-send-email.perl                     |  2 +-
 git-svn.perl                            |  2 +-
 gitweb/gitweb.perl                      |  6 +-
 http.c                                  | 58 ---------------
 imap-send.c                             |  4 -
 perl/Git.pm                             |  2 +-
 perl/Git/I18N.pm                        |  2 +-
 perl/Git/LoadCPAN.pm                    |  2 +-
 perl/Git/Packet.pm                      |  2 +-
 t/t0202/test.pl                         |  2 +-
 t/t5562/invoke-with-content-length.pl   |  2 +-
 t/t9700/test.pl                         |  2 +-
 t/test-terminal.perl                    |  2 +-
 21 files changed, 23 insertions(+), 188 deletions(-)

