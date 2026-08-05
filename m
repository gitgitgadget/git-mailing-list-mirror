Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753311EBFE0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933047; cv=pass; b=m6F/KoUS/rbxDI8qziF1zczo9U6EkHc5hTZ8lhfCBaVr/SG/DlrYxFNHpSWw4j6qloo483fmBbdvSxWFAThCvKmr/tqGfqMdz/LQTCzoq0WcKp9gfMUWS8TNuBww+6KgX4QD9wCbGxJAryMbxRsToU3Xv+HIYHOuCZH6+l5uNcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933047; c=relaxed/simple;
	bh=CharL08s3/fnaG8kq7BeqbcJYhlm1B3DAGsbDchIdXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioi0g5IXbmUDxmMlg44QCFVdR/SLyM9M7XAGjSqG+VBQTDi5aZcB+uVcrDcXv818X1mVY2o4otpU0g1NQTnnOKY5kd3Jr7yQFgFqdHgnIs4U1+XbY3JUhfj1rx1+LqYO0/qm8jbqZG81VDfasYFzdgv8MTF6AtG4nySWW2Hnaus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvuGrM7s; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvuGrM7s"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efec2c28f8so5937356d6.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 05:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785933045; cv=none;
        d=google.com; s=arc-20260327;
        b=G9zSVn7hyC+KP89l1DoKvaUb+AhGqzc5AsoonrTqX/CgKxm3fm1NJAJwQGZdQj6H13
         al5l0vauB0UNRjFiEusjC15EjjNQVMJhBbDeVaYFhlD6yQzIh98xbt1Hbf4kl8LkANey
         tLZ9l3V0Z/jnc5ZbrfpzLr7L6JtAjAWYTrjO8OWkqJ98KXyTdPYT1LJRX7zwTA33NL0j
         3CoGEQYNJJx8/2+5Af75+wkYCLBjz5vtTEgZ+PbDDHqfSEYTbyJZSQNDNbXLOFuU+3bd
         ocQyb8AwxvZ3kedORSPlJyUfZJ+KgRtR1rydALlKC800d03eWUr+/ustfv9dEIZKzrbC
         /xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fT+1EkPJ0QSscvrZj5POZW8GIIMUZQYEQZqfgKjkAIw=;
        fh=0oc6VvDwKUk6qEk60XqXbHYmY2uQ+b5A3T4hwVO51bc=;
        b=iCrq4XFmlFF6BdKlXqlWV7JMl1dl485Mfr1JOrN0IZ01FVHurEtmIRx9EIDoebrHQK
         4GZko4yW7p5VFBLjNltqc45YLPtedjV9YG1fhsP41sGfDQfAXvLJW01K/ttZy8RkOs9R
         26OdaJkBpfgZmNiCyhX0jDm4m2Ab8BXD/gnQjM0YauM+3ME8+rPyxAi4ATGbfpOuCWfk
         /lud8RcVrJd2v+T24X/g2F07LCSul7o60AItAUbvWJA4k2Emnjb65jNqpX0qK3Psz+Mp
         VHQ8aePEUDygwkc2R5TyOMgnoIaPqlBzbzyaE1Ulwtlc12ioNgtXrsXBUVI0jqB+HJ3H
         h/Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785933045; x=1786537845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fT+1EkPJ0QSscvrZj5POZW8GIIMUZQYEQZqfgKjkAIw=;
        b=RvuGrM7s6ptlwANbF20NJXXV76QmSwnqZ5huF4U7avNrk5fF0IgG1AffCm2nKXMWUA
         iY2KS5JYW0H662BE+M3Wsz8cMx3vpoNj6LRQI89NzcYg8P1vGv5hRHw6E9eEXBY9u/ho
         Ho9SdrWSC3oDtnM1l/D4fRsPCuRYTWAS9dh5Qh2lKl21Zo2ekNdeSPR95BgxkXO0Klo4
         0yCJ8ugmv2VTStrZyUiXTeiTtcny4t07sCaqpz1zBZqooZAO21jpECIs7RSanjuXXPM2
         VOh+lWECiPE+ENqgveYuWXXtqxa+TsnOroV2dJuYZX+s+mDu0TlFDl1r91Une0bmyHGl
         S/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785933045; x=1786537845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT+1EkPJ0QSscvrZj5POZW8GIIMUZQYEQZqfgKjkAIw=;
        b=LG/eOmwJXMRt8RUIRmDPaRuAlNDF7CbhUEs6QxZi/d4Uxq5ZXIeK+kkArWEqJybE4s
         cju1vEyjeotRe7YiqXw1c/FuW8pfR3PZacwU50vO1ZTymC53+3RUi5dpGJG2XLHE32cZ
         mpb4MKxbq8UUMj8eVlDTQ8hp7BOFWQRChnHNEXQl2/U/Bl+N3VnyT7PwJxyXwW51eE8o
         m6uwPYAmIhgRnSDS/EZs6A8UfiVUYWsLKWqOqR5ACtsnOn3ZOlWYRbJ9cEG67zmOrzjB
         S4T0nnBQT5d6Okygd5k5DzJtBLfA5UuveGKZCzWxCCj5Xc6rrMHNHffE78CmSj/l7f+E
         RiAA==
