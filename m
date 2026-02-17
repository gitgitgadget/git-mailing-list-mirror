Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BD374191
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354567; cv=pass; b=N5UvoQ8nM1vGSICjJ3fIlbILDovYAgDgCdFL1EvaNivGNpetCPNpMD24CUGt/2EbUQBjbUku5aOsnuieuIGdKazeC5XfznRwlRULNKkrsP4WItqHQw3BVUhKiJTo5s8EXIMfmyNZeVP8MwRuNYkSvAwiXni0x98LRN/uZ7DwOHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354567; c=relaxed/simple;
	bh=mgpzCqOgtJ30sRx+7tYODh5qzo/Owu6sgPdUdecdaKE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0vYtGpuO3OFmJLyNDYo1CUpw0kRlUHLX4Ju/r/HDz08tvHlQJjmvkOKee/hReRZtmtVrVE8MjqGbiPDrxO68kIte1KNaxBGui7D/H8w46TYCr46o+7bJ2Q2k/Jq9Ds/OCw7oJuUzKX5E7f5ORqZP/Fz0kXuY83o49zGHcvTm6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6Su855x; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Su855x"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so1059890241.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771354565; cv=none;
        d=google.com; s=arc-20240605;
        b=He9dowwk1ej3LXm4xiCN/WYoN3R2TAfbbm2qRPd8xIccCGGiJZlr0EF3kYpyHUx6t7
         sybj94CHApi6FEAj7R8iJD0L3RbLAJVhS1jXO7dxjAr2rdqs9i4C+ZL7S0SC0KJ3kp7v
         s+wxRyBtmt9LWaCsftGmKIOJbLkW01ooVUW7s1o028oKyRNZgkXT+0c4tgHkjKEc1NA+
         6edT3aHp58dw/YOQ4TMmq1SnnDss4QB2nJV9jDi2VCGs+JThlL80uTxF5iOpt2vfMj0/
         2OXsQMVKdemFzpwPojN44rqSIQpqr/0992cljV0MIHf7Yy5wUnHTjsVGOnIYx790v7Tu
         IayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Tw2u+uh50a7CaGmSE+CwnhLJyobXLQVPiwgUzHjaJNE=;
        fh=6h8LoOdpYUKTRz26lM0JJYIbzF5GCSkzlbFR4AlYs0A=;
        b=UyP7UA1j6vyp8h3KII6VQN6L+aKZC5qM9W6xziw+/fnde7pKSRgsDxCEo/yQ43+eGW
         5l5qNkBwDjFsGvPQVgqjdVEFLGYo5O3FmqpzeRjS0U3FNzT9PYAselAaYukGXWUCK5jL
         SZG4qeAuAt8kv0uBCU7LERaqekiLqHdF8eyIxTA4o07+2O91ectCYFfN1I9tvE7c8599
         quDUJCUydu/zBFn1zcc/ia43go4GYRVuLADb/1IE/sHcCMzeLmdWlza089mbv/m2mTrp
         hYXMGqN8OZjLyVpNKhNycMAMj0Do8mO7IOj6WIVKiBgJwXyJh5I/wBgMExxPpu3H4f6G
         lgnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771354565; x=1771959365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw2u+uh50a7CaGmSE+CwnhLJyobXLQVPiwgUzHjaJNE=;
        b=G6Su855xoQWyY8LJp5U9bl9nm/f+J9hZ4xQUdssHj4WozFDNKOaqGWvOFUSLAoraDv
         Ib38Cy19TzuyaaIB4shQct476/YuNiwvFVHmIRlyu9625rdNmcSqFvUIxVI2IqHZzQCK
         uWHCleqWl5ASRBujDlA4ARtB0gfAQEHfnHKZIfxHadUHeUMIYDc0L+yIAZOsZ9JLwgUw
         w/NH6CXKmZRxlDNlCE89vGKhJWEX+73TBqRAjbDO+m0BXbRNejTpb5hVzfSWGSMywlIz
         SqIqw524SuMjJYQycLqTz/rtDDgbx9rGbWHklGVt/YTLW2w08NAMSKWMzAzcHtUP43Kk
         /zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354565; x=1771959365;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw2u+uh50a7CaGmSE+CwnhLJyobXLQVPiwgUzHjaJNE=;
        b=tACWkU1O+rIdBW9czJwDzA9MNFJiY8FvHeLvCwWuszMtwCfTplSFMcqHkU/7CTCA1o
         jYbb8q/Y79YsESjUqJg+m1d7gFC7XRL4Aqmt5+FdooinSV1GB23oUjCrCZT69SQH2Owq
         4S0T3JIRbXh9IG0cXlHWdCAB6fVQblDe3iFK4qCoc5ylwV0ZdXmJ3N9eFByqH39h25Uh
         Fi31ROK212lvTO5lvkHGjxKK0QvgOQK8NtNXpH/Hi82xo/wuGYZ5MtXC9o/7PCbk6jyT
         ArT4zQShDA7XUEOcqKDrNV6z5W39HbTVFqtwvYG0suRAmpJ201tQ00XOUMLd/aDvFpvk
         M5+A==
