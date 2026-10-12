Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA447143B
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809783; cv=pass; b=tZWAR7R8vekIfghjUV9Wfza8WxR9KPkKYouo6gO/QAp7znVLlTWCY4UFEWrcG50Wymlu7KcXwNhissPsfsQRpft1km8jaSb79rE6z/HKTrDKcmWsPH+K0nBgXgC2Xdnd40KJa+VRDt1E55B9uplGL/O7+PLLBJ9LlIIVnrpOY0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809783; c=relaxed/simple;
	bh=MsSbsLJpEgPW2IxU5jn49W6cjRd5Q6d9pxqGkyckRgQ=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgNVtDqssRbBadmccmt8xBbWMcrakEonbU4iDnnTkQN2fWVW1jHAbDh2/gmAFE8Ww/9zJ7VKOTQu5tUre6jY9lUD9nq8zNolO1qp3HVzlLNF8KBUIcJtTmp+DR1nUhU8ta97YRng1Q5X7u1WH0sZ/gDwSn2oza0uRUmz1ta1kSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com; spf=none smtp.mailfrom=sph3r3.com; dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b=KpUe46xX; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b="KpUe46xX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917866225aaso30199566d6.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791809780; cv=none;
        d=google.com; s=arc-20260327;
        b=KIFhu2Fzcnx9aIG/uAjHLLDbRdUUjI4Fb3jPFFYJC9eGm3TYYdODsaSoTimdL8GJim
         fa4p7+5JPLJ5LEvd0FWCV3mvQF9b4Q6tRPXMFOhSOGkMAL3W5IMCcKwTGD/i5HI2vnV+
         KCfgVnf7klOqqE9cpllO2m5gYc11O09liUGR0W9shZhsXeZizBwfLe1NlNWl7DdnAaeH
         L5RsNsgK/Nm71UktqJAO3wbYxlGjODmHlhA/23Jgv4B9YU0pLU9LuufsBIdl38lgIT7X
         pNIFx+vRcPd5WnE/GlepZ1KMRoqI8S05RjyjVXhmRHXv6s5/VB4f+8HwZEEgIPbV0rvd
         ndcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=eQSFSCk29fipD6XDmaA/3FL2MEWH5r11Bs48Rx8N92k=;
        fh=5y9l1RuZiLFXiFoeOBpaH7qQ6TolV9HAfJsCbtLM/Ho=;
        b=Mc19yDRG9TSfM4fteG8FVNR17nJKig+KQ3v1JtziwGblXjGH8XsLrin36e/9g2dfXM
         EaPoVlKYBNCMUeDrpKCV//zgU8teWBz//HtthTNhGwi96mjpwIs6+xNwpW7M3UDugdWb
         p6CFcC1U8Np7IUNqs8ouZ3SHgOfk5Ud6OzT/Vk7UQnLapf4Mdh99XqSpUBOXrZOiKImQ
         gjUVs6KN/i8haTGuiZc9eYQae2I45wH8MKYiatIeNS8qMgp1Rgmavu9+xDOMq4LWCPyW
         Xm2v+6vefULZXscZ8akvOlRBFtviSViDg4xWBJKvFJldHvNqEnp7UA30rrvdnMUJcUWO
         I5SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sph3r3-com.20251104.gappssmtp.com; s=20251104; t=1791809780; x=1792414580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQSFSCk29fipD6XDmaA/3FL2MEWH5r11Bs48Rx8N92k=;
        b=KpUe46xX0tuq5Qy0/hesYDtGyhjWj0xdAgat7KRNeaEZr5UVUA9QTpiynTfjI2DepD
         LHwFd+DirfgJKwmfnSVBCU7gjRI2s4qZUJr3ovlK+V8rYXxSjov6BsLZ8XPmvIWtzcgW
         3qAke+faPfts0t/LXk0Ug+TLKIvdsdL4dqyOT1eqhVay7+J8rZ3tMMQqu1Q9tO8tTBYn
         mahNzx1CrqlW5rlFEY9y1CRoS9w/gxkRCupe6BznBRV6YL/cvOwcFP0lmR7ZSqozgjbW
         dTwYvqW6RDsQW3+Ldf3QFWhK3Nvo9BsFE3Jxr6W4B95xVwc0L27PDpnC/RidhPlJSZhQ
         Vk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809780; x=1792414580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQSFSCk29fipD6XDmaA/3FL2MEWH5r11Bs48Rx8N92k=;
        b=VW1zmztK1jVvorC5hdkHWUQFAHXvVG4exuRrIFPpQcVyyXDjKY3y5K268oLyy6DN/E
         isFarbWa9PRaC20YVSiYIFo20J7GAg2DrYHE8TcOmtNc4Db/zYdEo0NLYzZBiSOxSD9i
         YQeEDTmLoMnZUXo7VTZumwWgA4HEUrK2wEuh5xuhi9Mhx+HlpR1N/vQ9YxrZMHpwTUeQ
         kkJDdPGYxF8UssZNd74KsQuwIeIB1Ox7XTwepR6/yZNv3tyze0gEa5/ezeaMKR7axapT
         3mv3MgKISUECbvRev29FBGWgV7DolylUWTGO2Oi7c6hhpdouNqh6KDjZYD/91AsehSo5
         kVBA==
