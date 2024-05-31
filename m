Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1A7C082
	for <git@vger.kernel.org>; Fri, 31 May 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180318; cv=none; b=F8Y4/9smWMbURVyr+Bp0uyd9OamdmKqMrp/jEJKP0+WiRd9y5kxI5ZxI+pZa2+Up97UBYbMgOmziuXPrcL8til/59rKj7U7hXJRLjeWStPc4PWlYVTIFpHhQf58c8nYzng7HJGdQvuDIh5Hg82hFKnqd9HM7/UmeeK2yaJnFz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180318; c=relaxed/simple;
	bh=TpFlqnXaVfpJQTia5L9WTVMkXnPDmFE4X3MlnM8N+Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/S9mu9+PO+mO6E3MCwsGDReVe9h9xKYqnOoHoC2QN9aAkmRGgJqvvKwio8ZDK5VWf6TFgC4Fy4Xfk5PdIFDurTptTA62goleFYDl3YWgq6FMtBKOQw0WHh3tALIQvjwxjqfWemhyvYYPf+AfBCHpcJas9wog4hb4BfYBJ/o5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d04c170118so839351b6e.1
        for <git@vger.kernel.org>; Fri, 31 May 2024 11:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180315; x=1717785115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH/vmlcPY3ec9dOh/kRmm9MiHgpdURrnmuro+1b6GBk=;
        b=DJeAzwKYiPiKgwa6yhyiQlg6dDnHhCwg6cOol/teS7LnyCdWwqnX/eKaGp/wgu09ny
         P/+U//jTXWpWDqAH18hFApaHQtIlj8pbaeDn4RqdnOYtuYaK3ZwVc2xyBwj2VKs6Cum8
         m+5MtaaBQRci0guG5Q6HkxJILBOZbq5GC2VZ0ZlYsj5cOoQUVxOeImLAolN2yhlBnKi0
         mlLHqr8rQoa9dSjRu9XwOXr1GKnDMcne9YChG+CewU4MNurkB20J3E9SW8DB+h6/7oIl
         filkdWuv2qHo2pglZAennzSz55ujrQ8706/+/oRKytxTvni8K6OFfHDU1ZK5pPLIFU20
         dv3A==
X-Forwarded-Encrypted: i=1; AJvYcCXigcHuZd5mDTfn2dueGQ7lSMUzunuZhD48MB/vwYxosK861A6LV+mm+WCfEYGwmb198Kh1tTJ665UlRRAPRtkuea3/
X-Gm-Message-State: AOJu0Yw9TCpO4paOvkc5K3p5WgshQVxKUHI958AetdGlIw/+L5nxeX1S
	rRC7I/A2TSMn++y/cwxCHaqdpuf/hu7uPIyLOdoAWowfX+zwT+L59F0hxp7u/embbHLICrXU+nI
	534N8REAdUUdPfe2/48oY+xzHER4=
X-Google-Smtp-Source: AGHT+IFtm16OUz7J+8of5WyL2001k8kJ1RgqXc1BIFBvsZ8iPxFrORXL5VA7sn8XjlIawXx1etwo74nYmQfQfcqQcTg=
X-Received: by 2002:a05:6808:215:b0:3c7:df4:8fb2 with SMTP id
 5614622812f47-3d1e34a29eemr2705367b6e.33.1717180313698; Fri, 31 May 2024
 11:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240530122753.1114818-3-shejialuo@gmail.com>
 <xmqqa5k6jc0s.fsf@gitster.g>
In-Reply-To: <xmqqa5k6jc0s.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 May 2024 14:31:42 -0400
Message-ID: <CAPig+cRpwESDkZS3yFN8W3y8yugauecMbQC26rvYjVijH=2YLA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] refs: add name and content check for file backend
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> shejialuo <shejialuo@gmail.com> writes:
> > +                     error(_("unexpected file type for '%s'"), iter->b=
asename);
> > +                     ret =3D -1;
>
> This is wrong.  A symbolic link is a valid symbolic ref, even though
> we no longer create such a symbolic ref by default.

Very minor additional note: error() unconditionally returns -1 in
order to support this pattern:

    ret =3D error(_("..."));
