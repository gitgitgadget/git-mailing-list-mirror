Received: from mailout7.zih.tu-dresden.de (mailout7.zih.tu-dresden.de [141.76.32.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B627A906
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.76.32.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760210299; cv=none; b=Ke9UPsOvJT41ZvZRp0+sRksk4nYPSU03WOzfDUkE/ifJo4Qkkw8XN6m9px+x2iSnLYsCZAHel2tGx4O6NtnD53U/zkXBjf0ypHezlBf5ljncm3C26WF4w225p7rZdU9CS6+VJvvvvUm1xg/1pboASjAj2eR0kjV9T8Q3pq4xYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760210299; c=relaxed/simple;
	bh=kPFctZFv4LFUiIhWFI4jTu3O7QKM+wzmSkN2ydsnWIs=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=apDSjcxyIQEYndevna+Ez0WYOAnavODqmrN5r4U4mOkE0pS9/KrYyyrjGkjK2aTH3/k4/2QFGtikvsbcLMDmK+aBYupa3RFdTEXf8VoyoTRUbKslynsR15v3Tlc9n+rUFo2kpuex63FahdHjzhN6FtRMW70szyW8hzh0x+yk428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=jZU/mUmo; arc=none smtp.client-ip=141.76.32.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="jZU/mUmo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qdLv/u3vxZGOK36RABGLOmuyCGC+9lkQTR5L3N7aiYo=; b=jZU/mUmoasLPeDM3NB22VdIGPl
	AYl9lE8xOLFaRB0lcc4hhO5kx/HCjBnYNzcU3g/q4a+P3e4AzNAdwqscwUTH8oHvr1a0cNdTmSoRB
	NjCnlDf5Jd8BI6DygIjqtHgdzuoiB8RPPveG8go6fsYlQSfSqP7mrt6vWjbveDIe4UChF/FjXdAE5
	iqgYdpC9PqHfVHZXkOo84Vpg7/Wz9P454+jObtW0h6Onz/H8qrdduxTVQsXs8KgzkZ3rowyrOUqEY
	GEjLI2IwPIc3ZRXlEwy8zoczNPbQWq0GanzcPeYpnTwbP0gpz2+lnQRhD0XDeZmXBr++JRM7nR6fa
	IKMeA9Hw==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout7.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1v7f6W-00DQ7r-1W;
	Sat, 11 Oct 2025 21:18:12 +0200
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Sat, 11 Oct
 2025 21:18:05 +0200
Date: Sat, 11 Oct 2025 21:18:05 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <xmqqikgl5nj3.fsf@gitster.g>
Message-ID: <a13ed806-a04f-baae-ffa2-f1d12a0b3b0b@mailbox.tu-dresden.de>
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de> <xmqqbjme8rs4.fsf@gitster.g> <c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de> <xmqqo6qe78lf.fsf@gitster.g> <98592a42-71de-d86e-a727-32115615a82d@mailbox.tu-dresden.de>
 <xmqqikgl5nj3.fsf@gitster.g>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
X-ClientProxiedBy: MSX-L416.msx.ad.zih.tu-dresden.de (172.26.34.136) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout7.zih.tu-dresden.de

On Sat, 11 Oct 2025, Junio C Hamano wrote:

> [...]  Please
> fetch from my 'seen' branch from any of the public mirrors, and
> check what is queued as ac6152f0 (contrib/credential: Amend and
> harmonize Makefiles, 2025-10-10) is what you expected me to have
> without your mailer corrupting the patch contents.

Yes, it is correct.


> [...]  So it smells that viable choices are only three:
>
> * if the original did not use $(MAIN), leave them as-is and spell
>   the values (like "git-credential-osxkeychain") out.
>
> * if the original did use $(MAIN), leave them as-is, without rename
>   it to a longer and more typo-prone $(GIT_CREDENTIAL_HELPER).  Or
>
> * if the original did use $(MAIN), spell the values out instead.

So the combination of the first and last option seems best to not keep 
these differences within the same context (contrib/credential).  Do you 
agree?


> I prefer to do "clean-up" patches and "functional" patches
> separately, and introduction of the install target is the latter, so
> perhaps leave all the changes to Makefile macro trick out of this
> patch and concentrate only on the new "install" target?  And then do
> "clean-up" using Makefile macro if you want, with merit of such a
> change defended separately.

Doesn't it make sense to clean up first and then add the install target 
rule in another patch if you prefer to split this patch?  That way I 
could keep the first line of the commit message intact and the name of 
the branch you have chosen would still match.  Moreover, it seems to me 
that we are not that far from agreeing on a "clean-up" version.


> Thanks.

Thanks for your comprehensive feedback.

Best regards,

Thomas Uhle
