Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E124BD03
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018013; cv=none; b=gVBm0r3A6Szl+BeKR5Cl0X68cuWsniIVs27BLrzU8q9RzVFhXrM/3Lb2K0tLEQY4b8LiG/5gb/pqRwDk9rG1kaYqGzVj/Y/6L4GbAlXCJzd0jfwXWFPhkJ+Rj2BSzeAE3jgw5T2lX+TNymUFuIZ/J0kK0pxBL3w50TePwWNYTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018013; c=relaxed/simple;
	bh=YprtYWBw5XpIwxFgLORBJ9WPpuJUHZuA+81NhExuS5U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EUYQ7pP44SLmsh3034LHpt3Qu3RN87KGbgReYrhY3WpoSHfubmLIF0Sw63ms3+RgiiUd/UTd5GB49We+vI4HU0+Fjij6RjiSp6yUH9N0x3V8HYDOFJsiOX3UZxvGw4fCmueKnAPP67fhvPMxXFhaM2hCxtUAqbxin9aXyYPQy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ib+gCXDM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ib+gCXDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764018006; x=1764622806; i=l.s.r@web.de;
	bh=jsWCzIKjvQeIsOK9DSE1b9cLzIAHLk6myoTCaxiccLE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ib+gCXDMSF8h2qMsGPzCafr50W6/G3hifFQw+4uLMesa67FwmV1jq9yHyK+7LBdk
	 lTlND3hCPQlcQdjuc2QTfGSDjYN/RVFkL+rYsozUjQCvqgdRzP+IwtOqDVuvsr/Q+
	 hC6EOdyJiMqgFcjh6I34cMLo/6opKXOYGEyMVhM91XmD0Kl/YOgHMadMOfSaPPLgU
	 M6BVkFdlG2ArkDyol5gpQkwi6FT9x6VOknIv/VdWe9CYvV37xzUu2Rmhb/SKMA0Fh
	 oj6wU4kd61kKfrKPU/KGlrjDSXQtcmb6Onn4bqVFXPTtKtjI7ey1EVroWYKphrBcu
	 dV/TteWo4j8YvSKVTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.127]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1vaow1406S-00YrMX; Mon, 24
 Nov 2025 22:00:05 +0100
Message-ID: <06997dce-e4d5-4889-8e70-5f44da3dc800@web.de>
Date: Mon, 24 Nov 2025 22:00:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] config: fix short help of unset flags
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w9Mf6gbyCF81Y5ouJXUmxuoYBhVoD6BGWsRfo3S85Sai5++FnVh
 7OTckJ9D/CFZ3NVzyYC6n7UmNZb/9N44KTatelWXZ66NltZVcICyLvLNo5oWZZq1SWMgZRo
 GIYmqCKsyg7mSyTpjm/3ugiJKLOxdcns2HATsBS/zjdtheUpOuagR1RYR/d+zZpAmxMii8f
 8vcvXooyRmvgIe2hcSruA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WoKqfI7Bkcs=;GtHJn9Ljk1OJswBUUirodkaYU2b
 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
 UraIIy0I+53O70KRc=

The flags --all and --value of "git config unset" don't make the command
"replace" or "show" anything, they are about selecting what to unset.
Change their help text accordingly.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 86e0cd77f3..80107e61dd 100644
=2D-- a/builtin/config.c
+++ b/builtin/config.c
@@ -1003,8 +1003,8 @@ static int cmd_config_unset(int argc, const char **a=
rgv, const char *prefix,
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Filter")),
-		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with n=
ew value"), CONFIG_FLAGS_MULTI_REPLACE),
-		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config w=
ith values matching the pattern")),
+		OPT_BIT(0, "all", &flags, N_("unset all multi-valued config options"), =
CONFIG_FLAGS_MULTI_REPLACE),
+		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("unset multi-v=
alued config options with matching values")),
 		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparin=
g values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_END(),
 	};
=2D-=20
2.52.0
