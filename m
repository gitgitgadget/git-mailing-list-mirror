Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BB1D1744
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544816; cv=none; b=ryr+O8zs8AI9jcgkCwpDYDTQR0O08eVHkjg3AS/0PylFzReoy/QPuThUumxcTn/uztmAyaQsff681EQj6EuCQMPLf5Jf7excBFNjjLvI2QShv8BjM+JE+pecCznec4UcFonYi6ra64WzZhLWUuLcsexPvpVZAIgTXuAOizpBBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544816; c=relaxed/simple;
	bh=ozep8eAB/iwlNhQFlGQhQoTqQIiXl6X3dzAjqPOKEyM=;
	h=Date:From:To:Cc:Message-id:In-reply-to:References:Subject:
	 MIME-version:Content-type; b=npgaLACAUDuaJ1e/GLytIHZ8uzAbjxmfFe36OEatOiK40DrZcg6Anb4lY+t2PRjcU/sDB65H9u7EgD05W2pMvt3/I1aYNJ1Aei0E70mgFucXYaBPEnjwl2/rbTG9TT2MStKljwIWIX/WXZb1hipaFXKO/mbljJIOkjbERBuMY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Di0tn1ws; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Di0tn1ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ozep8eAB/iwlNhQFlGQhQoTqQIiXl6X3dzAjqPOKEyM=;
 b=Di0tn1ws4hKAbS9ERw6xVwBrPal2zT+i6FdPWCjbOJLt89cL4HNLL0RLqWqxTirqA19ZdZj5RET4
   BV+6sv3L06/98VZsgvlaXRZNWvIL0WEKaBnWe6U5/j+ZTNLpqmMriwaFzq6gJxqn+32w31lsBtpj
   Rd9xtm1Ded35K0bH8eqz6Hf9os6dwG9+LTtvJsP8ATnL7g/OZrWka/6rPkZfqYjddYYbWM867YwQ
   iyt7RCMXN5/blCSloS3u+80Gu9qVmQe+SS8wZEPQ0H7P+/OzNN+OSH5noouT35kAn2Npex0nh93S
   e8cWT7KlJx3dJ1Er4RHLf4bR2RbiCpSr27XNmg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLQ00A3F5BGX450@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 21:06:52 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Date: Mon, 21 Oct 2024 23:06:27 +0200 (GMT+02:00)
From: Bence Ferdinandy <bence@ferdinandy.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Message-id: <4836c7c9-58d7-4e2a-ab78-be4e7296dc1f@ferdinandy.com>
In-reply-to: <Zxa83K3M7vUY7k4m@nand.local>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com> <Zxa83K3M7vUY7k4m@nand.local>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: quoted-printable
X-Correlation-ID: <4836c7c9-58d7-4e2a-ab78-be4e7296dc1f@ferdinandy.com>
Reporting-Meta:
 AAEnPGpg7kOVOZ4tMYtz5EM84CBz9HqcVKzXcMjURRbySG/ilfbnoQDh0RCIG0XD
 zNeu6MNdJX7p4SDQOrPe3RKDK69c4TwfQArT5Jm4C/mN4LuWWl1cae3CmhDEsjJC
 vCICsPe3Rhm7swzXptrJuZOtdjWfmddM3aoasfnRzFPEP3Z6WfV+0Hfi2HKbA8Pm
 Tfk8qf1G6XeMXOO8EEt7Q3wZz3PCLP0f8uWLh/HMNyVQZwp08eLnEtQ1gW+OHnYH
 S+qZcuuEKKFhsC43yigON36nAH8UAUxAyY6JQAmWUKxLAFdEta5hWo5jKcAbLsmS
 yn/1p2ZbbQz9sQATIn2H1Hha37WowmveRxpXPZMEaMxkpZQBFjxKaAfGA+YDuPPx
 cQd03IlLVfH2x64YXw3ck1PauRqWcT1O+mJ7diZBrcg8FltAR347e39I1ckQ8maw
 udjX7RlJ1jjEEpKu+eAzaVvQSGQUupuZIo96opd5b6yYJKCYdlfAC5A=

2024. okt. 21. 22:43:38 Taylor Blau <me@ttaylorr.com>:

> On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
>> Sorry for sending a v10 so soon after v9 without really waiting for=20
>> feedback,
>> but as I started digging into
>> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/=20
>> I
>> realized that the root cause is in fetch and not remote add, so the=20
>> solution
>> belongs to this series. I'll leave my overall comments for v9 in here=20
>> for
>> clarity.
>>
>> v10: added a new patch (8/8) on top of v9 to handle HEAD in mirrored=20
>> bare
>> repositories, rest of the patches are unchanged
>
> Thanks. For other readers, this is a continuation of the v9 from this
> thread:
>
> =C2=A0=C2=A0=C2=A0=20
> https://lore.kernel.org/git/20241019225330.4001477-1-bence@ferdinandy.com=
/

And people may also want to drop the accidental noreply address in Cc=20
when replying :) Sorry for the mixup!
