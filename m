From: =?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
Subject: [PATCH] count-objects: output "KiB" instead of "kilobytes"
Date: Tue,  2 Apr 2013 13:43:30 +0200
Message-ID: <1364903010-644-1-git-send-email-mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 13:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMzdJ-0007yk-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 13:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760773Ab3DBLnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 07:43:40 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34670 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760044Ab3DBLnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 07:43:40 -0400
Received: by mail-ee0-f44.google.com with SMTP id l10so177333eei.31
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 04:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=sN2NA2Q1i8QfCTRyp6aqXCVjKf7vQek/uIUWkITOr+Q=;
        b=mVEIIGBDif550im9/7NJT4tSgh4ZsmNBCN2AZ8+GcPS2/liGwmxHRWZnG65cRDKEgb
         zRc6RqLuTODeUHKAg9sOUo+xXR1AKLlrg2SzWY0QZfF3uGi5A8/ko3MVG9UdnEhxJo1E
         YiGNJaVkksK8vILYfS3OSsk+M6+JijKfXi/NeWFCJjzYeOo4wEs4EGUjcb2A4D1VKVJ/
         msNgtZUVXCU+8emNbXO5Bry7ZdiN+U9kCn+LgFHbBsnwVtegvJZ6UCR3++arr9kY3mg8
         1HjZ3Qzo8Sz+xQgN7n7WlhW5U0cdsyLJGDQ0y7Jy3ghb6BUw3fBvyEkdF49flzKMm5Ug
         uDTg==
X-Received: by 10.14.219.7 with SMTP id l7mr48455096eep.12.1364903018651;
        Tue, 02 Apr 2013 04:43:38 -0700 (PDT)
Received: from dutier.st.ewi.tudelft.nl (dutier.st.ewi.tudelft.nl. [130.161.159.51])
        by mx.google.com with ESMTPS id q42sm2077073eem.14.2013.04.02.04.43.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 04:43:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQl7uVtEKW3gYcTmuaCbRTtNKl4nbP5b4Aduwtob66eWcc4kB4RgLSnfgtm1Di1HQA2A562C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219767>

The code uses division by 1024. Also, the manual uses "KiB".

Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
---
 builtin/count-objects.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9afaa88..ecc13b0 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -124,7 +124,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		printf("garbage: %lu\n", garbage);
 	}
 	else
-		printf("%lu objects, %lu kilobytes\n",
+		printf("%lu objects, %lu KiB\n",
 		       loose, (unsigned long) (loose_size / 1024));
 	return 0;
 }
--=20
1.7.9.5
