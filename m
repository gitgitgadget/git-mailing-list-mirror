From: larsxschneider@gmail.com
Subject: [PATCH v2 2/2] travis-ci: explicity use container-based infrastructure
Date: Tue, 26 Jan 2016 10:53:43 +0100
Message-ID: <1453802023-85055-3-git-send-email-larsxschneider@gmail.com>
References: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, mh@glandium.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO0Jw-0001X6-3q
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbcAZJxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:53:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36079 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960AbcAZJxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:53:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so16305433wmf.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amM82tfyFHs6KbGLqlZzLqSEsEm4K016+zHLSOSKDbk=;
        b=qhRJ7s34bInzbjEUO80plUR6l0s+1VyEq6Il/jV2ENHAGj+kpDoON0yiS7WvOtQlRa
         uvNTON/GbrGFRhwVD/1WQGCiofvNPcLykSf3Hu+ZrnPW0Pke4ezqaF11tzuTKzAva/gb
         VezqcXnNh0WjNrdIXBoWMJtRhLneVqhJeJ77WAIdvmkz3Yg6ySWf94SVAB6n6TcTugz4
         lkOYiHghu9wJ97wpggY/N+1TfaJST9akJd8/NpqnCvL+9WKN0VHz4YR1012N2d2/HFcX
         U7ReuKG8ZeQI9zbjbMoSrwdXBvIziEEfeWb4cwHngkJOE3I0L31WFlbac6ErgNHhVBgH
         TxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amM82tfyFHs6KbGLqlZzLqSEsEm4K016+zHLSOSKDbk=;
        b=Ren1fHsgJwpzIZJ7VF2Dk0PfLP80mkzfCa2YJ8zsWKO/hkPWQtjeDcudcwmjL62Ll6
         Cj7Gz+ytFSa/lk3ExGJaxUZ7nLHuoWswJWQqJVN9p9u/zYaFlYBlHmLTtl3aQcVp4wXc
         L+2Z5FtF5lCxmtCJL6xPB8YeB+vqoURl/o7bDQ3M9oZERxFfpv2BN+Ma9mQC9bAqiH/7
         /HlN9GQsbC3b9G7fwEGYXYgSTSKFKJmtK5DBMFj4PhLYFEnDVUA3huULqv095EnQfW+6
         n4KwSbR3hhu8LsNwCk7gJvqYPsHYcGxqgpejXNa01UEYeWps2zHNSH0uSJj4grkrTKWw
         TIlQ==
X-Gm-Message-State: AG10YOQDgsX9v1Ox62v9WK3xj3GxPgkEc2O7B4CJBM667PBkQIoHi5Z0+saL59W7/IKlYw==
X-Received: by 10.28.156.198 with SMTP id f189mr21591709wme.25.1453802026099;
        Tue, 26 Jan 2016 01:53:46 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA9B5.dip0.t-ipconnect.de. [80.139.169.181])
        by smtp.gmail.com with ESMTPSA id w80sm2683566wme.17.2016.01.26.01.53.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 01:53:45 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284799>

From: Lars Schneider <larsxschneider@gmail.com>

Set `sudo: false` to explicitly use the (faster) container-based
infrastructure for the Travis-CI Linux build.

More info:
https://docs.travis-ci.com/user/ci-environment/#Virtualization-environments

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 610881e..f8b73ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,7 @@
 language: c
 
+sudo: false
+
 cache:
   directories:
     - $HOME/travis-cache
-- 
2.5.1
