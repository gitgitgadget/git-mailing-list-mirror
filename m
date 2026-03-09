Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97D3C3C00
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067361; cv=pass; b=aIdUwHGYDusYFjg4rCjGcoDZ2XkwVvBoxUVVpV92ckuOYwspXT5lpPB7bPdhFR8uieN8YJMnIUp6OBMOCj21KvD74d/ZX3EqyTHwtsVp5e31tT3jMaARPPms5kqOWQlMgH/Kmq8TefGwAR7JOUoNQAEujp9jwBihh/6JqWWOms4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067361; c=relaxed/simple;
	bh=OOPjTbPic0ZNoChxWOxpJzN/Rch8nRIO7OF3mF4onCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxRwJfNAKUIq5HAKHAuDt8hBL3KacxxG6NCi/yUELG0TR0wfOrn+QlZBO6PCmro3sCUl8ZDEZRzE1JlglzIPWAs727H8HhhbBQ2G3Isg8rRZB/JqP73VzVsQXYMzguZ9FoT0DUNbLOUcIAR1V3QSfk7CYE2V/RQcIEhjk6iQ4Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYsZD9nn; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYsZD9nn"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so5590366fac.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 07:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067359; cv=none;
        d=google.com; s=arc-20240605;
        b=lD/iRjR7GEbJTSvV9lJI9v9aA/YV/zBgmyGAAmtrBTi4E6QNqBoRRMZackYtEKKcrb
         RTK49GaI53xHHI4VU09Gkw9y4HIL8FXuRHp11aufB1CvZjWez3IDIrD0Qc07a2ZatoYI
         CHUD27wx4HjtzTiQ14AZ7RmO7+heavuKWfQBWacHgMOGtpuzKC/F9+KUrpQn+QDqtKC3
         WwpG4mNMgJOW89VGW+ibHmH0N8Px8qaI/+wNWJxUrf3atUoOE0b8Jmmlg8z0L+RfPA/1
         HkkEgCTyuX+tO/iq2rmimWo3EMY/g5C7cdQ0wtZFlRe5+8ysRpj36zE5WdooZHKKfbE+
         eN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VK142yIWhyF4leurslkkYWU06eEt/Ym6uK9MNJRP0MY=;
        fh=fGgCEE5tBeqgln+k45XSP6I/6lW8+BXSuYNSyQGl36w=;
        b=jX1uGGhjk8UPazB1qyLeaYVrWF5IXIk97HSzD1CG8p5f6DN7tYlO1vXjjIqB8oyfZd
         2X2U2kxiTQa21A8QRnin3twCQaggGwTWqCBoxfREmOUek+l+o/uS9iDZsHwX+IiKY8F8
         Ysdc3/SxZXg7RRpPstql8rTTEA7xwRKIeiwMLc5YoTvgXKMFhq8wW2IL+YdI1R+E5Rz6
         zMaL238HpACuy8Xc7g+Y2izzXH41TROAEayHuf1iEapfqp/6BB6CW67d3rC8rNceqQc+
         G5rPuJilsJ9pCb6f2ADW+8vm7khNpOZBvSMcVVNTNcVXjupyODCO9Qhm/3JlC5BfxKFr
         FqCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773067359; x=1773672159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK142yIWhyF4leurslkkYWU06eEt/Ym6uK9MNJRP0MY=;
        b=FYsZD9nnKD+7+QR/pwH0Fcf3gSs5iGNxgQdJqqEEBlBdqlhUpQPCTLX5F5bsKvusaU
         h8a5yyYuBMwEevgiURT4DiM/czgUeY0yEJL0J9+KlWfL4oVNcQ6r8S+5ptovMGPY4KEl
         yCA3Cf3pPk58QoQABNKIYEVLlO97Wdb4CLrOrs1KZzeFSa/P9hEztz5eDT86TNzgk0cN
         p9kFieS6JtbFJiwNRn4BV84BbFymFK6Ubka1bxbtMXTjhs4TG/PIO+iSsAd20fJtoWjZ
         FOVf7qWguBXM1hGTW9HNRYWr5PaeZIigM1Ct7WRCofKJyYBFh9WJvvxeXEZm6O5QMFhF
         eeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067359; x=1773672159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VK142yIWhyF4leurslkkYWU06eEt/Ym6uK9MNJRP0MY=;
        b=SAcy3VCCwbeHazypAwOTk8Q4dWGMJWIKnM57gkDaLKcsOYMnvE3vwRpaTSS4bOWyBr
         /m9TjU/ardiXJlcFxB3h2yHDN49DHjOcFqVTB/i60QXo/xE6yw3QJhgeqj/MaU5M1MHS
         kHgmIn2q5q37GThBMOjv0JLKg1BOvvEIRcfzCDgD5195IHs05L2z835o0jRcpCd4c9gT
         FRY6eLIlzXf/sxcsSR8ZJCyKRG/MryMp4idL3YrZPE2RGHo37JpA+zZTLLzPkQAV0gaO
         TqNdsOmsucBNXPZkr7EUKwlf8tMzF7gJivOFozMN7DHsqOT2RrtSkUJ/BoUxR/aAfYrq
         uxNg==
