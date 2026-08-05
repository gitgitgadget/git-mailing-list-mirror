Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB7388885
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940023; cv=none; b=YGwHjsA6pAK5Z8nPKD9rC3Gw0JFv4yfTpY7elrJ0ZliTKz08qgLXWtaWwa831LVuQG1v/9g9dw6yBqm96ktnBt1JqPEltBi8wWQ1z2vlniZ1pdll8SLxu7vrsPKbL2suLZsFaZEfmpTxzZO6ACE9UAAckbIY947uATqzbS4Mid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940023; c=relaxed/simple;
	bh=9nw5qJuhTup9/RftlFnhcLt9X0dyTpRGtOaBMqnh9/M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n4L3EfiT3Y2JdaPefw963jVXraHJAZYeNpOnJS0H4D8kUFvMlXaXNP5h2OStEv45ZFIFuQILjcF9jfrV8XxdNd7WDs+3hODyR398q0K29I69Q91vNSrB8x1BUOWDySIUH5zri/CArja0RgwcenjkTF5XrNsfe6tQRWsfVwjozAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLeKGS+Y; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLeKGS+Y"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c04bf4711so9124281cf.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940014; x=1786544814; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=pLeKGS+Y9Bml6SBURJMtIKCVdkabgDRcdTeqKBBrbr1ieaDL+5UZq1KyZoyW8v8VmF
         iURJgvbYMdaHtRLkIuxUeAVT60xF4cPPygD/5hf9CqTaBfLhMm6jDYcfNyiURNFWmplR
         6t1yxnYVMlw3V5PE7fP45xEQAyDsIHMooIGOVU1JvVYtUKA71anOcj1eBfZ9/BEPR9R/
         gxUwW0D37UKN9i/BpdQFINOZwpN5YAVQpxJIEGxcofyX78LbrgW1EZfEgx6Bo9myNOh1
         vOf9Ii0+e9xQsNULQHEt8SxUkEfyvPugW/jGpH7UJakJoSXWt6iWULfqT5YJiyNsifct
         3qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940014; x=1786544814;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=aR308GcUumj+2AZFRX3pgJ75DQxOGJq4UA70FHwkASn7yVHnJqiCILFyzxTsJ2EV4E
         6BsOLJ0/CrsC4yiI8bUieanOSgK22G851EjfCDAZ0Q00mRbVZe8uPdMcfj+ZFD7uJNXO
         JYE8UFHkEJ59NSTng8IhJk0cTtPl8szq26EN0wdN7c3KlLyQ8YdoKrEikJAivdBMxEY6
         my1TuHmqugvLHfYYHkOjPvRSf85b+rzMBE/4x7DoO8o5zJ97Igo2ofDlTLvQid0O4yns
         gM7b19J0MvIpEM2sJparB1/mEftHmrz1AT3CnS0+07FsRTz/EaNgmWDkAjX+3zLRGWxu
         3g8A==
X-Gm-Message-State: AOJu0YyuDJ0slU0XXkznEuejqb/x5cZUvQU8xsHM5N1pP8gDnlF9ydVm
	j6pUzyn7gph8vEG84FAsy1BgtKVGt39uV9TlCdKGqMqkOT+atFFLj/HmJs9Nbg==
X-Gm-Gg: AR+sD1287TW2NRFDNW47IwNncDAg73fgn7CAAY/ZUDiPtNBcGrKw257ThWVIAv/nX0b
	VeUNqXAgD2YVDUSV3+VfDO6haYTKe6ujkaormrTGLHi6NUn6YU/bL5mxMQqJ/4ryYEKo20sQ3hC
	HHH5Sa5B+rS/1V79jp5+TS6Mx0s0H11vorL3i55S8BMW1IAXqxjpFgJhOJpkSAeaCM7PhoVKQGv
	vi7lsRNqdOSR2VUtfdHSdRGKKrS8kgyP48z/bewdHpKgCJNJ6jYDmdBUSGoK1vwHyvS6z95j8HR
	OtewduGxktvHRDB2MiHdfDyF4vwvFoTqQ1H5RzsGvxLzCB/On4ch8oIpXoMg8SZyUzw0xwMG8jB
	i081SD5ujW6KoNNZZcRtxYL0QRIhyiA9hE+Uzo/mJ8JAbFNbBoVNbuf08hbJivdn7mW5zqre0zS
	yCVWJMGjbcbGsdUmp2JcxC6f7aR9qqpgplLYqcm2/rvCZsmljrtFWo+VgW3GUZ0yo=
X-Received: by 2002:a05:622a:986:b0:517:9f43:4732 with SMTP id d75a77b69052e-52ce5fbd06fmr75830001cf.11.1785940013702;
        Wed, 05 Aug 2026 07:26:53 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800cabedsm26481416d6.46.2026.08.05.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:53 -0700 (PDT)
Message-Id: <b00d242621ad2da67cd07edf34d3c8d3bb19f638.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:33 +0000
Subject: [PATCH 07/12] mingw: only enable the MSYS2-specific stuff when
 compiling in MSYS2
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The tell-tale is the presence of the `MSYSTEM` value while compiling, of
course. In that case, we want to ensure that `MSYSTEM` is set when
running `git.exe`, and also enable the magic MSYS2 tty detection.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8363239513..21f53e3f7e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,12 +758,12 @@ ifeq ($(uname_S),MINGW)
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
+		COMPAT_CFLAGS += -DDETECT_MSYS_TTY
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
         endif
-	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-		-fstack-protector-strong
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -fstack-protector-strong
 	EXTLIBS += -lntdll
 	EXTRA_PROGRAMS += headless-git$X
 	INSTALL = /bin/install
-- 
gitgitgadget

