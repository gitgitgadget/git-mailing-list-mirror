Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C839479F
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611258; cv=pass; b=bs9CY/YFRkEDLl3kNoOzGEQ7FTqum/bmZHN5e6nDixIyECJychep+VqQ57aEAG6IcrxJ1/MAo/zJgibky+GXdNnTFLm6aPILAQ8YG7AgXJPeyxCexq6aFCJs3optPSa43CWM1/IsH2BcgnDhdwkkrnm6Ku14Pv1DB/8KRdja0ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611258; c=relaxed/simple;
	bh=TAq6fPyo+YsMeCY+zIg+7ZDq+vhBbDj1zJKhcJ5nzZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=butakGgZxLXunDM2hsLjxOtvtdX+GKNuryf16Cb7PkJ7IdiAiVZCY6G8CQjq3+f0T1E3Hyoo7QDrCeahMcepHYDceoA0MKJvK34asADyozSQzY2rgksPznBhMN/uvL1MALyQXJ4AIOj8YWmTrkd79LE7FzJsh2e+TuE+c1FztFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTTHMeL0; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTTHMeL0"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a456e44e01so2949561b6e.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787611256; cv=none;
        d=google.com; s=arc-20260327;
        b=YtBRncf0dx00vFnffnS9kqTMB9sjCWpNejKViiU8vov9gwIwxt4ERU9AOFyl5tRfWK
         VMamKpMvAjeUqT99DY85PDEdiNx45/J4LzpWYdo5us9GshWfB6/0sedYoevCD61DvqKq
         QEwlvkE0zzPax83gRoYJ93b2DHutlDYfacxcc3ls4I+hYR1NRRRvArjdwXNB4wC1rQrL
         t7j2enYKRe/IGTmg5XUm1NI/pb6moTHL5FHP6aSXPeeoTG0jDfxgzmrqXANYvvr9S0TX
         Qw562/G0Hs7C9bpRQb8BB0ct66aaYN0IuQgXChF+kpIRYPWqaxJT2Y8f4bhP2OHrrdph
         euBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9CyH8Rahg4vQ+ogW0QrybiRnAOQ8YkxXAxI0Z+AlLhY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=CfsrexdEmRxvywQiKKYiriu4l1dli3kI/EfvS2KmEAX03GmFSceJG4p+DpJCcL2jLE
         cpBbOD6s0ZH2d/bNekDnWl3HVT/PfAHAxDOjhUpOZXN3POCdpSLLj9hJ5J2Lt8S+FEjP
         V60g3MAgXVaDMR2SKRy1EztELKgrcVwhljuTzJEmrTVea7zbCqjYWCqoi790pdwE007Q
         6p3c3SVb1lVwzwOkpFe2bjamHlFbJSbz50h0niLe5mET1s5AkbsKIp0cOmH/ygnm+KRp
         QcNL3igC3d1NB6PxM8QCNikHY51dzPPQd6Np8V7ovIhhMEYKbZ6z/KZ7IsAG70LmNNoL
         9GGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787611256; x=1788216056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CyH8Rahg4vQ+ogW0QrybiRnAOQ8YkxXAxI0Z+AlLhY=;
        b=iTTHMeL0hPlbnDtfE2VGK9Uq3xbtYLHdTgipaE07Lk7IKNrGeA/c2cFqGes/ABcbgb
         fFIqJZLrZbJayU1mEnZPC3zZjWt5H9ZRw65ybqQkBJ4AOD18cnsOKPFLByIAxIedCbqG
         EGobLvTka7jT9nEv8V/h5wEgODMWqrE1kISsg7xpipBzie6YZyIolHJotNsWusOjuFEx
         RI5rU5AjmhxnAKLgjwez/BUaUF7gY5VhvDGMgPUDJtL1LYI/V1/fD8UP6CJdyIYet2VA
         mHg1gtC8UJrrjPQwFwnd4OFd91jhOXGO8WY93D/mAVoJeJbXIwNzK9o/KHyp7WKj+2vd
         l/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787611256; x=1788216056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CyH8Rahg4vQ+ogW0QrybiRnAOQ8YkxXAxI0Z+AlLhY=;
        b=anYotG9YyNc2/Hkb0fUbheUaJbPs9P7yqGdhEVlLVHKxMNPcEJtuo9beNmkxug6Q/6
         PKnZsWAzX8gGeAF/hOHLI5p2rR/ZvWsrxMAMc0JYAPpE0Guu6V7QspMlifg4qgxXy8mD
         SIF1unAIr12MZsLLt1zH6amDak5GkrYJD0tlXBWIC9v6MQQvwLi1RedLYbrIGjmlRQqg
         Rur2sXEox2zmYPJFcKJIEVc3M7fzUeX9Du0KcTVV6MLj/ItKsRjs9vFlYfp/8Pm5AIVN
         wPpCTtgSq/mspgvbKySABcucbyTZhJtUZz3/o7f7S4qHotQQp9xO9OyG0VUuGXp9i6U2
         MWGg==
