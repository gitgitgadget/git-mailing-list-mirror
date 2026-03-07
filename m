Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61B3368B2
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865242; cv=pass; b=q8OP583PqxLEQcwRBx2NQcWYxgV6rkuWyi6h6aa3+hOYp0FwXxi9R8jGwfBoNpBmkoP+PPrry2fzeqOxWnj5ET1QZWT0Cpd935c8z7uY8EDZOPAX1JZd1LUj3g1GgP62Wdvmt9YtbMqsJ6gnrPlKHYP4QZd8sCmGu3OX/rKsk0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865242; c=relaxed/simple;
	bh=s0uhdiRdnpj8K4iVt7j7GV1bzyNaFANG6oDhDUG56sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHbDpAexVrBnTUPxkuZy949TuiZ+9s4vADlGw2X5KL7Iphrje/DjsCior34/0gpeO3IRwMQRGHjPylXml5iqyq6hIcOmEtrcDO5+jC1vTnoDXw276wOWtqL1dZf10i8d7YfA/6i7gPjzAOjd18BaZhuJs3KoX1oF2YHxUhGpzQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be2ce5b538so340192eec.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 22:34:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772865240; cv=none;
        d=google.com; s=arc-20240605;
        b=dQTUpE/heQHRbua7+QCIyXkN/UbxAfLqXj2h8HQN5mfYJNOSgS2l4246pji2mzH6W0
         kX+wmJhEWtbO5PbYTlLhxulSOHf4hTUn2Zli4DVFSZqgIdoMKlaedxVP++TgOO5fsnXZ
         Gyxwv3lk07CYdPuDDc4CWQdCkarCYikyazoU4N7pZUTNL4M1m7MgCqlu5OkTSWsmxJAm
         9Ix7eZDk8vfFrGET7M3AaqB8wWibLJ0VVSJ+amvcLTttdLA+/Dk9RLBgeO021SUBSCmq
         7eNplX7W36Nqr2A6pyBCnW82/UntjcZyYSvUl9+jOeUil8uGZlO7u2GyDPey4de96DhY
         zg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=yLEQw+9Q1tsp1NJ1PgjaJCDtamAZhNoZP4tQTYIMjkA=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=l2kZ4CDNWY+J34pxSmuJT251lk7wFzY3gjPSi93KtRm+5UfWx0NmTdtdtkGtyQSKMa
         nVsRBE19ow3GyWeQfHMfV2tp0haRJSn6V333cZKAOhY/1EfmnZwGsVlVHLu/YWLnYK0u
         ecZPUuzETfZkzxTLD/yiOZimpOwWQZt5UkCOKBeGCSAhxPly6qAAKlo4oFxeEDCB066h
         GhuGhyKjMpHjXxlW0xh9x/5DX8W4V3C0RQ1qxe6SvzlahD6AaYkLEX9OS0sXgL7UnEj+
         WJfj+tJm3kFYlrDrL5B7yqdmbNXoRrMoX0qKfeqiknJOdr06luIbm6BEGUHIuP1qV1Mk
         YECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865240; x=1773470040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLEQw+9Q1tsp1NJ1PgjaJCDtamAZhNoZP4tQTYIMjkA=;
        b=lMxwZ6sQ4mjATrfnyhaXLVUoUZll0dw9CcyzboDz9m7RlnYpo7Hot2G4UWzYk6YXCV
         LTO63+aD/1N6EpZ0cqMIpVYAVp/Wb/FS1Ys/c7p28xYFO0OVfQOqVMpl6KiX0A9OMtpv
         CU2fsCBHTgmZrHbXrsGunjNAdwFM+NiwcKbzPLK1opPZ7qWG3yQZpjsAJqnUUY2W7kea
         fbiNnTGdjZ9TnjzcIMOjck7mZkF4B0jvtf8b4Oy9KCWLJZ/pEiEKSZ46hdrOGG2GrEFH
         +65syPE1RRtwqMkH1x4hHELiANSUPuQZaoev76dvENuzjJ+jjyGiRS8kf6NHaZmrXnqV
         pnvg==
X-Gm-Message-State: AOJu0YywJtO3IvyI3a0NKiI08B/zxOrutvrCIgUQg4FozdJqUagPhUp3
	32qojaqngpn5Msp/l/hs1lbRCTjM2TPvox2nc8LCiCJQgAcCzuFK+m6twobTZn4pe8E+tnSoxkt
	1WLuyEcU0SQo6BpCnNMpUWj9E3GfzB50=
X-Gm-Gg: ATEYQzx5yQokeA4LCkjltjctaml2Yqon3JtUeSXQsZx2iLlamXRpQP61D+BVqJMuvdf
	PgVRfoFVL5jjHOEwEF8Xu5RQL5rPj4jNSOfU2mmWarVI9jNMcoomH3yrK2pfLtUeYPbOz6X5IBY
	zUSdNmixIMyX0Es+QoYM7a96VllUCnF4e23LeK5TYyvAR6h6tJp4tmEhZLn8NsCZMCOqRAX5VAS
	3rL1dvSpF0RRA6AZWBfp9nyapcwH/rMCMeZKi7DYff9B7j+zOhP6esy/HtcmpuC3aCLVdlNvt75
	WM32dZrpPMdJq5GbScS3nUgygk2DIiH2rGec8GwSfVZC0CHWm/Y=
X-Received: by 2002:a05:693c:300d:b0:2be:e92:7f44 with SMTP id
 5a478bee46e88-2be4e268d09mr904454eec.8.1772865240281; Fri, 06 Mar 2026
 22:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzf4ktm2s.fsf@gitster.g>
In-Reply-To: <xmqqzf4ktm2s.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 01:33:44 -0500
X-Gm-Features: AaiRm53j1kKsyVQU45Ocdl1a_SQyLISs_dvUKsURJOk1V030udrwigshpkmYb7M
Message-ID: <CAPig+cTMz3SmxrJCVA88yrV-_CkHT6JX-GMVZ4mKp2LiUX65kQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> * fp/t3310-unhide-git-failures (2026-03-05) 1 commit
>  - t3310: avoid hiding failures from rev-parse in command substitutions
>
>  The construct 'test "$(command)" =3D expectation' loses the exit
>  status from the command, which has been fixed by breaking up the
>  statement into pieces.
>
>  Will merge to 'next'.
>  source: <20260305225128.54283-1-francescopaparatto@gmail.com>

Perhaps one more reroll of this topic is in order[*]?

[*]: https://lore.kernel.org/git/CAPig+cQWCK48GJEnGX7bP6exu847WR8HU3Y8sna52=
5w6NEhmmw@mail.gmail.com/
