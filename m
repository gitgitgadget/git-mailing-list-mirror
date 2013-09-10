From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/3] MSVC: fix compile errors due to missing libintl.h
Date: Wed, 11 Sep 2013 01:21:53 +0200
Message-ID: <522FA991.60807@gmail.com>
References: <522FA959.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXFt-0007sw-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab3IJXVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:21:54 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:34400 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab3IJXVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:21:53 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so4219202eek.32
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=yZSkizmZhB6X4tAfUwrMZNw9GUdjvzczOcW68MB7cMU=;
        b=kGgV0QingB0a8IleyC92pBC+T4uRm8lzVdUD+boOqM9pYjoXviYtWUN55tTdz3My+1
         6/+9uRpOAA/uWwfVOfnwQnMnojsunwvOe2wcTHLRQUwJHmpkzLkcex6X04pgKYFG2kzq
         g3gf6YysBnaMwh5M455r6txMmNBVKI5KY5uoOiZ/UQh+CC37eTCqfO1w1FufhK0BUH89
         twVZgZBDs65MfUmzx38g9mX+QTWA3hovnqG3rmCcDBgNvdFED1LmX1sCwtwBa3Ipg+XS
         9JNjgb2C9JYl+HemmjafPpanS8ret/HdZun3N+lzZ2b27a11qMfVUjciqplP1WMeCDlc
         Cquw==
X-Received: by 10.15.75.73 with SMTP id k49mr42017167eey.36.1378855312458;
        Tue, 10 Sep 2013 16:21:52 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f49sm35436371eec.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:21:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FA959.80108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234505>

Set NO_GETTEXT in config.mak.uname to get rid of libintl.h dependency.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index b27f51d..64b7f49 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -340,6 +340,7 @@ ifeq ($(uname_S),Windows)
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
+	NO_GETTEXT = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
-- 
1.8.4.8243.gbcbdefd
