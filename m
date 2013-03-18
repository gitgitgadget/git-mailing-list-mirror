From: zero modulo <zeromodulo@gmail.com>
Subject: Git build fails on `make`, undefined references in libcrypto.a.
Date: Sun, 17 Mar 2013 22:03:37 -0600
Message-ID: <CAA8xkY==7021SyDmeiOcHMzXbX9L0GgG9yTTED5u1r+tfAPGqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 18 05:04:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHRJ0-00047E-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 05:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab3CREDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 00:03:39 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:52415 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3CREDi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 00:03:38 -0400
Received: by mail-ve0-f179.google.com with SMTP id da11so3988230veb.24
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 21:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=8balCdthzEAl7fR/vl69A09DLHp5PXpUL4YLpTDA85M=;
        b=x+B5FEzxZGHmVErj0BWoC2dEczT0iF8nFTZNAMKOpg8nxBGtmWzaPOl8iBO37ZQYZ0
         mRloavkzEmPOlXBKCrwZ8ZyoQVMgqiefI1G/9/+7EZg2Kts2dXsfrKtofadIv9k2DXWK
         4HC0p0CZKBquVBkIefg6WXAfzrifDkuBW2v6e2+0qv2o73/kdcfc/aVsrdbpKUzAL+RI
         poBqnCSyfm8n+NaIFrZCjX0gA5Og8CMgAb1FzYxQnT8QhHIkAFiUMZVFkpuEuM7q/3O1
         RTJy/79/aEeWiI/rKI2KuMNnFxGr5DguTyKuPM/x9xaVf2tiS4E3eWKuvGxcsCObSXvc
         wBuA==
X-Received: by 10.220.154.66 with SMTP id n2mr17728662vcw.40.1363579417338;
 Sun, 17 Mar 2013 21:03:37 -0700 (PDT)
Received: by 10.58.210.233 with HTTP; Sun, 17 Mar 2013 21:03:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218390>

$ LDFLAGS=3D"-L/sandbox/builds/lib" CPPFLAGS=3D"-I/sandbox/builds/inclu=
de"
=2E/configure --prefix=3D$PREFIX

$ make
[=85]
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_global=
lookup':
dso_dlfcn.c:(.text+0x1b): undefined reference to `dlopen'
dso_dlfcn.c:(.text+0x31): undefined reference to `dlsym'
dso_dlfcn.c:(.text+0x3b): undefined reference to `dlclose'
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_bind_f=
unc':
dso_dlfcn.c:(.text+0x3c1): undefined reference to `dlsym'
dso_dlfcn.c:(.text+0x4a0): undefined reference to `dlerror'
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_bind_v=
ar':
dso_dlfcn.c:(.text+0x521): undefined reference to `dlsym'
dso_dlfcn.c:(.text+0x600): undefined reference to `dlerror'
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_load':
dso_dlfcn.c:(.text+0x678): undefined reference to `dlopen'
dso_dlfcn.c:(.text+0x6e8): undefined reference to `dlclose'
dso_dlfcn.c:(.text+0x72d): undefined reference to `dlerror'
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_pathby=
addr':
dso_dlfcn.c:(.text+0x7e1): undefined reference to `dladdr'
dso_dlfcn.c:(.text+0x849): undefined reference to `dlerror'
/sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_unload=
':
dso_dlfcn.c:(.text+0x8aa): undefined reference to `dlclose'
collect2: error: ld returned 1 exit status
make: *** [git-imap-send] Error 1
