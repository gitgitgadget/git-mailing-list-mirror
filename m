Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFB365A14
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250237; cv=pass; b=ap4xgGEDjGQz48pefAGZsGnoeyYDgBklOLeKxe5iDRKD6ER0kRfMaVvp6YLUIFjTUJKeQg1FDuKjTQdxU2cJdbjt39wrLMX0vBc3gp6kWHLtoi4696/lRzjODUIcBD9nQvHpfKGKDCStCgD67DIbYXiyhAz9ZRAE9FPBPDhh7ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250237; c=relaxed/simple;
	bh=B6+eY6YHhhE5i9nW87vexfRdRU/PPlqLW51lNW/kb7c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=buxGxv9iFJkF5iImfctucIB6fuPXBRQ9ASa/8tdbPcVWe9EapoAI2jQ9xo0dAW+6f8qYPhAEEx3KqxVAQ1bYip5kEJZnwDU5/Po4LhP0Azkq78tngN8/Q6spKVXzKhU1F+rlX8SEu61268s+/bZe8Yg434yLsLPF0PBGezpz1Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqErAB3A; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqErAB3A"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab395abf79so6520047b3.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 08:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792250234; cv=none;
        d=google.com; s=arc-20260327;
        b=eTu27OkQapantxqlEDPWn7qP8aLrZAZmlSazsn8Vg/rap+rDUd+rcEZtwYhcQwfpMu
         aKllnKMBZ27M0I8rQEnDZiJCOBfhhFiYRUnchPe5zBK4S3w84In+J42oCIuqkOUq4/44
         jbhyp18StXlMVr4FJXAfPeaHbaWlbd+3JbpoRXrAZgYnqvCOxpYH7RSjudrH0x1SNjAm
         2LeFGPvzyO1NSwl0K/jLJH9xJVOIgVvqHeTLqjM9Ng/4gXc6XYJi7XSExbQM9ZvtwfBU
         icqWawQykT8Glfol4ERdhsjCRNTgEkGzktm0WE0RvtxigW21wtCL3jFA0DlQPTyK9pE0
         nNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iVHR6hUnUuCzPV6vzSi2tIvA4rEjPMKLnEINcdN8bJg=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=pcpbooWATpKUcCHGfZ0Oc98ni6M3N2GMLbFvIxBP2Aejiulosm1IuOJQn1owb1SW2C
         Fvm4ZNPMTbYefyIf64TFwprCTUcXk76jFH4rNwYAqDFcWRnuDWLUlizbsXAOeQqImutq
         WEBVWPkTxZ7nclP7ALb6Ps47LNVhRvaR4qnkSMuSpdJFMb2DTUE3+YJUSLTeylhVnvhO
         OntN0gOLqEXiF1O04sFJt9ZsjA58uvTfO7FcfDg0XUeTS1CUng1LA39nhqHWMJ+QAd17
         9GCNXnlI/ruD3VGxyH8hCohznYOroPhZJ0w5znPOYXO/+xQHn04P+vz5PNrImfRBHxOU
         zZrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792250234; x=1792855034; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iVHR6hUnUuCzPV6vzSi2tIvA4rEjPMKLnEINcdN8bJg=;
        b=WqErAB3A34JSLYQ8x6YwqXgrK7TAG3pW+y5m4K/XEzuF1Ryhd1XKvHXx7JwbL12Rb8
         /qKvbWcuKJXniakbRPc23ji4lRhuQ9Dp5SecGz1XL9GR+qwLlfYLUrakZl+/W9ocKeZR
         dQS1txiOPdyeREyRyDzYxATXzLCl21gLruH5f/OmJEQm4i8Ix3zuC9AJTgP5Mn687WTF
         3i/qu6etxd9009QAguKwnWET2RcvxR5/Tc3sDRm7bRN9UEMypp7Nn5K/1sr9t1/v+9R0
         wSt+tToB+RNg/Cbh6Usa0sa0+odnmKJKCI2KHqA6ZT5QL3x/9oH7uyrsliACY/lPnxlK
         iC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792250234; x=1792855034;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVHR6hUnUuCzPV6vzSi2tIvA4rEjPMKLnEINcdN8bJg=;
        b=XRFZ5sNzXtVylxU+iXyF4pd8/0EPkTJa1dvGWZbNm6XB6iTFkmhdTlfHsAgRdq0Eq0
         sJrHwK3d/AUxX52hiEpYvvPQd/ax0LB0e/Qpiesm4nZKQBFQ7caqS8SMKXkKKAPQxJ6S
         HK+qrPWMqlMH+5L6vv7oZflXM5J9aOFopbgscI7p4Fuexy2Rl3rIYZEaEpM/zbJP3sEy
         UbaZ7QIPF5g8MF+q6iOvirHv4Bor/sHOyzHuYF7vpu0V1+0kKDC+qlOUF7w9mvLSuXt+
         k03A+5y6Y2VCxejXe/H9pqr/4G4usZY5lGJHFgKp0zG05MwZ9QuLFRvwAjbR7JHn4gV7
         NZjg==
