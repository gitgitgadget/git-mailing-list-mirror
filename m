From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 3/4] git.txt: document the new GIT_TRACE_CURL environment variable
Date: Tue, 19 Apr 2016 15:10:43 +0000
Message-ID: <20160419151044.27814-4-gitter.spiros@gmail.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:11:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXIy-0007DB-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbcDSPLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 11:11:05 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34580 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476AbcDSPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:10:57 -0400
Received: by mail-qg0-f66.google.com with SMTP id m8so1870710qgd.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZ+HQTi5nIck6EgEjCbOENBfmzOeqdVcBpb0fcuvK2Y=;
        b=b29iED7p/K6PiJcXTAEy10GDZFUly9efWrSoHvuG6Iiwyb3ZYrTNURvhDlAOkxpjmA
         /kg5iHhjIx2jzee6f0jJXjlMgpuLIuPpgOaMZUbFo0g5jbsHkLGgpHGCPI1xfwabglAY
         hD6M/pbY65ccv6L/PUfGsXifsdTFFhD7HoTdkHtcRMLkqJ/agXUINo66o3F7ul+JfYCf
         nFar+6AICfdQpHQUM8K8wbovGx63GeiWeTexptwcSpmMYcApk4HecWtsRb4EZUHCqksa
         bTFEMDHXFHAoQ16ZZ8J1CHYM8Ys6pKpK92jwB9rk8rhimqwVZvfAhFcRC5+6yru4o6Kq
         pHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZ+HQTi5nIck6EgEjCbOENBfmzOeqdVcBpb0fcuvK2Y=;
        b=CP4tUdj3Y01Q3IK1xnXrVLs77ZjwG3JklPL58j52fZmv0ayJuaCnsAl5oXO3d1pFbp
         hBaOwLv6WPWBdnBroG5cZXjtlCAPrdIFcojM0CLG/mD9xsLA4KKIuNQd2hqErgfJtz/1
         WUA/hkdGLCrMmuovrya0Tw9jbGi2oqiFbNw28nEV4rppHH/dz3n63lU0nYFrOjL7CJII
         bjPgZuYHOYsaxoiVhZvKLVikBVxOXyadGPeO+do7CE0k3IZzDnZ4bLj9YfS7KzHDDf5b
         nmnDb3Y/pvSyu8XRh5Q7pXsALTdBQJpigWs5dy3Dvqbf4owwXixMhxJB++qc1ANb9eU0
         TI5g==
X-Gm-Message-State: AOPr4FVnYDbkaaMSchQQG1NPNWkdEd6n/4WHj7uhUd7E8EGE8g9+dD+R22ih676GXnKmwA==
X-Received: by 10.194.158.98 with SMTP id wt2mr3658645wjb.102.1461078656909;
        Tue, 19 Apr 2016 08:10:56 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id u16sm4846168wmd.5.2016.04.19.08.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:10:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g0f2638b
In-Reply-To: <20160419151044.27814-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291870>

Describe the purpose of the GIT_TRACE_CURL environment variable

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8afe349..958db0f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1075,6 +1075,14 @@ of clones and fetches.
 	cloning of shallow repositories.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_CURL'::
+	Enables a curl full trace dump of all incoming and outgoing data,
+	including descriptive information, of the git transport protocol.
+	This is similar to doing curl --trace-ascii on the command line.
+	This option overrides setting the GIT_CURL_VERBOSE environment
+	variable.
+	See 'GIT_TRACE' for available trace output options.
+
 'GIT_LITERAL_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
--=20
2.5.0
