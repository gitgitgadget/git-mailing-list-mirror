Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CA4EB30
	for <git@vger.kernel.org>; Thu, 16 May 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861646; cv=none; b=sjKPw1NQO/Sflx0OK55qhlRngN4v4BfT8CkdwxLcC3RE2TyyUj52wLqG77ka9/Q7qi3uyRhSwYUEMBeebplRf3w50XZqPs8NN/9huuzb4UW75uBy86hoCllgMPK0/aAHvVZSqzvRSM9vgqeLsW+GREUVx5N0KxLnxerZ/4jE4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861646; c=relaxed/simple;
	bh=Lsr9ar9POvZB2lMHopd8YqnU6zr6ET8hswaCQbWWAaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=crvK/MqYm3uubp3jb0zzgk7QHsOv3M5LZc+rbEbNFPpthO+TT4EfMu11btRtv9ulgTamjoRIl/6Xx4RiTSUEIl+KqX5Z4GhCu71fOgRSq+imXeANcXH7wSoKUQgwEyuPuNNoTgcYTlHTRVROPHy6vsaetzrqtZkUI9ZPCKb7bqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VbhX4omD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VbhX4omD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715861639; x=1716466439;
	i=johannes.schindelin@gmx.de;
	bh=u7YPGttZNIkDpkbbzg4iauznQa6A/66n08un57J7FBM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VbhX4omD0624jpbJm8KnGAc2dpfMSJ6AQC4QhNMy39s7ARQHptIYk49ogz9IWuiZ
	 ulmev0lvOWHgSuIBmFbvr0RlXL0JMWlLxX/IfoL/h8k4kZcJNDiEPyWaUa1KxhbzJ
	 0yo/q/ySo2TS1sCAIdqFo3jIgF4HDfAysxSmRBJhrQIeEwyuhM2pSe0bYuQS5R84t
	 D4V5hflkNhWAqPn1WeaVdmNmxuYTpdla1YJ0lZxStJWBmMtgOU/aYBZrQDVDrVNgs
	 pwg67WXQXDiiLo7VSqq2OMkmykS76Ajw3bS7hvVwlZz2jL1N9OiYY+uiQUZrAmOnw
	 F/0bW40u/pwoLdMViQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1sipYd1Wno-00bYVu; Thu, 16
 May 2024 14:13:59 +0200
Date: Thu, 16 May 2024 14:13:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brooke Kuhlmann <brooke@alchemists.io>
cc: git@vger.kernel.org
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
In-Reply-To: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
Message-ID: <5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de>
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8+F+rg8L50b6jQbKbfCmVsaNeRhiIuoISTIxIVhQ1fCLfAgCQL1
 pAwF1M8G+bYwLBIv4+cMBmSd2yzgzgOuGFxyNFe8GCRwoFhtMpRBDPVsqlL0rMh4DRfYLdX
 Oa+q/1lIip2XI96vSw3yeRFgUsTT1rJwSGUrCP0Pz8RUPFhMAtjdMJt2CemArOjm65r6Rwc
 s0XznolG6KIMcMZv0C85w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:daY5mw3sg2s=;T+V/2Zp+DP8U908lEJtOrFgaFZ7
 rgxAjCW0q9Zr2lVp7d0L1Wtrrvpk6TyfMdXHJ8xnjQhumwUFwetL6mgUErF1+HZz5w/9z2Y3J
 PgAuaDSXPRqleDBKz2mgAVFNcPr9epmfjo2UgXcqqxsgfkCY8VJIGC7NRZQZh1ILrvW9EcyE3
 DU3iK3ynAJOIETZb3plNjdI8Z0xTPI1m9RmBW9NfLpEAhq3/gQAIKA4Du3rkNHn4fcDFInoUF
 GTklXAJ6PY1ndLsM7Qz+yrzExvsr/Q1+vlkJrqCjckK833W+3g3a2bkVMGLZP3h1bApAf5m9Y
 96Vwt7n3l+B74xoZBMB0Xp5ftAhWOmnllVyMCaXeoUI2z3gryLKnO2uJFsufDr/G0xe7grPU+
 dB30/yV3qDTdMm1nNO7rSSBypYf8CqXzaxcaZ6uSyi9SAAhtuTlEkKmwMSnkrphCbMpre/HDI
 g0iRxhOTey/UJHCkjnHbsEa58q1XaIBhEOZQFczTuDry6xS+VFW14WpvorUZ4kfXqe8zEKZ9G
 ovYaWmI6dincpdXZVDfclzN/yZXaCQnku/8/VbncqA0HRA66w0ZhR9QbKelTMN4mEGPO2jLxS
 hF4iF6VHGLb9wBk+78mHmFY/qaBpVBVNHKiCtgbEExM/Txy6sm0cFDiibGBkYzsAfSYhY70jJ
 fruhy4UCzkXTdV41qqnK+0BVfivUSwMyYf4Zy8I5A2nLGTifYdzP64EnyRlzj7L41791W0UPd
 RecDr4yEAdFGw3+isZDctprwMgyUImXDBwxMBU3F+1tJ3T8KVDodExQT+svKwjLi/l2PGQOWJ
 zK4xBDJbF0M1dlNImgmUjSOipvZ80tnk9+Xx1EQx185ww=
Content-Transfer-Encoding: quoted-printable

Hi Brooke,

On Wed, 15 May 2024, Brooke Kuhlmann wrote:

> With the release of Git 2.45.1, I can no longer do this when cloning
> trusted repositories (my own) for build and deployment purposes:
>
> git clone --config core.hooksPath=3D/dev/null https://github.com/bkuhlma=
nn/infusible

Ah, that's a clever trick. The clone protections try to prevent overriding
the `core.hooksPath` with a valid (but not intended by the user) path.
What you are doing is to specifically turn hooks off *1*.

I plan on sending out a patch series later either today or tomorrow to
address a couple of regressions introduced by v2.45.1, and this patch
would address your specific scenario:

=2D- snip --
diff --git a/config.c b/config.c
index 85b37f2ee09..380f7777a6e 100644
=2D-- a/config.c
+++ b/config.c
@@ -1527,6 +1527,7 @@ static int git_default_core_config(const char *var, =
const char *value, void *cb)

 	if (!strcmp(var, "core.hookspath")) {
 		if (current_config_scope() =3D=3D CONFIG_SCOPE_LOCAL &&
+		    (!value || (*value && strcmp(value, "/dev/null"))) &&
 		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
 			die(_("active `core.hooksPath` found in the local "
 			      "repository config:\n\t%s\nFor security "
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aab..1eae346a6e3 100755
=2D-- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -41,4 +41,8 @@ test_expect_success 'git rev-parse --git-path hooks' '
 	test .git/custom-hooks/abc =3D "$(cat actual)"
 '

+test_expect_success 'core.hooksPath=3D/dev/null' '
+	git clone -c core.hooksPath=3D/dev/null . no-templates
+'
+
 test_done

> I have automation in place where I want my global Git Hooks to be
> ignored when cloning like this. The solution is to do this:
>
> GIT_CLONE_PROTECTION_ACTIVE=3Dfalse git clone --config core.hooksPath=3D=
/dev/null https://github.com/bkuhlmann/infusible
>
> ...but is there a better, more secure, way to clone a repository while
> ignoring any global Git Hooks from firing without a lot of effort?

That is certainly a good work-around for now. Thank you for the report! I
hope that we can address your use case in v2.45.2, hopefully soon.

Thanks,
Johannes
