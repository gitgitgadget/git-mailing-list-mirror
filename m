Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A0243367
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409541; cv=pass; b=qYf0J/6whnSQAKaebfk2yPF1rNJdVohRzyY3a1fQboT+i/pzwiD5GKXHjmWQIj90E7YYI5Q8gtlh1I034eI2tKKUYwd2jNjM8LKjjz3V5MaKLafznWITo4ismtq2IfiPUfYvdaNTdpuw+qY09kvID83YePIx8wkdj+CQCjCk7y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409541; c=relaxed/simple;
	bh=UHUYPdYxemUxoUaEwLCIMhkH1/Qj8itCf6N5ijUy1Z0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAwzHCKkOL6JwzAX5cC/pMh3ROuagFPt9KFgBq3ewm4z9FTJNyttJ6k46IY5nvRtFtKIZxGqCKmkRPEUU/OTiELRCIyxk/LZnrt7zO21ETRNdruhPCL7djC0N7rcPr/sWMV7OTNe7BkXvgLZm5soSOk7smdWZsxVHvFY6dVCIKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk85W2Ds; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk85W2Ds"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94abf5a5e51so3232173241.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771409538; cv=none;
        d=google.com; s=arc-20240605;
        b=TmFISoMhDrxyLEg770G5fX4I8LUnSbm31h5uUDa+aB9ORyNdb/z7fLOh9F0OB5JhC4
         uw0/emoxJ+uXeSnXzPmw/wptkZX9nDDn/CRjsYWHavRmcop8T+MXkBQ1ZJB6RIsY6dVG
         qsrZjVCWYeWprBk/Xkxbsnc8Yo+U7kcpdCBsqDp8J1ZXJ4JZK1lQBrHUyRYbWFLbjzBL
         7tKc3+4HjV+8B30lmDFtqpLnTSOQz2wFOhum7IDx/X2XgEzOdGTDhBlc4Hv+vYMcVfpH
         yanCJB+8B6E3Jy6nY61/mCTbio4wj/oOlQ42M3bYvTBETdtU4OaF48ijd1d9a/AuXMtp
         4f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=K3/oxMM4FSjObUlRqCu9yBdDOa7FC34liXUJ8N7XjgM=;
        fh=iI3DQWEbEn6iLnDDabJph2txJNNdOj1IraQ9BZqNxDI=;
        b=cVXw6NStyfu46H1Zgjhoq7FrkP53wlcZBMBo6GxMIq7yY4rNQXSnurJsimdexgVSua
         NDgd4IdE3AVhcc9orMr6ZEc81rwQZDqzEnIBENbWVRpQZJ+SHRafM91D7u9LVYosrhrq
         88tR7RNojdwLFeYp5PHCX5yHTRRTft2aCAgaAyF6FYhFLsH0NTYwZP0QKrEFPTo6HCiE
         4MfcJTuv5yeXyR5V61oSEfIqHfUlN0RW+vzXnXX+vHDvPbtA8xUvVbBJD4dgddojh3Sp
         CAHbsupxeUIt3PzWYRdEufZyeogtHStKZai/90IkzOIoRhZ7QXQiuY5SlXFfGURDABBK
         CzyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771409538; x=1772014338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3/oxMM4FSjObUlRqCu9yBdDOa7FC34liXUJ8N7XjgM=;
        b=Fk85W2DsnXaOma3Yb5ndO+GGsZzH1purC8V56hf04Y62ga+XxPko51bDqvkWa8L7J/
         3ztcda2tN12oRTGVi0YeY1gmzt8kVLG6E6su3ElMcCNUExI0HzObjm9gxpnHjzISy3Be
         yG8KCaUN3p7ffDeoLCCYn0ha+k/eJ1nY/d7DLHFv7Lh1nCoL35LemS46cLQy2zosCMQ1
         K7RspZoZzOhWhPtSPnmJS5z5HNoA4jAOJqAsqOsulvoqsFqGcNVWMCb1OTE0KHJdQhE/
         cxWwkFxuZqaiPDsMcD42fKc+iQPLZxfOeRu+1vE+Ea4Au2oN0B9pH5FkkvYKatE7TnP5
         ++1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771409538; x=1772014338;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3/oxMM4FSjObUlRqCu9yBdDOa7FC34liXUJ8N7XjgM=;
        b=PxuKBpiuDdIUzBIxeV15b4S7ezA8iEVtIWbe+Wj3XyVyNB7+5mwmZpra1/St1aLt+p
         jj2OoHy7I4eMSniveQWKlXPaAQzEL/NgZS4OEFVHRJUyvNSsmWmguWfhectZH6vSoTQZ
         mkEOrkyA7UcWV6gTLysRokcuAqZeI/nxSj7H3rcEYvI/WbqmlEvzqBFUP85T9jdC232V
         zgZsMMi3bMCP/bc7sZvogtRGelzPSCXiUlDItA15/uVrPf5NP6mhWwMH7R0aNauMKf7k
         bJCzK690lmkeDPVrVAyAfteiC2DkQoc9Sng4SJVmec5m821yJJd+uiv3YZSzY9HqxIS2
         qEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSBjGcCfx5IoIwE+iAIu+dsZrMqbBwHXwp+DpsREjRVbGRGnRTAn/AppVyNQgS5K/1cLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIMUKCER4W/DspzfepRejrHg7RfE+wiZKzPFLQELzMA3tc+42
	LuDeL9IYWwh5rTYJ3MUFHfQqOL4wnpAgmHR59YO4gTn2i4EkvjtUCL1tgFFBlZhCCGJKZbj3LjN
	qGxnPfQSLbZ7fNJhtjSpe/jC/XGw7eZeZHA==
