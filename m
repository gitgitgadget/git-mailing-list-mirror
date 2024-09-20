Received: from sender-of-o54.zoho.eu (sender-of-o54.zoho.eu [136.143.169.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92F33997
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726857418; cv=pass; b=mcWsbFICB5YgWHd9ci1doYebriGWfYGVDuTuUFDPxMvkgFiFQc0EIfkkc29uqQ5GY78e+XIsmicx5pFs/nRBOf6hV+Xd8K9zLNO9KzFfFdHrUDvQJGnQQmdkGFKlLBKU97dNfqsS7epnMQ7/fTmfrhsaA2Lk5JMF7AZD6/IBfos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726857418; c=relaxed/simple;
	bh=/+guy5VnNA4/zjA5LlEb596pMA/3zgFbLSGzaucE13w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rsvfGZpb6YlSyFpbR/8C58dsuihZPKK86v7rC9o2HQ18EDdYB8qh3uWbX44482HRUBwoDkE1DanFsDXk8f8opa1O8WmOhYOrynu3duyXwqSoWA3MzJJ+I6pUTdRLGUNwBZZhfE6AgIMTMrPLnZlAaSkR5pWenukMLpktAGnQ/Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b=wOeakgdJ; arc=pass smtp.client-ip=136.143.169.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b="wOeakgdJ"
ARC-Seal: i=1; a=rsa-sha256; t=1726857384; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MleRrcoZ9XuitntcoqbC2Q2Qigg6+FmpcByUDNs27euZvKDk2pP5X+gCaYFDa9t6PVR//WBRY7tlYG3LKpmjnNwGwQhVimwqpc6bZi7BaEbzUcjLjAlvslgpKHB2xOMMjIhff17uqr4kLYxpxsaORbhfd3KNoo6nR1kyPle5os8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1726857384; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mS9n/UPNsQkbZLdjFzvsUGDqfQL4WdgRO8q0x12Wwhg=; 
	b=QP0pTHBMuP8SvTJYGcucae5/ueEj2OKLJuhsFNpWK7V/l+Hm7r6ySI21zPOmSVviPDVqN2eGcsDaU1iZZ3r7X81bTenDj6CEney1c9QUPnsHduE0IkD4GioZZ7YtjU/8sVR0nDRaxWdNP7Lg0JktWGGemO5ZTFFvaskYBFKG0Vc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=orca.pet;
	spf=pass  smtp.mailfrom=marcos@orca.pet;
	dmarc=pass header.from=<marcos@orca.pet>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726857384;
	s=zmail; d=orca.pet; i=marcos@orca.pet;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mS9n/UPNsQkbZLdjFzvsUGDqfQL4WdgRO8q0x12Wwhg=;
	b=wOeakgdJN7K5LtiUBE3nXaR7IeTGA3Us+MHP3NV+PheEhghz6xGuL1dD6Uj6tFAJ
	ZzfWtg4Sz1SmIHSRyai9MDk6puz+ssmBGEReLBXnf6zftEaKr0O0xdS2fyKK0367wt7
	W3Tosz6mPDohQ+vWyQeV2rRw4LJWE43Y7jgAwoWM=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1726857381848164.20985485541246; Fri, 20 Sep 2024 20:36:21 +0200 (CEST)
Date: Fri, 20 Sep 2024 20:36:21 +0200
From: Marcos Del Sol Vives <marcos@orca.pet>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git" <git@vger.kernel.org>
Message-ID: <19210b887c6.f59622352625372.1022723129771458212@orca.pet>
In-Reply-To: <xmqqsetugpip.fsf@gitster.g>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
	<Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net> <xmqqsetugpip.fsf@gitster.g>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

---- El Fri, 20 Sep 2024 17:51:57 +0200,  brian m. carlson  escribi=C3=B3 -=
---=20
> That is, POSIX forbids failing to open a file for writing because the
> permissions are 0444, and as such this is not POSIX compliant.  Note
> that the operation must also be atomic; that is, the server can't
> emulate this by setting the permissions to 0600 and then doing an fchmod
> internally unless nobody can ever detect the intermediate state.

I'm not sure why atomicity would be an issue here?

The file already exists between the open and the fchmod, so another
concurrent thread would be unable to open it regardless due to O_EXCL and
O_CREAT.

In fact, Git is *already* using this method of opening with 0600 for
writing and then chmoding to 0444 when writing pack files: in
builtin/index-pack.c, method open_pack_file opens with 0600 to write, and
then chmods to 444 in rename_tmp_packfile.

> Other folks may feel differently about fixing this, but I would suggest
> against it.

I understand that it's a workaround required due to non-POSIX compliance,
but considering it should have no impact on any other OS and will actually
as you said make buggy NFS mount work, IMHO it'd be still nice to have
the changes made.

---- El Fri, 20 Sep 2024 20:15:42 +0200,  Junio C Hamano  escribi=C3=B3 ---=
-=20
> It depends on how hard it would be for filesystem providers to fix
> their ware, but (1) leaving our code to require open semantics of
> POSIX may serve as an incentive to encourage them to do so, and (2)
> I am not fundamentally opposed to have an option to help users of
> such flawed filesystem, provided if such a change is done cleanly.

You mean adding a Git setting to, for example, disable using 444 mode
altogether? Or do it in two steps (open + fchmod)?

