From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] git-apply.txt: mention the behavior inside a subdir
Date: Thu, 24 Mar 2016 18:56:17 +0700
Message-ID: <1458820579-31621-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	mehul.jain2029@gmail.com, sandals@crustytoothpaste.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:57:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj3tN-00019Q-ID
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcCXL53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 07:57:29 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33150 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcCXL51 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 07:57:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id fl4so19932313pad.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vqp/QRGQfpUFwUihD6vtAVGhzVKP06Xgp15rM9vgjFw=;
        b=VZ6khqVDVIk207U/czxlDGlsnGIOz8yLolM1opnnIYWvGgjddyiFGP4Tf81cS1uxrg
         XEU6sYUU0doytaEwVIzXXztAoAHu/EYgu3DPvG5T5wibrvb9b5y4PCzmUqXsxZw+e9vV
         QwEq+RgMNBnPBv9ZUNjL5UnAVwkTqmH+DUcu2+f2AlAFy37cBoCfK422/ep24fB9+ixU
         HOxpUKL6vNF0Lu8HG/V8Pgme7esaL4SBcWoRwIgojNy9ZkcrpTf+1R7OnIpmlaWTZ8Rm
         4cJcy1v21WOLeP7p8k9QiKx3OONIphdJfeVAJTOG3ASoEQz8FF3lB56cHjWeECPcOa5M
         IqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqp/QRGQfpUFwUihD6vtAVGhzVKP06Xgp15rM9vgjFw=;
        b=TJGSV3CKySJPFH0/FgGeSvWbpseC0oXGml6AO950OzA64MXuIbNxWZqdUfJHlQdBx6
         24wj5+HPkcibw61GWn68DjVQqmi5F3yjcu0WqGdIbruWOSOW922iRtICuVn9pvjhXp/+
         SVHIOYVh+LxQ6zMGhZ3tJgUqLG6M/0hAkmaQalC24ETp99dcUhPvoi1Vt7zgbMrfrSIY
         27opNEHRsRf/h+HB3IfOzIjjxHdmW6Yb9Z/uC1RUp/JlcKUJRUFPPaMEjkWPRFz6w7sP
         c/q99q1sjZTGOAJdBnu4HlGZn+a46bJpTlrLONrAtg9W0u/LjjJQS3E27MbL4mf8HmBU
         JJbw==
X-Gm-Message-State: AD7BkJJ5oE++YmSdF5nwRqAfcRtldgpB4+aeCd61+d6eEVTp/9LW+QgqTBfViWdGf1+ZyQ==
X-Received: by 10.67.23.161 with SMTP id ib1mr11654901pad.156.1458820646538;
        Thu, 24 Mar 2016 04:57:26 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ac1sm9984802pad.41.2016.03.24.04.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 04:57:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:57:39 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289739>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-apply.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 5444d2f..8ddb207 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -21,6 +21,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to file=
s.
+When running from a subdirectory in a repository, patched paths
+outside the directory are ignored.
 With the `--index` option the patch is also applied to the index, and
 with the `--cached` option the patch is only applied to the index.
 Without these options, the command applies the patch only to files,
--=20
2.8.0.rc0.210.gd302cd2
