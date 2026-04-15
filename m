Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6398298CAB
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220068; cv=none; b=ASroLc/TllKMlR+kHP6X7NvnNia96X+MDiEPjS+BpnsblAomK4L+mo7rvlecqbO8d0X1fz7F+kl3OwPKVxFRs7aU+Q+n2CqHOQ8tdOu320Iemv7UK76sZ7WkjZKScN8l7T7HHZ42QHnFeWIvwT4QBCo9NnwL8Pm6w5YsoxPPYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220068; c=relaxed/simple;
	bh=c4uE7GvRpO1LapB1HobWcxSNs/UfQI4zY3RlaEpluoA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GDvmz2aTDYEN6xjbaRJ+iFhMtisTx81cCMMNMye1zNFGpYC5J1oveixF2HKNMTpHq1Bsdu5eiimbFSYIhYS5u/AnpQAqWl0MMV7zNAQDA3YqIuKwNk1B+UKT/V7zioMuGC2zgWD9VbcNT73yFotBH+AUFqcfZQTm0SnXwGqMa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSLCupfE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSLCupfE"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd71fb9f06so390811685a.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220065; x=1776824865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+rCuLdfTelJGToDVvn3nnRjHn/eLEYm1f0Hm2sn0rs=;
        b=kSLCupfEZYX3jCum2+TydQ2D22ORruKJuZU2OMETXB/Uz+nS5uOdPu1ixAuw/VuOry
         GnJ2L6HPfb78t4pvwV1bxqIGBgFgWwm749up35YC6Hw78v2ZfSYEXm0qIFNnSJpvrBKp
         pkf/nfRpvMEF0+20bdQoZ8cYee3tVIGYxRsrD7pArq4mwVmxSp68DlEBqcVr61WDEvmn
         Vw4tUAr6FQvdU6BK6h+zkn/P50B+4guM/3J0kLvqXs8hl2Allzw3lWw5r8X/2MEvFrkZ
         ULy0KMXAPyLbBOOBstLtv7TgqHuQUhHSdwy2IdlsW325i9INlQsognAV2fkVpL6qMIPh
         /plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220065; x=1776824865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+rCuLdfTelJGToDVvn3nnRjHn/eLEYm1f0Hm2sn0rs=;
        b=WkOQZXzNu3odXB+3XduxoJvsHuGCbYmhVP9a9YtI2EDJazhaMSOJEfphJPBa5vVZbh
         6eEEUySvDEiir8pPdgHt2wSHdMrSzqLXtCkluKnOT6vFmKesB4jlaXwjOFtQXyhM51/t
         f0fpFUKu/CzBT6nvmLdrH6ZMOmxoiwXP2z168l/A5mSLwJO3Tv5kaFZ85U3vZ8mjPQfz
         17ysiPwjUVBpBGVVeu5c0Ao7+cldvH7wPcMAg0vaaMKjUaJUGyVHqnkNfumk4qFbSV5T
         q/mkBr7uBy45KJEQEVRhce3lmsRVOrNBE3OFatBllfoPbNyx6oqmiL/AG6qlV1ZFbXtI
         8DpQ==
X-Gm-Message-State: AOJu0YxlQ7IPKjhlvV9IKVseOErrJ5Bgp1Rw26Q1p4fkuQO8VtLX1l7V
	dacWAhPF7Z3Z1smut9KT++4aHtezSuuGQudVuZvpPxynMnBsEi/dt3TWz5OOLA==
X-Gm-Gg: AeBDietoRKrHwh2XrgIKGYcC7qKJS0yvLX6YkL2e4P8AfnYCywy+Cwhrx/SWCvEywVe
	GySQE17+gaX24x6nMgAp/w6saewrqjsBfOeqY7uOmHB139omMT+l+R9+LCLnylcCNhRNX1ocETX
	Wxqw6q4w0Bn6cAvJo6XPVh1PqGSRzhznn/rHRBD2BxKXCpPG/DDWZLCsSsGN1EwGM4JeuU0B4fU
	HpF+SXq+8cQ5B3hPZoQOceBGomjGK1iCrAhElivNl07kmTCxjMbRYodc4X3DZD9wzScI7vxNvW9
	gJVRMvc55UqxEMq3H5rjKoCsOEjv9VY3IVoZE75amaGeoGdXkIDFksTg3rMWphudYzUNH5BrRgk
	3d7sZyBMfrpeQCV6WI8G9HV6F3QtlMwL+TIuJXEhK3dFMZHvXGCNy1sL3STBrpJR9qeO88zkJqo
	zVBmsro8ux3pFSrCYzzkRGm8BW+7Q=
