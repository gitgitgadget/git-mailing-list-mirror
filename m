Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D272DB7D
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUIjTr/W"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59158202d22so116383eaf.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 04:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702643274; x=1703248074; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=7hW5HNNxGmNNjBCUDL8KoGYI4J9kJXOHhY6DfOP5Q8E=;
        b=mUIjTr/Wr5tQUnyxNDnRNWegM8FCdUBA+jY/9a34XE8JRXv/mx7eUiUTp5CpuFyjYM
         8PDZNbsAmAuQK6YjVKdZdQtj4QdHDDpmJzGx/hgL28r47N6UIrJaMaJmWnOvGCJB87dT
         xzKWJUU8g97pG1W+1gv23gL724uPnP76PJtsChRL7jtswZROn8r87Hkna5ekIRBhOOoU
         lheoP+r/QhcTFf2WdveslqQeYWFCukdbhJvBYk2Vro4brH2Fi15k7urKyBJNERdfmwMF
         InjED4rD4RGYPbCELQ6fUsfAn2igljV7EbjsSi8mbcE2cqetdgURi5Ow/vc5WcOiej5k
         +b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702643274; x=1703248074;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hW5HNNxGmNNjBCUDL8KoGYI4J9kJXOHhY6DfOP5Q8E=;
        b=eaVGrOcrCt2rI6ZRtvD2GuEy6QqZ/1oHJrLnm9ziHD5SBpyTNCDPtEvONTuAZIIT9d
         helW8Guk/Z0shyhOXNUGnmv2vxvM18L2GfUKK8RshSdKFsZxxjNZzW5hoX/NxmaCe5MY
         sKevNVao+ZjXoQe8wQ32QHdirnEKLPZiyPA/0hsUrbaDbO92SJcDY1QhCVTlw0r7U8c2
         ZYuCgRXlLrGO5hyaHH/0Ucp2yBw0SSrzTOuEzZqunPod3t7UbVmJJBNozO8I00T2OnLl
         4fL6z4H1DpQw1gJSL/qWcZoqVBCwIGn3tU3SjR1uB0VM+8aoT1sUXSphb3mYMdJivDzF
         +zbA==
X-Gm-Message-State: AOJu0Yzc4QAC1FIG+tde7mdictetAgXMBthceyOPqu7XvxT4YUiCWza9
	3MrxstqCCmnjhK29o/wErITneXQ0bi4=
X-Google-Smtp-Source: AGHT+IFVTgzidBTjWAoEachK+8W8PNFppyii6QBckJwwzJmw7Y68JsGmY1JdhH+LyAPAM20mkxnyLw==
X-Received: by 2002:a05:6871:892:b0:203:1727:c6b with SMTP id r18-20020a056871089200b0020317270c6bmr8906568oaq.5.1702643274494;
        Fri, 15 Dec 2023 04:27:54 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::82])
        by smtp.gmail.com with ESMTPSA id qp27-20020a05620a389b00b0077dc7cb232asm5883723qkn.103.2023.12.15.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 04:27:54 -0800 (PST)
References: <m0y1e7kkft.fsf@epic96565.epic.com> <xmqqcyvgz3ih.fsf@gitster.g>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sean Allred <allred.sean@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's the recommendation for forgetting all rerere's records?
Date: Fri, 15 Dec 2023 06:21:36 -0600
In-reply-to: <xmqqcyvgz3ih.fsf@gitster.g>
Message-ID: <m0sf43abw7.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:
> Sean Allred <allred.sean@gmail.com> writes:
>> When outside the context of a conflict (no rebase/merge in progress),
>> what's the intended workflow to clear out the contents of
>> $GIT_DIR/rr-cache?
>
> You could "rm -fr .git/rr-cache/??*" if you want.

Here's my reasoning for not wanting that:

>> I'm wary of recommending `rm -rf "$(git rev-parse --git-dir)/rr-cache"`
>> -- it's hard to describe this as anything but hacky when the rest of the
>> experience is handled in porcelain.

> The "intended" workflow is there will no need to "clear out" at all;
> you may notice mistaken resolution, and you will remove it when you
> notice one, but the bulk of the remaining database entries ought to
> be still correct.

When we noticed mistaken resolutions, rerere had already applied the
recorded resolution and there was no apparent way to return to the
conflicted state. If clearing out the rerere database was never an
intended workflow here, maybe _that's_ my actual question?

It seems likely this 'recovery' workflow should just be documented in
git-rerere.txt (which I'm happy to take on once I learn what that
workflow should be).

--
Sean Allred
