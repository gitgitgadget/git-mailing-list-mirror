Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B01D0E2B
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715569; cv=none; b=YGgyLIftBg0eze1kA8WXkZasyOVPTdMTrZ0POsBY3FF0nzuZlcNGKcElnb2diL8b+vq3dPZbU4/rCHqNmp6JjKKMVkiO02NYLHq+qpB1cemfk+IquNxtl8pkbCLxJXS01Oo90MRsS2XlYUQwFppmMpm5WJHvSsuzXAPm4KMQ1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715569; c=relaxed/simple;
	bh=Pjfk1yZkYsrlbV+P58eXZB9DbkR8cCtdBwcn3PxXaqk=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=LerE6XyqkWk7eGhxvFPShsNIXnNKRVP7iL4S2qScLxWajSL3lkoglFBRD+p6HqfILqleqUAeOkq8kXU0+ZIvpVoSF0ZL/hRLaDj7CWzKgJ73R1AmlqXsrQ0eIif+KtVrprUOFOmLx2HXGP27R6F+laMAp74rzWBXTpB+1DTwdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=XQy598CE; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="XQy598CE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=VH+HRf0Zu5bMWsrlaa3kcF0JwaDbiWiWWOhNL7UdZCA=;
 b=XQy598CE4jSXpc8GttNY4qLJlEggJ3sL/lvZBZSURa/X9jcLhzRnPY6Mas7mYi9hKIJ6jRjIQJPb
   p99JwAplFOS2NJn1SKRAe/A0Cu6f0Z/8ZB7kMua45xxRgjcG7Mp7yJDJLGZWLr1TKfAm7f11c9zk
   LfepSk42WPHap/QVYxOdKZQn81j9qTT3Gjs44GJJkproC+YbjhLbsx2urQpBHzqL/d2RB2OwOjbb
   3wPFvkzrzK1DqwqdBPt6oa2syzffBsI7W7YsuuRydlONAwiLnomO2etU64DKxeaMQwScgoCq7VNN
   GdsgkQBK2e+J1pcRCfHP5mrx3Kt2pi+87bmTvQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00LC4T2GKAE0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 20:32:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 23 Oct 2024 22:32:08 +0200
Message-id: <D53GZBSWBUW2.36KFBIW6AERF9@ferdinandy.com>
Subject: Re: [RFC PATCH] notes: add prepend command
Cc: <git@vger.kernel.org>, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 =?utf-8?q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= <congdanhqx@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Teng Long" <dyroneteng@gmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023201430.986389-1-bence@ferdinandy.com>
 <ZxlahJygsRFcxDev@nand.local>
In-reply-to: <ZxlahJygsRFcxDev@nand.local>
Reporting-Meta:
 AAFwbYR92EaywibRcnmhILKeRPfiQsRRer8NnmBv2i9XkEA3y6RhCoI1RYZGLsbp
 78Sb02jNqXBYDYbD3kbllR8dYaafoiwVSwsmOCmwIbfjt0OBRRYNTGc4/bY3yOPG
 FPAUR1SmauhYd3pxdJJbHSCwmCpVK8VgmJ8qnDCi09asCjomctQzjBf+SxuDTkfd
 Hvy8qNac0XR+iSsXAwcor5S8oZtJbW34e9zsqgx8kCPxy6RL2vXd0tMBmUEcs4Ib
 PXE/PXJdp4foeXq1Lt4JFWnyo5633Kb+uxNNQ+UESPD7AbYNLM7D/i8gduegBNV1
 skrMrA0Y8VOIcp+WqiKHguyY3bhnWb6Ar68kATYjv2lvZDOt+G5LsrrVKxndNlqc
 mSgKG3k3PAPCQtokpgUW1+GjTU506Ub2CdMS4YKRTTZsrFcVFgI5qmra3riMYPdG
 oIrrOP4jEpNENAq5XWMZSbWrZMfK9oW/6IEY3RbxP4/o8AJ1CCy+9xwn


On Wed Oct 23, 2024 at 22:20, Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Oct 23, 2024 at 10:14:24PM +0200, Bence Ferdinandy wrote:
>> When a note is detailing commit history, it makes sense to keep the
>> latest change on top, but unlike adding things at the bottom with
>> "git notes append" this can only be done manually. Add a
>>
>>     git notes prepend
>>
>> command, which works exactly like the append command, except that it
>> inserts the text before the current contents of the note instead of
>> after.
>
> Hmmm. I am not sure that I see the widespread need for such a tool. If
> this is specific to your use-case, I think a custom script and
> `$GIT_EDITOR` would do the trick.

Couldn't the same argument be made for append? Imho, it's a missing symmetr=
y.
Ofc it's probably not quite hard to script around this.

