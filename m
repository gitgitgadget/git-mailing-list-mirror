Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B635C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHIRFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHIRFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:05:43 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 10:05:42 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827E2133
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:05:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C502C40E01A1;
        Wed,  9 Aug 2023 17:00:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L-QiQslGiJtS; Wed,  9 Aug 2023 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691600430; bh=Aj8qHU99Lea7wrl4Oa1ydabvcW4paC9AKuF//ZVUdYw=;
        h=Date:From:To:Subject:From;
        b=MCQKd7iIGZdm6Md1ACpgq3831LJ2TBGXEBLdhhEEx7/8oXDPV/L7qL/hKuhy1LFmD
         TMyxQlWq2b5l6VpBBtgD6oDtQnBmXiz+1eNzdMoqPQ6dTFUEgltdu06m+MOkevh1C6
         fH4FUxOIxj2DzH6DmeZ3Ayu1ADSMWL832mJgNqZKThu0kkwQuKmeu7nKe6hjG5fHU/
         oPFYcQd28LcMnjtyfhDb7anquVkB/Dss5ryyMhlAaY/uKLWAY/ENGTGk5FqZExy2jd
         phGu7oFkJ+MmRctDPbIcbwfiqb0m3rF3rp+2y1G9Nn1KfEAumt7F7UWn0zwZGANnSZ
         thWSbPavOoSXullInFh31wgR2qODb55AWyAdGyEHlwWzQ5CUeyIlkUoRk1ykfLWCn1
         YwoEdsxG3MzFkZ6MyEjyD+oR3dz1cIU0rRS4kgqsC3n8PVW4qYvsF3cqMUWYWa4CG5
         ABge7PRZkMNXKr5tLBe0wXXdOctD7NwRRzxKQSUVoYqIJDuFLRZVwRevh7F88AyWYK
         No6T0Q/+bZeC7mmxkBzuXH/I7UeAxlyeBUKvdImHkjnOSH5PiCqJ8Qoai7OwuE6Dut
         IIBEGg0dxiB3NNMoDqoNLbRUUvE7UrXKYOws9FgeDalabXt9CGRJf+L570a/dRiuUH
         NKOnfY3qWwdf8M3CBAhWEJ5E=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EB0040E01A0;
        Wed,  9 Aug 2023 17:00:29 +0000 (UTC)
Date:   Wed, 9 Aug 2023 19:00:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     git@vger.kernel.org
Subject: git send-email -v
Message-ID: <20230809170028.GKZNPGLM93GYB+7Ej9@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

when I do

$ git send-email -v --dry-run --to=me  -1
/tmp/UdA2hemFfD/v-dry-run-0001-x86-microcode-Include-vendor-headers-into-.patch
(body) Adding cc: Borislav Petkov (AMD) <bp@alien8.de> from line 'Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>'

From: Borislav Petkov <bp@alien8.de>
To: Borislav Petkov <bp@alien8.de>
Subject: [PATCH v--dry-run] x86/microcode: Include vendor headers into microcode.h
Date: Wed,  9 Aug 2023 18:34:39 +0200
Message-ID: <20230809163439.26391-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll):
---

The -v and --dry-run are glued together and stuck as text after "[PATCH"
in the subject.

Without -v, it works as expected, see below.

Shouldn't the option parsing error out with "-v is unrecognized option"
or so?

The git version is the latest from the repo: 2.42.0.rc0.25.ga82fb66fed25

Thx.

---
$ git send-email --dry-run --to=me  -1
/tmp/kl2hW__Izm/0001-x86-microcode-Include-vendor-headers-into-microcode..patch
(body) Adding cc: Borislav Petkov (AMD) <bp@alien8.de> from line 'Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>'
Dry-OK. Log says:
Sendmail: /usr/bin/sendmail -i bp@alien8.de
From: Borislav Petkov <bp@alien8.de>
To: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/microcode: Include vendor headers into microcode.h
Date: Wed,  9 Aug 2023 18:35:18 +0200
Message-ID: <20230809163518.26423-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
