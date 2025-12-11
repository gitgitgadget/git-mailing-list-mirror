Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A8298CB7
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463656; cv=none; b=p3C6YZu6JpHp0Pxsx6bisw7c7ky6bQiAGH0P/dP7b2/4c/8RRW5h4GsWD7Kflpt2EIdLV6fvgXgSBAOX+TiEQILYLef7fbBQArQELjKIeHeBf4NbLXmsbWIAH9cqN6dZa5JZa3gbzfqtrq+iyCTIiBVEnru10PzZbfCbZToYy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463656; c=relaxed/simple;
	bh=lxe7xg/q4stGX2dYep8ywZhkzM7J9OZfro6+qtK8tmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYbNiR7Fim3BbRZiz4hIYxgz3rEiug6vnHPohd65NZ86OJ4rwyt0GlycAks4VQjsebGoTKoiNS/ew3+L4Rub65553BUbnuMVWH6iOzo9q7xys0Cam3eqYjHQ65U/RXCO34V8JZc0xI8gWKWWkeHbe9qHH3PshuTU+wV7uXMsUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=V3XOYyeu; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="V3XOYyeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765463641; x=1766068441; i=l.s.r@web.de;
	bh=VJstabdjFbjlJNP5kotcAhhz9IgSv/Dvj2tA3Z3D8zk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V3XOYyeu2EnDW0u97BQzNGdwoAxrTRhqKPPDO5Ur9N6aHQlgUc4uS5KshyoQ+Uif
	 RVF6NqackBOSJI/a1h7BXnZTO0lS15cwfkT39RCzrjLGN44R7oteP7X2vP/E1e0lX
	 +ucIR924o9n2cxlldyZMPEr8ID1nj/czh5doZmm8677Yo0HLvPaeYtfIavu4HNxL/
	 BrRlF9zpT2xGVOhKWkESHbSPwntVhBbkBRtoy4aVtK2uP8IdObSZj0N9JPHlGQ1qW
	 3IzbsFfcVtQAyNRHeyDmQdc2rs/xeOrGv/R2cInmj6OkZ+6zoWjy1WRwz1LNPBu1W
	 OuudCeYLmN1OJ7eWTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1vPZ0L3jtZ-00A0Ak; Thu, 11
 Dec 2025 15:34:00 +0100
Message-ID: <5308d067-6c3c-4694-a30d-86a561704e6c@web.de>
Date: Thu, 11 Dec 2025 15:34:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <aTn92yqtSDyVoLgh@fruit.crustytoothpaste.net> <xmqqecp1hhi7.fsf@gitster.g>
 <xmqqfr9he3v7.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfr9he3v7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L63a8wBPLdZcKLNzsn1B+rZUs2e23AkLhvLCo8q4UrZke4ss4GS
 DFXzWIjl8QN31nIlvFQGE20t3aDhdI1mIU3KuVoGc7Mgfc9gKE25+/5RzMuio56RvO8F+NO
 Unsu7wb9kdxd4bKsYSecIOX2nnCr1BZHAixBy3YM6M0H9F94IS43nzasryPoA0+oueAyVDM
 dUs7+MYTxdynZgRiPilcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fAxtG0WXxqY=;eTRpWVqwhY4OZrm5E9SGEHgyV8w
 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

On 12/11/25 10:59 AM, Junio C Hamano wrote:
>=20
> Does anybody know if a purely vanilla installation of macOS, without
> any third-party software collection like homebrewk, is supposed to
> be even serviceable?  That is, if somebody at Apple builds a version
> of Git that they ship themselves (they do, don't they?), can they
> untar the latest tarball on a vanilla macOS box, type "make test",
> and expect it to pass?

It seems so.  https://opensource.apple.com/releases/ points to
https://github.com/apple-oss-distributions/Git.  The latest tag is close
to v2.50.1:

$ git diff --stat -w v2.50.1 Git-155:src/git ':(exclude)*.git*'
 Documentation/fsck-msgids.adoc                   | 12 ------------
 Makefile                                         |  1 +
 attr.c                                           | 11 +++++++++++
 builtin/help.c                                   |  3 +--
 config.c                                         | 13 +++++++++++++
 config.h                                         |  3 +++
 generate-python.sh                               |  2 ++
 git-mergetool--lib.sh                            |  6 ++++--
 git-svn.perl                                     | 30 +++++++++++++++++++=
+++++++++++
 http.c                                           |  2 ++
 perl/header_templates/runtime_prefix.template.pl | 25 +++++++++++++++++++=
++++++
 sha1collisiondetection                           |  1 -
 t/t4014-format-patch.sh                          |  3 +--
 t/test-lib.sh                                    |  3 +++
 usage.c                                          | 20 +++++++++++++++++++=
+
 15 files changed, 116 insertions(+), 19 deletions(-)

Their top-level Makefile sets NO_GETTEXT, NO_FINK and NO_DARWIN_PORTS.

Ren=C3=A9