X-Gm-Gg: AZuq6aIyHosYqV8Wch2aLF1T7qKCVZF1J5HASdPBdUT0AxhwKjkknhlcvd7T4U2yRmP
	WDNfEPAu9GfpCHQ16FqnyC9Rd+ClvknYKbQvudZxBoJ+1/YaIY3VkEE4nCgKhEAVpFjGQ9+qTrG
	APALQ7AXfaKY/0HIBCJem8T6i04XxJ1jNigRhxMKUO68RNOAdPhjNJ7xkHvp/innxujQJkl+kJy
	rC8NeSS3GSwRO6G8BHNQa+CVWBfHBjFmem5vrN18n6eORoKYWDjlB1WcrFsdpaA865YHWaY0//+
	vmO0YA==
X-Received: by 2002:a05:6102:6c8:b0:5fd:eef3:cd96 with SMTP id
 ada2fe7eead31-5fe1aca4233mr7028677137.11.1771409538422; Wed, 18 Feb 2026
 02:12:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 02:12:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 02:12:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260218051850.164972-2-a3205153416@gmail.com>
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com> <20260218051850.164972-2-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 02:12:16 -0800
X-Gm-Features: AaiRm515rgn0pteDIjnoqn9nQUs05KBwEdyRbote9SD0cQyJ7EVUTLmQleT_4iE
Message-ID: <CAOLa=ZR_tH6A6JEj7NwziwYaVtezkHMez_cZNYyU1TQi5D8=XQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] setup: distingush ENOENT from other stat errors
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000004a400d064b166c6a"

--0000000000004a400d064b166c6a
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Currently, 'read_gitfile_gently()' treats all 'stat()' failures as
> generic errors. This prevents distinguishing between a missing file and
> real errors like permission denied (fatal).

Correct.

> Introduce 'READ_GITFILE_ERR_STAT_ENOENT' and 'READ_GITFILE_ERR_IS_A_DIR'.

Okay, to clarify we're making two distinct changes:
1. Split the 'stat()' error ERR_STAT_FAILED into ERR_STAT_FAILED and
   ERR_STAT_ENOENT. This is what your previous paragraph described. It
   would be nice if you could also explain this.
2. We introduce ERR_IS_A_DIR for when the .git path is a directory. We
   don't talk about this at all.

> Updata 'read_gitfile_error_die()' to handle these cases:
>
> 1. Return for happy cases ('ENOENT', 'IS_A_DIR');
> 2. Die for fatal cases ('STAT_FAILED', 'NOT_A_FILE');
>

