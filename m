Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792445362;
	b=sDjmdlg3AoN6eCxLFNwFVaCN1nvk7gzmxzBCywgFYI/a/RtW3LIjgM8aY+CEeD5WyipW
	 jHCxRw+CZ5ndeqMnLCA5INyKYXXV+H/+56DsjuM+dcgAf/A5rxXT5t8e7r2mhhSwDrIxL
	 tv2a0Lg3pZ50Tf7+2rEuPXaLoCoIlagiVIFaK15gcwFdp8PNEJPxkLlHGpZ/tCSmNB34B
	 KN3I8BXRNf+vnL6B7N3FEV2S4M6/if6Vdsmz0f7JsgSgnJDwm7rWudwaZOML5PF8FJV9b
	 fuFF2ad/DUiRvm1Cxy1snTyWs/C7HQQcZ0nDUTOGPtBjl+KWd0ocRAshCfiqyrO8kFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=53tUxxlGnZ4rwUzwwt596+ImT4OZWUL1Ud90052kbPM=;
	b=UhDG9lqExfyDsoZSOjdmTuJBJizKQ7wiAsIbalkubmh6OH5LoR7zAtur1/KfRLKTKBH6
	 QDYwqN1IvQkkxMLROqqSTAITNVrEEUTY+cFR994uAcs8VPAZHT9bdnZaljMIo8iG/3PFK
	 jBbSiWhsAZEaJfglmzqiau8rP6jMqyDcFIcPwnNG8JEHVL/x3ZorAFnucYX+xVlr37Y3n
	 Uq+IaxCKpRQSuaON1ZmQJi/0j5qltDqfsov+M5pFb5hrpCYsEEI/i36R3wfQULQCTTSgb
	 gQdfep15tocsEXuDmfdID6O60dbVtPLYBoXDgXcyrEDsd9H7+/uABrQhb+GUG6Ip6Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=btDIawww;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567E606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3567E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=btDIawww
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so1412950241.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445361; cv=none;
        d=google.com; s=arc-20260327;
        b=lCHvtCR71l4lhZbPh/ceSsS0HwAexCkMHsvHfGtaEnrJRzFkfGn9FZFQslmPDK97uh
         70b5U2EJE4jBe2Hn7L/29Bp+Ui9NZ8T/+Ah/8WVBHTL+vfIy2CEMsyOYzKOpqsMPg7/7
         lI+3dGNs8ZaGk+MNF63AV8Mp2Bir04gpPXe9PS4YeCg1PRWGzMcvX4lfFiX6ZAIAPwJK
         IgXAU3j68x6q/KAO61ScW+dOmh/lu+Ir5jA8fZYHB2FiiwYPS8bF+AvP7ib9cdXzMjPR
         z/qwbzUlgV5VX7tn9imJD7aX7VFYMe5BYf3YznF+Kk2z15LaCWBjq1yCJ0rWtn3Jp/Cq
         TBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=53tUxxlGnZ4rwUzwwt596+ImT4OZWUL1Ud90052kbPM=;
        fh=2LZN0PSznRnNYOh30YGvq92qNjSmrFzNkUHaRi26vAg=;
        b=rvXWjGx2ofqYvjxBURFzv8U8QzWl63vvks3PE64I0AEGku3wrJR82gWAZn8VxLDzre
         MrBC0AYroE/DVYKqzLp+/5eKvO7hH5VM2P6sUq5dVUOtRTogyUBVrNpkcWahzJT+XThf
         26FzYvxRB8pjQgQwyB8/5Tk9xoZxJG5zRzd0Bs8lCLgRvpxOjIKiEGgmQ+lhQGUPJeUo
         SHS45nHDMzTKHxZg5CL3tJ5VEdu4cBJ8nMiavN2BYYldycdyMr+Z0zNONnhJYKpIQOla
         E8Ba/LV+Q9ZZUcjiC386IPY0U/igscOk9xAJEszhae7K4Wj145fplzuAGwM2Jj9dvlg2
         d4dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445361; x=1793050161; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53tUxxlGnZ4rwUzwwt596+ImT4OZWUL1Ud90052kbPM=;
        b=btDIawwwJrS7PbxxJP1cCQxTl3TMsNWZrHUO8MHxPVgHYGqVbOcBDEJRmw6RtOD7SR
         p9JaGzte27Xchi3aZrgW3dOKkKlqo4KvUioIaiy8G/PBX/6cnqF2T+cQ3T6Q2MADKz/j
         Cc66xl0HyqV2QnAZ0x3JHcrZb7t5lKrawBPcGF/0WCNTuUCn19nsLEnRl77Lfq+HllF4
         2kTw89FKUDViMfGXxucjbufavadw28yclGLfgFsMUcwdMrZOHtBCWKQc+XDDOEFAeA9Q
         NyQjZRDLOdi99ogRsP0R4YrcSe8f/tx8ew9dqi3G6I1fHVpb+OzeJ6yI6rA27HuyRET8
         uy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445361; x=1793050161;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53tUxxlGnZ4rwUzwwt596+ImT4OZWUL1Ud90052kbPM=;
        b=cU4o4W0CDmGFj04UDZfBgF5UmtyA7tZMgbnXuItp/Wxc9X8HjOM8937I+XMcVuIgpx
         1gY81xFdZZQ6WzwgSRQxoTNgjdy+UvejvnL2qlrXofnv+rcEibV3x6r16cBioC1LHD+Z
         NZpNgQy9kFpv8CxRFnAUsm5xzifDUvopfNxYvhuYX4b/BZ5zhSybH6VNAsoAnDuyfEIF
         yPl/cCNm/icnPrjnKIzrLwd8srU9oyg6ojsWSkwZgGxr+D48HgEgggvbRKypEVTwpEcs
         1q8w0X7uH9CjO2H2c8SliLpsuM4Nte3X8tmFVdGMIqXdowj4w/b/rlI87tA75jv0NUz3
         WW6Q==
