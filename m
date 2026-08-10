Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927513D9DB0
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366384; cv=pass; b=ZLW8vjNR9kN/oieVzSfnCAakELumtlDEHcYmfYaizM37mE+MFHdjwUtWyyBAA9OVpV22a0aLkbKyZBaL/0z5Np+iEEFHaD3h1Omr0Sra7KF6Gx5k7xTL4CI9TeJ8XCKvmcae/WHpYVFSR1I26Y3GvFPXrWRqk7fz/zQAPUkJc/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366384; c=relaxed/simple;
	bh=1Yv0faOQTv79ofJNQnefXuefaklxltGCQqegiG39u54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft2/RUGM3NDdClfc5vwNGXcCt5Mw2y0qo50j7EXMxAfa5xz0P6hFFPYBzkGhHfJJVKGLjVs7oMoA7Aht8DxWljkMpOMKxmyDzSV10KhBhM1/0HxYY65OZ2Aw9lPIgt/4ev3JaXhJlT+pH7BXv+4se+4q5li1YPolIhuUxNTkD8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6pMyfLa; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6pMyfLa"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1828518a91.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366382; cv=none;
        d=google.com; s=arc-20260327;
        b=F2JCIsrJE4oMtyHS6vczcb/Dp4M8DgDDR5VBJRLxLptKIQ2gPI0pjDmPNwOGt3CjDs
         nx1F1c55x4zNEHRWrgAkdsx8rLD1FRbOSxbXgkDnqHEH4ho8JVpcTMO3V5N32usWjJWV
         wwXrdMOrChTEi2rsbWqke8dEJ8d+Yi5K3sWe6c7xCjzs1JdEVHOLWERzKmxZ5nHdFTrP
         9VgxWG2nc/YrAR4xcQ4FF1TljDyPm5c1kBl2hvGq2na5SXTbRNkio/Fa4tTA8TMWd7rP
         uNSBu78g3BKISLRLGfIujW4//KxamC0YkCOV/w9KvVd/sIuRGnqU9lOYHaaIhJLs++Ju
         KkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=93+woh1Fa/ICnud7ERSAgnwA/PaSAn3Rqo1UxFKS9dA=;
        fh=H6lokUr+VJOb8K/s4/XQEDUqD1mgPN6Wv/mJsHIkuwU=;
        b=Oyo/XEj1QJ85avTQnJN2QnpY94f6HrE8tzJNGgti6TB9avOFxduokSMtql3tcgbyMm
         vpg6HNtNXAP/+NpynaRQCvo/E7rjd70o6rwDrJh9F5R1o9MWZwaGn3XiPxeGVHS1dH4a
         UjsmaIyarrhqLUWNQN1PWvQxjRxuRdrArbCM4vSxUjBO0DfkPe6GwVVheevNLcDqmuXo
         xfgSe3ERc4rW97svsbAeZyoGjeY9YGliz6SbmfGOtLMKW9lSjOj12OLvfNcPKGG5DWIQ
         mg3xbs4+idnE2PIwZMSy5SPtxw2/KdJg65zVUf2TUUIjP5l5MVaFEZj+LBe3HEaKl7v8
         vqQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366382; x=1786971182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=93+woh1Fa/ICnud7ERSAgnwA/PaSAn3Rqo1UxFKS9dA=;
        b=X6pMyfLa0OavdMuQEUh1SdTvpcBK3AdVQnYVMuZ2mRJkyFxDD1BBrSM5zuDiql7oHq
         dStrnLj+QAXzlf38SWfRAKWchM45dc7EQ6upg/E3EX9D/OVbvhLEIZjp3DmuoWMwqeOC
         fAjarATsat2bUHgC8OU7JusRuWMEgbvGE1xf+DYZV2qApohG1oLNN/9HEmMyw3pKSoSO
         ksB8pZUuk/3GtSLFgohcFh3GAymcHLffRr0dgB+eoAULfcltmeCZtINYpKxOur5/+cXC
         aR7Fl81gTd9YblSxdzTK+I5qXiZ/HJIdRJ7nQfeOfqdyts/+cdMUXwYjxU+Og7xLXCNp
         a2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366382; x=1786971182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93+woh1Fa/ICnud7ERSAgnwA/PaSAn3Rqo1UxFKS9dA=;
        b=J8N9xsTIRhhzJEVsEMeoV1QuZCGXnEcfn/FbT4TZO7UNay9SmjbEpR1wvs47roIHSS
         FkdlP9D8I9UVwL2cxTvNeYLmnELs+hU3h2BC3SYmVRhQB6f8Wlwky7Zvf1G4KYEu5Uk6
         QKHxi6RSZ08OBRdbYPOayodTuI5z3yD6om7WKCLjwLMQQTH8msX6AlhlX+daR4xnNYNt
         5hCBVJC25T1qHcoU35QrBkB9Z+VJaPUKk+ZWb7qgoF7BJXs3T4IknOwHpEiaMujU+rCI
         NviaxcUB+pLLl2usCPGB5QRUhDvtQQEnblb4NypMJmvYKZCJ5gMJe5Rtm/fH3ogr18bD
         yDBg==
