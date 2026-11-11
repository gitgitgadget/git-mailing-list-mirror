Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394096;
	b=Qki8pA+uyZYrS4N0mnIilEllwJ+pbG7eAT2yoiJlGhj0vE7tAJV/0K7llhlS/Lj3BIlY
	 3y1Iow65rdOTwOzHxsyxYsufqQt0bvnsQbaE2GHsqB5D01mUkhvmeiZExbG9Y+pJnB9jb
	 dSAwzVPUhZSwu0HpOiP2qFlDnb05pMgy4aLtK5SWS8tuaQNR+fs+i4gtt4xOCZlm7zltP
	 LqjD8ECuJO+jVnwzw9dlzq7tUuhTBAtWATdTJgEibaM1DLfurIq+laZ5fs0F+GBxZgcyz
	 GqNULLyi8EiPZbvZ1vSVqhnuXI+PNExndTx8Fn8sGU09DZr1Qsb0H1b7/JQQszEM8Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394096;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=niNvpPuIkEImyL2OGNpWautwIIBpc4uUlXKcVcTjH14=;
	b=Z50a1ypfL4aPr/+BnQ7jiViy1ry7A+lfs551eT4Lb0du8vbs72VR49x8Fu7tgjIFFX1i
	 OHMSamzODyYKCBVb1AFTYAwZeZjmvEFiqgTRU9xe/YJ3K6cUSnk9c4LrdCKzXMC7dqGBB
	 gWPwYyP7Hf0UUUazwHpXImNZldGgVcJeDAbh+MzV7PspxEOVOXwAtR5BJtUzSBokDDuvW
	 rkeZbXAKJubUhPNx86R05m8Ow9AlIy4PPF5cUIWSFaKVDWAMe0eP3pyWIcF6NvCmPzch+
	 71Lc909b2y7rCKJqNNE4NEnClDLyB8Sk/O+i9hHhWJdyTfYjMa+L1hNSgxNEU18Drjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=d24MDFJX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xrw1XplP;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61555606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61555606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=d24MDFJX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xrw1XplP
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A632C140013F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Nov 2026 05:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394095;
	 x=1794480495; bh=niNvpPuIkEImyL2OGNpWautwIIBpc4uUlXKcVcTjH14=; b=
	d24MDFJXzCmA5T+cANimmkG2BsTkeREUDMUiygxWnWhbzTl3wBiqihixOGMO9gYg
	iKr09N3bBk3qw1ACJOANQbBW3OVn+9kHJMylTef33tQYAemYCWqqLI3617RrI4Os
	P3DL2iWCsMxuBp+niErAuthO6lYAKeOOX/VTsjWBGaLiMBdZeiBDTjbSedm3w3ot
	E7RkgGhLy10WQn5eLb4lojiQyR1L+fc3/bCzYOyX6H1oa3q/3nU/IWUuGFv/kqD1
	RLk+GkcFhv9Hs3xCdjvkG0UpvyQGWD5bJfk/M3jSHaIM/vIvq0lAk5xCPEmK45to
	oTzKINjVIEVM3GSgIQo/Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394095; x=
	1794480495; bh=niNvpPuIkEImyL2OGNpWautwIIBpc4uUlXKcVcTjH14=; b=x
	rw1XplPCwxMchzLgkoGt9F6egOQNxHqaDwfvQ4Gk9bJk5qRI3kx4tSSsbKXJzPA8
	DOFbMIWCvz8cnZFhZvWIRZsUscMpKLqi7rqIyAWKDtn8MQb4zpJl2C6frKlO7GeU
	h4uP7UQkLdWXZlQJpglknljWUMPFeo0jwQ/9st2e0mmftnfhr6nWsrNOTs6zYiKD
	2nQdhrrBmIfsNv4OoBsynpcmW0PY4DLNEHo82NIalfPnYpqdqvgwaKSHILFwUnHz
	15X7kCCAS/mkWezHYPbBaJ4D5NS0qFvWt1cHO/Fl2O9MCXxc9l/kjOs96dWBDVqQ
	/9nDm8WFqxkBspw6tiBVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394095; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XZFl3s0DgOgaImoOpahw4PZ7/42gvAMLeKD8O9gEhN/P/F7
	ooyBcaxcXVWv14XQEWtNVg96RSDOodWSriV3bgZHf2L6Wy6sqW04lcE4mnOJU/4R
	W+zwJCaPTiQCM7u8BwkdeC5drrv+mjYt248J+bVsKZIK7gDQlAkJQABDINO90GPc
	9At6jRluW8R78CvF79taTsVstiziYclLsGGGS1jeXnDkOjDeLo/cHGYBbDNlVCvj
	Ao6AQKuxS8O/9xlVOfMGreWxCg+U0U/+4rodAOKsl4qMLGUBiGb7jY31yCicK/u5
	1Hm0S8GvVHSHJo8jkUAtkHeCh1TUnF+pE0mL2vg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LtAiWveJVtYuPEPLeWDOD/KD1mne9rpYJ5dVPXZCPhU=:qFAj9b+MIID/tIm7d8GDOxwwhOSZZs7mGVWVqY5o+yc=;
