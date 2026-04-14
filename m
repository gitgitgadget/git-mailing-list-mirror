Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39570280335
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197612; cv=none; b=kPe4iBFK/zB6xUfk/2M6zTrfeYaixL1uXdI3x7rpF9GSmXcsC4y0cE+0nsrhzyN5KZjlkAN7xmsTo778jzAt6GOQzJRJpVokcYHHRC5md+MZyBPYFwWIioHEt6fj+0D9r+qCqJ1cQ1CBQorhtYbYgh1ZVnCRmv5zPmmx+q+t4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197612; c=relaxed/simple;
	bh=thlY/1iMUQ1Yii1705LpMyACwxgFCvDCqlO7mr+IqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuGGFQPbzaTQwcB4PSRCRM59kwz+YDZInINz2CQou1S3XbKCdsrXjFdGmsBSYyXjXAl/eRRTJFA+bBE3/edLVkBUXNDMycNsF1q/QHOtvRNh6rewzkkZ+RdglAseOmtiZQv77sTE+uZZU1bFzyoopAWqVianYLpxH4DIkQlFhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asAm7mwH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asAm7mwH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3cc771c26so4826492e87.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776197609; x=1776802409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re3qSErCtQhYth4Aj4iYDWR8FtGS4xxwHSz2ph7/rpI=;
        b=asAm7mwHDME1qxTJlpLkU+m4PNwp8FjSXkOezvW0E40zL3rQKMP4DkgHpqY9EdopM+
         m1PAiqnYhKi3fOJb4++BuquJdIgjF6R9e/YsAq8BbqnrPcF3Li5he3u0BZcGhHb8yE0r
         ZR/01occCX/nms9FUkhtOeaf0EujPAIxJE/FQa3gr68lXA8PpRIlg5ZXtJa46o6NZd4q
         QPMgzCwiERM4QIzDEdSqT2lWEff1fm2d/y0dwwN1cg6bRkz5E4qAtGsqVp1utS0hQkre
         Ujt2NaefopkhXHc1Wtgs3xsepkROZnNntx1gBOZbGjXdFMr5qyFFATKyiBFhPxfGIPka
         y90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197609; x=1776802409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Re3qSErCtQhYth4Aj4iYDWR8FtGS4xxwHSz2ph7/rpI=;
        b=ArE8bHuX+IDP3qYDn4RPXIMHDOHyFdsROOI3APEuQg1+IEluK2t2X2o9+Ylu/+MZTq
         VFgUMVh3IAbv4LSSPltsedqQtNn51wYZCJX/J8VskHK5JExCd8kyl/xRloC8UXKCTNEH
         P4kUaISZgj2o95Ts/q8fvVzC+EbURF2hyTD5Y7b0fI/qxaXT1tTNGBCY+MF1CiXnRyXg
         jj4nfn7ODkCeqFO/4+NWDSMeTyk6gZsHJSg4qP6fy/bKsOWNcA0hWsYmE3dl1ui83sXK
         xPMUaF+GcN1dfaWDJuaf9/ciQ4zDmC3IaCrI1wsUv7Aum2Z4EwLq5/vil9TcYWPfQAQZ
         zr/g==
X-Forwarded-Encrypted: i=1; AFNElJ9nnHGdxLOIAjnUx23WB/vZ/APc1xtY0Ji5eyEOb5akxXUwzbw6kTuMgqn7wZnYjBAwv6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxEtPnOvUMxk5EfytImp2zceTFV/TA5j+zpg6oaxTBZwd4Pci
	CtyHvjX3odb7HbKb8V2OyWszWqKjS8Ylg4s6CqAvi9llOOIBl5QILUkl
X-Gm-Gg: AeBDietfi/G+TOKL2yXxytvGF+8uZI3/xyWmKkqnKKxU/uKTGBOXgEKNcynsntV2ZwE
	qtQQURkjNN5rBVSAT7YNWDtiGcJf8W+toZq3nVYPtkuNVYfmy3D6QwaKrYWovCogNjBdXjG3Fua
	dnbYyub3NiJQ8o5I25kzijpQCAyxl3J81mq9c4gsr+oOfwr6hThVTHTiB5wm13lFBwhCI3FlpS5
	av1bKQhA3iHITdRsIIXFr98jsJH0AKUN9eDptXUVr8KIWEJuzLLLxglpTqsjNVGPap+Q9ogzRiw
	HTBgItIepu5dvpulMwrkBhG6d7WdMIpYF3PqNIcL9NmUENrbK+31iPjFBX6w43PekDlbTYSXSpd
	B6/BwZVK293d+dMY57smzsYYrTgmKxAHEv4leWMMJZnd8Zlg4ijhVGkC3gVwlDUw33C6575XGHA
	u2wXmjfyfKz7nPXzwKMpZcKKeZKKeNvCSqXsnzWP3FdNw4WjLvNeMa4T32X+H4Fln2NmyPURbeq
	zbnh5h2VkDgW7DfnY70GdESTrU=
X-Received: by 2002:a05:6512:3b90:b0:5a2:c766:13bb with SMTP id 2adb3069b0e04-5a3ef914a7amr6731195e87.18.1776197609237;
        Tue, 14 Apr 2026 13:13:29 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee865f2sm3543249e87.6.2026.04.14.13.13.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 13:13:28 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 22:13:27 +0200
Message-ID: <20260414201327.51745-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
References: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +                     strbuf_addf(&autostash_msg,
> > +                                 "autostash while switching to '%s'",
> > +                                 new_branch_info->name);
> > +                     create_autostash_ref_with_msg_silent(the_repository,
> > +                                                "CHECKOUT_AUTOSTASH_HEAD",
> 
> It's a shame we have to create a ref here. MERGE_AUTOSTASH exists so
> that "git merge --continue" can apply the stash once the user has
> resolved any merge conflicts. We don't have that problem here because
> there is no user interaction and we could just hold onto the stash oid
> in a variable.

I don't know how to actually do that. Maybe better to do later?

> > +                                                autostash_msg.buf);
> > +                     created_autostash = 1;
> > +                     ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> > +             }
> >               if (ret) {
> 
> I'm confused by this - if we stash then don't we expect the call to
> unpack_trees() in merge_working_tree() to succeed and therefore return
> 0? If opts->merge is false then we should not be trying to apply the
> stash when merge_working_tree() fails.

Same here, I'm not sure how to get this to work. Maybe better to do later?


Harald
