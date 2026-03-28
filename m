Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5313C8E8
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774701943; cv=pass; b=MsTxm8za4sMrq1V8lDPastW0RIIOYV1ipxj8swxPMPdNKkW2LZklHMoAQewhX8qC2rFBjYl8jbHac07fNocMi2/6vqVHoeuSF8cz9japLDuMg75WxgqVsqOLPvZ+LZ+0DXvKcHCUGioRa1m3NMN+E+0wzfAKbW25MdR4bB+jGQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774701943; c=relaxed/simple;
	bh=bxM4NVH/gXY60l2N6yI9ntcSW0hpLjaj6ER3NC4LEX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joSYCpq2lXIUz/bdw8sNRj7C5fkKf9o0B+B5z7xo99MXmNRX6jwLgt8kf489HBOoqsrdEYC3Kfnw7JP2Lk4iqK7trcPBt/H3QGX5p7DZmL93yQsebKpYS+F27HD0uHruK56r3+bNo6qbMo2y/DXb1Bi4n87f/GEnAyuVMj17wjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG7eiUM6; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG7eiUM6"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50335b926c2so25379561cf.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 05:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774701941; cv=none;
        d=google.com; s=arc-20240605;
        b=Ue6D9A8F0wpSaQW+sghpP+1tqu8VT6j9smw/ea+FeLNuRslA4TajlfAeDUMvQPKZll
         CykkX9eG5i0vGQXC0TlawVNFSQuYZLveM1B4/eLvuOhybBreZii0A+4JUnDEwFApKPBo
         mq8nvPwAqUXm3StSzNyqGuR7R6oaOrB6rJSVYQgEoNV/Zb7xEGR6aM2ZgiwSrtGb81cS
         Y2fG54qUppDWIWtnpftGxefCuznvSfMrtOqciyoAC+Qh4SdGK7Au3K0IGwVDr5ksm0LO
         +Uko88MB1jUASAdGCdGOuY7AoGWf/sR27DTT67Zz+nik1M4JZcItDq8f4ygheFpLRc86
         Gb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZ9VzpzInJd+ynLza87OaJni+MlbKHDDMVaab2O8P6w=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=RqnKbUkvv/tgqvX8sUo5u/Q/Df5ITUY12Bg6pgmTX/gdBbO04xmF9HoQO1sSY85B7B
         kIBe7SiJo+oYs8js6hbVYEgkwmFlc7/dhxP5qs0ONZThvOScGdPTCWH/hEO1if2h9CtX
         ETz0thavtxoZB747doIyoQsQ4jCTMjQyLrOlHYHk8q+kSItBWAX+2dYuRCzL1+ivHCn9
         kQQSwRAnSsKQHNk7YfmDBQ4OAYLgm5Cs10Juno7ZGm5FXKUb8+grLLOlbzVn20/pXOxp
         cjsbLSpVK7Q9U+FrLviSBPNyZW/8PpA9cDr2YL+6sGzMn9ei+GOpJyy0zKOBtjFMFHdF
         z1Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774701941; x=1775306741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ9VzpzInJd+ynLza87OaJni+MlbKHDDMVaab2O8P6w=;
        b=JG7eiUM6ylglPZkat1w/xjftGYQBhZ5M5cTDpEQFWRxS93M4gGBA3zumgBekZdH4X4
         enxigbLgpjXhPpAFWPub0eh6JTFyRVxpFdL2dXU2XHDv9SX7h53qnuJwn1qGkykeVcTa
         uTXNes8J1tsA2LL2iW//czDUiCJ7Pph7r99cONbG3CudHelmadzUy80PmD8MpdlLvXSH
         wCTEfckOoHM2L/cooPbDWdy34B+MGLPJzrXrSTRo8i9BAmTuUJ4GFmwmfKEGOeJux5Tl
         IGMxcfJ9IF/5grSB5Hzgj/5j1Tw3HKjVwOL8rndfGLOmqzDFGp2UPEu+hjeMv+aqhuBg
         dFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774701941; x=1775306741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZ9VzpzInJd+ynLza87OaJni+MlbKHDDMVaab2O8P6w=;
        b=WhZziPCGzkhIiI73W5ZHlEJu/6Pr1cMrzTiYssnGtIALGfMKiJYcMSLiNlmH6f+T3z
         pfy9nqlw+XLL2iG9b0TCO61xfi+9iM1e5ESyypwi8sJlzro0X6OnvtN68a+ZnL4PQFI4
         RPV3U4A/xWSK9gPj2MjN1Jw6e7gUpolaIYZouHTTxoLxdcsNxqtYp0DhOiJK61FF5sGY
         umu2CzcoKdivTwo6mcAC7/f0Adxmumi5CNvJ9cI29jDZtMyGOYi8AQDeWk7c7Q6yYq+0
         hz8CYJ5EHyYGqQkRs6jrcPjYwKpJiRWmbAIT7cPvy5vd32E/oJRjyTIz1Sfi9nowm+hZ
         mx8g==
