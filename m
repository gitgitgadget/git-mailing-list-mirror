Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267B194AF6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534987; cv=none; b=sUB3k4XU6hfHY8mn35oWK8AddvBjZYwJFJMWroM7wpnIdZcuKxtf9yuqL+U25kokPV8R99bNixEAFLyZrq/vlFSTjmVa2hX9UkuIcc/yG4N25PMtYTTIb9mLSe3aLjPlhAh7rmye1STtJ3pgqSdT1J5BgGNsjP2yvcOODv6sk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534987; c=relaxed/simple;
	bh=4Z/R8O00zgA7GF4Fgf3eQbEMHsNR0K9KoIq2xjWyuZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG9sbASTRLn1w41qlO44UHj0X2WmL5YK4vP0cEIV44PzZMkIhwYWbcFNcC7F1BwcKZyr6ZEasAQqzdsBqSwnB8GI+P2P0F4Ya8k/3vth0+vqaDtSOlLsgQhLjIfwL8xgFsrIjMIyoXEo/yizx1G5Qd2ba0EX7SqCjQxeiDR0mpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbd12de220so6877466d6.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534984; x=1730139784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkxftTivdxwuhEH3eOQbzKwzELz+EwFzbdEvHTuuAQk=;
        b=w3mRZ+UwON8xijYowiWrBVMHwGQCku+iz61vkWu27OAnuvJFJZt9rV9egw55csN6f3
         t6HVQvKIr+CI/N4gDAZMErRuATAMIIVNnPfCihzBKG5wK7PW9Z2M3LsOphLhQM7yLyN7
         fzBc2SkMA4CKJi/Qxtx8fVTOJLDkJLGh1WgcwaalO0AwTq+TXQ3/Lm7ZNAru5Wq+yJzs
         VhDqHQbGNe8SblgdCDUnW6vjz5BEzPuzGswEvKvEMqAqs4cZR9AChV/TW3yAoL4HRDS4
         F2TWUlMP0zs61hYXeJfj1GO7HyDp0+mDvK0o9L6pf8oKDrQolz2bnyrcHFYgjt+q7zJi
         lT/A==
X-Forwarded-Encrypted: i=1; AJvYcCV7D1mIkbINd/Fbb+LGE0WOVhfrfyfLhiro6ZjGht3SgyfBuIwwLIEVH6cfj26ihCEK8WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsvWz+fqNS44b2J+ixJ3BE+oemki95nmQYkvqoytQUElb5lWk
	PralbpN4Hchp8pzK3Z2CNH/YcyFDSvr6M5yDYpNuSzsFgZHwkbUQGSRDBZ+DyFwQJP1hIgLIOoe
	QRgKqpz14X0Y7eHIyZWF7Pp+C4d4=
X-Google-Smtp-Source: AGHT+IEjCmmctKoPvsmquECAyMJmmEPMRVkAk0etZV9BCg4w3WwKumJm62pnaOWV7t1EXAcSeOFVo66szV7noWYWTyU=
X-Received: by 2002:ad4:5c82:0:b0:6c5:bc1b:e20b with SMTP id
 6a1803df08f44-6cde1604c2dmr80628156d6.8.1729534983276; Mon, 21 Oct 2024
 11:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
 <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com> <ZxZByGdre-lup2sO@pks.im>
In-Reply-To: <ZxZByGdre-lup2sO@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 21 Oct 2024 14:22:52 -0400
Message-ID: <CAPig+cSb-2c1kUfOQ0Qzdh7ZXfSeF2FoboSvwYUPfkXJ=56BZw@mail.gmail.com>
Subject: Re: [PATCH v2] notes: teach the -e option to edit messages in editor
To: Patrick Steinhardt <ps@pks.im>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>, 
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:00=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Sun, Oct 20, 2024 at 12:03:00AM +0000, Samuel Adekunle Abraham via Git=
GitGadget wrote:
> > +     echo "Initial note message" >expect &&
> > +     echo "" >>expect &&
> > +     echo "Appended edited note message" >>expect &&
>
> When you want to write multiple lines we typically use HERE docs. E.g.:
>
>         cat >expect <<-EOF &&
>         Initial note message
>
>         Appended edited note message
>         EOF

Nit: Since there are no variable interpolations inside the heredoc
body and we don't expect any, we'd normally indicate that by using
\EOF rather than EOF:

    cat >expect <<-\EOF &&
