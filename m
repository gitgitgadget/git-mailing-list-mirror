Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068331;
	b=iDFYyvZ/i/42WMCiM0rhhvnzpY5pE6GqTyUkDz3B2enerQoUQjx3Ip2x9VWkGCJtMiUk
	 U79oYDD0bFRgjIGi/E81Jc20sjP1jXwmJIU+iRHF7DIdNOWEhTEZWOAjw6RVpJx/Q5fTs
	 Z3xtrThIE4X2bP6UzTyTWOURMSM4+DC2gh+UaO5dlET7Uowsm6EFIFirGHeBzhHLc/mPJ
	 aeRbXXigEE9e87jL6aAvwk47RRkpfWymNRXedgOUAIhvAM8uQnLExSJBUIA592oaIaStx
	 DJEwqYm1T1M69E4PBHeNlo5Vw/H2zTcWQT8yRxxPhjoZ/7CDfXaM8Ju6pMDy9It7lFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6py4jIJbFVfAegdoB2z9M14rdEUvTUVrpZgKCRHq14g=;
	b=mLpVGdb7L0pr2lenz0aFbz6bepcMr5i6Kcvf15zbhmE51J/0ThR7CpAh9lAcYwm0H+db
	 9FsKy+OWf88mt9WF7s+DQCnCIO/ALFtQMZACTtKE/02Pg7ea6HbbUF3juQ4lH8GM18GKl
	 /UrplYgJA51p1hGKcZe84OrHHfsVSXQ5BxMxaWIzGBo8JsKi2Kaa83IGErfHI1QwNt58I
	 W6vReoPuMZ1IDMe2hgMUifjePa3s87ULxWfVwIj5kwCCxSLFOwOlpIboft+3CoSXbMkd0
	 v61L0bA3dAScw08n1Af6UmbZMJ+si3ZuOTdNn17c25tQmUDCb6qzlEzTSpnbogrhiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZRqrVtw;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48948606A33E
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48948606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZRqrVtw
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491846221ffso1464068f8f.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795068329; x=1795673129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6py4jIJbFVfAegdoB2z9M14rdEUvTUVrpZgKCRHq14g=;
        b=0ZRqrVtwl1Fs9zFo9ufAG5hQTDd2seDekvKfHzutIRXws+dMw/+hdQWUyjL/fCPWQm
         fp2Nn36oGP8P7ukGx6FtadiO9YpG8Mv2lHAxJECfkw7po6uOHrnzSqRXthmkVm8vzLWA
         2nJ6MT2JfYUWp1PlH6YOQNqe4YBSHehGjjvzquK52rSgytJvo8m1/0S2Tdiwvqe219+D
         ZMzF1IEuYTZfixyohMC3P1pSVmpgmUXHtrCIyzaDoFUbPFEAs6zppLdaSpmUyIV7N49H
         z7T+dTbocsDYJp+XU+hfRpq1lztF+TRNkxd33/O6eY0BItZoHw9yCwnfD4AgEkF4NmtW
         OUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795068329; x=1795673129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6py4jIJbFVfAegdoB2z9M14rdEUvTUVrpZgKCRHq14g=;
        b=GsPdbQXo/36Gb1wDGBX3HdzgYl/d9BNKFXgd+FBssv5m/TniYZpQDiUG/JuEya7KcH
         lB8o5gmkatLBUAcLXUSPAKC8mABebRrXj6qQI/PMqtahDvMDUFFYH7ny2m2ZzHDqrTHl
         DROnuInGx0oJBytLoKs9u10yFCNBiNxfikGEKMFnItAvX4uIE4fLrzvqZkxn+Z9F16E0
         ty5JsSLmxntKDOT0YAsrx73qXTsHXhdnJsl19J1o3VY+Sq1d79hHlSl4NxZCM2Rl+xoT
         Xc1BCs1zZMYhEesgApYWYwyiOeKV2OhFswTGiOZeIS/pmQiZoUoH99uAKc+4hGpwZRJS
         4S7g==
