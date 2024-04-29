Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693381745
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405639; cv=none; b=FxsNR5CmJmxwtT7LCHxBVgVXhXO012YBpIyGXCF70voU8DunF6CXNV2HJajO7pBlju3BQVlXae/VMWD3YymPRpahMrzd21pVeNaROio72kkpPBCGIEVWyXfv8Fi/gel/XwRf9LDq2c2TD9/O5wCpeVLGZLS2Qwg90mwqJjrJGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405639; c=relaxed/simple;
	bh=x3mlgntx9qfJT6kn681yeeVw1o7MQvnYEAHxAPoXt4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtTzdp5DC90HSQKW49mwSHfd1Mkd9EX4NuBYBRbeujBSxcj0LwsGUQHWARl2G7vexLzMXVoq/3tp5fLDIOAki6bt95ouGI8Gr/clSK5Gzm6FyX5SnStvMWcsG/F6KXz7CtU+Ivlr641r7jwcGBqpp9Vm+rHgdf10z8tiJAZagyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L05Qxfzz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L05Qxfzz"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ca95db667so4072705e87.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714405636; x=1715010436; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SQGRxVJTN/KXminojOp9dGuSPzxRmu00LMnxbqOpsB0=;
        b=L05QxfzzA9GlMxaoRRd9hkk9oI3nCKUC575vt01fmFg75DJcB8P7Tp/1ntWuQTjtBZ
         R4MIi11T2WM6CkTXgrJm8ptlTwt22tlYR05K70JwxZXNZSnPjueGaJQ/c+QXwnViW7kv
         ML3yPDLppcomnQChhjokgv/yNSFCPF/m8igbLfhNrhCUJsmTbBRd8YI7rNtqjs4Ax+Yl
         GuIIneWEDvyIGEy5KTww8hOstKrToGKdMwWu83A5WIXdvCMA3BhrDKFdQR69gX3OezwJ
         vsCdZTi9oYmf/8oUkgd3a4ZYOvxNKFWuPt9bMZBaE0U1UjZmMmxLZm0p6W8PxDb5CP7U
         +ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405636; x=1715010436;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQGRxVJTN/KXminojOp9dGuSPzxRmu00LMnxbqOpsB0=;
        b=iF+bBga8SHKioAW2bH0p4m7lrM5AG4Hb9f4TiMO9LpNNbTJMv807iIleFGADssmdJs
         5nXF5eFCIY5+c1icO7oxuDOKcN4YqDrc9YW05TA3Dx52w8/VCTWrrE6A1XRcS3QYUUGJ
         x21JdYccuNd6Ar71xN7TsUHD684ZpGZAz1ogxBLYG2JMe4si43X9tRcoEtR0an12eFft
         PObo+0A1ml1L0GJIO0VKk8b2a2QO5K6QTM0zrXqg9x+hqsb3r1fcBR4Sc3CjRwfyqLVi
         z11rh4BZzpTg2ClUVc+KTI/pdy3T09nd6XXFbcI6k6mSnxtGdqXFN+jLuBRKPwssU7T/
         x0yg==
X-Gm-Message-State: AOJu0Yx+IaOFCHGta/DEvBflbGd6LWno4VIU7ARW55qoGdznKbpyCIdm
	0on211bimdllKc0rkN8itr/JiQnQ3+dqVs0CE+YoGK6nJ3ufKHOw
X-Google-Smtp-Source: AGHT+IFVaqX8E2l86/7apE+MEvkMkHiwKBqmUrOy8yXAhsEgM1dNeeEZL9MG3qZgSWclNyj2NjlYJQ==
X-Received: by 2002:a19:750c:0:b0:519:611f:df49 with SMTP id y12-20020a19750c000000b00519611fdf49mr8068574lfe.69.1714405636225;
        Mon, 29 Apr 2024 08:47:16 -0700 (PDT)
Received: from FBUtveckling ([128.127.105.200])
        by smtp.gmail.com with ESMTPSA id d25-20020ac25ed9000000b0051d66f20405sm675314lfq.243.2024.04.29.08.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:47:16 -0700 (PDT)
From: "Felipe Bustamante" <fisadmaster@gmail.com>
To: "'Beat Bolli'" <dev+git@drbeat.li>,
	"'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>,
	"'Karthik Nayak'" <karthik.188@gmail.com>
Subject: RE: Use of Git with local folders
Date: Mon, 29 Apr 2024 17:47:17 +0200
Message-ID: <000701da9a4c$83d53130$8b7f9390$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqaTGlgD23Aqma2QeSZ+yiqLOwNtg==
Content-Language: sv
X-Antivirus: AVG (VPS 240429-2, 29/4/2024), Outbound message
X-Antivirus-Status: Clean

Hi Beat,

The technique suggested by Junio C Hamano resulted in a resf error when exe=
cuting the for, which did not allow me to obtain the expected result.

On the other hand, the technique that you have suggested to me did give the=
 expected results and now has a master and all the commits made for two wee=
ks.

Thank you very much for the help, everyone,


Felipe Bustamante
Sverige



-- 
This email has been checked for viruses by AVG antivirus software.
www.avg.com
