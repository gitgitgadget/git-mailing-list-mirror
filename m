Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4035F184
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115774; cv=pass; b=KNHTyB6naWPu5+DMrqD60lsawmOW2DqAqsGaHlt5nmkYBecdidsvq9xKkVX7QzcUw9VTdx2+HN+LeesW50/5pT4fuKSa4sPIWkU9SiEUsQSiIAx8RJJhhrOuKXF3tD0JApOJHj0M7Ajy2vKJvXzkUGvrZEuoB1LxM0ise7r4j5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115774; c=relaxed/simple;
	bh=LZq66Iwu2SBFJ/526aQMdejDD8phXhtmSaozeC+zWdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkGw5HPpSqr0fAjDN+oU5FK4QpJJY/3w00keHplUXiry8vwsO+cUYJutXWWi4lAw2eHpseKqyQLkptF9RxvW3tJnzbKH1MMt9xF+m/S+bPsFDzmMHBz7eWg594Bklk7z229QhrPKO1ogqiFns5bYfpjI/WmgdZ9Iez4g1ik1sWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjetgS5E; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjetgS5E"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-495b27007d0so2099493b6e.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115772; cv=none;
        d=google.com; s=arc-20260327;
        b=By/Jm3x7yhShRrACa5mFUbSbkfeKm+AOBhu112TOJx04+/3UwmIjPMBZoN2qGmZqY6
         Ox9EA1vIqOCN57AC81wKeSdyuQgb/k1CfVFAwJP7C7fO3CuxHxe8x0R6QBNhXVv5Tt1X
         8OAqyjvKwEmfAbTEGP3wooxQLybmyU96YUftMhHzUqMD8dKLMckrhIfxSw/AwbHeXsEQ
         cS2X/YAekOJntZRpVKVivSLg4WnwlPRrrUFeNuG9jzuySmmJqZWjCoEsim9Qwgac2KoP
         YYA2GpiZtzZ9CK+UFU5mWApQZTiPm9MhKH0m3UaDOxreeH9z/TreeJvJFSMIQ1fk3OwG
         hi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bjsHYJk57rUJy838n/jOGA1FoqdYnoP6a+T1rtQoaFU=;
        fh=tWeD7t0wKZf+Off6vGLQNOfMoo7hTOFbWrsZeSQp1yc=;
        b=UZMAln9T6hRf6FvPKkavYnJiRxARvJWb0plLrsGxpoyK4f/CYjZljNGe6qNJoC7IPi
         xPojs77yfIpvyyORlqiItLIhfcaHtBcqzmZxXFhDgwfwZYkVQxHftZRcTqMugG4GbcCX
         TjUjnVho411vjM5C70L/qIOzDrKI7nDHqKQgFUWYKujFEZ7BBIpVgU0lC13WtL0aJ/XG
         Bv7zfm0WC7QhATvPIDxwchcydnSVwdS3QpMGds8nZ+KSbZaM+WryN7+GmD34Q4Dmc89l
         ymyc+U4n9ancILi/Pox9Khl+WovRS3kbzFxtMpKoa0aofwiJPhGzLkOAYTaXqVfAtFuY
         WnWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115772; x=1786720572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bjsHYJk57rUJy838n/jOGA1FoqdYnoP6a+T1rtQoaFU=;
        b=MjetgS5E11+/qjG5TASaRQVgVpuLAdMdIBkclgUb0NfQ9PRWS3aw8NFNEPkJJLF/xP
         Ipmr+yz5yuTHhSMPjF8tse5iUvsWbEKiuA5DUZMKkISO0v2RPMJYcpx13JjAXe5rjQAd
         L8Espoe/TckTu7b8na/svCOC01Eb+d9cYEJEE0f3I3KvA1O/3HfEyGzKSAykx5qie0HG
         TTLT/HeXrJrt/r/YV6kaceJ36WiO4vQSn7ygfTArtCfnV8BF233WoUr74nGRyY3uU7ck
         4BzrkJ4W9H4OE5q05/Iwger2iFHPpDdFxzPXtF3nyJf7nz/VNNBWxSBAs2IjoTKJ1oea
         yqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115772; x=1786720572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjsHYJk57rUJy838n/jOGA1FoqdYnoP6a+T1rtQoaFU=;
        b=RbIcumb0Xlq7OtDZcKLA4LTdejhuZcqRguZFM+zjcyaJ+ZnSdlji69UDNRf6hLmpAu
         4FHWzJrpUIhDXPHkPeMpp7ILlGR6Rn+mGpmB9ColqipSE7ZzbejMtjE/0O+ZkVti1X3f
         /UvzHaST0Y4CWxZWITjXOAr6xQfPzKZWTk/JtdadnoOf1+Jj6ZZGBerKqdzDcPw4UDnF
         D03lLpmBcr84mL0ibWa888JEgqA8VzCh+ITjHh/TmDQepPXOXXGJO2uJYp53x7Zgdabt
         U+uZ6vrMTyG3DNac5Ftp2Oq1mzgc48nCNLMjHoqEKmNbxHTMuqXJrE17kzxodQQnE+Iw
         lWgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8yaHrp+LrleKnAYvOTt90Fh8Lqd8HMeCVDWV6DRT5xHvmyQUANQGrZsf1cJyWqYCiokc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMtCzIJlA49DNfTENEJLTUjxo8lxGlKkFAmQzCYb0qAHaCTbj
	a463K8Q8HG3+HN+YnXsMEBnmHeVXvS46w5G6ukfDEOrji24jeVbbqTV81FNTjpQHk+xbktXycnU
	99glWznHQlLGJFRd+lG6+qo92PfS3LiM=
