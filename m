Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+Y5BAQF"
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354BBF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:50:18 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fb13a0951bso1697405fac.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702309818; x=1702914618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeLZ4oiwnGforEJaZ6BuyCTpiDAwlkqvJeDtkzlZz98=;
        b=J+Y5BAQFnCSy5AwnJSoDyW7sFljMYh7F6Ck0cJJS7pQR8WngzDAK/MDXCpfG/NQxjq
         DVS40T0rF05g3z7NwaSDsw/7kNsXGwPfZvpE+ZbCk9Ybe3GCK07NcfThB4aAh63VQHKt
         4IWpzIK8vPB/kN5hD6t/QSAbV3ZYFCbsTX9DhqHJT66DnniDGS2Zmpa944/W+NPgxT9r
         wUz+J8cJq/gnguBi3VKIN4e1nnmX6Lf0nNcv9E1i5f+cHFhR4pz8aBQio+1im0+zRdXh
         HhHaiuhmBx0GTS+NuQP8eX+kABkEOq7gnChITpYqmNRJ01BDM5L4GEgGa0Cjur/4CWDf
         5vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309818; x=1702914618;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeLZ4oiwnGforEJaZ6BuyCTpiDAwlkqvJeDtkzlZz98=;
        b=dXNr7rxu8t+5X3LuwFtzQC2OCrGRc7s59YGcMHeIDkmFxlQAAkdZUQSrVFbsdW6OJW
         lLXLOt7uGB7ufRl4K3JJTmjHru4cElY67NsWhl3ZFO2LSMCn2hHxcs4Eu+OiXSHFU4hm
         NclglTZP5HTFnp0CH52/Uing8hn9F16AtWqZWTM5bWGH0TO70osO5wcthIA79RrzW7d/
         CnEOE08tjDSO1r34L2RrShyBq0x0IRC1PJBsbBYtJVgis/Ku1D7A9DQUYTRap49eTPW2
         zcFouev6bwZNMzOrN4eVruVaL4z9bu+KKM0Lq4F9QQH207VlA8pa3HJlrOYkDsbtVcxR
         QHnQ==
X-Gm-Message-State: AOJu0YwvhL5QdJal9CyvXHFM0ueErBpbfTtIQWUPmqfUMquqN2JLO3Sz
	cMJHRVMZb2XR3BCsnBiIFSry0o+aIYKU4XbLmwVhXKcx4AY=
X-Google-Smtp-Source: AGHT+IGkPYe4kpvpw+FWuQAwCh65jdexYiferGgOfRnJaNrbnI6LawejWyUWonEu0zN0WbyUv1E1XfDY7cSl1ZYGnPM=
X-Received: by 2002:a05:6870:6ec7:b0:1fb:75b:2ba4 with SMTP id
 qv7-20020a0568706ec700b001fb075b2ba4mr2563679oab.96.1702309818086; Mon, 11
 Dec 2023 07:50:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Dec 2023 07:50:17 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZXFy0_T1AZLh058g@tanuki>
References: <cover.1701863960.git.ps@pks.im> <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
 <CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com> <ZXFy0_T1AZLh058g@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Dec 2023 07:50:17 -0800
Message-ID: <CAOLa=ZRTQ3X7+PnNHaAeM5vKh=x3Vq9C_H1emUNzJB6PUBBwEA@mail.gmail.com>
Subject: Re: [PATCH 1/7] setup: extract function to create the refdb
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Dec 06, 2023 at 10:10:37PM +0100, Karthik Nayak wrote:
>> On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
>> > +       /*
>> > +        * We need to create a "refs" dir in any case so that older
>> > +        * versions of git can tell that this is a repository.
>> > +        */
>>
>> How does this work though, even if an earlier version of git can tell
>> that this is a repository, it still won't be able to read the reftable
>> backend. In that sense, what do we achieve here?
>
> This is a good question, and there is related ongoing discussion about
> this topic in the thread starting at [1]. There are a few benefits to
> letting clients discover such repos even if they don't understand the
> new reference backend format:
>
>   - They know to stop walking up the parent-directory chain. Otherwise a
>     client might end up detecting a Git repository in the parent dir.
>
>   - The user gets a proper error message why the repository cannot be
>     accessed. Instead of failing to detect the repository altogether we
>     instead say that we don't understand the "extensions.refFormat"
>     extension.
>
> Maybe there are other cases I can't think of right now.
> [1]: <ZWcOvjGPVS_CMUAk@tanuki>

Thank Patrick, this does indeed make a lot of sense now. +1 that this
would be super useful as a comment here.