X-Forwarded-Encrypted: i=1; AJvYcCWTOp4QsDYiIfjZrlf4CxZRUH0lep2bXePqmWs0LR6Ek7XHlDM/ncdhqkjQfaOkfQuxpSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3snadRAtQj8JmkaO++O6Nz1FZ+dwY5hWoYOFSKgIMhGVr6jB
	63zmlEJP7tnlbfvWKAPgbp5sIxs/1vcwz7Dzhn9zPbiPrAGuTk4FbPR1+0YqDiSMCg5odfACiMT
	5m6myvemf1GADHHE6p7yg6f4jnl4WfsA=
X-Gm-Gg: AZuq6aIpL3Q6FJlNIgs4KhE5Aqu34d822mvKP8tsoCWxl49e1KhfOEzPflygY/5a3gD
	R6oqA0oDWGsHGsbQAQWJgNV8CF+c7UBjq7BkS2mmUac4trVqM1RyE1mwe56puKLWzpdtHHNdEKx
	SDJ2WfDcmbRxYumUB1UW/2ruEEo8fCKpXhj7cDb9xovSF9OI3wBGA+tmIqX0mfMPLmHt/avjxah
	9GcO+5uXAsghpjZA3Tldh2JpR/jno5vz/zhMo8oz+J998PKTQe7v5jjNuhv7D15g7IXEajsQs71
	o9hD1Zgsq0tjNRVBAoBd4G+JmgpDV4gcxieIYaloQg==
X-Received: by 2002:a05:6102:3f4c:b0:5ee:a3d3:39ec with SMTP id
 ada2fe7eead31-5fe2aed06f9mr4010415137.22.1771354564864; Tue, 17 Feb 2026
 10:56:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 10:56:03 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 10:56:03 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e5cee6ca-b908-466a-b496-0b170c6a2838@gmail.com>
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
 <20260217084124.150366-1-a3205153416@gmail.com> <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
 <e5cee6ca-b908-466a-b496-0b170c6a2838@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 10:56:03 -0800
X-Gm-Features: AaiRm5336_LlEorL6EUKexDhFnwT3S0jBhFeq0eCQhUw1Mgd_S6p9tlYabIuTvE
Message-ID: <CAOLa=ZR-0DGm4eHB6oqi6FpdOV1YDT6mf0=ONZnpi==3o3ab+w@mail.gmail.com>
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000009c4be2064b099f3f"

--0000000000009c4be2064b099f3f
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Hi Karthik,
>
> Thanks for the review!
>
>> Small nit, it would have been a bit nicer to separate these out into
>> individual commits with tests added per commit.
>
> Since this is a security fix involving logic changes, I kept the tests
> and code together to ensure the commit is self-contained. I hope keeping
> them together is acceptable here!
>

My indication wasn't separate the tests out into an individual commit.
But rather to highlight that this one commit is doing multiple things
and it would be nice to split it out and each commit could tackle an
individual problem with tests included.

>> Wouldn't something like 't0009-git-dir-validation.sh' be a better name?
>
> Indeed a much better name. Will rename it in the next reroll.
>
>> I understand the exclusion here (they are non-fatal flows), but wouldn't
>> it more make sense to add these two exclusions within
>> `read_gitfile_error_die()` which already has two such exclusions? By
>> separating this out, it gets really confusing.
>
> I actually implemented exactly that in previous patches (handling these
> exclusions inside 'read_gitfile_error_die'), but Junio pointed out that:
>
>  >> diff --git a/setup.c b/setup.c
>  >> index 3a6a048620..8681a8a9d1 100644
>  >> --- a/setup.c
>  >> +++ b/setup.c
>  >> @@ -911,6 +911,10 @@ void read_gitfile_error_die(int error_code,
> const char *path, const char *dir)
>  >>  		die(_("no path in gitfile: %s"), path);
>  >>  	case READ_GITFILE_ERR_NOT_A_REPO:
>  >>  		die(_("not a git repository: %s"), dir);
>  >> +	case READ_GITFILE_ERR_STAT_ENOENT:
>  >> +		die(_("Not a git repository: %s"), path);
>  >> +	case READ_GITFILE_ERR_IS_A_DIR:
>  >> +		die(_("Not a git file (is a directory): %s"), path);
>  >
>  > Hmph, isn't this backwards?
>  >
>  > We used to treat STAT_FAILED as OK without dying in this function,
>  > because we conflated "there is nothing there, so you should go one
>  > level up and try again" happy case with all other stat(2) failure,
>  > and that is why we introduced STAT_ENOENT here.  ENOENT is the
>  > *only* case among what used to be STAT_FAILED that we do *not* want
>  > to die in this function.  The same thing with NOT_A_FILE vs
>  > IS_A_DIR.  We used to treat the former as OK but the only case we
>  > wanted to treat as OK was IS_A_DIR and all other cases, like FIFO,
>  > we wanted to complain, no?
>
> In other word, ENOENT and IS_A_DIR cases are *VALID* states during the
> discovery process, not *ERRORS* that need to be suppressed in a "die"
> function. Therefore, we moved the decision-making logic up to the
> caller. This allows 'setup_git_directory_gently_1' to decide:
>
> ENOENT -> Continue search
> IS_A_DIR -> Check dir
> NOT_A_FILE -> Die
> Other -> Call 'read_gitfile_error_die()' *REAL ERROR*
>