Nit: It would be nice to explain on the decision behind picking errors
for the happy vs fatal path.

> This prepares for error handling in the next commit.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c | 17 +++++++++++++----
>  setup.h |  2 ++
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index c8336eb20e..0ca129623e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -897,10 +897,13 @@ int verify_repository_format(const struct repository_format *format,
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  {
>  	switch (error_code) {
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +	case READ_GITFILE_ERR_IS_A_DIR:
> +		return;

Nit: For this function it should be okay to return early. But I was
expecting a break here, since it was using 'break' before, ideally we
shouldn't change it unless there is a reason to.

>  	case READ_GITFILE_ERR_STAT_FAILED:
> +		die(_("error reading %s"), path);
>  	case READ_GITFILE_ERR_NOT_A_FILE:
> -		/* non-fatal; follow return path */
> -		break;
> +		die(_("invalid %s: not a regular file"), path);

Would it make more sense to do 'not a regular file: %s'?

>  	case READ_GITFILE_ERR_OPEN_FAILED:
>  		die_errno(_("error opening '%s'"), path);
>  	case READ_GITFILE_ERR_TOO_LARGE:
> @@ -941,8 +944,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	static struct strbuf realpath = STRBUF_INIT;
>
>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;
> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}
>  	if (!S_ISREG(st.st_mode)) {
> diff --git a/setup.h b/setup.h
> index 0738dec244..ed4b13f061 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
>  #define READ_GITFILE_ERR_NO_PATH 6
>  #define READ_GITFILE_ERR_NOT_A_REPO 7
>  #define READ_GITFILE_ERR_TOO_LARGE 8
> +#define READ_GITFILE_ERR_STAT_ENOENT 9
> +#define READ_GITFILE_ERR_IS_A_DIR 10
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir);
>  const char *read_gitfile_gently(const char *path, int *return_error_code);
>  #define read_gitfile(path) read_gitfile_gently((path), NULL)
> --
> 2.43.0

So why didn't we add the tests here for the changes made?

Nit: I would even go further to even separate this into two commits:
1. Split 'stat()' error into  ERR_STAT_FAILED and ERR_STAT_ENOENT.
2. Introduce 'READ_GITFILE_ERR_IS_A_DIR'.

But I'll leave that to you.

--0000000000004a400d064b166c6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6bc473cc1025a765_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVmtIOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXROREFDaW1XTFRYcnM0bVNOZmY4VFpOc1BoN0VFLwoya0pGRldvUmh1
c205eXVFUTlNejliK2VTN2tYQjh5V2V1YTVNWWkrdktlekNYWlhEbmxCNTBBelQwaFJTbDJNCmwr
WEQ1Q3RXTDRhcHg1VEdMK2ttOTMyUmZmWnlBZndnSUdPUkJOdis4Z1hXeGs2MEdXMWFBMS9Wa1B2
dDBoZHgKa2w1MEVHcXRQa3FBcjFiTnJ2amRqU2w0OXpsd3VLbk4xckdQRnpLRmhBVHJ4RmhpN3Na
eWI4NEg1OGt4ZHZQeQo1b1UrLyt2RzFmWGFGVklnd1h6NlFsbmcwdUJuQUlZV1lyWFd6aC9vQlRJ
aGdvKzRoNjAxNlBvQmR6QWVFTnVOCkpoQVNDZ3pmWlorMW94VHMrR3Q4Q2Zka3hNczltSUY3Y0Np
S1p4cDVSdmdJMVJib2dLazNEU21UUFIxbTBBQzUKZ2wrQnFIWm5mcmhtbDBld3dJa2V4R0dzM3Jv
K1Q4b1puNTVYMG5FbXg2aVRGUGU0OFNRSmZ5ZldoU2E4Yks5bgpSSXhGRHB3ZHovN3gvZkJMK0w2
Z0Z2VGdGUG5QcVZwQ1NqVFIvU2MzTXBUNzRhdzhpcnNYM2lXWlAvY0Nuem1pClQwVjRzdWVzQ3JZ
b3lXenYwcXN6MzNIY1dtaGJrYXoxR0t2eWY4Zz0KPTlxTSsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004a400d064b166c6a--
