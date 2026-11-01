Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524769;
	b=QSOyeXf/rPtsBADIaXQQekLms74Ai1bBaym+U1jgZU0xpBU7PRnyxhNWE4Pw6p5j/7SD
	 3iqQ0ifu4pmjCBDdqQmLkXVtNIct8/bo5X84jPBGOt0MAypEUNtCjHHuhvUAoVPS/Yiq0
	 810FBygy6388IXzQbFulYEyM8yjwwlPgIZJhz0xPwOgoSFlti+8BOqBlBUAkbjN08crZG
	 d/a8EEVb41r1aW2A/OUBQya2yznVS0xx3FICtGVNCekA/eidAQLXWN7o55Rf4rNdhQID9
	 WgWS9tZ71jD2twRfIzHBwXfduqp8pyWtTPcxo+h+nIMs+2WUM3AloNWtAqAScOK1m4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FaW7MJlXz0YstGhZ7bIibR+mQfiRpmP8qv6qPV2HshM=;
	b=AbGiO9k5xMjBW2O+sXtWGa9nk6xO1+bE7WkepNYKewcKRqXdCfEqsHc/S9CKAUOpyivp
	 s5Kk44nPIxzlSSPjoeZf+W+CA4ajB27XJFMStdzT4NoU4YJknYJqUvwIE1m/5f2m46TFS
	 TpBAOdHobAZYnsEQy6hD4CJZW1HxTFnx4+9E5zWDMjdp6b+Dj/UVM5rZqv8nSw8y0NIFq
	 B8E+rJBbcfmS3l/mngpp/a7SBj89vwh1n8eulkGB/lH4HZzFJdlwdwHQU6A8YrsJYfief
	 W1oQB07y4QcJyCl+37FMhFJ2lPGDfo3woIaCpq6fOSOiJ+E1PY8OiUX7grkqq901LOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbHx5rAZ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132A606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 09:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0132A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbHx5rAZ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20edd106so1594814f8f.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524767; x=1794129567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FaW7MJlXz0YstGhZ7bIibR+mQfiRpmP8qv6qPV2HshM=;
        b=GbHx5rAZkmPqYGHySDNp8WoLOL+4DRS/bOOv6KNCSwSLFKpvIXkcF9eV152v5zYOSn
         p5l1rRuO2IvZVCX3qXON+QgIE+T31o3sgiI+9AOzRjz1pQsmzTTG4Ydzp9JYhYf6NhRS
         KdDKPQTb85z+Em8RvF67Lv3Ysy20MuWaTgRuKki93RCA+mipQXnKm6n/K3ybt45l1EYH
         MtBDtCo1OlAvpZDj9xTf46zoqNmmiXcW7AZ8thhNGceb5p+e6bpaLJmqxe7KYoNSOwt8
         lpBtGmhLXDi51EjVYvCDNO7RCsRFRrNkU4KP2Fp72XdQ9Z8mhxV4LwbSVSySYP9U93bl
         +4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524767; x=1794129567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaW7MJlXz0YstGhZ7bIibR+mQfiRpmP8qv6qPV2HshM=;
        b=M7BVXP6k/R/y+y3DfdMZwB8WOhFxLAiBylrl+6sKNEzEWSyBcHIRJ+QZSKQ7Qjpj3O
         drgSeaucPoQJT6QLSHtQATKtkeZ9g47DtxCW+DyP3p4wdzyHUoH7cZniYHjlgHDYT0Up
         9V2ve4BlAuY+IEr8i5f5jK/vZaaS3WHs2xs5SlUeYnZ0SrFhU60DU9hCMzx2L9XmNWDb
         knl+znDBr+V5uHmO7j6yVMJh/DvbF9NtfLoOie84CHuAwNtwz4zssKbynqO5fb0wzcRS
         MTlkWHiFhsld52mQw+/iyYCQozp5vXweV6pV+IrZkQLsOX7gXK1kNpOOxxG5C8vkApGU
         TeNw==
