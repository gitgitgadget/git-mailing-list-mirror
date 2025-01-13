Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A11D9688
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810243; cv=pass; b=LluQmZ4sf1dhug4B0SzMvR6UeJ6rM3tbh+nPoeIZHswggBIdvmvBwMZPUWq33xBUaBOmBCnBjR0JjX7lKQpeez7pczQFBkOWtrbu8uXjjrx4Mrg0CZ/cXsA0QCAEeaw17kye0geLJJ/2zTpNDUKK0TNMpI+E/IpJ4+1CD8JY3iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810243; c=relaxed/simple;
	bh=pttjjDQUATRV0XejwJLzNbf3NWREhNLxNVxZb/VBIlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC1+2dlnxegsEgXQxyPcZvy//3UBladmxSa782zXX0kulguEpg2aHTzc9R7wVmMJidy4bnLvTzp3FQ/SQhdCJxRCN7zZrL1OXfgwo+TN9XSaaEEeecD7r8NQkjTYBilOD4J98kSn9afTsKqspkgttwGT/yA+mlWYZVyUalj1O7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=ZbutwxxG; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="ZbutwxxG"
ARC-Seal: i=1; a=rsa-sha256; t=1736810237; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jQQAFAmbTQNyd5BXv39/US7qPoCaGrwcggFIrh1ELFzQSC2E1pULBQBvl+3pYZLyWePbqr3dJ2QX/kF+4HrbnGvgNbGsIO+mbHXCTtDCoNjbKV5NYEcLXAvIG8racT14dV5C+9e2hJvVLat89yYnRKEUgsXeA5ff2lzddkr/k4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736810237; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pttjjDQUATRV0XejwJLzNbf3NWREhNLxNVxZb/VBIlM=; 
	b=EevHrmeQq44trdtA5wVPkS0EkeWQcpEiJfNkAY46oMZP+cCJDbse4SkdwPBnXZYKvqmJncgCOKDSQ4UzanVMjGkaZNM3Y4a08A/LpUAbFsaLyQkxBG7wyNL+7qv059ycYU/KXkmdLCBxijOMLTnUshSWa7cd2BkG8pksaV1bf44=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736810236;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=pttjjDQUATRV0XejwJLzNbf3NWREhNLxNVxZb/VBIlM=;
	b=ZbutwxxGX4IE5FBNe6SAzhuSQVwQ5l3aEr8vZZHlQGBnBoM7hVHwJj8fb6XzAuKf
	gMA0nDNO10F7r5UeOI8Uaiq4wD5036MySSjGz9U4Lig+7oObZa8FrHHHW1lX7At32oK
	+RPXkBjbvqJrABI60gzgTcWgujn8jn7RLSWqcpQs=
Received: by mx.zohomail.com with SMTPS id 1736810235004465.7676109749701;
	Mon, 13 Jan 2025 15:17:15 -0800 (PST)
From: Askar Safin <safinaskar@zohomail.com>
To: safinaskar@zohomail.com
Cc: git@vger.kernel.org
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Date: Tue, 14 Jan 2025 02:16:49 +0300
Message-Id: <20250113231649.644012-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227859c783ffad6310fbe1cc3940000d9086a8b192bd15d1d4059b0ce999688e3131f1f253a0b3e7b:zu080112270e50cd6113421324c385766a0000ecb15aa1eddda54dc97cb46a0581a2e704a365627051b33050:rf0801122b8cbba3bb23b9870cc096f6f6000034f551783d1304f41e2ca3bd60a0f8d788878a1386d523ace18963b8bd:ZohoMail
X-ZohoMailClient: External

The same thing happens with git 2.47.1.

It seems "git bisect" didn't change much from 2.47.1, so I think
there is no sense to test more versions (but I can if you ask)
