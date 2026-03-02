Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580F407598
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463644; cv=pass; b=H7F56I0oJ0+nN3z/VlbNjFeUCis0gT0EosTfO1H66kWj7vqe+3QTzPqlsyhYr//8C0kk+toM7Q+sRRCs0IRTD/cmKo6U9SgPY+FdrIM69MpxQoRtdE1cSu+9Njf/U3kKUsiXkZ6b9WToBTGH2RtnIGh2F6P8DoIMF+xFBTNC92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463644; c=relaxed/simple;
	bh=Zn2gTBg8AcT0IqvHTrX5MB4qJX2oqYGE5EpUpRrXKOY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Rz7JTWrnStFoI3mr/OrYTrUq+dTVXR08eH5n0G+U2yPhut6mm9mQ8la/aJ889tsp0Bi2GbNQCB6wliSFb8XYLCdbFeMwoldp6rUe1RqLCSwtMBqrFbVAha4mJ2KhEx+84lrEToAsc63ktNooRD1WfPL722z/xuyHVXOavmVt5gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=geBRcjRQ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="geBRcjRQ"
ARC-Seal: i=1; a=rsa-sha256; t=1772463628; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UJL9DGDMCrNPVXQbitz1uYyxNL8VIWTRHgLod7fhBfxPHAXXqt0KEHlMF9sbgN/1tih3DT25Z2Xvi0nV/IqS9lu08LXPa7QZJq941DjHAIyjpWM+by9HFnPXwvZtUYAuq9jYOUlFQbUtlMCEKzkOvX3SzsH95hBlNlhiY9QnbYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772463628; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fzMT/tBTCf3LPEKzALWW6vUOQAMIZ+q/nf66gNsrJxY=; 
	b=Y/DEXiAO0uQg4dq1EgXrJlDKyJ9vtBtzwUSK6vYAHOE/h7XzK9iokG9RyVNxVg9rcgQ2SDMkO+j8AFy3jTmkUrcoAASiJkt13M8k8JSXpnPkEDcJgMbmiNj9M06dRKF5RnPYmTc+P08sYS5Q7r7zvfOdsvE9nA8Y2plSMSj1IYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772463628;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fzMT/tBTCf3LPEKzALWW6vUOQAMIZ+q/nf66gNsrJxY=;
	b=geBRcjRQmTxw4l+VoDs8TB66si5E/JQ6dwTrTxdUgdaX24Ch1NJb5a0Qi/ucWkqx
	9oeTyLydfCT2+uWS43J8cWR05OFmVMGAO/PN30IoTQiA7cJUzeqxz6yq5JehVM484qf
	JVPzcPSJpdin7e6nnGiFn5jdN/fucbWhFSaA0UEk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17724636271131022.8420982430209; Mon, 2 Mar 2026 07:00:27 -0800 (PST)
Date: Mon, 02 Mar 2026 23:00:26 +0800
From: Li Chen <me@linux.beauty>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	"Phillip Wood" <phillip.wood@dunelm.org.uk>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19caf109a99.6c639fbf1370819.2681969272338930783@linux.beauty>
In-Reply-To: <56b1b6b6-94c2-4a2f-b473-9b4d09d6f52e@gmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-2-me@linux.beauty> <56b1b6b6-94c2-4a2f-b473-9b4d09d6f52e@gmail.com>
Subject: Re: [PATCH v7 1/5] interpret-trailers: factor trailer rewriting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,

 ---- On Mon, 02 Mar 2026 22:56:04 +0800  Phillip Wood <phillip.wood123@gmail.com> wrote --- 
 > Hi Li
 > 
 > On 24/02/2026 07:05, Li Chen wrote:
 > > Extract the trailer rewriting logic into a helper that appends to an
 > > output strbuf.
 > > 
 > > Update interpret_trailers() to handle file I/O only: read input once,
 > > call the helper, and write the buffered result.
 > > 
 > > This separation makes it easier to move the helper into trailer.c in the
 > > next commit.
 > 
 > This is still missing my sign off c.f. 
 > https://lore.kernel.org/f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com
 > 
 > > Signed-off-by: Li Chen <me@linux.beauty>
 > > ---
 > > v7:
 > > Use strbuf_write() when emitting buffered output.
 > 
 > Also renamed "sb" to "input"
 > 
 > Apart from the missing sign off this all looks good.
 
I sincerely apologize for that! I did check it during development, but somehow lost
track in the end. I will definitely include your sign-off in the next version!

Regards,
Li