X-Gm-Message-State: AOJu0YxiJtGlotLGRQAvJuOii+Wts57Be0CGwgDnAxSgb0YsTlB4yICB
	hIkBza3KnUxWjDXdt4GyWJ4GpRBggTQhee0Kf1wsjpZwelZmHAHqmgesfBtTQoXaKglyruL7Oat
	Fb6gFk1qIW8kFb9M7wKiJ7kKLnEONRw5xKQ==
X-Gm-Gg: ATEYQzz2y7z0rBIfFwiHMTbpX/IY6v9rQJ6HIa7Aw2gykmmlj2jP/ld33BpomZmcU5P
	6hyczdGAqG+TUekfytGTESGlYXmwUpiXyAKM7Yl4ywNcCgNu8NeROj32BLdeS/o3jqyX2Tn5qc1
	Akh4De9uiTIfe3e8Lvq0Mabf3VM5MfOfgYTcHoYPrubIiaqrDH6rAPP8nIOKVOhXGu5rtzJ9RT6
	ZYH9nJOmtuZvpX+OKBxgArGIwaOa5NG/xA7BKyh1tApDvZ6HzQHpCUcDIjtJzzm14Etttlu9ujG
	mnmq782qUshWZL0PwkkDdn+C/925yCiedtyxOiEJ
X-Received: by 2002:ac8:5f12:0:b0:50b:86f5:8fbc with SMTP id
 d75a77b69052e-50ba3947bdfmr78291841cf.51.1774701941332; Sat, 28 Mar 2026
 05:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-2-shreyanshpaliwalcmsmn@gmail.com> <acY2pZnCSEf5hcWZ@pks.im>
In-Reply-To: <acY2pZnCSEf5hcWZ@pks.im>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 28 Mar 2026 18:15:30 +0530
X-Gm-Features: AQROBzCPnhnFHuxdPc8pq8LAlAGreRUko9QU-F_SJzROJJcxtc6sPxSsTDxhtgQ
Message-ID: <CAPYXD65H87wfffuvGWZtnvn19-2kwQFc1bzLHpyw-3X8QC9qvQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] refs: make branchname helpers repository aware
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Mar 25, 2026 at 10:14:18PM +0530, Shreyansh Paliwal wrote:
> > diff --git a/branch.h b/branch.h
> > index 3dc6e2a0ff..3aa53eb243 100644
> > --- a/branch.h
> > +++ b/branch.h
> > @@ -111,7 +111,7 @@ const char *branch_checked_out(const char *refname)=
;
> >   * Return 1 if the named branch already exists; return 0 otherwise.
> >   * Fill ref with the full refname for the branch.
> >   */
> > -int validate_branchname(const char *name, struct strbuf *ref);
> > +int validate_branchname(const char *name, struct strbuf *ref, struct r=
epository *repo);
> >
> >  /*
> >   * Check if a branch 'name' can be created as a new branch; die otherw=
ise.
> > @@ -119,7 +119,8 @@ int validate_branchname(const char *name, struct st=
rbuf *ref);
> >   * Return 1 if the named branch already exists; return 0 otherwise.
> >   * Fill ref with the full refname for the branch.
> >   */
> > -int validate_new_branchname(const char *name, struct strbuf *ref, int =
force);
> > +int validate_new_branchname(const char *name, struct strbuf *ref, int =
force,
> > +                         struct repository *repo);
> >
> >  /*
> >   * Remove information about the merge state on the current
>
> It's more customary in our code base to have the repository be the first
> parameter. Other than that this patch looks good to me.

Got it. I will send a reroll for that.
Thanks for reviewing.