X-ME-Sender: <xms:70f0alx9WHJhtbBLuZu1e_wNbT39P2rhafovb8lkAR8-mIugYMlnQQ>
    <xme:70f0asTITOxtoJhKXXACVga62lcV6lN2ZxVat5_09bHhQXNVXUB-GCDHWCLcFdOC9
    QQ0Va3kz3s_zdAn4G41EjUoWyLjpC2j-yOf9m-SLa1BzQ_2US9JeNg>
X-ME-Received: <xmr:70f0akWhqxN7bsbxwx44F2bBasCOtzpmZxI8yzya5_LkP_4_dD2sACy-0NqK0oELjk3x2w>
X-ME-Proxy-Cause: dmFkZTF68gyuBnIeQdRwGHfH7RpIlBB8u9KW7pV3fOGC/OlYIHC/es/K1KGMlODmxVcYNN
    GcBPQs7w3Y96F0FmpqZnu4iQb4d4EpGTBCZXw7DiRDog/gQMeooaoeiW/rahAnDOA50GUb
    c4dB14xxYQkQBdSkZ9hjjF5SnZQiniIU+NLLiwFEAgUQn4fzO4lce5M4wUPVZoO4pDq27i
    jGd15xQCLdEN/tbUSivRW8Pi5kI7yyUpOYt6zWSIhNvjWLMuDwfacf+lDI/awuiTbTbZm7
    0Vo56/7kHJh2z0p0DOTgWIM0kwI3CjQPY7ZkNFI7u3pDe4mOu42s71W4yeK21amwK8V5eB
    n3RASqq43zkYq4R/A5ACBkC0POXw9byDxvih294et6g3Y16z1Hubr0BZiFkBTpnWGVtejs
    vyyAL0Ebj86BiBcsMU7pUIfnwyb93jtL4gRGrhDIK2inDaNxU+CaNNwNj+0fVx/8/eTzgI
    sA6tskUXArim7LJyB7CS8FaSbJRrsxHDIG0jcFHJDWXdCuZwwJRuECNEo7EwtZiqeqyvFE
    GO3kDvua0tWJjK21ommu7WRzTm8wsOz+aKgUDi8cgqr1w5suA0jbNL9xmZRjmscZVOTQVg
    Ge0IhW40xrjhEXtprpYyaIOBuu+dgHdZt16W9BYmAlgONvTMTxDNipJOxDAg
X-ME-Proxy: <xmx:70f0ama2s-2tGSranH-CdRpN27EWuCWsLKOW7CZ6rBPWn7-cIUywCw>
    <xmx:70f0ai2DrfJTLJHbBN9-X2RBHGlCHeh5eCuFDlRlX8R17Ma3SNoHLA>
    <xmx:70f0agiWzXk7OCxjt6OOIVBMa20AzWo-2LYFLNAwOIcB5dKskNNynA>
    <xmx:70f0auYkn1hMe4ata-WuWUA0eOLPCNm7dfmAUT4BVl1IgV-BIZElCw>
    <xmx:70f0alqjaawM2vi_HDI3FINxvIGZwvXtw5ze2nHYJIbILSn0J0QK3Z0Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b29edfa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:56 +0100
Subject: [PATCH v3 5/7] t0027: cache expected output files
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-5-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

In the preceding commit we have optimized one aspect of t0027 already.
Another inefficiency is `compare_files ()` and `compare_ws_file ()`,
which are both called more than a 1000 times.

These functions will repeatedly generate the same expected outcome even
though there's only a small handful of input files that the expected
outcome is computed from. Recomputing those every time is of course
quite pointless.

Improve this by computing the expected outcome once, only, to reduce the
number of spawned processes. This reduces the runtime by around 20-25%,
and on Windows the runtime decreases from 480 to 380 seconds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index a3904b729b3..38ce06cbc1e 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -5,22 +5,23 @@ test_description='CRLF conversion all combinations'
 . ./test-lib.sh
 
 compare_files () {
-	tr '\015\000' QN <"$1" >"$1".expect &&
+	{ test -f "$1".expect || tr '\015\000' QN <"$1" >"$1".expect; } &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-	test_cmp "$1".expect "$2".actual &&
-	rm "$1".expect "$2".actual
+	test_cmp "$1".expect "$2".actual
 }
 
 compare_ws_file () {
 	pfx=$1
-	exp=$2.expect
+	exp=$2.ws-expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
-		sed -e "s/0000*/$ZERO_OID/" >"$exp" &&
+	{
+		test -f "$exp" ||
+		tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
+			sed -e "s/0000*/$ZERO_OID/" >"$exp" ;
+	} &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" |
 		sed -e "s/0000*/$ZERO_OID/" >"$act" &&
-	test_cmp "$exp" "$act" &&
-	rm "$exp" "$act"
+	test_cmp "$exp" "$act"
 }
 
 create_gitattributes () {

-- 
2.56.0.611.g1030f0b940.dirty

