Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100F317144
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473144; cv=none; b=HXCbOL0szUWW5BW2amklKDOnSr7ABmeSSzWxohl6IHUVDg3ltnLv3x0qbl6FAWbq6boIlOo1WGLR8+zBN8WKxJ0u3UbzsAJNriv0OU7C2D7DoCm4eNNncX1gM8CVnM6u669rOqNNb/Oy/n7iDP0XicNbL+IX6E90O7LfPeBlwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473144; c=relaxed/simple;
	bh=GkpFkfQelR6JMgAIf93r6S3zgkcvTopH1W5qBrTXLQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOP7U+KfoBQL+WyjpMZHTlzYILTagPhAGKcZqLkAZi1QLFXc63r8awizF12Eoci2ccfy+CKurL1nZz+gBKnahWbcbG1GuUQaJHh0NTEP+zqZ0DoKZVWrc7gFD6uDtKxyVyrFPd3jaMYtPPB5Yh39mJPcOAMgX7fWpP5vPKLyEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6kw+Axy; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6kw+Axy"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4638a18efc2so3556453b6e.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 09:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772473143; x=1773077943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4vKvi7syNOCWt6aXVuicVDJI8G0X+L1LPGndbDYvSE=;
        b=j6kw+AxyIygPlHAbiD6kCk3PApGhuACK51L03i4ieRI25QcNUBFjXKcMYogsoMEjA+
         Wm+ePKnqa9X1M/9AHTGkpBVYhAUvHmuQBOknFIYhkFVrvR4ezUvJA2LvFXgQAN3ALD6U
         UUL1guUZF3nXv4N3jIWWsRqXO3mSrrbnRJuNzt69ru7Kif0/ei1mIIxUYB4wUgYCAfNe
         LCzI1rJ7/Pxp3tCZDvYqV37xSaFq6IM9TfMpjtBGyfdJIO6wae+RGYbWTL5JLPAB6ve+
         26VjnNHLeBuo65DrXpNChFWr4Jo2ZIi+s+tKxckncqidP7gAQuzGoAmMD8V3CfWqhL/S
         e4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473143; x=1773077943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4vKvi7syNOCWt6aXVuicVDJI8G0X+L1LPGndbDYvSE=;
        b=lr83kepsNabt4JHZg5ziGcwNMM4sdMBg7tq4JZGuz1ef7D0lQ77ihoKd4EDrnhrNGy
         WLHvgxm8gKWqhgTagq57f7xpju/WYy33YV2WsUZVGNFnMpQ5Tv07A1hjv/QsanTMpncu
         HznJ1luVjipp+h0VtZkYgvnbV+cMeTPFmE58SI99KRzE9SqfaH0vYjXoWJ299XYoZsho
         +hvTodUiW47jd0ItHt71oBnNXZpu18pwWuhnz1JXBB8xDmwRiKvTm6TmtTK1BekUc/k/
         md9LQEQiKyZJcupDlJKE82RjEsMgGgW2Pj5GLZK1NteEZp63mMhJ8pWwl8p9ci/S13Cu
         1FeA==
X-Gm-Message-State: AOJu0YycM661u74ARecQTyq9kfLPDNRX/JyGUaS6jh+zEfigrhoiCIe9
	BQ1kGhZYY/pkT3K5S47XRFK8qPqIF6vesZs22fMEgpn0MRJM8/RH+Wco
X-Gm-Gg: ATEYQzwqJVJUDkGSOWlXNeKRsvEENnzNrlCCu5d0gX111gA5r4ITNFQ3qw7GNf0WBGZ
	9It4FFN8CKUJVVma0GtPOR39B2iX1K3NdQaOv5CmwweJIkbZ1pE8w6EuQPVAvu4g0aC7hSQs7ZR
	mX06U/aL8/9XNCI99ajE/vMgD3ONvr3m5qeTumjCkY2wbkaHUR97Zcw/0L4vTnXC+9ukvXiqZ09
	DSUeDj9aLdEaLO8eCQ+2wIrNDd9YGZfphywSKqaCbVXrKHgZ9L0ZMdH/mn7y56UFbcu0t4dtXjv
	QDaKQQhFdVua8/6nRKbmUSBu56ksAsVP6CjvXgMnOU7doAomc5Ay89M9o2/o6IQ4BRdhX+W9D8u
	WTR7B+HJR+TtPorN5tIv0WMBoC/Du/pwf7oDGFW9TBPdaED7WeZ5UD7bjAEA39yaJ+6R0e/atw0
	Pvwb/lp4uIAcE6SRvw
X-Received: by 2002:a05:6808:d4e:b0:450:b14:7a6a with SMTP id 5614622812f47-464beca012cmr7337401b6e.60.1772473142786;
        Mon, 02 Mar 2026 09:39:02 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab302sm7944377b6e.7.2026.03.02.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:39:02 -0800 (PST)
Date: Mon, 2 Mar 2026 11:39:01 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com, 
	eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 3/5] builtin/repo: add OID annotations to table output
Message-ID: <aaXLH9Lt-K3_ojyC@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
 <20260223174120.2356504-4-jltobler@gmail.com>
 <xmqqpl5r1dom.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl5r1dom.fsf@gitster.g>

On 26/02/26 11:56AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +	if (table->annotations.nr)
> > +		printf("\n");
> > +	for_each_string_list_item(item, &table->annotations)
> > +		printf("%s\n", item->string);
> > +
> 
> It is minor, but I suspect
> 
> 	if (table->annotations.nr) {
> 		printf("\n");
> 		for_each_string_list_item(...)
> 			printf("%s\n", item->string);
> 	}
> 
> would be easier to reason about.

Makes sense, will update. Thanks.

-Justin
