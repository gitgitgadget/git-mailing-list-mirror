Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF58F48
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352997; cv=none; b=MemfsO+AMB0+UuEzlfnjP4bquupKB7YjBKQIE0T4G86ZM6hzSxwLpnUec8CRnqf4fh6E4p936tYArYfrfFvfycTVKwRT1APm88CC+v/obPltTEc7ci5d9TR5b+7fuOfuvcN8TJiebyF2Nd6QRB6PAstx47bcu+7LI5GqxbugRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352997; c=relaxed/simple;
	bh=oZm6yNLpsm41yFkbgUl+q+qV4ndEUNjbrObyWBjNC+w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eN02l6D335q0v81TqkGbWW3S3WZwMYsfoD8rBDUt5TI63DVJVEAqiJSMJG/jfYFvoUQzmm0jIFSGYRRagfFU27b9Kql27pshfUHECWMPYvOroZIpKeC8sp3g2B7hmocwWgvrTKz2mi6r0OOIvhseI8LnbRsVCylJ8A4vQaQakFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45PM342p757709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 22:03:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>	<20240621154552.62038-2-randall.becker@nexbridge.ca>	<xmqqmsnekvir.fsf@gitster.g>	<016501dac409$7dd5bc00$79813400$@nexbridge.com>	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g>	<xmqqtthlimtr.fsf@gitster.g>	<03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com> <xmqqmsn87n9x.fsf@gitster.g>
In-Reply-To: <xmqqmsn87n9x.fsf@gitster.g>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about zlib+libcurl
Date: Tue, 25 Jun 2024 18:02:58 -0400
Organization: Nexbridge Inc.
Message-ID: <03f901dac74b$740c78e0$5c256aa0$@nexbridge.com>
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
Thread-Index: AQHq0XJehhOvdAHgpxm5+qQ6Ucb/ggE1bx9aAneMcGQCRemapwGCRHksAmkbpREC22/9igK65SwmAgk13kCxLQVPsA==
Content-Language: en-ca

On Tuesday, June 25, 2024 4:58 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> My take on the separate patches and discussion about reporting
>> run-time values of libcurl, zlib, and OpenSSL, is that these are being
>> added to --build-options not --runtime-options (does not exist yet). I
>> think that grabbing run-time values could be confusing to users who
>> expect the --build-options even if comparing the two values.
>
>Yup.  I thought that the consensus was to leave all those extra
complexities like
>runtime versions for a later and separate topic done after the dust from
this change
>settles.

So did I, but there was other chatter that made me think we did not.

