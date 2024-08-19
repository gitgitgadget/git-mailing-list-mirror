Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44016131A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069719; cv=none; b=lXK2FWWWWry2rkB/HXphoBTd3MB6eHHHxMxmmRZyouW2yEBJX+PclEma+mhubkWNrZchc84VEFabLD/GJMr8VLHnpG9x7FXtXW3k94jBm8fyfbhWZ4+Nq5eAaCDhch+R1WTveurIA6ME3IfFFs8rjCXPWbU3JkcEMHU/uTKqVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069719; c=relaxed/simple;
	bh=n9JvbFywyURbEwBEi0FiYaHRlaV7runS7NOuLUNzIak=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To; b=fonb49D2xuyhaTUctMEjcLX2nAiT/GmdLdjBIK2C+kxrftzTiqd6OIUgXLmK4KcvonKEeXpH4t5KGQ//2iJNdTvvxP4d4JuzokhIeSnJiyK8b6LqcTfblmn11bdq7S4QAOylMw92PP7wGgAQXipf/MVqKS6SErawPeBXjyFx0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBhOyvyV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBhOyvyV"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7bcf8077742so3150484a12.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069716; x=1724674516; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9JvbFywyURbEwBEi0FiYaHRlaV7runS7NOuLUNzIak=;
        b=aBhOyvyVOcx2/r0Rl4fiiGwG5D16HAsh4BXAwPxk263VXKhtvjqCZpEaH8ssPlgv7E
         e5+rfBa9Y/ZlWn8exkfql6A8Jb2BF/zSQwW7Fnc3dpqcPuLeqfcJGbHbihWm4i9g3mPN
         1N8yUAqPpsasJXX0Br38dP1VvASgzw6d6XpX9es8yESLu8YciYFiGyFEoeRMcBoJfDcb
         oxtFpj4+jj8XdI4ldUulBsAVmkZ5mYezSxFOT8elsChfwmHPOdA+KSh63bTq8znGkofT
         n/6EcAHsSiraUhE3n14fwAaDC1eLaVnC4GDmt91yRicQKjvfzA74+JrjWnNCE3MHJrnn
         RMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069716; x=1724674516;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9JvbFywyURbEwBEi0FiYaHRlaV7runS7NOuLUNzIak=;
        b=e7qXDPKE+PRwjUmjbaJYSJl87D8hlU00vpJ5lNTBAj8ZAafDzCY4LkwM1uPvQ17bMr
         5sH5aZ9C/oSX7+YMstRYe511tAwA7u1I9r8S9yDbF5ZAP9GCHv5rio3O0ymbSrpnHU4v
         YYKZJvZI3EuHNXWhZgUy6+bljq7v5fQRUmPMPEgt7tPDsa11xsfzHy0/FZvYvYWUDW6I
         Cvv1agXTd4l3HfqDZTu68QVEisCbexjvHTq9L0cLrDDuSpCeSSqBdmgR2zK+2FD//Hv1
         JDPKLoSbOo/jpZthukZbMZc/jyQCazNkJSL1GMb4L39RRGSiVlaW0KhrsZVFccXA4sDP
         7BPg==
X-Gm-Message-State: AOJu0Yx4gBJtUSjtMTAG9F4iF25OCfrZTWaljd7QJW6qYZNADgk+0BEZ
	i8e1GRTjsSXmIMJsfn4w3gt/7O05xrfMKPLmqUKZRcy/i/NwOlrm0NLkBQ==
X-Google-Smtp-Source: AGHT+IF+gfc7wfXK0uu41lgm+ZTMjTors1LSZ9zRl/BDdR02wJlP2NDqXWfXB+gFAhh47AUU962H8w==
X-Received: by 2002:a05:6a20:9d8e:b0:1c8:95cb:c42c with SMTP id adf61e73a8af0-1c904f67d7dmr14646316637.6.1724069716135;
        Mon, 19 Aug 2024 05:15:16 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3fdfcsm6461623b3a.219.2024.08.19.05.15.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:15:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: =?utf-8?Q?Hello_let=E2=80=99s_start?=
Message-Id: <EF17EEA5-3E4F-45C7-9243-C6A92D0E0D1A@gmail.com>
Date: Mon, 19 Aug 2024 19:15:13 +0700
To: git@vger.kernel.org
X-Mailer: iPhone Mail (19H386)

=EF=BB=BF

Sent from my iPhone
