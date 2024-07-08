Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F878C9D
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450985; cv=none; b=Sm0I4MRWFAL2XsQLUQGvLWqoTn/hcnTlRBJZvblstNAUoLYnNwwvyd2rGWIK66ohze6giKF5j3q6jfCSElzclZSeF+Z6pPOzy/pOkJ0ZrqdgkQptbmYUKBM6749rrdGnEVR8/TEXMqav2/52w0xDEbu230l4rDi0Z8PZm6pUt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450985; c=relaxed/simple;
	bh=5bGz9rb/MQ3wqP2fa9cN5EpIwm9X3cLvMbV/K0eyv3s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uyP9LbX0vWWvMZroxxAs1aq7izEYHi81iCQNwyUtD6H37I2DsSmoDcqn9JEPR7vKEhAaumARROq71kEL8n7NHrWRx9ucgdhaC6Mv5m9u/4SBsqdTY3SCKFQnTm73T2mw5He+hUds3PaNz77pxGVa+yz1GDM0hrAszqDyebuyXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 468F2uNE3210561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 15:02:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Konstantin Khomoutov'" <kostix@bswap.ru>, "'ellie'" <el@horse64.org>
Cc: <git@vger.kernel.org>
References: <15bb8955-8ef6-4d83-b10c-e8593f65790c@horse64.org> <793a0c16-c2e5-4fbb-9e97-297c096fe42f@horse64.org> <20240708143239.vq47dg7mgh33hykf@carbon>
In-Reply-To: <20240708143239.vq47dg7mgh33hykf@carbon>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Mon, 8 Jul 2024 11:02:50 -0400
Organization: Nexbridge Inc.
Message-ID: <001201dad147$e9fdf9b0$bdf9ed10$@nexbridge.com>
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
Thread-Index: AQIOcuJNQOiJMkQZvscuPTyr1NeGY7GFqdrw
Content-Language: en-ca

On Monday, July 8, 2024 10:33 AM, Konstantin Khomoutov wrote:
>On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
>
>[...]
>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>> CANCEL (err 8)
>[...]
>> It seems extremely unlikely to me to be possibly an ISP issue, for
>> which I already listed the reasons. An additional one is HTTPS
>> downloads from github outside of git, e.g. from zip archives, for way
>> larger files work fine as well.
>[...]
>
>What if you explicitly disable HTTP/2 when cloning?
>
>  git -c http.version=HTTP/1.1 clone ...
>
>should probably do this.

I can verify that this works in my environment.