X-Gm-Message-State: AFq9FYJASSklnTBch1JpplGJAj52kRr7pmxvbQJxGDH8Ocz5AqZA5gzs
	ZFwNd7pnKkTYB0XvElrGm/egrQw6dwsJgnr3s/F5GB67zEaeze02+pqNQO8Le4mrtwo5GC+uNeZ
	t5IK7MwmTmMFp8yul4PPVGjKOrkbX+P2yGww9
X-Gm-Gg: AYBFou0r3EsHunQ2KcX4fvMBOhb7a9zG7+LUX1tygdjSiRkGuURKNrB1WewqI936goQ
	4rbChgstCHihKmrIUBvcR67ouPlBE0tdAp/xBctF6kx/lF/AuB6L0l+qJ1HH29Tk0dGducZgoob
	xgbGNslXiK3ZHEV+viyS2aReMshXSIAaxze2TE4gzuX8iuRfq6p7uwrYgZKeRvzvIR+i1b5WBCo
	ToAUYJHbb6A704rEi1cmV6yGJsCO8/imqfiXDFHFSyYCd+LlljES7pIPu++1ed7dCINkTsKWzzc
	DzR9T+Lt5nLVj9iT4jZ3EB5LxEwmqhrBz31nMb1tZWTdO40R+BBtqw==
X-Received: by 2002:a05:690c:29a:b0:8b0:702f:2a69 with SMTP id
 00721157ae682-8b0f21c8b34mr14477617b3.39.1792250233933; Sat, 17 Oct 2026
 08:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gingrspacecadet <jackrawlings2011@gmail.com>
Date: Sat, 17 Oct 2026 16:17:02 +0100
X-Gm-Features: AclHuK-8lh3gLIHI4e8_OcN3DBTx8GTIPox2qNeXaGmE7nnp_cFzN8kkgxVgqdA
Message-ID: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
Subject: Git crashed on `git apply --check`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Checking the following patch:
diff --git a/tests/constraint_type_signature_lifting.test
b/tests/constraint_type_signature_lifting.test

new file mode 100644
index 0000000..0000000
--- /dev/null
+++ b/tests/constraint_type_signature_lifting.test
@@ -0,0 +1,40 @@
+name: constraint types in signatures are lifted to generic parameters
+expect: pass
+stop: run
+errors: 0
+
+[source]
+constraint Readable = {
+    fn uint64 Readable.read(Readable *self);
+}
+
+type File = struct {
+    uint64 size;
+};
+
+fn uint64 File.read(File *self) {
+    return self.size;
+}
+
+fn Readable identity(Readable value) {
+    return value;
+}
+
+fn uint64 read_size(Readable file) {
+    return file.read();
+}
+
+fn int64 main() {
+    File file = {42};
+    File copy = identity(file);
+    if (copy.size != 42) return 1;
+    if (read_size(file) != 42) return 2;
+    return 0;
+}
+
+[stdout]
+
+[stderr]
+
+[exit]
+0

What did you expect to happen?
The patch check to pass

What happened instead?
"git: apply.c:3856: check_preimage: Assertion `patch->is_new <= 0' failed.i"

[System Info]
git version:
git version 2.54.0
cpu: x86_64
built from commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
gettext: enabled
libcurl: 8.19.0
OpenSSL: OpenSSL 3.6.2 7 Apr 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.10-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 May 2026
14:21:20 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]