My understanding was Junio was suggesting that what you're doing is the
inverse of what is expected. In short (on top of your patch), something
like:

diff --git a/setup.c b/setup.c
index c3dd6a4197..7edf921564 100644
--- a/setup.c
+++ b/setup.c
@@ -898,10 +898,14 @@ int verify_repository_format(const struct
repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
-	case READ_GITFILE_ERR_STAT_FAILED:
-	case READ_GITFILE_ERR_NOT_A_FILE:
+	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_IS_A_DIR:
 		/* non-fatal; follow return path */
 		break;
+	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("stat failed to run correctly"))
+	case READ_GITFILE_ERR_NOT_A_FILE:
+		die(_("unsupported file type"))
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:

>> Okay so we unconditionally read the error into errorcode, quick question
>> that comes to mind: Wouldn't this break the previous flow for when
>> `die_on_error = 1`? Where `read_gitfile_error_die()` would've been
>> called?
>
> It does change the flow, but intentionally, by passing &error_code
> (making it non-NULL), we prevent 'read_gitfile_gently' from
> automatically dying.
>
> We must do it because if it encounters a "garbage file", we now want to
> capture that error code and verify it in the caller. But more
> importantly, if it encounters ENOENT (which is now a distinct error
> code), we definitely do not want it to die, nor do we want to treat it
> as a fatal error.
>
> It does look a bit verbose, but it makes the state transitions explicit
> in 'setup_git_directory_gently_1'. I believe we are on the right track!
>
> Thanks again for the feedback.
>
> Regards,
>
> Yuchen

--0000000000009c4be2064b099f3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 423f06038d97c0c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVXVjSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODA0Qy80NlAxSm9LSmdLWk95VGxRUzl4UWlVdHR0SgpZTUNKbmR2MHFQ
RmxISFcxblB4UmtGM0trYURyMWdZZHF1WTd4S0JWanVnSEpXemJBcHRNUTlUbjlkd09Qby8vCmNS
bkhnWDcrUEN0cFQzdGlhMUpJbzFVTEx6Nld3TVhrNUFIajdlNDNqMGxPUTMwdGExb21BaDRtSXFJ
V3JuTGkKTnJscXdOU0x1V0w4T1Q2QUpidTRWdmI2Mm9tcVl1RTlXUHlnY0x3SDRvT0hWK293RzlM
cURraHFWOXArNzc5MQpHM09hdXh4K2hPN3J4WGREV2RmTlNuVGszNm9SRC9Tak1LTGpTZSs1Y3lt
S3QvWkRIUzgvTEZ4ZC9zOUxxRFJwCkVlVHZHaDFIa3V6VERVeWJ3MitZbkNYb3d3cHllQThsUS8z
QTBDWTNQWjB6VzVWdFczbkV1NTVGTWt1b1ZzbjEKdEdKZHR6VVdNZDd1NVJNTlJZbEF5NDVSbThB
bkQxS21BeVo3MVU5cEFmY0xjNmRTL3V5VVRJaVRHNEVTT2NxeApLZEx6MTVmdmlYUWkya3ZoeVFw
bGJwREVpVHh3VVdmcGJIZHlDV2FCMGVFblhKeTErZzk2TmR0N2srcGUyS3hyCmNYd1ZXYXd3WWh4
WWw3RHVRTDhDdGVtV2dESFMvSUY3TkNiZ29KVT0KPWVuTEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009c4be2064b099f3f--