X-Gm-Message-State: APuU4Z881gdS6B0eiEFYymYfg1Qlns69ubsIR/lnO/a9ZLPPDE1zqzpE
	Y8OQw/rMt5dHkBqz9RE8s+BVVw7h3wLvnX+gqFESkp9IjnQxOhCg2JSQdWqKcQ==
X-Gm-Gg: AZFdTZfXlzlaeELL3Xzkoifge8HlBEVKIG79qZUT9VzgnLqg6B5+re56Xk7GwHvYsO0
	XoDqXGJeXQTFkLQvHFAE9e/VuwKouLgk8vVByPq+bJlSUOJMqSe6lbc5SdLpQl7GHRtAw8cQC1M
	v6E7IPxzeFbzREDrxjBOWfdJnSWfVz7S23GbxWixn2QiNymTdsKLdZhOWzXNkjLdywAF3M52b5S
	jjf02JjG9fnVP01iy/5VOPMhB39HIhyHmXYaGtjYf9zAWd3TTYzGjvCdui/hWtmLA6aHQ3jkabg
	ceCvF4buMsCkhkSgnIA7SWGyoruWv62rhqHVxIkrMFP7SzfVRHY6nyJnGryGGRMh130m7fuEC3v
	qP23VnkPyk9rnzy7RQ1pHp81NH9QhyU7GkXXwNxoH3Pyn4LEOma+PBfkWyAy7x5ELkMOfRFXgM2
	lWbIPVjCz3p/4bShNm467o5Nzzy+Z69QyfmrEddtNmuRTDPk5MMyJ6tYUMC2dm7XPnSDAYYhu9r
	3AODHtOk+eiWJ3QN6NWV97OgIpi2mvaagDMf+6c6UW5OilwoL0pEezi1JFPsk6qydtiJaZzoPpp
	gseawQJU7b4kdH9Af5Bx2T+dYNbqveTtYoUmnWf69TIKRbMqLtih1viVxr8lcec=
X-Received: by 2002:a05:6000:4812:b0:48f:fcac:a5e2 with SMTP id ffacd0b85a97d-4a63bbc54c2mr9166165f8f.38.1795068329508;
        Wed, 18 Nov 2026 22:05:29 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6570dcdddsm8006902f8f.54.2026.11.18.22.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:05:28 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] pack-check: use size_t for the size passed to verify callbacks
Date: Thu, 19 Nov 2026 07:05:23 +0100
Message-ID: <20261119060524.775205-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av2pUyAwTA7e2eOj@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com> <00939c7f1b144fb9dbbc1745e60f7baa18217742.1794984184.git.gitter.spiros@gmail.com> <av2pUyAwTA7e2eOj@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 02:34:11PM +0100, Patrick Steinhardt wrote:
> The more interesting question to me is: if they only inspect a prefix,
> do they actually notice that something is off and report the error? If
> not that certainly sounds like a bug to me.

Looking at it again, on master the callback is not even reached for
such an object. Just before calling it, verify_packfile() checks the
object with check_object_signature(), which also takes an "unsigned
long". It hashes only the prefix, the hash does not match, and fsck
reports "packed <oid> from <pack> is corrupt" for an object that is
fine. So fsck does complain, but for the wrong reason, and the commit
message is wrong to say that the callbacks look at a prefix today.

check_object_signature() is changed by 1/4 of "use size_t when parsing
and checking objects" [1]. Only then is the callback reached, and it
needs this patch to get the whole size, plus the rest of [1] for
parse_object_buffer() and fsck_object(). So 4/4 belongs on top of [1],
and I will resend it there with a corrected message.

Blobs are not affected: on these platforms core.bigFileThreshold, an
"unsigned long" itself, is below 4GiB, so every blob that large is
checked with stream_object_signature() and reaches the callback
without its data.

[1] https://lore.kernel.org/git/cover.1793444420.git.gitter.spiros@gmail.com/

Thanks,
Elia
