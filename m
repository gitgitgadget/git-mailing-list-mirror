From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 0/2] branch: improve verbose option
Date: Sat, 12 Oct 2013 02:00:27 -0500
Message-ID: <1381561229-19947-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:06:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtHX-0001Bb-F1
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab3JLHGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:06:31 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43007 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3JLHGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:06:31 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3435874obc.37
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ClEREHmswQ43sYlguVXsYCpE6Y1bRhhboqmSVO5XaJM=;
        b=mV+lwkAnrv6Xi8ak7kvKwWtzIaKY+OPmCPT6LF9AYrtmQt/lffwldvQNOvK2I4DYrj
         VX95mdH2WEX/g0WE/uEkpqve4TLT6lYNoT+ynDJpV9X1Krqzzt8okSbDuSiUymTQrEXn
         /Dn2rpUwaIhOh/JPKPM4aMg09F9V/5eIaCwvTVavm+VcPS10llZDXFJnu3M7jC+d+BM1
         5McA3JG9KmMmF3BXcemF9CfIArP1GesdkSZ4KHEk6mGaTqgK5cOzxydnYT4jnCGLXlOt
         5NUcFFVlCnryEw4deBGGtNxmGhvHm777eIc8/IDOHwSRCqnQUVfOkFzj7tWNBXNQz0Kc
         pyeQ==
X-Received: by 10.182.129.201 with SMTP id ny9mr17884114obb.0.1381561590518;
        Sat, 12 Oct 2013 00:06:30 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28616638obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:06:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235945>

This has been discussed before:

http://thread.gmane.org/gmane.comp.version-control.git/224489

but in the spirit of the perfect being the enemy of the good, nothing got done.

This series makes 'git branch -v' much faster, and gives us the most important
information; the configured upstream tracking branch. Showing ahead/behind is
not as important, specially considering that currently 'git branch -v' doesn't
show the branch we are comparing the ahead/behind to.

Strictly speaking it's a regression, but nobody would complain, and if somebody
does, it should be easy to revert if needed.

Felipe Contreras (2):
  branch: trivial cleanup
  branch: reorganize verbose options

 builtin/branch.c         | 33 +++++++++++++++------------------
 t/t6040-tracking-info.sh |  8 ++++----
 2 files changed, 19 insertions(+), 22 deletions(-)

-- 
1.8.4-fc
