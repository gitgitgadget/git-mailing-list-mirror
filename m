Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000601C3C1F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442080; cv=pass; b=Ok1WjgX/olzJA8Jb77jkEAPYhyDg/Pl2BBLOW2jPuNv3RAEZPjFn3MundLSnJ573p95WHYqLcfzPdT8aksXZxbV+oKC2UWrNZM7P7R9058h1tL+ygSSPZjJXq4XiLGJe14tldt9F3q+ERSJLadYN2OKPLqHAhY/9LERYvAXE/Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442080; c=relaxed/simple;
	bh=Tsd0Xm2SI+8NzhkL4bIAKlVKsWY/hGLkagvEO9o3Yp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZXZtaPNbSgsoIAAm2mYURhnIiehfiK5kT/qrdMqewsUTbtlY5j41z9XSo03Ax30PllSJBiSQ6XfWxgTZQsYlDjchiUnLLF/dn25MLMOP0lpMYFf0DKxkJtNlHqyUtGL+7JMrfwisaMyLHUvnzvjxmdRuj1HrDKTt1IK2jH3Ggk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=M3Tmldhl; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="M3Tmldhl"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b740872a01so331784eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771442078; cv=none;
        d=google.com; s=arc-20240605;
        b=bsDqVo9xLoZd7H1xK9JdkBsM0AlF8Y6+M7jJ28tsSHk9YS8AvVeKQpgTP0QLG4Dpg9
         FuQK2KwdKzoxzk43yKT3tE2F23F4yBcMG2OIPs8w97P0Ckd0xzfjyz/CRBPTBR+IrC03
         yOrEYyhFeUJJdNYtMApzdt49XI2CluQlr2YlIc0KOJc3l8+uJ5GdyqWgx5AcI2BEstTb
         LQz+mVYsPFSxkSeTc9ZS8PZIWhIyxPAIeHbJf54hPQvnNw3uS8hXVfhwAKdwucblDbU2
         5qvmMmuauC7eKNWci5x3x0CHhD0eALH9wmohbINXMRhzuNZ+nL8FtRhiLPNiAC8bYjLW
         ukEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JiO5jPv0qMoKyPVeu56Xym021W96xwYn40loSAc6FhA=;
        fh=Uks93GOZlVbSY9FCUOriV0scWSEUgOsxLwbQ0kmvji4=;
        b=NXHZkwV7KDUn+O10SON5Kptr/0d1WZ2UWkapgjcIpbDVqGWWfVWzvOq5NTUgnpyhjp
         ncpUs/nScYh5P7Q4dFG52IlmfYqeGOUEiz5KcRso8jhhlRV714zYMiDHhLUsElseW23M
         QTIRvGNtXV5XWgNdEo29PNBcWcpuWiuLHjn/t1xCrV9/oFuEqWBASae4zOiosCOvlqp4
         MMQ/hqBLz07F3rl368JqXkhQ3ZMNETQZNS9FWhGrbHTYADfAZ6nAkMWoVV8yboVPfmUu
         CHe7mmNvkg3Y0CP/Jf20I8TcvG1cUZ+WjeCINdj/WzYXfTt2aFViP7AG9o4LjNkxrJzr
         0x5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1771442078; x=1772046878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiO5jPv0qMoKyPVeu56Xym021W96xwYn40loSAc6FhA=;
        b=M3Tmldhl/MbfSRgUP9heyDu4mbUW6LOW+rLvmEf9ZlmsYs6biiyj+6KE6AWWGZSTe8
         sAnHkF3CSkB14QqfLEp6uOg988zvIrj8cGzeFLXpXNqMDbsCi6350jlAuDDSz0fnM0gN
         RKJieFJu64Ja3Z2vsRz0miG70cANIVdI93B50S+CFp9IiSsbAZd6Mq0DgjR/s8/41Q8K
         opy33gx8EW/7puCDODynWV5o2kfEfYQ4aatEQKx3VqvCy8lXGM/3Y/9pSbcb0TnE9Zhu
         Q/N6qJiaTuVEaCPTg8Y9L0KibwiQLVXU+ss/laNWSeLQfkxQ/gmqCw/mcWgIVrK3/Tbr
         xw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771442078; x=1772046878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JiO5jPv0qMoKyPVeu56Xym021W96xwYn40loSAc6FhA=;
        b=DYt/qLYVwtm0SVzmX9BujY0iNqLows7qbEdNXolQFuyyF8R3bDlgB3pRrItU1B/o5A
         HL3gdlKhjtYZ4WpurIGszA6yLp46dMOTAjAvpjbXBF297ezDlcPowGSlaph30cnZq7Zu
         U/E5m3MwFGaAC5h+zGSM3fWLn59+ZhaGAgKKJBQ6LQX7tJAp3EnVmAc5GP3h7Y4FnaVj
         8SphK59ZK5JkF9qaFSk3hJ9J8p8yT12mbjwYKkgVn1hTtvpKtthHriFO6ziEzV8oYV9Z
         Ufb+DDgtA2rMTmPZUBt2dQrdGr7oDumNvv4xGCpWvu7fYQRbzltds0uoN9LEGAiMUtw4
         QWew==
