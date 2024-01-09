Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365303E460
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk5Xnmp9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so4342889e87.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 14:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704837888; x=1705442688; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBpkSE0pLBkJr7xQItDFGQy+xNTd+zarzogPsxPcp1g=;
        b=Fk5Xnmp9AyLIeZO6bgRhLDQUMeVW6JbcX0b6TIm/d0V20iV9ziyRJx1+Ashnibfi72
         I3ACLzyHkKmVPz/Xp6w1wIc+LXFuGnOBv1vH2lmMI4mG2NhB2taLHFHwJ115fvswHIyc
         G5MxaO2FJvkzSVTasyEsHLy7Sc9BLY8Q6oz0i17G3jrf6Huioh5T2r8ZBx8cxz5+PXTS
         R2P+gFLV8JW245IJjmDQIjM/uQaoGVZUCzYSAYAfzp31f4dfA3v2YpEL5b7arwU2jHO7
         6y/z/C9WeNIxUUMxKoBPUKU6Fc51Z8y3VPSUNwcE9tTXC8xDbm5B1kdOJB1pq2HDG11P
         r89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704837888; x=1705442688;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBpkSE0pLBkJr7xQItDFGQy+xNTd+zarzogPsxPcp1g=;
        b=g/Ve170XPGa5oqcivM4a0O3dkx4CiFLACozfur5pLCiC6sl2vjcRH+cyyoEhPQYGjz
         oOW7GXsrHPWM+afN+ivCtMQf78kEBz17RW9MwzOIViTeL2nWn92VKkYqipAdnRuKifSs
         0lxHUKUCFzhLpaqnw8RWq4XWCDuqiasXMRncDopIPdNIjoKljY50u51MTaoNj5c9TCG3
         LZlwM89TJh9VxRrBm+mI69Mef8nQ21Z6pFKghydOrKxJNpvnSH3YpMtPjBB1V4WUtR+a
         pMMICPepD4a/V+cXJR5l8QlxqF2Nh8gVE1OGZoTdSKTBKSEx+ITc3uE82orujRuD0whz
         SW3w==
X-Gm-Message-State: AOJu0YyirOPNC/euzmd4h4N6u8PccZUZ6WnJIBEmPJhsKwb0/f8RJMMD
	vtGRn7fI/14tK5J3rPcYtQZmcwrcmW0=
X-Google-Smtp-Source: AGHT+IGXRm+BTdfMmOoDSYv7XOPVCbSi2QomDj6MlHQutG7F96Jk63opytluMaOz60/xvWgKdEj74Q==
X-Received: by 2002:a05:6512:3da8:b0:50e:7c70:f8da with SMTP id k40-20020a0565123da800b0050e7c70f8damr5700lfv.16.1704837887602;
        Tue, 09 Jan 2024 14:04:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512108900b0050bbdf9616bsm469022lfg.217.2024.01.09.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:04:46 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
Date: Wed, 10 Jan 2024 01:04:45 +0300
In-Reply-To: <xmqq34v6gswv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	09 Jan 2024 12:20:48 -0800")
Message-ID: <877ckitb7m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I think the current code makes "-n" take precedence, and ignores
> "-f".

To me it rather looks more like "-n" implies "-f", but then there is
"second -f" rule that makes things even more interesting:

  "Git will refuse to modify untracked nested git repositories
   (directories with a .git subdirectory) unless a second -f is given."

How do I figure what files will be deleted on

  git clean -f -f

when "-n" behaves as you (or me) described? I.e., what

  git clean -f -f -n

and

  git clean -f -n

will output?

>
> Shouldn't it either
>
>  (1) error out with "-n and -f cannot be used together", or
>  (2) let "-n" and "-f" follow the usual "last one wins" rule?
>
> The latter may be logically cleaner but it is a change that breaks
> backward compatibility big time in a more dangerous direction, so it
> may not be desirable in practice, with too big a downside for a too
> little gain.

I agree (2) is too dangerous and surprising, and (1) is limiting: I
believe the user should be able to see what will be done on

   git clean -f -f

by simply adding "-n" to the command-line.

So I figure I'd rather prefer yet another option:

(3) -n  dry run: show what will be done once "-n" is removed.

This way, e.g.,

  git clean

and

  git clean -n

will produce exactly the same output with default configuration:

  fatal: clean.requireForce defaults to true and neither -i, nor -f given; refusing to clean

and one will need to say, e.g.:

  git clean -n -f

to get the list of files to be deleted with "git clean -f".

With (3) "-n" becomes orthogonal to "-f", resulting in predictable and
useful behavior.

BR,
-- Sergey Organov