X-Gm-Message-State: AOJu0YwyhZyNIT/E2wWwbIlNHFsf/xj2OktrWk1NegwRRx0AoX4PCT4H
	SRGUU4sRtOcJB34odAeJrf50NZA0qxCeAUqP5mo1nr/9sf/CB3bsRBJgCpRZKLDYIx6aLcHn0Km
	LNtVw31v7Gt0B3TdT2Ns6lPCPGFMNCKY=
X-Gm-Gg: ATEYQzzpjZGw2TrNUfLoX3MGEGdcvJ24hHz+JGOTHHatRVVFnzUsPBX89De/10xEk4L
	awicEzMnfWtNJEwCI4ZUzSf1+T6LRUGdsYVq3aeH0HAr7k8AenYT4OtQhKj61aFXxBrVtFuG4PN
	kDSCRmDv1fy9nW++eEWqFkJATrVmlSnXUwygM/6Z+31V47wGNSGw6qFDXB3fsegAdxuphWivMou
	dqTs34aBzTfBRrXit1xwsboxQVEW8pPVIObRn7/CatxD9EXPuSP3ovqzfPb8GcO7xCuxAxtDONK
	Rjrj5a6Ma4LC2vx0+O7S/ouIgWA0wcn3wdWlgRkfskS5BoVONlwEq0Gf/Pn1rVw4aCyjAA34CVM
	Vp24=
X-Received: by 2002:a05:6870:b254:b0:417:1fce:805f with SMTP id
 586e51a60fabf-4171fcea4b7mr2852649fac.22.1773067358787; Mon, 09 Mar 2026
 07:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306151605.29330-1-shreyanshpaliwalcmsmn@gmail.com> <20260307200926.149273-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260307200926.149273-1-shreyanshpaliwalcmsmn@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Mar 2026 15:42:26 +0100
X-Gm-Features: AaiRm50JVpV_fLJzB8BKbYERAc-6oZS9PdEdVfoYqDTovphNQvh-_JF2ZoerFew
Message-ID: <CAP8UFD3=FdwyX66gGaLg01VU+Euw=fV8s4gPPOXEXDFn+11yRg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_red?=
	=?UTF-8?Q?uce_Git=E2=80=99s_global_state?=
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shreyansh,

On Sat, Mar 7, 2026 at 9:09=E2=80=AFPM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:

> Changes in v2:
>  - Added links in the 'About Me' section and updated reference numbering.
>  - Rephrased and revised the 'Pre-GSoC', 'History' and 'Proposed Plan' se=
ctions.
>  - Updated patch statuses and changed some wordings.

Thanks. Your proposal looks good to me now.
