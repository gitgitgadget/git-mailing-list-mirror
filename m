From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] count-objects improvements
Date: Fri,  8 Feb 2013 10:48:24 +0700
Message-ID: <1360295307-5469-1-git-send-email-pclouds@gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 04:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ezZ-0001Hy-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 04:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915Ab3BHDuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 22:50:50 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:36912 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759721Ab3BHDut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 22:50:49 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so1548365dae.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 19:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=h0W2R+GeFcpDdnBIunOX3F6q32hmWyopAS2AjbzXMb4=;
        b=K7yRfzCNRa/yh9cklMwC60VSyQ3tqKFfegx9xcWxEofi+MLBtpNCbzETyVDP/XJR5l
         MzWn9r5sOMPwHBRMWI1S0iRFMYN+fOg2KMJ6lupVIRgBHBcBbEpS0MU8j8bawV4Cu0RF
         n5TNBtyf6OphoJUdKp+zL4dG9WCkYePbOCiESdBx6FIIVIe2VPhNr9KMx17KMXaoQdro
         LVTheapUGpXThbJFe6hzu0OwGH7D7S6JmcO8o++9wJLcJoVUzfytH76UTgOiWarFXEeH
         Fb0K3Bb3d9FkazNkw7ZKn3JqomD4sNR27lHfXlO5yc3FtCOET7Kfidqal1DyHuIWHIf9
         Wlqw==
X-Received: by 10.66.85.103 with SMTP id g7mr12669278paz.45.1360295449229;
        Thu, 07 Feb 2013 19:50:49 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id e6sm50874571paw.16.2013.02.07.19.50.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 19:50:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 08 Feb 2013 10:50:41 +0700
X-Mailer: git-send-email 1.8.1.2.495.g3fdf5d5.dirty
In-Reply-To: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215744>

This series:
 - updates count-objects -v documentation, describe each line in detail
 - counts garbage files in pack directory in addition to loose odb
 - shows how much disk space consumed by garbage files

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  git-count-objects.txt: describe each line in -v output
  count-objects: report garbage files in pack directory too
  count-objects: report how much disk space taken by garbage files

 Documentation/git-count-objects.txt | 22 +++++++---
 builtin/count-objects.c             | 41 ++++++++++++++-----
 sha1_file.c                         | 81 +++++++++++++++++++++++++++++=
++++++--
 3 files changed, 127 insertions(+), 17 deletions(-)

--=20
1.8.1.2.495.g3fdf5d5.dirty