X-Gm-Message-State: AFuF++m7wgfYY+4Uz2woznM3jVdR2k+lJH5QMIMkOkoNR/vxjIKXED3G
	vDjs5CqmEYETRK2H9YqoHmeD/wUkhye1E0qcC/V4CXRRmEnWZ4BOwMVHNDPCcDu2wzY2cwIO6Gb
	7/jIX4iR/C5T4nAnMLMN2VxYxhDjRFuE=
X-Gm-Gg: AR+sD13GnIPPlnPv/nXbRTAc57taxJ0FkfpgOHEL1rJwGZEnopbSK0UrDf3hNTMbl9s
	MTrnILIWj4v6veKbFtY4RkuEpbcMgujmI6DjVrvIfJaOUsur5+XUP6lLZWyNXOgaSdk3z8Sa/AH
	lA1Tppaz4/3ByOAhSMFvArz2gyjXYRr/TYTLsUvIgWS7YuX4XGrcVIYK7ILYx2iiYXnUAk4lSCv
	WDOf8Er4/gWXFag4Zq25rFa3wNrumEFGNygsEaJK2T5CfC9M+8SGSEzQPrREg6rzgUFF6VICQBC
	DCufC35heX++F04WIUndLZmZiKcrlG/baig35tye75gxWcSyk0N4YG+XwLnwX5mwifwaHUlYZzx
	m96WxyObnsVQmvKwIvYVxYL8wNigVDlAUrjoVMWFOiKYslyUGyanvAK3S+lOigN4=
X-Received: by 2002:a05:6820:2d05:b0:6ae:42c7:ef83 with SMTP id
 006d021491bc7-6b158fc84demr29425083eaf.0.1787611256105; Mon, 24 Aug 2026
 15:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqtsojp4zf.fsf@gitster.g>
In-Reply-To: <xmqqtsojp4zf.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 24 Aug 2026 15:40:43 -0700
X-Gm-Features: AcwNN1WyYPgEl777aoCS8fs70oEwwn6vRsozTn2TlZITQjqL1Bk_dJqBQ0OtmoY
Message-ID: <CAC2QwmJkuF_awJnZgDCOKwpoHstVNygLdbECQAr6vXUSVEx+qQ@mail.gmail.com>
Subject: Re: [PATCH] rerere: technical documentation typofix
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Add missing preposition "in" to a sentence.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/technical/rerere.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/Documentation/technical/rerere.adoc w/Documentation/technica=
l/rerere.adoc
> index 580f23360a..56ec7093f5 100644
> --- c/Documentation/technical/rerere.adoc
> +++ w/Documentation/technical/rerere.adoc
> @@ -77,7 +77,7 @@ Sorting hunks
>  ~~~~~~~~~~~~~
>
>  As before, let's imagine that a common ancestor had a file with line A
> -its early part, and line X in its late part.  And then four branches
> +in its early part, and line X in its late part.  And then four branches
>  are forked that do these things:
>
>      - AB: changes A to B
>

LGTM.