X-Gm-Gg: AR+sD11EiilQuYKIcXRTG8geU1F1GPB4VTRJxgo+hMSk1YdTE8PBoWhzn35sZP5uBlN
	tcIlj9OTwLXHqzYHZxwsKI1YxS+stO5JrA5hYxTr9G6N4q67gzKPgCfOnPNe4XrHNT4EwIOBuiq
	Tzk79i6t4BPCvInB2MeaIrF7bI9GtSTxBdoCQZe9DCrjaNONv6sTF+JuUXfx/xIKFsjrmFHkkRA
	BagnPB1TLT7nmzlDTBxKM1KQ1NZu2xc2wTmYhhG3vj7hE3PLrlbt2n7Pd8FRMcndOiOz+z0NOUg
	prsbhITky6OASJiZFVvHYxtkHz2H20cI3Uw1YB9caNbLTatkUHBCC0F9ilR1LE8M++C6/QSNQo/
	rnbrM4PHvUUwfQ3somSWY+W8GLDnxK1dbOx9Xlqs/QCTbq/jO7++hg79t5H8zSjM=
X-Received: by 2002:a05:6808:159a:b0:49b:dcb8:e2b5 with SMTP id
 5614622812f47-4b13eee8c3cmr5749682b6e.19.1786115771977; Fri, 07 Aug 2026
 08:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
 <CABPp-BHbWKr5tv9ApH8ZagJkY39XZgQbLoFrmQJfU71z1y6_xw@mail.gmail.com> <anWpt6rzws0yYdFH@vader>
In-Reply-To: <anWpt6rzws0yYdFH@vader>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:16:00 -0700
X-Gm-Features: AUfX_mwNhiXYGe_lGzo7fXFv0Zi9Q1-q8D_wUa2A1Pqh5RmaoB43SApaXEM44nU
Message-ID: <CABPp-BFwbiasLBS3LDvaz736o2u0FkQJ73Tb8SQnc5rcR5Vn0A@mail.gmail.com>
Subject: Re: git-replay/git-history lose notes
To: erik88 <erik88@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:49=E2=80=AFAM erik88 <erik88@gmail.com> wrote:
>
> On 06/08/26 23:53, Elijah Newren wrote:
> > git filter-repo (and implicitly fast-export/fast-import) too, though
> > that one's a slightly bigger can of worms.  (Trying to treat notes as
> > the underlying commits they are represented as is a really poor way to
> > export and import them; any filtering on the underlying commits will
> > cause the notes that attach to them to just be lost since they will
> > instead attach to the original commit.)
>
> There are some workarounds for filter-repo, IIRC they work _okay_.
>
> https://github.com/newren/git-filter-repo/issues/22#issuecomment-18340414=
70

Yes, I'm the one that added the "workaround-available" label on that
ticket.  :-)  Just thought the lack of built-in support (which would
require fast-export & fast-import changes) and questions about ringing
bells meant it might be an interesting tidbit to add.
