Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759F346ACD
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165924; cv=none; b=b+qi296dajWDcGOhYhaBMJxsC+ShbcES06Tj6gUFIKiyIvUJM7/NnyZhsEjBpRtJ3ARR6wMMh4xgcnZfvEc3ztwpdRDbp+hlnKYvZGovLdzsZ+5o0rvRlnwmOb1LqDwKtHS67cPIg4eTRfmP7hzlNp4ob5BvqT8thQbieiqz2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165924; c=relaxed/simple;
	bh=a3NiSEGVxkKykvQQWDa4ZYCBSMPxx78aQ37gCiFVq24=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=byNCSk9BfjXCsdN4700WsMqzB3OcMKBu8DJJzk4X6v7juGGl+UmjgBX2drha4ymH4sF/fTzjprLPY8r/A7c+YANJ4SFqIOeeUjcBRvyV03Edl/mFY2KVBKjgmYuXZpR5mwMt+UZrLDXLb3to9LoVABP9mkIxju+dQ3hLtf9BEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id 38B5D8C4;
	Wed, 19 Aug 2026 14:58:41 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id B43CDBC0DFF;
	Wed, 19 Aug 2026 14:58:40 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id 2DE46BC0CBB;
	Wed, 19 Aug 2026 14:58:40 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id C09601C11;
	Wed, 19 Aug 2026 14:58:39 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 5DEC63C168C;
	Wed, 19 Aug 2026 18:58:39 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Jg-uHV6e9BDy; Wed, 19 Aug 2026 18:58:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 315623C168D;
	Wed, 19 Aug 2026 18:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Ugbnxx3s3gmV; Wed, 19 Aug 2026 18:58:39 +0000 (UTC)
Received: from smtpclient.apple (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id 07F2F3C168C;
	Wed, 19 Aug 2026 18:58:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2 0/1] config: surface editor failure in exit code
From: Kenneth Lorber <keni@his.com>
In-Reply-To: <xmqqjypmuh3z.fsf@gitster.g>
Date: Wed, 19 Aug 2026 14:58:38 -0400
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0A00C40-47CC-40A7-BE71-F59C02AF3CCB@his.com>
References: <20260817211936.2943278-1-keni@his.com>
 <20260819150922.2984850-1-keni@his.com> <xmqqjypmuh3z.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.113 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record



> On Aug 19, 2026, at 1:58=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> Kenneth Lorber <keni@his.com> writes:
>=20
>> (Apologies to anyone who gets this twice.)
>=20
> You should not apologize; instead make sure you do not send out the
> same thing twice ;-).
>=20
>=20
> We actually have 633ac346ee (config: propagate launch_editor()
> failure in show_editor(), 2026-08-12) in flight, so we do not need
> this patch.
>=20
> Please build from 'next' and use the resulting "git" binary to try
> it out.
>=20
> Thanks.

Works fine, but includes no tests.

Thanks.=

