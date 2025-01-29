Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922E29A2
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182828; cv=none; b=NFHQzd7nuyeuplffLYiNf/ifbPFJqFTP5v4ZWd8NamFv0ax1BkHUy/FXF3C9mM8wIE2n8gZWyjYoulVWDXrtvaAaomGa2pUXM900B1Tk/TktGvVslth0mdBP6lWHGtK0rcNafOOmgWeinalI1TWPJoBdbI47avHnETW4p9K4JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182828; c=relaxed/simple;
	bh=fc4c0xn4ujB45DLQfHX0hD3YKiQt2wo6/tqIs7u/cQI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSPB5zvQZoDHQRFZ8dflAbJfHnvyJjPifkVWZLWgBG/Oc335kJbzYdqx6YtV/NGm5TDBZhuVRwrVO7LqRGGg1+oPgaWuLwAKzUpbBvPFEAN+p+L9hjJrawlTQxNL4IOK4/3hJJ5ecJkrS15zsB/qlL8ZfZhxQWEgAIuuaqjZHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50TKXfVD2006431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 20:33:42 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>	<xmqqbjvpk1wo.fsf@gitster.g>	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com> <xmqq5xlxidh6.fsf@gitster.g>
In-Reply-To: <xmqq5xlxidh6.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 15:33:36 -0500
Organization: Nexbridge Inc.
Message-ID: <009c01db728d$164a60d0$42df2270$@nexbridge.com>
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
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBAdADBhMChc+5B6+4EubA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-4, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 3:15 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> The documentation on the Environment Configuration page seems to imply
>> that
>
>Sorry, I am totally lost.  Whose documentation on what software are you
referring
>to?
>
>  $ git grep -i -e 'environment configuration'
>
>comes back empty.

It is here:
https://git-scm.com/book/ms/v2/Git-Internals-Environment-Variables

A few paragraphs from the top.