X-Gm-Message-State: AOJu0YxA9rKWHGotux5oZGquNeZBOzX5MraQztTTbvukvul7R+tQCR0p
	J8vslU9MH779PVZ5gjy3LZsLLAzXlEtI+1Qxm7i1YmOvXxECl+X4V3dUgNHjt16lqGe54gOJ7zL
	nnDDlKpBFaevupJdSXA+2+oc1b8JFhHAB54nkm+M=
X-Gm-Gg: AR+sD10SqZRyI8JuSpLEeJ3LvTdf5YJtf+kkAQOuGAx+XLjBWU6HIS/GGGZZCx6pqBS
	41cFEp5GEnTTyNpjkWBx7XnP6lxxAyKcunk4HkumpCxlWiOrt++VAss/ED5NHPbl00m6BO3Lmgy
	gbkK+BX4jFtKAyLCfBfhW4hwfabzvyhxDKZ59LhtQac+TsfZk/CoAWWeOnFkzn6nRna0zCI9BK1
	jHqKER/4pKs9PbZngdshWpnAXv8FIFRdYUAyIA/AWCMbwM/YdijQt67/fv9xXPF23PtDUa29so3
	hyoRuLgdFlwGvL59oax9QOFlR/JPxlgNpzt3JCKnbLOvLu/+XU+ybQND9NVmJNh1FYO2GJYO8eg
	PIWXRJm735uH63a2OwnXcNV25avA6VjFN
X-Received: by 2002:a05:6214:29c5:b0:8ee:b05c:596f with SMTP id
 6a1803df08f44-908813906a1mr61817516d6.29.1785933044942; Wed, 05 Aug 2026
 05:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com> <pull.2192.v2.git.1785932208004.gitgitgadget@gmail.com>
In-Reply-To: <pull.2192.v2.git.1785932208004.gitgitgadget@gmail.com>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Wed, 5 Aug 2026 21:30:33 +0900
X-Gm-Features: AUfX_mytDpoIWm5PZjhQDPfdDNKZBPbG8Q-CY8h3wUSr9WIxPMnybESzkkrPrxE
Message-ID: <CAF5D8-sca=qutDYH=SZEjZsWFGkFAVLiJZz27jzUOfhvi3LWKQ@mail.gmail.com>
Subject: Re: [PATCH v2] worktree add: shouldn't dwim if -b or -B is given
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Abel <jacobabel@nullpo.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:16=E2=80=AFPM Yoichi NAKAYAMA via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Range-diff vs v1:
>
>  1:  908a32fb56 ! 1:  b00f6c2fa1 worktree add: shouldn't dwim if -b or -B=
 is given
>      @@ Metadata
>        ## Commit message ##
>           worktree add: shouldn't dwim if -b or -B is given
>
>      -    'git worktree add <path> <branch>' DWIMs <branch> to a
>      +    git worktree add <path> <branch> DWIMs <branch> to a
>           remote-tracking branch when neither -b, -B, nor --detach
>           is given.
>
>      -    However, 'git worktree add -b <new-branch> <path> <branch>' can
>      +    However, git worktree add -b <new-branch> <path> <branch> can
>           still DWIM <branch>, causing <new-branch> to be ignored.
>
>           This is a regression introduced in v2.42.0

I accidentally removed the quotes in the commit message. I'll fix it.
--=20
Yoichi NAKAYAMA