X-Gm-Message-State: AOJu0YwyCd7LJ/wewE4mLuXErgEBZ2Nhnse1hUTbhhfukaOgyjR0Kpu+
	IR/mrKZu0vNWNu+sVCrLY3ivBNTDJzKy66bKNzk/vq7wFbEmFLC3tNiTp6Bvd0sB1U4TprGnl+d
	xg+IWOeREMFboPaUkcRRd4rXNT62+HeI=
X-Gm-Gg: AR+sD109l0HqPmqYcpt1YKTdAQaYvz3PxqkJFKov+EyI9Fc2l40x45qG0lmdGGBS8VO
	BIMPnOGdBJ/VeqsW3uw4iMFaVWKxsysKmyZ0FGC2pRxfcCNusMKKF0YmLjA4NR7RygaZoWJa/1a
	4UHe4zP4tL7u62UfgO9Lkq1bXe4QSQStBzV5UcBVYvwtkA5tgDlD1h2rGo3uLHBL4B6YCIKaUDU
	Y3DKa70GbgWp3GV420xKCQkpkX9CsGn1xnW7tcnCyUmZy6NNiVjqeiRKtOuxxheajyNN0xssnkK
	aUtYFlKMBVZy2eTwGAakI5NIrIgx65QlFBnaeV+zg7bRy2oKime8mxdhkSSLZahXIkq+OtKpQwK
	qR84SD6RLty1vLk/FKowOJW8Cw4ugq1pDNTMx1t4RFmS+LwIUmJggcpwEjjiRR3tViKbSFfpy5u
	0l+VBv/87qo3XKj+RI1hA=
X-Received: by 2002:a17:90b:3bcb:b0:392:c868:35af with SMTP id
 98e67ed59e1d1-392c8683878mr2818551a91.20.1786366382492; Mon, 10 Aug 2026
 05:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org> <20260806-history_autocompletion-v2-3-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-3-7e60f52a1c20@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:52:51 -0400
X-Gm-Features: AUfX_mzwJsW4xuxbNy_sZ2mKrdxL4xJStRXmzV1t1pNo1q2aq3-M6g0Xst0EU5I
Message-ID: <CALnO6CDZURfK3HFQF_LYrSz0KWtamUguVWK3-cnVUCeA+oVBHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] completion: complete 'git history --update-refs' values
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:37=E2=80=AFPM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> The "--update-refs" option accepts either "branches" or "head".
> Complete these values.
>
> Although the synopsis only documents the:
>
>   --update-refs=3D<value>
>
> form, parse-options also accepts the value as a separate argument:
>
>   --update-refs <value>
>
> Support both forms to follow the parser.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changes in v2:
>
>   - New patch.
> ---
>  contrib/completion/git-completion.bash | 5 +++++
>  t/t9902-completion.sh                  | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index fe5223b8ec..6f1ba96763 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2181,6 +2181,11 @@ _git_history ()
>                                 ;;
>                         esac
>                         ;;
> +               --update-refs,*|*,--update-refs=3D*)
> +                       __gitcomp "branches head" "" \
> +                               "${cur##--update-refs=3D}"
> +                       return
> +                       ;;

Contrary to my comments on 2/4, this seems like a reasonable place for
--update-refs, since that applies to all current git-history commands.
If that ever changes, well=E2=80=A6 we'll deal with it then I suppose.

>                 *,--*)
>                         __gitcomp_builtin "history_$subcommand"
>                         return
[snip]


--=20
D. Ben Knoble
