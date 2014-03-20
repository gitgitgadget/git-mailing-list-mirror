From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/8] git-ls
Date: Thu, 20 Mar 2014 17:15:43 +0700
Message-ID: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa0K-0008K3-Im
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbaCTKPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:15:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33481 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaCTKPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:15:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so726436pbb.5
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wLxLA2MDfmZnbZsd4blehztSrmxa80cnQ9fCu5jSySU=;
        b=sCSiJyFDQ1ESsHW9paBEh3fP9CIZF7TaVG6WcxhkvQm1clOSWfkQLAUfj6aGm4GDAE
         l+4BAzBbwCWNvws3vagCtnwu76Z6c+zAoL5y2r3gP766Y806Ik8xZrXZ38qA+xLeSjev
         nBacwmcx2OghZCDBRIxFb3h/iwTFHFj+wZRcuIcAqheqWXZ/bBvpvy8KBW1zhti5LVui
         v4YgSwbuddurjBnWEw6kitQFXc7T1duFZP7QDO3j3gpZyuDsJWaofyztIQsVz7eNYmR3
         v3z7Ptu7YgOv5UggUj3lzBBXxzVq/1LEAHMVloCFKyZPrSYBtZm8RxDCwW7robwQ3iA5
         2UPw==
X-Received: by 10.66.102.66 with SMTP id fm2mr46342078pab.51.1395310505403;
        Thu, 20 Mar 2014 03:15:05 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id iu7sm2946727pbc.60.2014.03.20.03.15.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:15:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:15:52 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244530>

Last time I tried this was more than two years ago [1]. It's time for
another try and see if the community has any interest in it.

The command is straight forward, it's a ls-like version for listing
things in git. It respects $LS_COLORS and does column output like GNU
ls. "ls" shows cached entries (but no recursion), "ls -o"
show untracked files. I want ls-tree, "diff --name-only" and "diff
--name-only --cached" too, but they are not implemented yet.

WIP quality, this is to gather comments on the idea.

[1] http://thread.gmane.org/gmane.comp.version-control.git/166405

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  Import $LS_COLORS parsing code from coreutils
  ls_colors.c: a bit of document on print_color_indicator input
  ls_colors.c: enable coloring on u+x files
  ls_colors.c: new color descriptors
  ls-files: add --color to highlight based on $LS_COLORS
  ls-files: add --column
  ls-files: support --max-depth
  Add git-ls, a user friendly version of ls-files and more

 Makefile           |   1 +
 builtin.h          |   1 +
 builtin/ls-files.c |  80 ++++++++-
 git.c              |   1 +
 ls_colors.c (new)  | 487 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 ls_colors.h (new)  |  20 +++
 6 files changed, 588 insertions(+), 2 deletions(-)
 create mode 100644 ls_colors.c
 create mode 100644 ls_colors.h

--=20
1.9.0.40.gaa8c3ea
