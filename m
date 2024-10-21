Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B31E1028
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545235; cv=none; b=bj2xb64t5BNejvrHKMu0eBeGoQ3oyHL6EkMGq6w/bu0cAlxVMbPyU1dzARe0HP7r6pazOICbNhEQXpOOq/eAOmFCHTmGJ4JLkhG2O8RgJCz4TmVNs3FVcVxOH6o4QS4XbQKv25wcGPYadOu3feBVQMHyQEZKa7gPgB/4b1yeHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545235; c=relaxed/simple;
	bh=+ERmTOUOd6JTyKZcJrxV0x1vlfdTrgLLLmCUtQd5l3s=;
	h=Date:From:To:Cc:Message-id:In-reply-to:References:Subject:
	 MIME-version:Content-type; b=NM3Ks+FjRg/huvXQl3sRBz+IJ+JN1R7YByAmv24aamM0AQnDkbSoANNLAIYdC6LBPDs1tCmgbrPG0u8qVyKFsKR6xHzESokAXM25+j8z9+bmwCoWGccbq5qbXmmOcWU/lT5PoiRLoW5oqXDgC3MIs/zoWr9FmXdNOU1BUga7RCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=P4bBKMUW; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="P4bBKMUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=u1ZWY9DzHXKo4+FrJJySk3SCMh2pt6eAZ2lFI9HTJv8=;
 b=P4bBKMUWZIDlknpNImMp6DCOW5ek1qYe5Del3c5eCswBcLHP4q7mbl4ocrLWcwm5iodKKIK/+Hiz
   wxUcidp5/Z+gJtR5vfI86Jqwv4BW0mQYO8F+742gBZRz7Llgb4b4y1ZlVhNxomBxj3GJEcbXLUgj
   S4UJaxijFSTu3cCNCCgivqS2Whl3I3eeyhbLahps1YRxZtzlISrG1kFDpiqfQ+6JYK5bAnrw5SLl
   5L8J3C5zhDL+K6lWXafMH1KRMN4ZNj13ZXeYaTFu+V/41M+TI/N6hGyxQSWUk5WqEBYBge9OkVzz
   H2SUXRfi0m8Gfu1Rv+1PLsMkkUxVz8V6z97hQA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLQ00C215N32Q40@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 21:13:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Date: Mon, 21 Oct 2024 23:13:19 +0200 (GMT+02:00)
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>
Message-id: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
In-reply-to: <20241019225330.4001477-1-bence@ferdinandy.com>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
 <20241019225330.4001477-1-bence@ferdinandy.com>
Subject: Re: [PATCH v9 0/7] set-head/fetch remote/HEAD updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
X-Correlation-ID: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
Reporting-Meta:
 AAEnPGpg7kOVOZ4tMYtz5EM84CBz9HqcVKzXcMjURRbySG/ilfbnoQDh0RCIG0XD
 zNeu6MNdJX7p4SDQOrPH3xKDK69c4TwfQAp1uWv+6QYZEGL40R/kaXjGJtzJBsDe
 MzQ34J+fr48mEO21xWFV3MFaAMfSMnpuanpDeNYh73NerQN4IjKZqb+8x40sQlhP
 xy7PeW0Orqmvi8OxvN8dX6swCcaxWhfuWiAoICuPbwk7ryAt+1J+UeW96I/2jJvV
 G5O3yD8bWa7L3YmVbS7i+ycCHkz9lPBOYmygo/SXRGsEeJ/CmGy2t9YWhhf8keMh
 ov11Ki3aB12KhjUCJ4xkz9Pv/Sie64UnZvBTT4BYPZK1AcAcIgIa9OuB3OISZgYt
 BJ6FsJF2wTHEopZXGkJuiCI8nVbXSvTMa/gTqxA+uUzRyauzNXr1es96GncENCeT
 bvQX0B2eH+PBHbeDrQDPw27S1reZsaemzzooFA2O/ZM4dy31lwl8/fA=

Hi,

just a heads-up that due to me not being careful, v10 is at a new thread:
 
https://lore.kernel.org/git/4836c7c9-58d7-4e2a-ab78-be4e7296dc1f@ferdinandy.com/T/, 
with a wrong noreply address in Cc.

Sorry for the noise.

Best,
Bence