X-Forwarded-Encrypted: i=1; AJvYcCVGOZya2/iYsVvpTvr5V1t3mQwDA/Yr23W0LHav1I3/VeRJNkrHEWMhRF8sn/PjAAE1tU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKq8YZ2b9XiUiopOCn3/gQ5m7YC3HMhCgxdarDGTfqmEICmb3
	9JsYwJAfd5vGhBtYZvug/Q8xJhthDDKP5hG0+96+YJVsuFRPbS13TnheOjSY/E6O1aukCmcZHuG
	DJNzi2czLW8oC7IWjIjh+aUQ088V1y5c5fr7qhu7AkTeZFdjftZpKFvUZ2I7cBrxYqxh8qA0fQo
	opL//0n0n0lqlD5oHjz2ODJ+Kr+DXHkQMqwUhE03+LWJ3qhOPFMZu/muhm3rsfDXIV9P83tu9PY
	od+kxW88qx+dVr129VefORWfT0HykB4zwDMo3JlYRXlLS8Bb0ddsj9eQTzIj8FF6P/KEyMzOFEC
	x1Rm9FdJYs72wPU=
X-Gm-Gg: AZuq6aI7PQbTUNpqWUjBPARLhtGLTpkFb2t1dtm1kyXs14tG2nxly5NB3z4a+8gsGT8
	dilABsPtd1bUe07SSXL9VGyr0bVqCGEm6wqoe8PqpsOFrNk/ZG2qb8EKs5ut2nUgqNp1sDMJtpw
	6JW/v7Y62RI+fHheOUxalBLnwxnyXN2D2mQCGkn+2eo3ijKy7OoF1MYS9a7gFOyM9kqEwG4MBJe
	moQ9pO2ZwkjUnMyn75wX0zgbfakVKrQOzHcEvDTXg7kSDCC5Hs2WcckayY6rC4volDBkz6fcCYJ
	tE3u+4Jt
X-Received: by 2002:a05:7300:3254:b0:2ba:a15b:5f40 with SMTP id
 5a478bee46e88-2bd5015ed65mr1383909eec.26.1771442077865; Wed, 18 Feb 2026
 11:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
 <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com> <xmqq7bsa7x78.fsf@gitster.g>
In-Reply-To: <xmqq7bsa7x78.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 19 Feb 2026 04:14:26 +0900
X-Gm-Features: AaiRm53w0CtunUr3A3xeMfIwBSExJb-95Z0Xx2p6JQaNfpGdh6v-z6ODd5w-0w0
Message-ID: <CAOTNsDzwb_k+FDBbfzf7z=X=zGhnhXb902Dx9JFGv_eLjza2tQ@mail.gmail.com>
Subject: Re: [PATCH v3] osxkeychain: define build targets in the top-level Makefile.
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 2:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/c=
redential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
> > +     @mkdir -p contrib/credential/osxkeychain/.depend
> > +     $(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLA=
GS) $(EXTRA_CPPFLAGS) $<
>
> I notice that many other places in the Makefile we seem to use
> $(call mkdir_p_parent_template).  Do we want to do so here, too?
>
> Other than that, looking good.  Thanks for updating.

$(call mkdir_p_parent_tempate) seems to be used for creating the
target's parent directory (e.g., creating
po/build/locale/bg/LC_MESSAGES/ for
po/build/locale/bg/LC_MESSAGES/git.mo).

Since .depend directories are handled via dep_dirs in this Makefile,
how about the following change for consistency?

  diff --git a/Makefile b/Makefile
  index 1c2019a4cb..47485004d8 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -2876,6 +2876,10 @@ objects: $(OBJECTS)
   dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
   dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))

  +ifeq ($(uname_S),Darwin)
  + dep_dirs +=3D $(addsuffix .depend,$(sort $(dir
contrib/credential/osxkeychain/git-credential-osxkeychain.o)))
  +endif
  +
   ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
   $(dep_dirs):
    @mkdir -p $@
  @@ -4066,7 +4070,6 @@
contrib/credential/osxkeychain/git-credential-osxkeychain:
contrib/credential/os
    $(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security
-framework CoreFoundation

   contrib/credential/osxkeychain/git-credential-osxkeychain.o:
contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
  - @mkdir -p contrib/credential/osxkeychain/.depend
    $(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args)
$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

   install-git-credential-osxkeychain:
contrib/credential/osxkeychain/git-credential-osxkeychain

--
Koji Nakamaru
