Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F412B73
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562799; cv=none; b=FEFB+zNY4ASoP0l2QU46DW7cSyJYxYfNKPrsL2EEwwCfh/+T/dmphNxqiqro7LPAkqd9xo+R5f08sH2bRfuobUD8e7RSbLh4sV2A3mzf4pZwCt79MK/LD75/avUeu4jUUr2Me4a5rxrhAt1frDXvuurq3Eebj8U7tgD7Pd/MGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562799; c=relaxed/simple;
	bh=E+/41oTaAMuQRRXgdDAasgEzWD5c5MWGIMnSV9dhgOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWmGBLY4JlmLz7rBRmFw4v4MH9MdZFoKVXMBDVVruZ79MJQTdkKwbD+PxDN0M+GowX+dPGvoTi4DqQQ5HXSTpEo/X5FweZwKTAQBMbTmPjVel7msahw6K54lc92HEhYEnCRDONepAjCnVAakyRRFAxEkGp4Hy5/xr2uGlwcFKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=XoBrCtI5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="XoBrCtI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733562792; x=1734167592;
	i=oswald.buddenhagen@gmx.de;
	bh=Bi0q77trPASgC0oD1U2KJLMCD0MEjbDH5Lhar+2M/Ds=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XoBrCtI58T1SqQyLxEPw11etgB6byzsGlqmrmSfLrzYENm/HjdQLU/q4g0Uu5xFP
	 kBlALaB5QAknsMKEX1gZKn9pwATAbLgyV6jvll8VhP3ft9bEKLzSp8ED80RSDA7I7
	 8hKAQBibUNmJLVv+INtE6iFBmo3iCXfFfkF97WqLmNhhp7FNm8Pz0JqzLMaSjD7WD
	 O8Rkh++cSeGjn1w0GpLIjWhrs3PyqK8o//cnl5M+onX1eRCFnLBSEaBXEDhv5+YQE
	 9Q2mdpZAX2P6OmgBcbhJ3NV62YyySXw8ULD5nSbYsr1FwCGOI4frMnRvPihkRdPio
	 TFr7nwYc8eEX6AKt9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1tuIcV43m0-00qFiu; Sat, 07
 Dec 2024 10:13:12 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1tJqsB-WIY-00; Sat, 07 Dec 2024 10:13:11 +0100
Date: Sat, 7 Dec 2024 10:13:11 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci/lib: use echo instead of printf to set up sections
Message-ID: <Z1QRp8jFJPYdNmQk@ugly>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <20241206-pks-ci-section-fixes-v1-3-7ab1b69e3648@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241206-pks-ci-section-fixes-v1-3-7ab1b69e3648@pks.im>
X-Provags-ID: V03:K1:AGMhT3zjGNzjJrapgNmSDCo4MR88GV+sPHmoH+i40rCXQ+X0DhH
 FRWOKT29b2aq1KVa0zpe3EavzJ04zaeDJugXpXXaeF8ch4c4OprEHQrZ2REEWrKf1+kvevp
 0jXwFV+hWXw60OTbYmYBbh7lIxnXZVAS5LjZ1Fx9y2RSR7ZGmTRe3c6sGvO1qlTYn/PMcKT
 wd+uAZ5tZh+Lwk3dC2lXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EdOzQTLW7+A=;WSThbZexNj3UFlKePjwZzDiChDg
 7HO5olVT6F+taJSD3vaGngXwOweGDUQPjTi1iIDJ1287GYmFDTdGEmoGQk4T9pnSxZS6gum5k
 r4Ee/qpWXOgIPyzdBThrN0Y3N4s9/uKzAogazonzeGVApcD9ZxkQTKE7wUCKXt5HP48s3I7dP
 +zPoY0BljKkkyM41GZ7R0O7Uyj80LxW27/wfEVU6veOivTfFQcXinY20YFBq92rKOpx/tErgr
 po3l0Z5ihKCTIc5fvNP4Ap5GXmdDRPUzO521t1gBCfVv/gwYRzyLL3Ke8/vBObGOG8nOGNqpm
 tarswTqXG7m6zFLwsw5xXIY7TYiyDzh2bD0qcG8nialBGbNcCOQk4+bjq7WK5QGiAejQUdZJ5
 s8cPsYOcxqCNA+9flkwlqHP2++/PdDYIm65vVpaWEoVHQPUh3N1jdJOJnDMo9lbx1eo5FNrw2
 rXQQlN7BXVi85qR34EpgsdJwgS+A94rgENJEJl22Al9uuq0+z1XUnLtdez6EYN9OmrDUxEHLp
 yfDQlQUrYcNWumAsGungNwYpyHq1clxbWu6L4RQTIeJdwKneWQVchjwPc1fM23nyPD5339m2V
 M7HZeXD5FtEud2lcxX8wnS0QcKNyq8VoY7Dk+mGOhrq8b4Spt/MnP76J5B7xqO7LhTiaW1Ik3
 B1Y6m8Hw+IIiFpupAxfsSL9g2oc6ad9eKYWQpeVFHIiV4vFLsaRfCd0fX5OF3Ifca/gV2TlGF
 895s0khAV5b80ED1EB0iJU4zXqxxyJQu4oT381pNqTWAnVUEM2HcPThlGRkjZiXC/y5ZbLC5u
 OsHp431cpmK6d7sCvs4ZPCXYA2tmSNRT1ACEfInYV7cro0v6mR6QYrqdSwYpmFzOpLOTNcBn+
 aNMffaGmnqW8nnbaaSCVR08D+kmv2X3CC8EXvzMbZk1Q14woavY3VU1ffpFNpJQWaqv1X69uk
 /lyaQ99+rDtVrQvuKG/eVfOpncf3Egg8JCM6SKy+5SZNqO1ehAWKOWjWtIU5R6XYDQ+6irsuD
 xEXzXitBXJEU/CpwrqFArwXl0fEjLTYyCy256+mgIN2FTfzUbEk9h7bmiVcY1twcL1X3jcTdQ
 LsYUAGd0i/DZ4lOBrpinugLW/1iMsIFhgRxg88ebQtgQU/EEyIzg==
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 12:10:15PM +0100, Patrick Steinhardt wrote:
>We use printf to set up sections with GitLab CI even though we could
>trivially use echo.
>
probably not a good idea, because the file is also included from plain
sh scripts, which may invoke an `echo` that cannot deal with \escapes.
at least potentially.

>This may cause problems in case the argument passed to `begin_group ()`
>or `end_group ()` contains formatting directives as we use them as part
>of the formatting string.
>
that can be fixed properly by using the %s expando.

>+++ b/ci/lib.sh
>-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collaps=
ed=3Dtrue]\r\e[0K$1\n"
>+		echo "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=
=3Dtrue]\r\e[0K$1"
