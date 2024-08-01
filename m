Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AF1B375A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528490; cv=none; b=prxTdGmc061OxdZ8T2MDFly3cPTrzuOdXZaKZ7vOx/p2D6l6FnvNWuafqRsh9xI02/7p9DPaKqf6+83k2efSsmgH6D5KRLhTxSGDnXirlx939HKhid8Ryx4xpI621SSg0ZPsyjZ2uANSf/ftfBywtVumF1lFmEcJnFSNtb5bAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528490; c=relaxed/simple;
	bh=uOhEvy9nQ0q/CT5ywAthXSfglAjr59YBmWodDiYNnd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZK1EQLTu+XMxZdwPrxId7AURmJUDbelOouWeGRuacy0y2cFLCmA8H2v6xy+UWQntdLJj1rPc6LzlYAeW6f7/xeu8hio9v87urrcHGcDnocHuaLEpmcYY0k35dNQ+iepir3+p/E1sH55gMuk91YW6m8yzMOXHS+fInM57MBCs30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D29jb3lQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D29jb3lQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A332128C4F;
	Thu,  1 Aug 2024 12:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uOhEvy9nQ0q/CT5ywAthXSfglAjr59YBmWodDi
	YNnd4=; b=D29jb3lQTercov/VmNMXyzbnIhYymNZhO+2rru0B2hD+ZZdoIT5aDY
	9DKIRBGd7WwpMuo1pXtwqAcyxzcuRpju3i43jC485J26MOSLsXYS5lEIP9o+XmHt
	h9coCCgRS8cXEyA/k/PqAy9Q8JBENslBamETkTVoA36/IEBxp6cA8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B95628C4E;
	Thu,  1 Aug 2024 12:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E35028C4B;
	Thu,  1 Aug 2024 12:07:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/7] t: port reftable/pq_test.c to the unit
 testing framework
In-Reply-To: <Zqt02XmevPRB3idt@tanuki> (Patrick Steinhardt's message of "Thu,
	1 Aug 2024 13:43:21 +0200")
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
	<20240801110453.5087-1-chandrapratap3519@gmail.com>
	<Zqt02XmevPRB3idt@tanuki>
Date: Thu, 01 Aug 2024 09:07:56 -0700
Message-ID: <xmqq34noxm3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 384029F2-5020-11EF-9EB5-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> ... the whole series LGTM now.
> Thanks!

Thanks, both.
