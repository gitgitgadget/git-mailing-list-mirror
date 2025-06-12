Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74702522F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767463; cv=none; b=tplELHKsNJLu0yh20oUy469X/xEitZ1IpKLZZ+e7TjTv+j/Nv3Otm15RqSbXr2Ss8KS8Yc7kNR4qxdzF1aW1s+Q5m4P/AD7pVEVEr+fmlI6/hvWKgxEi7stlicj/SZmWsvfuj7k6sGUl4f9Tu+PEiZ6YPFFvT0rSodLeLTefKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767463; c=relaxed/simple;
	bh=ZejrOIs7UmNsVtc8rVHhUcb6ehubrncrQFHa5QJz87w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVerigaHyE5Z/BEcdJSVlOi88tvZ08pTIzFhNLiGotNNELJbm8nTVfx3kvGilzLCSO6iVVkEGd2AsPjWsCWw8m20o9PApsoaBYcMYoGNDgeWi9uplDRYWCQ5cbSOz5/prVrFzI42+CuxAHqLOz1IkYdfpZTCobZ89NzI7varIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtganaQE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtganaQE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74877ac9d42so1074890b3a.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749767462; x=1750372262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PONB5ClItsPpSp0tSETSgbLuyIvg3iUOuX/FbFWmjF4=;
        b=ZtganaQEdWCGs7RY8jxFmcAMvs9Lnygf79YvK50vBgp6YknyhKxEA9p4zpmBRq1DsZ
         d7zhPQBvX3k4PRabtqNiXNUhujgBYXuxxsrg6cAm857guvcugNp7YTSNoth+vNLtpFYc
         3q9ujb9/OykgfR+i89BbOOuMDBeuKItYd11mwHCxD2cTT1V+qB6hpxbrRBCOzacpXeDW
         Dr4hQdbSpetsqR5er+MrbAC0gNu74/ePOJ1s2FAo2YvWBqQgM6YHr0Flu/9L/hHF5j6X
         OxQH/0hS6UnZYYYeeuoGYpM6q+iItHehHKNay/qRgHKOvm8tTYkxzVvIWdjrM3rU6hRE
         N1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767462; x=1750372262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PONB5ClItsPpSp0tSETSgbLuyIvg3iUOuX/FbFWmjF4=;
        b=nlbsCcjdrcgVXHVbbF7UM8zsLhR48GDmsf0VZGaUQn851TqT13GFYOfW0t1fNVnJyY
         DPNUFJLFDL8w069ZbuGrO1DyHz/1cozsDIBGtixXutjkB5NfMZ2g2y+yeYkivMll97Qc
         BRpM0hPhc/lq3i61eyWN16Iy9Yd08qkcC23YNYolfbvpohtZU5AMmCAc25C1nDkZGXRD
         Ba65HKd8MpQbF/+Tu+wPjg8w2DJTTZAC7Ij4U/kW06vKPBWb3LkkDpA2PB8ATXLQ6pd4
         U8l8DQ/MqooM3Prpg8QVlvAhCkpyk7wziNwE8VZJDCCkYKvWxgOpTHRHRdHF7nxTzd+E
         VurQ==
X-Gm-Message-State: AOJu0YzYP2/sE/ydMA+SwHSETTQVe5hOb84n8sRu9uVnMs7HVoyerkS+
	0i9n0N/KmLEMCQsoyQ6rXVgFanJ5b65E0y/qWC6SpLgk6iBOKe40FhVe
X-Gm-Gg: ASbGncsWWh03SlIyvP14bqBSXUV6V2H2DLcMedZM/M89IY0NY9pp+esnSrkskb5AOsG
	aFuL5pg42iDlYeYB43vEN5VWbv1HajvCbCQrXeD9B8vWO3gyRelsK3A2X4IYWd5CXukuzOo/iBk
	ovGBNFKIYpiAjpIYG1+Mw97otDzvE43e/gJWuSg9PxmKyLYWi48oxlWxktuZmlLB8CmJGumgutX
	xuwVht7zH3dGtCveqUenNzH9rd1/NqANZtnH1Fhl/ARCvrpHpp5B6Rogg8FdLYcpTYl9I/G8iwH
	9a7IJooIKBbej65RnuZMbLrHdSqyuzIZCyabUdAzf9afkoZJ5DTCh8Cd0QhcnQ8FQef0OYV5SY1
	ZBodjyXFl0mRul+w8WBinpg==
X-Google-Smtp-Source: AGHT+IE54TBkfYu2GijpcdroPO0b73xwW/fftGlfVO+opeF0Y0yorNp1Hj+W5Hp/0uh1tUYczaNQ5w==
X-Received: by 2002:a05:6a20:12c5:b0:204:432e:5fa4 with SMTP id adf61e73a8af0-21facc87925mr874528637.23.1749767461604;
        Thu, 12 Jun 2025 15:31:01 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:8dc3:5851:1e44:aea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006059sm276875b3a.55.2025.06.12.15.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 15:31:01 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:30:59 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Brad Smith <brad@comstyle.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] config.mak.uname: update settings for FreeBSD
Message-ID: <4fi5rwhpavu3se3htd2s4ym7oppswrwam545vczwf2jvumeqs3@z7imdc7cdw52>
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
 <aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>
 <xmqqv7p0bpdl.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7p0bpdl.fsf_-_@gitster.g>

On Thu, Jun 12, 2025 at 02:51:02PM -0800, Junio C Hamano wrote:
> 
>  * So,... earlier I mentioned about officially documenting the EoL
>    timeline for various platform support, but without any official
>    one that documents the decision in one place, how about a commit
>    with a detailed log like this one, which I stole from brian?
> 
>    No code changes since v2; only the log message talks more about
>    where we draw the line and why.

I was hoping something more like with the following (untested) "fixup"
on toa, obviously the "unconditionally" in the commit message should
need adding "for the supported versions"

diff --git a/config.mak.uname b/config.mak.uname
index 9cac400d94..cbf1f4c0d2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -280,6 +280,9 @@ ifeq ($(uname_S),FreeBSD)
         ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
 		OLD_ICONV = YesPlease
         endif
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([1-9][0-9]*\)\.'`" -lt 12 && echo 1),1)
+		NO_MEMMEM = UnfortunatelyYes
+	endif
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease

Note that either way the build won't be broken

Carlo
