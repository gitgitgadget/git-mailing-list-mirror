Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACA22D4F7
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428958; cv=none; b=nQ/f7Gvfy1VZRaFqg8U3rYsAuSJuTWBZSKNDLAJuSz9fJe7G3knTkxupZpcjFC5L3lEvd0tG07erBCRk3p/CY5YFrVqddPXOTOud4UW2G1eEt6tuwVZ4k/7oZsLK0rx3bbDp3uBrlEw4kXLMf8+TsOBTKLDsQ5tzU4xg7W/13Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428958; c=relaxed/simple;
	bh=Lhy+6roI7sAv/RamADwEbedJmBNv9RN26RkhJX5cYKU=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bA6N7iPdCj3Ehs2JAL3cAHsq4iTaji3AEgCJLpCPwa4J+hERoCnXY5PBL//E+5SdBNC3YGQvoWg7Pkv4kq5rCMc7WFhjriDtSraMoemMoEvte3IzOQwknvwbrKmnYy5QOScMOP8ePgq2bTW/X8nGox9Q/xV+yOn0uO8yNrsGBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4B5K2IB33618483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 20:02:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>, <git@vger.kernel.org>
References: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me>
In-Reply-To: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me>
Subject: RE: [help] git status doesn't seem to work.
Date: Thu, 5 Dec 2024 15:02:14 -0500
Organization: Nexbridge Inc.
Message-ID: <048801db4750$97831e70$c6895b50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHskUCPhCSEHGdpLMn+wYikDJMal7K1feRA
Content-Language: en-ca

On December 5, 2024 2:53 PM, A bughunter wrote:
>[help] git status doesn't seem to work. See how a pull caused updates =
after status
>showed "up to date"
>
>```
>~/Peeranoia_Framework $ git status
>On branch main
>Your branch is up to date with 'origin/main'.
>
>nothing to commit, working tree clean
>~/Peeranoia_Framework $ git pull
>Enter passphrase for key =
'/data/data/com.termux/files/home/.ssh/id_ed25519':
>remote: Enumerating objects: 17, done.
>remote: Counting objects: 100% (17/17), done.
>remote: Compressing objects: 100% (15/15), done.
>remote: Total 15 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0) =
Unpacking
>objects: 100% (15/15), 6.41 KiB | 312.00 KiB/s, done.
>>From github.com:freedom-foundation"up to date"/Peeranoia_Framework
>   03edf66..4cf4f51  main       -> origin/main
>Updating 03edf66..4cf4f51
>Fast-forward
> README.md | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-) ~/Peeranoia_Framework =
$ git status

This is exactly what git pull is supposed to do. The operation does not
leave files in an uncommitted state, so the message

>On branch main Your branch is up to date with 'origin/main'.
>nothing to commit, working tree clean

is 100% correct before and after the pull in your example.

