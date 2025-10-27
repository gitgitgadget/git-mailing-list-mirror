Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8327238149
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584984; cv=none; b=Egmv+ZloZypv11QpzN6/xq6AzECp3D/JmzkpzE1yhO5XDWHWfQm8To4ejTgPyBGZSsCuH56HMCShq2xlEyNANPTFrqf+QYnUFJEYbIV7Fu9X3Geh7IQcpsO58a/yYAaEocNqAYkfEFaU9HTUAydfz7A6XxLc4dSOH+k1namrGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584984; c=relaxed/simple;
	bh=GDoQbneIufEMrIjuXunTJLGbRpa8RAoL38wEiInX1iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ude0R1yFn0GmszJpKC/wEi5f2hjCiVfk1YzyjxAqIbBCVmu846++iK0RxWlOcJfcT3gJoZpBumRCbI17dLfijV3SZQbs1+WnkoXplhtavxP9e56ZmljUgqGPRgP89fruOPcpKE9d6NzPN4j+f5Ppy0oJCrwnDV6gKukvc/FPqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyPTYEJv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyPTYEJv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7815092cd0bso60076937b3.2
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584981; x=1762189781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dv3KPiMRn4A93DADzQYvZJV7934ZO1ZfAHLBsTTq58=;
        b=lyPTYEJvCwqMRMvUQkkXfNivPxCcraDOb0sOL464vAcUHQIPYFtt7F869BAWo1qnRh
         kyMeVGsm2hAoQYDZSSttuV6txb4oOb7hpza79x4zlki9oqULtuBGdde0FMmrJdrNzmvO
         CeYyynGVQHLoGNltoPxy43BjISITeKRB+GZXnYe9Pu0iU1BQW1vF/azy0NC6UuBdC9Rt
         X7/mDGECMyXtb8sh8uRHNGevSYqXR6ePqu6VWxMk4yX/rG0WdWW99xjBKMPT1N3ArJwz
         Fj/ba3iAWinWWXcd/414r+3D+wfc/3oUAT0CARkoUveSezbeGQdPZ7vkHwFjePDYbaux
         XwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584981; x=1762189781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dv3KPiMRn4A93DADzQYvZJV7934ZO1ZfAHLBsTTq58=;
        b=oSHNLo2FOzRaRO3Ev9nEpBopv86cV92fdJwFe2a4U2qQ8yEwWZlPq58sp03uZGd4ph
         POXcy7N68205c+SLX9JLmb4x/9zGOFDUtK8CMixbhRYojiqf+8wUTkkqXq7etjWy2liR
         svSVdfa4/RMlydBN8y9EmyKxsuRFwgQQavd66lez/60ZKdPPyB8qJkX7i51b+OLyhouO
         TQVKXTCSN/jPZxcFNstM1+j8Q10P/b4QJkzPi8lDl+Zjr3JEVK+czNMfOmP796U1aTVO
         r8cgLNO2/RZXcINOv3GKkWlM/EA9CqXslzxnDTasBvKnO2YjigHlUY8WzPWGs54ocuoA
         LFqw==
X-Gm-Message-State: AOJu0YyUcHeclck42DQhLGlmFEcC7Fr/8RFQip77Z0MkkphpmiAXp1ru
	tLn32Q/JwRu0m/4ZDBaO0NWTRryeBhTn3R+Pf6YEHMExPqZmTFLffur5cZ+3ZEO6fLR9grVAdV0
	IVuh1l59j9PYQRFfpcNQsel7IK/+Kix8=
X-Gm-Gg: ASbGncs/rGJhoXcJH/PxYTOl/WiYWd5A41QX14tKtBuvmR1z0k1SLteKDMwrJsEoCH5
	ZS8/5jYiIbjeyl77W/CQ5rV2tw+5M/hcdFx3gIL/BkAY6oX27cmDwrJKoYt/rHij70CIBqwok3l
	vS3RnpSrIi2UMONLvual5l8N3tY4WJTB/D4uw4Gg/IwSXoB7y/wqylfyHTtvcVResoQZ2Y8QAN5
	NRQk6i/mlqWGlOrsQMofipAeMgiVZUSPvw6bW3aBGLINQhbuZJT7Qp10w8j6pHNEQ==
X-Google-Smtp-Source: AGHT+IH2uCBnfEdTRiI4PCtip+4C/Qty6wEk+EDAz1y/r+tquTBKqyQqGffAapi/2msCJoRaZNk1hZXKHEBthgIFPvs=
X-Received: by 2002:a05:690c:b11:b0:783:7081:c483 with SMTP id
 00721157ae682-78617ff1fc1mr9087577b3.63.1761584981574; Mon, 27 Oct 2025
 10:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027111600.1481-1-qjessa662@gmail.com> <xmqqms5cl6t8.fsf@gitster.g>
 <CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
 <xmqq8qgwjpo5.fsf@gitster.g> <xmqq4irkjpek.fsf@gitster.g>
In-Reply-To: <xmqq4irkjpek.fsf@gitster.g>
From: Queen Jessa <qjessa662@gmail.com>
Date: Mon, 27 Oct 2025 18:09:30 +0100
X-Gm-Features: AWmQ_bn7uuEm8lC25_MYO7LNFdGF2DbnsChSn-VmPpG2HkUGzlnRUX08FF46zoA
Message-ID: <CA+JX8Fq-7Vy7TXB4cfxCJNouBAYzjyaqtA-mxSiGUiNm1DRs8Q@mail.gmail.com>
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

okay. Thank you


On Mon, Oct 27, 2025 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I can make the author identity and sign-off of the version I queue
> > consistent locally before applying to save an extra patch exchange,
> > of course.  But now I am not sure if I understand your preference
> > correctly.
>
> For now, I'll queue the following for this topic.  Thanks!
>
> ----- >8 -----
> From: Queen Ediri Jessa <qjessa662@gmail.com>
> Date: Mon, 27 Oct 2025 12:16:00 +0100
> Subject: [PATCH] MyFirstContribution: add note on confirming patches
>
> Add a note after the `git send-email` section explaining how
> contributors can confirm that their patches reached the mailing
> list by checking https://lore.kernel.org/git/. This helps
> contributors verify that their emails were successfully delivered.
>
> Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstContribution.adoc | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index 02ba8ba5f6..f186dfbc89 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1153,6 +1153,11 @@ NOTE: When you are sending a real patch, it will g=
o to git@vger.kernel.org - but
>  please don't send your patchset from the tutorial to the real mailing li=
st! For
>  now, you can send it to yourself, to make sure you understand how it wil=
l look.
>
> +NOTE: After sending your patches, you can confirm that they reached the =
mailing
> +list by visiting https://lore.kernel.org/git/. Use the search bar to fin=
d your
> +name or the subject of your patch. If it appears, your email was success=
fully
> +delivered.
> +
>  After you run the command above, you will be presented with an interacti=
ve
>  prompt for each patch that's about to go out. This gives you one last ch=
ance to
>  edit or quit sending something (but again, don't edit code this way). On=
ce you
> --
> 2.51.2-678-g0cd646409c
>
