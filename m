Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502563;
	b=swPAtuXEtWfb79vivWHrLwITa3qKguoxAsIOndUvBRXEVbhWct10ZQqH8LOuWg568DDU
	 b50uiRHWNKWy+upL0wbfXAKxnjXv4OY2HknySXgqe05bwsH+GAAABT8wSxoJLMHcx/i+r
	 DwtbRLwlMb3PMJ+d3oViWznbSGN6bgWktOJBo9O+loSPW6kBTDot2UQi6/TY/xQw4tJA7
	 K+af4r08BIroze/bnGXWw+WLk5MF/3iSkqoNMlC+W4tdj9kvrb7y7b884Xd/4Q4UiOZ1m
	 TGyxf8oAk80onTPed8soBfs1BC4nU1Z2TOC0rlAntYCDbWEqAxtSuNNgV6gt5IqGAfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z8YFmulQK8q/H6I8GzsLaNbBX9RTaR87X9NBTNzXNPc=;
	b=o+R92hvk7/JC0NjS3QnLdHDJJSlXwSevfrSmHney5g3Hh99+uz3+emwbUfJ+f6/4Pm8O
	 oAo6N/ZzC30Ko+feVc9zEEGWFx6BaaB0HlFfRSK7vxTxHaSEWgDibaQoRseof0iHn2WMi
	 n+jFcNdzjTLeCrka0nJsw89rhuyPmPHo4bChB+Udc9uCC6/NblafRko7m2IJiVBWNbfi7
	 yT+ArU8NO6EZajEuHw8sX+EOyV0pWU4c9P1k96VPu1KXFjKx64WvAOqtniOBkx2wDdIlO
	 Ile3A1rf7XaJqGJ7tAtHfcpSHKnt8NbCRaIZLNDak4S8pGtDaGJvjCc7FQRIVuXNYEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJhq20y3;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E64606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJhq20y3
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2685854f8f.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502562; x=1793107362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8YFmulQK8q/H6I8GzsLaNbBX9RTaR87X9NBTNzXNPc=;
        b=JJhq20y3tv08ywCvuS68gJ1CCYew+gbffow4zJaPjoua5HX09BAOZXRkHAumHgJBOf
         o7si7SVxTxnrCFH7fmSwOeM+yw8paaXWhipMPsSXN8nfGhMjAFUhNUoq4qqb8qCwCDZL
         vOa/pzIgXDZE8+vbdmxJHIi9QQcYdPNJPBieHONBRhUbeheK1Z6YoQqaZ5vmbBdMDQLy
         une4O9wqz9Xj3/+81FlP+wGP0FaO0olVeRYceQ4/HhRxfEOi2y3LZQAtVChTdXFWoHLr
         mGKT9IGwhGp2YbWN23lzUcrIwdjTev/h9m3xee+IqixV0CSqYReMzXtwB0ALMWdxl3IR
         lXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502562; x=1793107362;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8YFmulQK8q/H6I8GzsLaNbBX9RTaR87X9NBTNzXNPc=;
        b=OuVzZBPkP6X1GP6qy84P21KqqG+Z0GVddybq4422zdXiyNc6g8yD4ITqx74mLi1Y5o
         0zrTjvWdeXjolbg2FXSlb3+SwrplFWCl83tZEsWqraQUdW3xOD1wQkBqLFl1KZYzQ0Kg
         I3iCPcx91tgJmo3XAXKF/ngHgh6fbU5IIRYY7YpEl2iAsYiwpbnLAkNAGqotRAeS8/D+
         xWnEfWl46NOIdXrI44WqN36nWbTR7h5ZowpdyMEsnmQa1C+5ZvRQoxMPmkCsUneI48C7
         5U+s27VMn9bvpQiWHbKzRT/Q12xK5PnMeDs9QnxbxGYFQJNvxWwnLdOhdODz7uRUpqAy
         xung==
X-Forwarded-Encrypted: i=1; AKwUvBysyYP+hBRkgXlaG92PGYBup+QZMVwcKosMMKzg8e2VjpUC43KOs7mtKRSx+xUxsW76jJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ1GqpLvAo2dvie1MCEjeuMt/2YCjaK3yKaJr51+yGerZc3wM4
	2ADbBXCLyxmFRM7uKW+6qrwIpzH1oc1lF7ZjisLkFeprr1kqYVOpe+/QF6W5qg==
X-Gm-Gg: AYBFou2mL0P/8nXmzw0GLMFMjryggbtrf0znWWitSQztsDyZw++qXwgh79phfZ2aCAu
	I75GeQl/lD7eVjiAGfqi94a6GCpyYBssdv5UVEX9KKE09S4rIa5s50nfDThEh9pZnFEuJTC/I+S
	kxnVWacrSgY2uAQTcheAkZlo4yY/iGZde950gwhKF22oQPZXIaXwgoVuJLXtHmTc1nY5nRrNQP3
	rgM9Yi82I5EzL89PrNdXfTM9AymK9rm0jkor/5fI0nRGrsZ4xqq986ZUEqjQPb3g8acYwxe43jc
	97KYkn04fP78wFCLUumhL9mlGLe8KIzyTTBB4M2LfL/LYI266T/b2bhSQL+Hgab8YjZ+U/3+/bA
	2lPTfuVvBIsuchyDcME4RY2Vz5fDX3jIsc+qi4iUoF4bMWJ7+cQXe47ylooO2Xm1oEPzvhpWiZM
	6MgVWiJ5kr5Ov27XjRaHd2bCuQU9+vejU3VZYwU3DN9pc1yhVyEoeW9HqK0eeeFY9NBG397nfRW
	PCxkmOwIIIxtKoKRB5IMFvLFeyzE2RougVRkR6ZId/Fzqs4z11G
X-Received: by 2002:a05:6000:46dc:b0:48a:fcec:2a29 with SMTP id ffacd0b85a97d-48e07bb593amr16466290f8f.20.1792502561428;
        Tue, 20 Oct 2026 06:22:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e3csm4934656f8f.53.2026.10.20.06.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:22:40 -0700 (PDT)
Message-ID: <a5fa416c-da26-4f7d-8a66-3dd11ed7937c@gmail.com>
Date: Tue, 20 Oct 2026 14:22:35 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] status: compare against both upstream and push branch by
 default
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
 <5030377b-58c8-4193-8d72-79955082269f@gmail.com>
 <CAHwyqnU1NPp3N7Qv3ChEPCo-mL=gASeG334YFg2tczzLomsm6A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnU1NPp3N7Qv3ChEPCo-mL=gASeG334YFg2tczzLomsm6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2026 11:19, Harald Nordgren wrote:
> 
> As a side note:
> 
> I see that you include the whole message in replies, leaving
> responders to clean it, so more work for multiple people instead of
> more work for a single person. Isn't the convention to only include
> the parts that you are responding to?
I tend not to trim the message below my signature (which indicates the 
end of my comments), but I do trim the context above it. I aim to leave 
enough context that someone reading my reply can comprehend it without 
needing to read the message I'm replying to. In this case the original 
commit message was only a couple of paragraphs and I though it was 
relevant context for my reply so I left it in. As a thread gets longer 
I'll trim earlier discussions more aggressively.

Thanks

Phillip
