Received: from mailout7.zih.tu-dresden.de (mailout7.zih.tu-dresden.de [141.76.32.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547517A31E
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.76.32.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186778; cv=none; b=DBJuPqFjnD/QDJza/rs7wsAlv3CIN1D5ikxvsxeryv1PeThwQYqYVyKkfeihg7fuCgi+njWXixBguj9ys2NruZX5+oJOMuvizlXGwi2KT89GtQEOWka/F9imxaKg+TdIWOaOOvi/QKqjbSoZEwEWsbMvQh5fJZ/Z5MqafPMRn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186778; c=relaxed/simple;
	bh=sWaa5Fj6W46uYznNDoB68euJ67wXsIQvdIa0BrT0Tws=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MKbd+li5vVCjbOLuAFHwVzD1/UMf3B3KrZCyZFYLJdwRCsz9cpLt/swmQH2hPiDGmO10xd89sL++AMx+Xh0V1/lRlOpMiyFE2dudw5gXP10QTJyQgwcu6CqHuK9IT9weVZkCe2m0BslrdeyDm0d3Zs13f49xmh9b8EQ+T1GkIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=CbrRmdY8; arc=none smtp.client-ip=141.76.32.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="CbrRmdY8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+OaA2MNxXnMcTQtNYI3TclJk9dQNDoBJbGx99Xtu1rQ=; b=CbrRmdY8yx3OpUT7JFlVdrC6gY
	XxmlBBWid83JD2PX2if3xDiiMv/3ZkXWk3JMWI2O8sZVir4W69Ybrd6juFBk9mvrnCTVypSqShRiC
	u0Wk0f2/Z4YlPrQDFErLjM4Kj4/RN2xBB1sXwCQti2L7DZvZSZwt2vVXJKiSnyY+ROWr3UAswfVGh
	fNNNBSY9GtAmQccW92U9G650OK4PuSpBuN4RRdw+GXmawbgFu6BlB8JXcma9rEYm3wD1Vds8YDjOk
	WwpezjpYTfkz9Rg8NfXyBOsfwUnEq9D7bJKLVBoCtIjHoZU6T2ytdSxJEpGcoE3zsUoynyzBHrrjT
	Z3Qxb6uQ==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout7.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1v7Yz5-00CEUq-38;
	Sat, 11 Oct 2025 14:46:08 +0200
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Sat, 11 Oct
 2025 14:45:53 +0200
Date: Sat, 11 Oct 2025 14:45:50 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <xmqqo6qe78lf.fsf@gitster.g>
Message-ID: <98592a42-71de-d86e-a727-32115615a82d@mailbox.tu-dresden.de>
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de> <xmqqbjme8rs4.fsf@gitster.g> <c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de> <xmqqo6qe78lf.fsf@gitster.g>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: MSX-L414.msx.ad.zih.tu-dresden.de (172.26.34.134) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout7.zih.tu-dresden.de

On Fri, 10 Oct 2025, Junio C Hamano wrote:

> Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:
>
> >> Content-Type: text/plain; format=flowed; charset="US-ASCII"
>
> Please make sure your MUA does not corrupt whitespaces by sending
> your e-mails with "format=flowed"

Shall I simply resend the patch unchanged without "format=flowed" or has 
it to be a v2 patch then?

Should I also rename $(MAIN) to $(GIT_CREDENTIAL_HELPER)?

Best regards,

Thomas Uhle
