Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C34E3EEC
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974653; cv=pass; b=dx0xJJegbG/YejNsA3uyNoPm1k0G1ztbjcX1S46GBn9mSyGENWZaiK6gyibCSEp+397XCX8o/MVOtnpG12OnHjy1WuOf7tCJv4QaAds0iTjdcavhrup2rCAA2WQQi8HUUqbBuzPGoYcRewhNEQsOCYzsaUvR877+DYwl8XnOqzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974653; c=relaxed/simple;
	bh=G/iHS7dUR2mUslyR6Kiw9UjdSXxJaKopU+uFTtSjOOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdNYv00S7i4888U5k88AI+YzkM50VsS5qlkP9SECr0eMC/9jlMt3+Jy9VfSYuk0AQXtZTF6pC4wW64nd8ObiF5+MYfDcigeQYWwnTW/lRaWNO4oDqtRX4U1SGe1RvK6ise0eZluZw7xuN3r+gr+YRfcARscjvqRzST/464AOEo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=Jq7x7GOH; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="Jq7x7GOH"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6711f05fb14so3271676d50.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791974649; cv=none;
        d=google.com; s=arc-20260327;
        b=Sl7c6SfDCuDxTh/VwppKTqyG1X3GjyDCFUGk0E2VG5ralI2rrJDiwaPG4HU0OY09fu
         AVXdolhRH2IykJ9aPqTSH78d40YWq41OZ1/CNm8fsJXTWAUjat6GQ4WUROaAPoqSpaMG
         AjRyY5sril/Fy3901Bp5GI4bilByJEvvIo3bjqW62Gu7mlEPAvlxNdPdWbwF9nOzTJ+6
         jC2EHhpb9wAeCFZc4U73rqwJ+w8bqeYDit6bTDObM281/8jKo/BB3jh/sP66kTDJ+LEY
         s3cntSLHfWR9djIs5XK/6a4siCtt07pkmDOXYInWvd0eDyXsxiRPNp+WY6d/PzZPxkfX
         aYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G/iHS7dUR2mUslyR6Kiw9UjdSXxJaKopU+uFTtSjOOU=;
        fh=mZtAGu2os8gU2KV8FdhYS0Hhpni/QA8DNJ8YEQ3ncG0=;
        b=qPHcwaXfPzBbAo7MTgnWi53RVj74DDipW5xfXq8YaDlHKCbBKPnZnybE3GOfSttrxv
         Ou52SXZ14in2Wfrg0BdQ5JCMZqC1PORScUmd4a1KBbCZ0INJQLlphuLT/50FV5IVQ7b3
         c/fM/Vh9uJKbZ5Lr9yLMG2uVyDMqNjRDBR4QWJOJs3pLRaS5nIfcPxsZAUx2DASXAU02
         NAaCbEnr44P2vVQhX4yTsc9U88L4f6l58C+6YWxeNFze66QM3cJNp5lOugvONBbqveZX
         FJy0QLAyKu1gEFyhLmWdDme8lpkLM/Q5RCeAkbOLLSVRXfYpAJk6EUAFMggwKMInEzHU
         BYug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1791974649; x=1792579449; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/iHS7dUR2mUslyR6Kiw9UjdSXxJaKopU+uFTtSjOOU=;
        b=Jq7x7GOHFXW0IKbTPy+6sp8FsRtaqw3t4nc06TkL7a9WgTUEPIOIEU5SUjJyheek0e
         AkKuGrlG+0yuqDoXQnWbedNczxwr0O4Wq72azsiYlhBYMNhIJa8mH8ZA/J7X0wEVF6mk
         pwS0EWYbvfTPC34J6oCBomDARgoMQ1OM5M/c/XJLbo5FPPFHGjpC/YuA8E7Q+3THknO/
         dyYriDGL/3IFVKkZLQoNl9oLjI6z8SQGAPrcrJFKE3kJ9n96Bl46rI2XOVHuuFfbbk25
         /PznMFXpoqiSCnQ7xDLO8Wg6ytly3yBHpps/FHojR3nP6y18mhGGOimCfNYS+VYm+RCv
         E0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791974649; x=1792579449;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G/iHS7dUR2mUslyR6Kiw9UjdSXxJaKopU+uFTtSjOOU=;
        b=pCgZgnE+ggFX5ETV96KZHdNMeijIj6iHnW7oPQgxXoxij7tr7f2dgupNmSC9jPhLdX
         vQIZLZeeySMedAbjycZzwI+Q9tVF6IjlLBmddHxqEnKGlenoYSCvEx3t+0QDdfCR3h2Z
         gzSRMqFocLDD50Ac3xek9K3AK/M27+v1HAlTf9i4skkWtNcq3t7BW4B8A9wERMjr8Qxz
         XidC00ryMKhKF3MpfmSrsHAXZWonN6lMgSdxt3wypWtFR6hnFZiPP3z7bDvGxCPJaH+6
         cgNMfz1aQL3YPQpCvl+wYZNKiNsSCGGqVRkp3tm3A8P0HK3m9PN2EaFEIZ3AFLCe/ht5
         aSOw==
