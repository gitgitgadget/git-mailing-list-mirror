Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530799450
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708902649; cv=none; b=bNTMYCsuzScWRCiNcLQSvv2BLjHpgCN95Fh8JZ+C2ro1hNmBDApZtMFL3ljlJy3ph4VdKZrSfwNr9eXOEeCz0EC8NfQtTkhxmqOyfQmhgFBOEqqGTELFBGQZApL38+FX/BaP4sTFMygS9XHtqmiwrHHEVdVL+N86Q3sJdahX35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708902649; c=relaxed/simple;
	bh=ZD/HL0cTs6Sh/prnwwZqAJ/Q2ff9hfN9ZtfV2DVZ5nU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=sZi6TpQKzpq+/FttCLHE6Q5HUyw+KXM3JJNVMCt9ir9wGYwkSxX2PtRkbTpixs67QR86qPlV57zjHYK6vvXi051qdttWQy8XI7DSkkwhyYQy2C/GgPuscKURbZcRvIbi6rModH08dW/SzEvOauDxX9Yc3EqnXw1trQTiWWX5/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/Z6uXsi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Z6uXsi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2485639a12.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708902647; x=1709507447; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD/HL0cTs6Sh/prnwwZqAJ/Q2ff9hfN9ZtfV2DVZ5nU=;
        b=l/Z6uXsibBMJ5cdSDbxpX44hb9hrcml6k/7vZjyJL08tq17wNSUaRf0eb5lNvG0Kqy
         mpqVcNszlr5sqQ5St0DWQShYy7b68ePzwZtmzEZsHQwYPaR4KKbLA/27Y3oAVYKDBeOD
         QhCxN70fqk5/hkNnTvKjzfRzodJco59gqycog4SB9qiOfJbcAFex6pNVaaPKl8qVspKA
         k7TDQvbtt2LipWm57UPnu6lLs1hUrctP2tznmnewvF4aDMpjmPnwjTsH53m9knyhX0dq
         uVrmKPJU3rbLe0hYF+1EZoQZN2ZmO0ts6LGSCqZVp52qC7EdJ5bXpBYswRzuyKwWamog
         +v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708902647; x=1709507447;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD/HL0cTs6Sh/prnwwZqAJ/Q2ff9hfN9ZtfV2DVZ5nU=;
        b=mnwNg5BstFnBBB6bsaIEJr9obz/u/5iuelnCfTiBQXVJuU/+Y42QmROSMQJ4K0XMp3
         4ZFX9Rqxl9SqChsrgpOBgkGVjienqqVrD8mI6OqAGPjeUVBaN3+5O3k6ArNqBJCqi5HO
         9JA++bMvQPaAjFnBZBohId2oiXkRMwxarsSACvsMU47CW81XBAVkmkYuWNEe5M5e4T/X
         yayAZpl2bTEvVyp4HuBYBWocwqvoXUuS/5pXcCf4bUx1H3GvnZVlyliqbenOojdPm3J+
         //3nRTmN3avvOOV9FjJYS4sWq8khxKO9GjOAqtOSA3FkSbJwexSn3UJiNgGkT+5qoRiw
         Gvuw==
X-Gm-Message-State: AOJu0YwnbF9hsoxAjbfGXxgSYYTW0KPdVp1m66JWfdwXodwdG9e3AOOk
	VHJGxt0KkVgSbjiE7dIEmIkQNeNRg9QOb6brO7jJMiCQCxwExIMiYDaot6PW2kI=
X-Google-Smtp-Source: AGHT+IFtekgviFWL+ADtP4VLg2beHodF9xfrDroo8j/nx8RIEZ4B0uRpeIaVz7P8QQRZtgG4MxuMrQ==
X-Received: by 2002:a17:903:258e:b0:1db:6722:5b3d with SMTP id jb14-20020a170903258e00b001db67225b3dmr4480571plb.21.1708902647147;
        Sun, 25 Feb 2024 15:10:47 -0800 (PST)
Received: from smtpclient.apple ([14.194.174.54])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001dc63fd39c0sm2690860plb.225.2024.02.25.15.10.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2024 15:10:46 -0800 (PST)
From: Akhilesh Kumar Yadav <akacademic05@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Interest in Future Collaboration for GSoC 2024
Message-Id: <39C00ED0-2EA9-4BCA-8662-AAEC5A108D49@gmail.com>
Date: Mon, 26 Feb 2024 04:40:36 +0530
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)


Greetings!

I hope this message finds you well. I am writing to express my =
admiration for the innovative technology that your organization is =
working on for GSoC 2024. I have been following your work and find it =
truly amazing.=20

Currently, I am committed to another organisation and may not be able to =
contribute to your projects at this time. However, I noticed that your =
organisation sometimes faces a shortage of proposals. If such a =
situation arises, please consider this email as an expression of my =
interest.

I hold a strong interest in your organisation and would be more than =
willing to submit a comprehensive proposal should the need arise. I have =
also been an active contribution at open source projects and have decent =
programming experience.=20

Thank you. I look forward to the possibility of future interactions.

Best regards,=20
Akhilesh.=