X-Gm-Message-State: APuU4Z8zqc2nVEN2lckniksW+krHNhR7bsNFCMbCUidRnRWKA193aXBg
	L5IylWPqofYCuCfVXjgm6iAfWnHCzxSLa7xX19SVoEk+GUk3Pcp2Bo3aHNqU/hz4
X-Gm-Gg: AYBFou0VsaYXi4kwjSgFyCBHfn5Nz+swPBDCXg6gCW5IJzbzYA3BYJC9dyAoJ09PuLb
	6ZjMnsKHVOZ0bX7CBTQIwMGknAuE1NBSSbArIUbizh62bIYmZyCHFhix99g9PeNVSqrhbq/3lPz
	05tbmubYYxUHePRBGUqlR0RMui7rFew0iCSXV+KNPsxpQryYRjPiRgRUeNn05rZWKA8fh+GJKH7
	MzBPZAkDHFqC4jf3EsprCE+JazZgjre0NKroxpZtyMqmKZx8DsKotvarqRAl7Hw/mOOKPK6lM5s
	rJhGYVJnzdE1N5YcDWxJmglJgA/nFcA3zkScOlAZv9bAjYcN+D16tR9VB+EYc1srTfoq7nlJKmg
	7MDgwvYRMk8FpiOtrtF6R0H0juIi48ZnCLUxWXJtP3chioOn3Gc3q9JsWmTLK1xPoi1PcVdeEuK
	x63DjvxoEPy4X8G447teLtAnnplk9+P/J9fNkRF82hxi9/eLwfGHrMlJrHKeWCj6tEsz4Sq9gKH
	exJYuZWOvEhmsprynygvcPr5VrClL6eDCe2Vem+sHXJu/ObXFsqlLMSLJEUpncSfyCtzSLN2AYc
	jzUdGVEKDLwdlZK6/IOcLt4fbzOZAmdmakA2IHmtFu4RdYg4LyQ9zUQthL3ukXQWsnDwpFfqEAu
	kWwvol6W5
X-Received: by 2002:a05:6000:4559:b0:48e:752b:9f90 with SMTP id ffacd0b85a97d-48e752ba019mr7780885f8f.38.1793524767237;
        Sun, 01 Nov 2026 01:19:27 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm14859390f8f.31.2026.11.01.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:19:26 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Matthew E. Luallen" <m@sph3r3.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] archive, apply: do not truncate files of 4GiB or more
Date: Sun,  1 Nov 2026 10:19:21 +0100
Message-ID: <cover.1793524457.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two more cases where, on platforms where "long" is 32 bits but size_t
is 64 bits (64-bit Windows), a file of 4GiB or more is written truncated
or corrupt without any error.

- 1/2 archive: tar and zip of a file written by streaming come out
  corrupt.
- 2/2 apply: the file being patched is written truncated with exit 0
  (also with --index and git am).

No new tests; both were verified by simulating the truncation at 16
bits, as described in the messages.

Regarding t5004, the existing test "zip archive with files bigger than
4GB" has been excluded where "long" is 32 bits (LONG_IS_64BIT) since
2017, because back then the object database couldn't read objects that
large. Today on 64-bit Windows it can, and with this series zip works
too. Thus, the guard could become SIZE_T_IS_64BIT to enable a real test
on Windows. Since I haven't run it on Windows, I'm offering this as a
follow-up or asking reviewers for an opinion.

With this series, the search for these truncations is finished. The
remaining warnings are not reachable: a 4GiB index, sizes bounded by
config or by the format, commits over 4GiB that already die.

It doesn't depend on the other series in flight and merges cleanly with
them. Based on master 50fe5cc63f.

Elia Pinto (2):
  archive: use size_t for the size of archive entries
  apply: use size_t for the size of the result written out

 apply.c       |  8 ++++----
 archive-tar.c | 10 +++++-----
 archive-zip.c | 16 ++++++++--------
 archive.h     |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