X-Received: by 2002:a05:620a:a29b:20b0:8de:d009:2ff2 with SMTP id af79cd13be357-8ded0093040mr1804837285a.25.1776220065186;
        Tue, 14 Apr 2026 19:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33b477sm23894985a.20.2026.04.14.19.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:27:44 -0700 (PDT)
Message-Id: <pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
References: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 02:27:41 +0000
Subject: [PATCH v4 0/2] userdiff: extend Scheme support to cover other Lisp dialects
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

Common Lisp, Emacs Lisp, and other dialects have some top-level forms, most
importantly 'defun', that are not matched by the current Scheme pattern.
Also, it is common in these dialects, when defining user macros intended as
top-level forms, to prefix their names with "def" instead of "define"; such
forms are also not currently matched. Some such forms don't even begin with
"def".

On the other hand, it is an established formatting convention in the Lisp
community that only top-level forms start at the left margin. So matching
any unindented line starting with an open parenthesis is an acceptable
heuristic; false positives will be rare.

However, there are also cases where notionally top-level forms are grouped
together within some containing form. At least in the Common Lisp community,
it is conventional to indent these by two spaces, or sometimes one. But
matching just an open parenthesis indented by two spaces would be too broad;
so the pattern added by this commit requires an indented form to start with
"(def". It is believed that this strikes a good balance between potential
false positives and false negatives.

This commit disjoins a regexp employing these heuristics to the existing
Scheme regexp, so it will still match everything that it did previously.

Johannes Sixt (1):
  userdiff: tighten word-diff test case of the scheme driver

Scott L. Burson (1):
  userdiff: extend Scheme support to cover other Lisp dialects

 Documentation/gitattributes.adoc           |  3 ++-
 t/t4018/scheme-lisp-defun-a                |  4 ++++
 t/t4018/scheme-lisp-defun-b                |  4 ++++
 t/t4018/scheme-lisp-eval-when              |  4 ++++
 t/t4018/{scheme-module => scheme-module-a} |  0
 t/t4018/scheme-module-b                    |  6 ++++++
 t/t4034/scheme/expect                      |  5 +++--
 t/t4034/scheme/post                        |  3 ++-
 t/t4034/scheme/pre                         |  3 ++-
 userdiff.c                                 | 22 ++++++++++++++++------
 10 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100644 t/t4018/scheme-lisp-defun-a
 create mode 100644 t/t4018/scheme-lisp-defun-b
 create mode 100644 t/t4018/scheme-lisp-eval-when
 rename t/t4018/{scheme-module => scheme-module-a} (100%)
 create mode 100644 t/t4018/scheme-module-b


base-commit: 9e8f4e9c04e3efa494e78b710e0c5f6cc77a0a5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%2Fslburson%2Flisp-userdiff_driver-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slburson/lisp-userdiff_driver-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2000

Range-diff vs v3:

 1:  e20ac5b6a6 = 1:  8e0b1e3d01 userdiff: tighten word-diff test case of the scheme driver
 2:  fb4c8dc5d4 ! 2:  0bd51e02ba userdiff: extend Scheme support to cover other Lisp dialects
     @@ Commit message
      
       ## Documentation/gitattributes.adoc ##
      @@ Documentation/gitattributes.adoc: patterns are available:
     + 
       - `rust` suitable for source code in the Rust language.
       
     - - `scheme` suitable for source code in the Scheme language.
     -+Also handles Emacs Lisp, Common Lisp, and most other dialects.
     +-- `scheme` suitable for source code in the Scheme language.
     ++- `scheme` suitable for source code in most Lisp dialects,
     ++  including Scheme, Emacs Lisp, Common Lisp, and Clojure.
       
       - `tex` suitable for source code for LaTeX documents.
       
     @@ t/t4034/scheme/expect
         ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
         (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
      -  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
     -+  (define <RED>|the \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
     ++  (define <RED>|the \| \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
         ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
         (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
           (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
     @@ t/t4034/scheme/pre
         ; This is a really cool function.
         (this\place (+ 3 4))
      -  (define |the greeting| "hello")
     -+  (define |the \greeting| |hello there|)
     ++  (define |the \| \greeting| |hello there|)
         ({}(([](func-n)[])){})
         (let ((c (+ a b)))
           (format "one more than the total is %d" (add1 c))))

-- 
gitgitgadget
