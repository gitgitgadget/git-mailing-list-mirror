Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156554;
	b=bOf+QUsQcOW1PnmHe9zloswNwJUASIZ8l8P5g01dFLb3+IWAh17DPG6Mp0fKqPu5Et3J
	 R9Hpp5sUtEFCrRKk+0vA9Sq/XNmlnCPkz5ymZadZW9+sZmbNgCs9CCWNlsUj8g9aNe13M
	 OdGRBBHMaoAIUVGvdotB9IlyuvyEmyH9JbwaxWaM23+fPDICRm1L/gB5QVbgec5Qowlgm
	 SAQBUnqy9ljNGMgezMwrI0MFPVPEPRZyFOMQ/yol++ujZI+le+Ebsp3ou4mDYjXAt8pCN
	 vhFsZNJyLdCczYCnUTWkRqwu06B3tN/vC4raIpUZ7XHQHkQSuTQ9++LNNx7RMVrAdlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156554;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=AZSS7tnXxO4YCcthoMbJ1KbS9tgmkdL6X8M2uyZMQZQ=;
	b=146nrg2ZEENsm2fqfz51VsipkKDQHjEdDVKxHZOwo0encGJB7BdrZ/NOKIWHVWD1L5Ia
	 7fOORJo6K6AE+jayV7VBH1gzCu9l/ANEG94FRdh+2Ls8e+OyWqhud872aVCOAmwPUpUOo
	 s9E6+NCrj/UVty1y8uIn6zUnn+ZzqoZVFB9CkqnUjngH9D8jspdhQpr0bddmkDCW5/s/H
	 qeVsXWeVOWBDW42TlehwWFILc7b2xuVbRIk9nQwhHga5pEcA+sN9yRUywlCJhMxmYGy8S
	 Vx0QcjUlpfiqg4+FO2O7Rir0qwzVhU1OI69ToY49THZvWZ8Oq5fYcZUyyvT+/Cj0Rkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=JQPTSiZb;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E951606A320
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 16:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E951606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=JQPTSiZb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794156542; x=1794761342; i=tboegi@web.de;
	bh=AZSS7tnXxO4YCcthoMbJ1KbS9tgmkdL6X8M2uyZMQZQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JQPTSiZbz24gVt+5U+TSSYXeoCS1xTvMlWtSu1TkiTvRzDdg3RZTibmpEojGqFN5
	 dah3nv+WKE4vyblJSziqftwuJmUGoRe/DB4JfqR0AaYdhQOFut/UUaZnG5Ab4sfll
	 JVD+3GU+GebkUsb2UDgT3Oq9+wD/ESVc8ke/Kr+gFZWKM0WVxB2fLyl22yfbNQ9vi
	 Avz9CThJK65M59dRfBkaJ4evW6yBjCQTt6J+o1JJFz0CQcwAj4H40vlw0M5WKkEd2
	 H8un96a1kJ6WU3/YZqjcAnhmSNeD1j7WPqFCY3vCVW1NsySrR4NHvujZS2rNuq9lq
	 QtlVqF/0rNMTWGaBxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9431-1wNvp3087b-015Bwo; Sun, 08
 Nov 2026 17:49:02 +0100
Date: Sun, 8 Nov 2026 17:49:01 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] t0027: optimize how we reset repository state
Message-ID: <20261108164901.GA29213@tb-raspi4>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
 <20261106-pks-gitlab-ci-speedups-v1-4-1fa0374c7287@pks.im>
 <xmqqv769kgqa.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv769kgqa.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:9fieM8qDHTHpnlRfTXXnwmo20cBq+6nR6R7GhnPy4/AKLOuGpgN
 gNqTKjkmsukiu1heHYjIDaY2JPRJ20lJvhtPUScVZi/iz/ev2hiw2DaPLD9xpOa2A5OrUdZ
 mMTgXg4XM2OR1xiJ5fkrhsY+uX9kgOvp+QpUY2bdY1OqCN4lEnlXnVvw06aVzA0akXKN/41
 Ltz0tWvjbNmoRPL3vwkhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N14lBYgR80E=;7wb1CL2T9ix/JP5b8Q2ttZC2Rkh
 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
 orf0jRBMQiE6AeG
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 09:33:01AM -0800, Junio C Hamano wrote:
> Hmph, don't we want avoid hand-expand the list of files even though
> we may want to use one "rm -f" and another "git checkout" command
> to work on them?  IOW,
>=20
> 	paths=3D
> 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> 	do
> 		paths=3D${paths:+"$paths "}crlf_false_attr__$f.txt
> 	done
> 	test_expect_success "setup checkout ${ceol:+ with -c core.eol=3D$ceol}"=
 '
> 		rm -f $paths &&
> 		git ${ceol:+-c core.eol=3D$ceol} checkout -- $paths
> 	'

"Wow, so it can go" - a well working, but slow code is speed up so much.

I used the following (before reading the suggestion from Junio)
and the execution time here on an older MacOs dropped from 71 seconds to 5=
4 seconds.

    test_expect_success "setup file checkout ${ceol:+ with -c core.eol=3D$=
ceol}"  '
        files=3D"\
           crlf_false_attr__LF.txt \
           crlf_false_attr__CRLF.txt \
           crlf_false_attr__LF_mix_CR.txt \
           crlf_false_attr__CRLF_mix_LF.txt \
           crlf_false_attr__LF_nul.txt" &&
        rm -fv $files &&
        git ${ceol:+-c core.eol=3D$ceol} checkout -- $files
    '