X-Forwarded-Encrypted: i=1; AKwUvBxHXzaT/3Hsit+HQ1REahmf8cwQIFcnLzKVlRMsPKe4MsXSp9IsD6lZLh5uyP/cQMGbAKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5WOxwpxPtcRNlC83kH/vUTy5/eK4mR56XMVf+0IdXpVxEnrIU
	0GBpX9FudBo9+dQcVK2/2J2Rn8H9Ir03b+O3wf4JyCgTNn7tghpJ363JSPm8bnSjNH2a/Pg4aS3
	8c1THa/rfrzyNVxwFLRNibVJbgNKRXhUpGPFrmD5G6Q==
X-Gm-Gg: AYBFou2wyIrSYMtZ81IWFo3SJaB4BlrYhkq3tyaeijPCAdcEF+MEKdMnnMnhRbsy93G
	Mde/8oBiUIDSKyDW8TDxcfljfum5B5mUvkl+zRXF/xqzU9lGQXcXoTwu8R5H0Q3gaNzAZAL6emF
	AzgjgY3jq1kzOhGuqo8bxKQFUSd3pRcltaidsZ6qWjYAd+RHy2G/3HeCazKyB+lPValgB7d1VG/
	DHOLOmF2nArrEO+EcujxfZRrixUi+R4eVTbMGI9LWLTbvYTnvAMdeJJOxNCGXY/DxXyvUtG8F95
	ODjMzC1GYFCmZ//eXBCFK894NLgjPQHzHeblCQRJHn5wz7gfOaQlvxcd5X0PcMvAvMvY5DJRwgi
	pz4j0eKemB767EQjaUm9BAfSFYwvADJYH+M/ag93IdEaswA==
X-Received: by 2002:a05:690e:4391:b0:675:6228:2fdd with SMTP id
 956f58d0204a3-67935edca33mr3630461d50.4.1791974649494; Wed, 14 Oct 2026
 03:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com> <as4ikRUi0NZv_jKr@pks.im>
 <xmqqy0c1zi6j.fsf@gitster.g> <as8U2Ao_oX5KsI1b@pks.im>
In-Reply-To: <as8U2Ao_oX5KsI1b@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Wed, 14 Oct 2026 12:43:58 +0200
X-Gm-Features: AclHuK_SPbW_SPacGjtxaKAMn95Og1-S8oKXNrP1xWWvKtYH96w77IYzKiSPwVY
Message-ID: <CAA0xjtrK=az1e7mvmBgCd8o3sL1_tQDmoBh=vKxSDCHTzr6LPg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] rerere: wait for MERGE_RR.lock, but not in auto maintenance
To: ps@pks.im
Cc: gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Patrick, hi Junio,

Thank you both, and Phillip too, for all the reviews over the eight
rounds.

Thomas