X-Forwarded-Encrypted: i=1; AKwUvByVDvQGnCVQu7jadN34eKmeu+09s+WAJPQtUq3M6wiW3+HvMrCACaY0tJVqg/Ek0QIjrlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBDXeyTeS/fiZXhFDXt44DqYgI0DVS9XHYf64VoGrl9W7h6tZZ
	xw1EkpWx49a7cL2Vmlr58Jn3u3nwtkeFq+7bgqtrpTKSHTYbe4YdvQQi9Uko/+yIhjETrmqaUWT
	jKUe8CtsQE5fQGMDkSDndUa4qu6m6b00fEQ==
X-Gm-Gg: AYBFou09gULeCUn9+jB6rdxCA7MZ91pANC5IM/8kRNNk/ph9UZA5wJqnSuSoA457+Nm
	SKpyWxyQWE4X7PLtIxUGZKNANmF36g6fFcZKrLUQ44m/b+owkZZNXSur2r8O3DYLbl4PvhQyfIC
	aROd+IskhV1WUBn5j7YlTrc17UIt87oDkLLJsQpvZPibmbb/ZQlt2SZX0q5mNDgE83oseGYqfgI
	bfcTZ4Tobbr8dSbX2yiHQ7typV3I6HM8fNtvLsbkE8Zz2Ck1ALGZJy7a11rWpuPnRZQB03q389L
	CCippiF1hoA8M8bHq7GKvAD5npJ7/j5bhx0rScd7kEtrPXZQCVNWjSABo1Ey0p1CTU+odpcsBhi
	cq58vXhTsgFGJbvcaFdsqDkqVmC1qRBG21QaqdrvBrWIESQ==
X-Received: by 2002:a05:6102:1492:b0:7cb:288a:b678 with SMTP id
 ada2fe7eead31-7cc369c10c3mr2742176137.19.1792445361069; Mon, 19 Oct 2026
 14:29:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:29:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:29:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:29:20 -0700
X-Gm-Features: AclHuK8m6MqbD1dP_5UCeR3H_fKHXeVC4QLMigX1p9vFaPQRi74zjyDFJces0t8
Message-ID: <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] setup: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000006c5a4065e383553"

--00000000000006c5a4065e383553
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/odb/source-files.c b/odb/source-files.c
> index 455f409db0..4a7cbbfd9b 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -1235,6 +1235,7 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
>  }
>
>  struct odb_source_files *odb_source_files_new(struct object_database *odb,
> +					      const char *payload,
>  					      enum odb_new_flags flags)
>  {
>  	struct odb_source_files *files;
> @@ -1245,6 +1246,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
>  		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
>  	}
> +	if (!object_dir && payload) {
> +		if (is_absolute_path(payload))
> +			object_dir = xstrdup(payload);
> +		else
> +			object_dir = xstrfmt("%s/%s", odb->repo->commondir, payload);
> +	}

