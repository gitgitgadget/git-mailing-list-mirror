Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE66400E19
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875661; cv=pass; b=Z1v7yWrTw2Qweib7FvZ+AFDnQ09PqgtFcfyKkC58d1cbLCbBQmOM1HIQ6DNio3v4Hbak0H0C730lM4DbhVbucDOcaSy/doSZ3wjyN84s/ONaj3EWcqstM3LLoNhh17X2CKV822C+jXVrK3avF96zPo0/jTfPf2dWHZI1IlgfrTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875661; c=relaxed/simple;
	bh=BnCqgZQUetZxAFD5f4LjVxk4iGbg+GZDUwxk86d9rPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGfrZnkoK0goko9LFza4rZDQQBUcHP0Fzb4UWZFieVJ1nLZJH+4+xT4g6PXH5r2BfOjFRph0eF+hhb4xVUedxPAmlXF5pUm1EMn2a2OKhN8FTeCpHMyPDAaFkJGiwV/O1A3fEV0cH+OQb/st+6+AjGEmD7Rq3GPsQPY1uBTA9v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rro0JusN; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rro0JusN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso2265400a12.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 13:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875658; cv=none;
        d=google.com; s=arc-20260327;
        b=B/S9CYqRisMgI6pFzn5ZaTzqeVE/ElIBI6mnym3i1CMrEXMJALR74TdkCzL+7mAYve
         pWoFbLl9i/YQur7Y4KPekHB4xCGzOsQrQmrixr2662HcIFZbq9axnVwT6LsQWaT8SCyn
         oJxlNI1pyT5IfecQ49jPK748uZdj/H4i3CFbfy49yecAankF5/15uARUXa4zO93HGWUo
         naHrxb1LLEwI9FrjTORgwE7lLJmrvn7IfhQ03RhuU4rIaY0vXwRzM8PMgYSuwZP1G9z6
         GhcyC1FJJA6uYGTJWFSCDafffzcTCTRUGiyaU2INMFlXupbhqTV/icPVvbObusM6PAEz
         xrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BnCqgZQUetZxAFD5f4LjVxk4iGbg+GZDUwxk86d9rPk=;
        fh=8P6dlj7/yd118jouiy1/nXSl/VisxccBlESWdNN4b9g=;
        b=Cou3qnVwnsJSbSE88a3SVsWEXMTHqQunaE0tBcww1MzGRDkPrpBW602fJzp1iHe3oM
         8lDi7i/aYv4dpjm1BB8qHF/wztXnKrEvrDJ+MuqRjDVnX/H7EioV5ZCfdW7XwkJ7Uvg/
         SxLhqGiKpDCsdwJEa7hiQt6kefTmBcW8fXKu3HJIgac48GeS5y15YNXaiFT7/6J5aplo
         JlZw6N9bPZpmh/oYI5QEaTLMFnQQ57h/W+IfB4JZ4QkuGu3uthhKxOroKtJDMDV6p2ww
         uyGQBo88eiv2iPxR0kMfHOgeOvH7WgbccoIAJOrzFWI15ltKiJEMcc/1gbPfGB+GQV8c
         PbmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875658; x=1786480458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnCqgZQUetZxAFD5f4LjVxk4iGbg+GZDUwxk86d9rPk=;
        b=Rro0JusN87uc4riCutr59fpZqA/FtKPeoTRfRdmiVz9rIe0xy4dencY0c8F6IhYr3S
         cGQMlmarEx4Do+VyFPxdsRYnuhibfozpS9pdrWibap3gYYgHmmOC3NqP1BxshSidyKw2
         LrIWVgDetmjy5fnkNAd58d2FitbhtWz6UhAknsONDSXvWL8u8fUI/UjIF5DkNv1Ay5rO
         PBibTbXjpSVXHwr0VAtc68ojlhDWm+gfMOdlO/fjS4aEILEu7FXWx1/SGVCm6s/WzCMu
         0KfVndwBxP67i6/+NNSY8KfTpiWPYboMJ9KoP4N5exj+6UG7PgKPkJAgnDkxe3wSckUt
         rBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875658; x=1786480458;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BnCqgZQUetZxAFD5f4LjVxk4iGbg+GZDUwxk86d9rPk=;
        b=nYFvkbotFN8klxbguhMRtD9u7V+/Vz1ohMbJ/sHAnA2UwgQbufQg7xhdozn+pMG1vg
         lQuirQuQP0adTN9booFEfUmGrBO/igaHXMZpo5/xd/iy9hLCuaqYIvjCIaBKb/iYDMer
         Qi0TW1sKMmX2w/g2TocpCU5tcI2IURRFp2IuBK8s6uPEyh4dafp/Djvam5+ePuNlTtde
         ID9G7jUFa7Rh3722vH/1+gpNPZIjmU9nlEwmrGI6eUMzGMSXzmMuDZ943BRtXHZR8VW1
         JP8AOLGkhOfF7Otcp/emVGdP0QkAjR+eI4o4pv8+D9RJwakKFJVlFSb7VEpNmVJEKXwR
         KhDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfcOupyKACo0jxSBltOuKYNF11gVESN/d6j2XBk3NLndIZbmhOiZnmAxOXw0POiwazAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtK4rm9Dpy7xes+UFWMP6InAKX37HVmaHgT+1lhHPfoyyoOXkl
	NM1/aC4Q372m+JQSJRc32xaFy2JJ38cjzXmUPzza3Qjbz6Z5f/auknn/icXjv9F6GheHzA1iowX
	ZoAMnRQuNqMp+gejrk/jGpue6goakZso=
X-Gm-Gg: AR+sD11p3ahsHFQyn7cZUmZlbc9jL6zEdlyEJ70C13KcmevtMP53yFR/+spcp38p8/E
	kIx8o4wqzxkC+0MlgLM2aTz1zSu4Eif02z8tCUslm+SoRJiw7CZAbYQkOWi7buPPgT0ehDapydG
	h4TBnPeSTG1D/OfB0EiChYlnsnCh7NlvvUh70dBvZ/74m9uxZsA/zQAsfIub1K0BL82Vxi3topA
	GYEic5pQW/uvVpgJ4WxlolCkR+iCSol4CvY7zIka3ZU0Lnk80rI7cSZsWuA9x+fjUQI1NlEwjWR
	BFlw4W6OEpbSps5Lgd89FUAHeoIOPpOiiPduoS5VlYKj
X-Received: by 2002:a05:6402:5045:b0:6a0:a46b:ad3c with SMTP id
 4fb4d7f45d1cf-6a14ef057b1mr1065855a12.1.1785875657606; Tue, 04 Aug 2026
 13:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
 <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com> <0ea7bbec-3381-4bc6-99a9-2c3b5d1bfebd@gmail.com>
In-Reply-To: <0ea7bbec-3381-4bc6-99a9-2c3b5d1bfebd@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 4 Aug 2026 22:33:41 +0200
X-Gm-Features: AUfX_mz1GkuclldsFTtxFDxsWiF8vIdzA16XneZD9tiCnUFM7eyprbsbR87vxBA
Message-ID: <CAHwyqnX37oJU8797XTZwzV5-mj9pOgj+AsnO9+UpS4QGu5Nyjg@mail.gmail.com>
Subject: Re: [PATCH v24 0/7] branch: delete-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Thanks!


Harald