X-Forwarded-Encrypted: i=1; AKwUvBwC6RFJanCIjtcVRmtqNqrxUXFaxLenbkKDNICwWy8gm7BKhwSK9W43AW7vyrZHBzvWTNE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoqNaS3w9aUx0KFwIcpKEKP9fLTBCOeJRNLy1ntSgm10773OB+
	vm1vceOyhJ/vcxKqoqlKjWK4wht3ZGL7pl5hbSDkqAEgy4b3F95wSmcbD2GXPB8ifwrcLB3c4y6
	H6XsBVZHPwCfiLBMq+l/hgl0KVyZl2EacgHT4bXYe/1qxKQZgjNXJ
X-Gm-Gg: AYBFou2CTCQq9KbfayaL136OafeezjZawy+NlCvKpllfzh+N9p5F2HpgU31VBP4YG+n
	2r5KKz4P5u2mfOg5B43OJV+4TomsD8ofwPo56360Z+cbGSF8RV94+eKh0syZx9izm9W2SjjtWUX
	65u9kLrAo0zY7NJZ9kuSD/XTNI2E++Qd4BTB4dyPHSimXAWpg/muk8EsHUQWhcXZljvY92ZLDwQ
	m3bHYdSzjcOP9cIhk6kjr5vtOnmQn7nL9TXDX7KvWMgX6fREN5nkpuy7u0gPzfxyhW6r05TPdy5
	I8uNWTuxt4I4EOIZxP8p6RZ7zhVBjc+IadYO6udtPMOxdbJ5znZxcPo9yVAeYZk23NdpDCIbCEm
	YO6fsWCpF+iPXqe/VafiRsm0pnzRCmQckmtpNsRbAzspIH8aZMzp6m9O/SOg4OvHNtX4xw7kjLz
	AxIuFhA2+70aJLRJuoCpMZj83CEIDVg6U1JzkOO1fo+SG1i3Ys
X-Received: by 2002:a05:620a:4456:b0:93e:920c:c00e with SMTP id
 af79cd13be357-93ebd1bb192mr1647306685a.21.1791809779822; Mon, 12 Oct 2026
 05:56:19 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 12 Oct 2026 08:56:19 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 12 Oct 2026 08:56:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: m@sph3r3.com
In-Reply-To: <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
Date: Mon, 12 Oct 2026 08:56:19 -0400
X-Gm-Features: AclHuK8FTVVq0EwEHyQ2O79mo06yosBW1slprYAysQpFiRtvbGNq0IP8dP9Jjzw
Message-ID: <CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

Thanks for the patch. I confirmed that it fixes the 2106 case: before
the change, UT wrapped to zero and unzip -u retained the existing 2025
file; afterward, UT is omitted and the file is replaced correctly.

For the i386 failure Junio reported, the beyond-2038 archive test and
its dependent omission check should use TIME_T_IS_64BIT. TIME_IS_64BIT
checks Git's timestamp_t, which can be 64-bit while time_t is 32-bit.

With that two-line adjustment, all 18 t5004 tests pass on x86-64
Linux. Forcing TIME_T_IS_64BIT off skips only those two tests; the
other 16 pass, including both INT32_MAX checks. I haven't run a native
32-bit build.

Best,
Matthew