On the reference side, we use `strbuf_realpath()` to convert the
relative paths to absolute paths, should we be doing that here too?

>  	if (!object_dir)
>  		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
>

[snip]

> diff --git a/odb/source.c b/odb/source.c
> index b25ef14df8..10abe33a26 100644
> --- a/odb/source.c
> +++ b/odb/source.c
> @@ -1,4 +1,5 @@
>  #include "git-compat-util.h"
> +#include "gettext.h"
>  #include "object-file.h"
>  #include "odb/source-files.h"
>  #include "odb/source.h"

Do we need this import? This commit seems to compile without it.

[snip]

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..c7c464d3a2 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -839,6 +839,36 @@ test_expect_success 'init with --ref-storage-format=garbage' '
>  	test_cmp expect err
>  '
>
> +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage is not allowed with repo version 0' '
> +	test_when_finished "rm -rf objstorage" &&
> +	git init objstorage &&
> +	git -C objstorage config set extensions.objectStorage files &&
> +	test_must_fail git -C objstorage rev-parse 2>err &&
> +	test_grep "repo version is 0, but v1-only extension found" err
> +'
> +
> +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files backend' '
> +	test_when_finished "rm -rf objstorage" &&
> +	git init objstorage &&
> +	git -C objstorage config set core.repositoryformatversion 1 &&

If we're doing this, do we still need DEFAULT_REPO_FORMAT?

> +	git -C objstorage config set extensions.objectStorage files &&
> +	test_commit -C objstorage A &&
> +	git -C objstorage rev-parse --verify HEAD
> +'
> +
> +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
> +	test_when_finished "rm -rf objstorage" &&
> +	git init objstorage &&
> +	git -C objstorage config set core.repositoryformatversion 1 &&

Same question here.

> +	git -C objstorage config set extensions.objectStorage garbage &&
> +	test_must_fail git -C objstorage rev-parse 2>err &&
> +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage${SQ}" err &&
> +
> +	git config --file objstorage/.git/config extensions.objectStorage garbage://payload &&
> +	test_must_fail git -C objstorage rev-parse 2>err &&
> +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
> +'
> +

We should add  tests for the files ODB with {valid, invalid} payload. We
should probably also test absolute and relative paths in the valid flow.

>  test_expect_success MINGW 'core.hidedotfiles = false' '
>  	git config --global core.hidedotfiles false &&
>  	rm -rf newdir &&
>
> --
> 2.56.0.269.g68944adf51.dirty

--00000000000006c5a4065e383553
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a43d5b1cb413024_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yV2k2NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2xBQy85bGU3aTJJaENRWWI0ZEdoSnNKdXBrRGc2NQp2NndJMTgvVEJC
eGhxQWg0OXRsMWVHaUQyaFErME1ONGdkUk5KQ1NpQkwvdFlEbU4wWUQ0eFZOUXFGTHVJYnFiCjc1
MFJQU2x3NzlVdzhJQ2NjZDh6QzZQbkRSVGdTOW9kMVM4VWRXaVJjUXNHVk1GVzUzUjdlVVFTQTcy
MVBxS0sKbTNHZUhQYk56SlRtaUZoRXU1cWJVZVl3ZUFiOWliNkFNVVoyUmk1VTV4dVhjcUVYTmc2
bWY5M2FwQkx2dUs5SQpqS01laXRqbmk0MkVvdzUrcm5sSFExTWQ5UjJZZ0tIMWtPaXVaVk5BY3Iz
K0VVT0tmQUlZVDZpeVhCeTNsQTVtClBvYjQ3WisyVE4zVUdiUStaZUlOUTY0RDhYenkrWldQMWQy
aUJGZ3p3NEJTbmhVV0NacjVQV01EeFIwR0hvWEUKMjIxVTh2ZzlXM201NTRjU29PWFRkWEhXYlQ1
ZXlvMU9ucFJvVmJibTliTHlaL09nMFhPQSs4MHdReGRRNytqQgpCZ2xWV2VJUkNCM3BRTllKRkF6
TURBdzFDaUQvUStNVW5LNWVWUW12TUxtU3JkZW9wMllrTUluZnFUYTZ0b3gvCkt1OTNpNStkZzZ5
aGFqbEIzTXNpZjdjN1FuR2VVLzFSZU55NTJxRT0KPUNZaW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000006c5a4065e383553--
