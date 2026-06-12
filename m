Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5E357CFF
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276623; cv=none; b=T0X9+qJrLbccRckrr9XhtHriHPR9uYF7H5Gc1YZH5AXoZJv3rdLI6JoFq+sWvXItuwPA1F88Xm96kZCe79CNn/8B1ewP02ShpNP6CqFHcqtx+dfqC48vYyhp50vXNb2TGjnE3ja18CURI29rJyveHxUsuXMRncfR8N2ICCxsYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276623; c=relaxed/simple;
	bh=0vyREF8TSfUfp7OY0EfJJpgrwkAj4frUVuTVtBm2ekg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hEytCoX4r3aSmEd27wYwn7ZQT9JNcGEQDp4CQZiC3vGNQTyxUdThkAuKDcpMGAiSIa+tJFtS7IkObxGYAY42CTjz0afAQbhoT24ICoqdxM446iiZSwxS1AiZxnNIAx2ggNQ9BXTph/NYHLTn4/dICOsUTBqVS0cUb2apLM4DMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 65CF3bki2648174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:03:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>
References: <xmqqik7pqeiq.fsf@gitster.g> <065e01dcfa75$ade00690$09a013b0$@nexbridge.com>
In-Reply-To: <065e01dcfa75$ade00690$09a013b0$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.55.0-rc0
Date: Fri, 12 Jun 2026 11:03:31 -0400
Organization: Nexbridge Inc.
Message-ID: <067001dcfa7c$a54fc770$efef5650$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2QUXve+Cc3EDmUgFIrOAj5bt+RAHkDBkvt3lVuQA=
X-Antivirus: Norton (VPS 260612-2, 6/12/2026), Outbound message
X-Antivirus-Status: Clean

On June 12, 2026 10:14 AM, I wrote:
> On June 11, 2026 11:32 AM, Junio wrote:
> > An early preview release Git v2.55.0-rc0 is now available for testing
> > at the usual places.  It is comprised of 397 non-merge commits since
> > v2.54.0, contributed by
> > 70 people, 22 of which are new faces [*].
> 
> Cargo is not available everywhere. Build is not possible on NonStop.
> 
> cargo build  --release
> /usr/coreutils/bin/bash: cargo: command not found
> Makefile:3021: recipe for target 'target/release/libgitcore.a' failed
> make: *** [target/release/libgitcore.a] Error 127
> 
> Is there a way around this?

Note: cargo is part of Rust. This dependency was only supposed to be added
as of git 3.0. If I may be polite and ask that this dependency be removed for
v2.55.0-rc1.

While my team is trying to do the Rust port for NonStop, it is not a quick
effort, and we expect no earlier than 2027 - given that the team is made up
entirely of volunteers.

Thank you,
Randall

