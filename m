Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A126289
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="i/CRIep/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqTQojUc"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8CD6
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:46:54 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 60D3F32009B6;
	Sat, 14 Oct 2023 17:46:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 14 Oct 2023 17:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320012; x=
	1697406412; bh=gNE8alXJr66Y4LCs/QPE6mLDrKfdkCTXg6MorakvaIg=; b=i
	/CRIep/s3yso84rQWw2NQTUZBwJHWnGcyytzgvGTa4vJwMKbqx8ZBvNarlQkmMpY
	p4wJT3G/t/dorJqqofofLfSDvEzIV9BczkDTdrXe4KKfGEzlKZldxLf7AxR4ZXxq
	07uQh90w/mtJTr1UQb9lUInqE18+ZQ0W/oRLeGA9XbEclKo5A7Zf1jpUesoKfCo/
	qBhWkGlP2h1BIGEM+E7yGR2jaNfYJPRQXy7i+jZWk/Fz4nKI3Rztgm5re4aV0s5B
	um1BTeXg4SpDX73c3P2+ENHdWub1sEDDFx9hcYgxeT5gNqJua2kFA4z5TE0MrCbD
	I3JIvt8XT9HHLF7CoRdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1697320012; x=1697406412; bh=g
	NE8alXJr66Y4LCs/QPE6mLDrKfdkCTXg6MorakvaIg=; b=dqTQojUc+sRhRELx8
	T5N5CgTclUET3VvjR7IVZ3T/EQgm/JwyLRnfbHAPhBd3ySQtPwYcNcaSwzzxnWpQ
	Nqz5rJCh1d2MLWzqt9fVDrZ2N1IAsXnyEl8ogxPimfdO7oDfyGeGQqGYj/bJ4sT4
	k6UZSn8U3MMc8E1LcOGQANtV2tW+ByNsX20BhMTL+TRchyPWahi+P9K0o18L4S9P
	e51W1SAG6x6tkyBUfhK6lAsvAUq1j/TbgwhjDW5j9hwaI23pZmD4JZr4OHrCnMML
	24NDkR5L6JPDIIHiDyIcLgn3bSi8BcWSPWwN0hsWIYdusZIvNs6WXYGgoAOlfbVK
	QHDRw==
X-ME-Sender: <xms:TAwrZcmfQ9GDLOxsotYctGOxchgV7psTxtBNPg0NwPD1mc4S4BUHCwk>
    <xme:TAwrZb26m74PvbxAl1ReGAvvIRc0nRyfvTfW2Uh8QCwMXHgo00FdoaY5Uc7Rkd8Fb
    O2HJedCkrXGs8rFiQ>
X-ME-Received: <xmr:TAwrZaqosBWsyht-i3xcLDR6ydtzu8gdjQgurs1YPVhhdjLMbqyQd8DGW3UF6G15sWauEI-MhfIfWfVOumMX7839cAApYtTsnSP629g5VFS0x5JCJp6LImFydg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtje
    enucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvteeivdetveelhe
    elffdvleejhfetieejvdfgieeijeelvddvkeefleelkeevhfenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:TAwrZYn4WyH_iQUSV494fUK3yfmL3LhoLH0Jp9QkZJd5aQWNxcowKw>
    <xmx:TAwrZa2sA_5IFt0GYGu4RiMCKX5isHWyi202PKmm4tPRgCLxVXSpNw>
    <xmx:TAwrZfuPFivFZMs0gIB0FZ_xyRmPRSYzvHvHB-elx56DxntRCUrExA>
    <xmx:TAwrZf8rXIpRb6szMPE2EKezaWiCOZmji5aTm30f1mvtY2EyFP2RLg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:46:51 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 0/8] t7900: untangle test dependencies
Date: Sat, 14 Oct 2023 23:45:51 +0200
Message-ID: <cover.1697319294.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Untangle test dependencies so that all tests only need setup tests to have
been run.

For example:

```
./t7900-maintenance.sh --run=setup,31
```

Test with:

```
#!/bin/sh
cd t
# Every test run together with `setup` should pass
for i in $(seq 1 42)
do
    ./t7900-maintenance.sh --quiet --run=setup,$i || return 1
done &&
# Whole test suite should pass
./t7900-maintenance.sh --quiet &&
# The tests that used to depend on each other should still pass
# when run together
./t7900-maintenance.sh --quiet --run=setup,30,31 &&
./t7900-maintenance.sh --quiet --run=setup,11,12 &&
./t7900-maintenance.sh --quiet --run=setup,3,19 &&
./t7900-maintenance.sh --quiet --run=setup,23,24 &&
./t7900-maintenance.sh --quiet --run=setup,33,34,35 &&
./t7900-maintenance.sh --quiet --run=setup,36,40 &&
./t7900-maintenance.sh --quiet --run=setup,36,40 &&
./t7900-maintenance.sh --quiet --run=setup,36,37 &&
./t7900-maintenance.sh --quiet --run=setup,15,23,24 &&
printf "\nAll passed\n" ||
printf '\n***Failed***\n'
```

§ CI

The CI failed but it didn't look relevant.

https://github.com/LemmingAvalanche/git/actions/runs/6518415327/job/17703822606

Cheers

Kristoffer Haugsbakk (8):
  t7900: remove register dependency
  t7900: setup and tear down clones
  t7900: create commit so that branch is born
  t7900: factor out inheritance test dependency
  t7900: factor out common schedule setup
  t7900: fix `pfx` dependency
  t7900: fix `print-args` dependency
  t7900: factor out packfile dependency

 t/t7900-maintenance.sh | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)


base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
--
2.42.0.2.g879ad04204
