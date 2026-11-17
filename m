Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959187;
	b=JXfvDC0sm0VxnYctBFnn9e1TyFP2SYCMtO8CBXgBJjely0b/R2Z/Zfu/XWv8EcT0HkSE
	 5F633Kerf85y+7fvGYw5ePKUdSIxz1OS5ybafub2cML/Pe2ErYCccphwOdlszpilrPBP9
	 NPzrDfPQTqCscVglT6P/xXDmL6HNaUi3hca8FiJ3LgUSlXjTARDwERVcPm37BcyDsz10b
	 dhQc1Sj3Qb8+hC1trvB+9kGv2vUsfCJXjKjlWteUrfsHvEbg8xCBSXDwyH3LwbR8ynYTj
	 4+4xIuMPdZHcFu4W5EqAD6l7G8PweemkupByv71r07ji/DMSJQLe9ywVHOh3h2IjRBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=piJdStcd/hbMuysWwScYhnGc5VMhSnaFeA3HgRJ0+zU=;
	b=vpvtDi+OqHzdUmk5LNpL1E9cV2YHaLaAHRW3Zo9ihGi/FGb3AlkRmvpVZ7BjqtJQ4lnf
	 KtZawXENcoUfyQOJBZ152MsX2aJ2vUSTBXrmH5KSPP5Tz/bJsV1/mwI12dWO8XxC3Suth
	 toS8SQoPwN1S2En/JWR/Q6RE/DdPKnPyfl9Z9CwP/B7DmI4krwIpikkEYqPpFtZZ0/OWl
	 YxN1AjUCsqGrk6VI/H80mveXI3NbOX5IrXsauh0Q34d1AMb8bLDOZ8BQIprAsIjMe6YUg
	 nH92DcFzMfJRPRrmhBG6E0Hp9WgDs2CTPTykUn20I4opvUtBX/qVumgWjeQbPEm4NFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7JyUrSl;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551C606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1551C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7JyUrSl
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8629fc8ad64so189956a34.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794959186; x=1795563986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=piJdStcd/hbMuysWwScYhnGc5VMhSnaFeA3HgRJ0+zU=;
        b=b7JyUrSlnoF+nEKFVy7+3GknxvmeL4FnTlqqiz8+cDECFnjqNyn9EnptgX/oGzH+Cw
         DeJ8DF7k/RQ7tPgdpsZ27EXHS10vuILV6bM2JPCquLlb8yppqICXlNjskwJLLFcSy4r/
         3PUHk8mNmZGM3UQZr2/wrtd2K/xNcr9d15B2FXiTci58ciHBKYeWEGGZX0MvJUYBO43k
         QichGR2Nuglmhm3uhTTUozjHHNu+JaSqwYSA/hc1THALaHlmnaLY7BEAPc7Wn3jG6cng
         ADjsu1HrgLWr51hLlDzf3QR0FikF6mRlhCGSejEGjREbB+Aw//BjOjv9i9yrkAOEHO01
         045w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959186; x=1795563986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piJdStcd/hbMuysWwScYhnGc5VMhSnaFeA3HgRJ0+zU=;
        b=G6grDstwOFJ+O2Aff/XpB2+g3vDKKqanN0FMh41SckKeNjtLCtePatcApRnL49mBTZ
         u00ijH0SmZ9CD5BGXty6o7SDxBdfI8IPV/WvGnRcz6EY0AArtH78k6DBF5ZwifQ/jGi0
         aYgsmTnjhMe8dJt/Ol7GJ4uah76AilyWx1pRJgOJJLPwWC2OUHZcEBf9gJ1yPdkLnbNG
         dopM3/KPmqB8DzivtaP5AKHQ3FcnAwxSJpLThGTe5M+c5JBVfMXDonxSXQpAEukQJzTQ
         sb6qqClmrgBCEslJBf8C9cvSEnKPQSOCWfzvOHND7uihPFtZ/xyh8q8CumPu3xghhtDD
         dLpw==
X-Gm-Message-State: APuU4Z98x8iQ20ViuzHAecyX55ufyqAIFQO+Ici2Wlaocaj1KV/jCRTH
	5409zbvSx508nScUj9K53NF2seJUw6F2QBJjAkm9aH8RjznHN/06Hx8OunB9QQ==
X-Gm-Gg: AYBFou2ryf163BqZyp5iasHniAQgddlQyKkbIXSx95MdwDTRVx48KYCRoZIb0Q9UY65
	LuHACLNiEWwEC/o4R3m7MWzLef5q3ZBysZ3jbvYBdS2kew4Qd8wEfItOqe27dCHwpO7dUw2EiKz
	gvLFAIOgnz5oV41VXdK1VQkxxlXrvuWFSq9h8pE3WXMiXQKYwAAsdliXAoUbqTMlfBQSYk0nLql
	9lejC8XBt2dSuUKZytkJnCFlREvfihUGHOSBt6l4TNdCOwHZNtg61z6HrdgACAPC+vNw4tEoxrw
	Q6rQb51ReSMNTqKDxNPyNtq1/ubmWHjZzS1sx0gCnZYv282Wyv2aOCydApMLJvmDXOHaRKS9qN2
	uPhi+4W2sVr5fndq30Z+/sIbqDTGa2vqw+z2AqlCjFd3m99qAKA9263XlwSjWeZPdYJTIgwRpCc
	gZfz3vlSTGp+aN6lYWRrBdPMpywerAW+loMHCo4JJ9czfwhUXiG+GpB3AZnuO+LDlUCyuxxS6Yd
	vNJjLDFq2mdcUKNHC4vMw9HwIrvwS4+74lXGxXJrqxuUqb79pnp5d4RGykTYHVXPf+88KxGTS/+
	aaA9DbMTFo2txcZgr0kg7iFovIU+EEnwqpKtedk3BnkL2doJ0S+YKg==
X-Received: by 2002:a05:6830:2549:b0:85d:4ed7:1caa with SMTP id 46e09a7af769-862f08cd866mr1253046a34.29.1794959185934;
        Tue, 17 Nov 2026 15:46:25 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f023760asm752675a34.19.2026.11.17.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:46:25 -0800 (PST)
Date: Tue, 17 Nov 2026 17:46:25 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] tmp-objdir: preserve errno when directory creation
 fails
Message-ID: <avznJsg7cB8NsP97@denethor>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-4-jltobler@gmail.com>
 <CAOLa=ZSonhP78j2sJdTwctp2h101jWZbvU_jcg1_TR41cRK7dA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSonhP78j2sJdTwctp2h101jWZbvU_jcg1_TR41cRK7dA@mail.gmail.com>

On 26/11/11 08:44AM, Karthik Nayak wrote:
> This avoids having to care about other syscalls which may be added in
> the future and breaking our setup as done in the patch here.

I think the suggestion here is fair. Will use in the next version.

Thanks,
-Justin
