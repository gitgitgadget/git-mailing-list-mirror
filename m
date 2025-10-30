Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB624BBEC
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840188; cv=none; b=Lo6XCncnaopgyWexvl9cVMsnz+UTRstAAR57u5uqK5wFE/jhWGm+hwTlCPgdz4M5kvtN7KvLBL/ey3t+3JxxYvPYptJDckzdC/8x7hEFulIvpSoLmCR6S9YzrkxKmCn9Bw7iMQQomQjzjFLJrPkc3VNDcPh9Zf6uDzU5RwNlJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840188; c=relaxed/simple;
	bh=JRI2RWTgtoPgtDUwRoYhOutehFBAIj2fAXLLC19+PwE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCsn4v3ykFZaRzyLlxdk7aY01nebey8+4Z5WDaYPLd+X0ZeTVA9i0i8vQJ0e0UxMsqm+0o1w7oXpfa0IA+Ka2IgQm0eYkj3Pca6clBQ3YDR5scLIiCT7wV3wQBpG5LlyOzaIgRE4n3R8pO217c5UWSu1QsnUEcM+EYLGLl54vQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59UG30SX1982717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 16:03:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com> <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
In-Reply-To: <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
Subject: RE: [BUGS] Git v2.51.2 on NonStop
Date: Thu, 30 Oct 2025 12:02:55 -0400
Organization: Nexbridge Inc.
Message-ID: <007501dc49b6$aacd9eb0$0068dc10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUZTuwh66ijI7aIz2t8Y1znRjrdQMi5nLUAqyTHv+1PCY0kA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251030-2, 10/30/2025), Outbound message
X-Antivirus-Status: Clean

On October 30, 2025 11:15 AM, Kristoffer Haugsbakk wrote:
>On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
>> I have found new defects on 2.51.2 that were not present in 2.51.1
>> when building with OpenSSL 3.5 (probably unrelated).
>>
>> Many failures in t7900 resulting from the use of test_subcommand ! as
>> seen below. This is run in bash 5.0.18:
>>
>>[snip]
>
>Would it make sense for maintenance releases to have a small release
candidate pre-
>release?  Both of these maintenance releases have had issues.

Interesting question. I would personally prefer that maintenance releases
would be
fixes only, rather than new functionality or introduction of new
dependencies or
constructs that might break the main release. If there is something
significant done,
it should be in a main release, with a release candidate. I think we should
be cutting
down what is in maintenance releases so that release candidates are not
required.

Obviously, if there is a CVE and we need a maintenance release to fix it,
and the CVE
has breaking changes, we have an issue - and if significant enough, then
yes, a
release candidate should be done.

Just my opinion,
Randall

