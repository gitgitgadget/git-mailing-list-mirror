Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF247606F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132947; cv=none; b=u4K+1OuAE4+T+UBfb3xq85Urvt63y6IgiFbhxNO4TFFBs/qpUXORVeN/sHMt+JHwV76xcs4EhZH4j/ewaCb4YyUZF8hgooJUzCMx6Y+gdPGXOunkHLzmXdWKjsoPCNogDUlOEOz1qZ60U/nHPRSN7/9f7Ft7BaT1dZ9HhLwnVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132947; c=relaxed/simple;
	bh=hPtyq68GzOCoqIhd25xvDu58WN7GwcOXS27k1l7kOzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUGq3Xk4NGQtgkmpC27VGGQbFbi75sruMs4/pq7PFijOa7TeHIuciAQsxUk5ONd2S7V8rRg/PdzMImXN8nXnjFEKbzYJNb4j1TKNOwfJyT4PlhXZ62WZ35KZzEcoaeJaLH+eWuGBJDzaHdHLpXjyrEN1j+5jA4jQXvZG7voiijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=TomxzrUY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="TomxzrUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789132942; x=1789737742;
	i=oswald.buddenhagen@gmx.de;
	bh=V4MGPXYKTAxDktkCuwrzGwM3Hzva71XtMoyfYbrla9c=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TomxzrUYNSYQpC7n7MRUr/TGgdz60qXJBZ1FroJsYUClJHVKzioAFz6wmqj4wVW6
	 JvZO4gv8GrBupnQOB1XvbRSasJQ+ApwVm41KgD7sN0Ku8ng/3GCSEPwKvQHmv7xY8
	 Wv+5w0WbPG/L0qwetnbQ0P2YYv3bNNaxthQBWLFqrMW/6uscknqjHayYWMTuZ4+pU
	 Vg1r+ifhsHdaJWzohls1iKOOUtUu0YLzhPdc72mUkByWLse/ypZnjZNhamV3pP3S9
	 LPymk2hDUbiHO73XGFNn0ucUS0SMAX/WSRLE/uV8lap74emJE89UdVJIg+4gwmqNv
	 Y0i78mnad0Dg90VDtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1xJj9P2XOv-00NFjN; Fri, 11
 Sep 2026 15:22:22 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1x51Cw-D15-00; Fri, 11 Sep 2026 15:22:22 +0200
Date: Fri, 11 Sep 2026 15:22:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 04/13] mingw: only use -Wl,--large-address-aware for
 32-bit builds
Message-ID: <aqQAjiFQlY_ti4f4@ugly.lan>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
 <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
 <37c6563d7440b066f562de13bdbc174703a75909.1789020327.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <37c6563d7440b066f562de13bdbc174703a75909.1789020327.git.gitgitgadget@gmail.com>
X-Provags-ID: V03:K1:FiUqiZVgxkalZlfEs7yzxRNe+cG3Z8C6sH5eRx5nVlVvjcBq+NA
 GUmB+Qs1tbc+T+WNw0D4BjK6UTygrMmM/TxvofJDxcMipbfA7uZf+Bw5/j01+RBJmULCMEi
 3lYvtMeV3VnWoJsC+7BZkbQ+6ia254oqxnFMAWYtaeR6Wc/JuV4GYilRxBpxqVdel+pOHOU
 tWIg/YsCiRPEViWLu+2Lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aU85kZdC1RI=;8XDSaj98T4bzjisX2OfEwEOTxXU
 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
 Y=

On Thu, Sep 10, 2026 at 06:05:18AM +0000, Johannes Schindelin via GitGitGadget wrote:
>+++ b/config.mak.uname
>@@ -768,7 +767,6 @@ ifeq ($(uname_S),MINGW)
> 		HOST_CPU = aarch64
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
>         else
>-		BASIC_LDFLAGS += -Wl,--large-address-aware
>         endif
>
you're apparently leaving an empty else branch behind. that looks weird.