On Sun, 11 Oct 2026 18:06:04 +0200, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> We write an Extended Timestamp Extra Field (ID 0x5455 =3D "UT") for each
> zip entry, like Info-ZIP zip(1) does.  Its time values are signed 32-bit
> integers (see e.g. https://libzip.org/specifications/extrafld.txt).
> Stop emitting them when the commit time doesn't fit in.
>
> Use a strbuf to prepare the extra field up front.  Keep it empty if the
> time value is out of range.  Like for the central zip directory we only
> care about the length-limited buffer aspect of the strbuf, not about
> NUL-termination.  This simplifies the conditional output by avoiding to
> repeat the condition.
>
> Reported-by: Matthew E. Luallen <m@sph3r3.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  archive-zip.c                   | 37 +++++++++++++--------------------
>  t/t5004-archive-corner-cases.sh | 28 +++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..785689584c 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -24,6 +24,7 @@ static int zip_time;
>
>  /* We only care about the "buf" part here. */
>  static struct strbuf zip_dir;
> +static struct strbuf zip_extra_mtime;
>
>  static uintmax_t zip_offset;
>  static uint64_t zip_dir_entries;
> @@ -81,14 +82,6 @@ struct zip_dir_trailer {
>  	unsigned char _end[1];
>  };
>
> -struct zip_extra_mtime {
> -	unsigned char magic[2];
> -	unsigned char extra_size[2];
> -	unsigned char flags[1];
> -	unsigned char mtime[4];
> -	unsigned char _end[1];
> -};
> -
>  struct zip64_extra {
>  	unsigned char magic[2];
>  	unsigned char extra_size[2];
> @@ -129,9 +122,6 @@ struct zip64_dir_trailer_locator {
>  #define ZIP64_DATA_DESC_SIZE	offsetof(struct zip64_data_desc, _end)
>  #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
>  #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
> -#define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
> -#define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
> -	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
>  #define ZIP64_EXTRA_SIZE	offsetof(struct zip64_extra, _end)
>  #define ZIP64_EXTRA_PAYLOAD_SIZE \
>  	(ZIP64_EXTRA_SIZE - offsetof(struct zip64_extra, size))
> @@ -299,9 +289,8 @@ static int write_zip_entry(struct archiver_args *args=
,
>  {
>  	struct zip_local_header header;
>  	uintmax_t offset =3D zip_offset;
> -	struct zip_extra_mtime extra;
>  	struct zip64_extra extra64;
> -	size_t header_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
> +	size_t header_extra_size =3D zip_extra_mtime.len;
>  	int need_zip64_extra =3D 0;
>  	unsigned long attr2;
>  	unsigned long compressed_size;
> @@ -315,7 +304,7 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	const char *path_without_prefix =3D path + args->baselen;
>  	unsigned int creator_version =3D 0;
>  	unsigned int version_needed =3D 10;
> -	size_t zip_dir_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
> +	size_t zip_dir_extra_size =3D zip_extra_mtime.len;
>  	size_t zip64_dir_extra_payload_size =3D 0;
>
>  	crc =3D crc32(0, NULL, 0);
> @@ -381,11 +370,6 @@ static int write_zip_entry(struct archiver_args *arg=
s,
>  		}
>  	}
>
> -	copy_le16(extra.magic, 0x5455);
> -	copy_le16(extra.extra_size, ZIP_EXTRA_MTIME_PAYLOAD_SIZE);
> -	extra.flags[0] =3D 1;	/* just mtime */
> -	copy_le32(extra.mtime, args->time);
> -
>  	if (size > 0xffffffff || compressed_size > 0xffffffff)
>  		need_zip64_extra =3D 1;
>  	if (stream && size > 0x7fffffff)
> @@ -412,8 +396,8 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
>  	write_or_die(1, path, pathlen);
>  	zip_offset +=3D pathlen;
> -	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
> -	zip_offset +=3D ZIP_EXTRA_MTIME_SIZE;
> +	write_or_die(1, zip_extra_mtime.buf, zip_extra_mtime.len);
> +	zip_offset +=3D zip_extra_mtime.len;
>  	if (need_zip64_extra) {
>  		copy_le16(extra64.magic, 0x0001);
>  		copy_le16(extra64.extra_size, ZIP64_EXTRA_PAYLOAD_SIZE);
> @@ -546,7 +530,7 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	strbuf_add_le(&zip_dir, 4, attr2);
>  	strbuf_add_le(&zip_dir, 4, clamp32(offset));
>  	strbuf_add(&zip_dir, path, pathlen);
> -	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
> +	strbuf_addbuf(&zip_dir, &zip_extra_mtime);
>  	if (zip64_dir_extra_payload_size) {
>  		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
>  		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
> @@ -644,12 +628,21 @@ static int write_zip_archive(const struct archiver =
*ar UNUSED,
>  	dos_time(&args->time, &zip_date, &zip_time);
>
>  	strbuf_init(&zip_dir, 0);
> +	strbuf_init(&zip_extra_mtime, 0);
> +
> +	if (args->time <=3D 0x7fffffff) {
> +		strbuf_add_le(&zip_extra_mtime, 2, 0x5455); /* magic */
> +		strbuf_add_le(&zip_extra_mtime, 2, 1 + 4); /* payload size */
> +		strbuf_add_le(&zip_extra_mtime, 1, 1); /* flags; just mtime */
> +		strbuf_add_le(&zip_extra_mtime, 4, args->time);
> +	}
>
>  	err =3D write_archive_entries(args, write_zip_entry);
>  	if (!err)
>  		write_zip_trailer(args->commit_oid);
>
>  	strbuf_release(&zip_dir);
> +	strbuf_release(&zip_extra_mtime);
>
>  	return err;
>  }
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cas=
es.sh
> index 768b0ff85d..20bab21048 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' '
>  	git archive -o long_paths.tar $tree
>  '
>
> +test_lazy_prereq ZIPINFO_UT_EXTRA '
> +	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
> +	grep "UT extra field modtime"
> +'
> +
> +test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
> +'
> +
> +test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32-b=
it' '
> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tree
> +'
> +
> +test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA 'UT extra field' '
> +	"$ZIPINFO" -v with_ut_extra.zip >actual &&
> +	test_grep "UT extra field modtime" actual
> +'
> +
> +test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA \
> +	'UT extra field omitted when mtime exceeds 32-bit' '
> +	"$ZIPINFO" -v without_ut_extra.zip >actual &&
> +	test_grep ! "UT extra field modtime" actual
> +'
> +
>  test_done
> --
> 2.56.0
