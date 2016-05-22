From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] Better ref summary alignment in "git fetch"
Date: Sun, 22 May 2016 18:20:17 +0700
Message-ID: <20160522112019.26516-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:20:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4RQt-0003lF-S4
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbcEVLU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 07:20:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35328 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcEVLUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:20:25 -0400
Received: by mail-pa0-f43.google.com with SMTP id tb2so36487921pac.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZsmcwnCT2q8h9s9SPNns6ro/4x1OcKakDFOtNMqb0E=;
        b=rUEhTO5XvC+5yejgcL4vtauC+85BFhOvfRvFuduvrRGI3+9DsZH4ZjlxjwwHD3mAR0
         lW0Qt9XeRaEbgAvzYwJLHJr09dd2gnPZ44UU+D9K1YkQ9x5fEYHsBDaoUhBJyaNnfRB/
         QzfYCjBUi7FIFeTBn3Bq15j+AP6+dXMm5/ARB8VS+KEYfAff+BWCRBhcIriToZqJdzxC
         t/IHahHfAVZBFvHIJH+0HpxfRCLy3hdQ5Wp8it/4aqYBs6lzFK5N2f+xw0haQISsVfwq
         MPos/+ZtMI8xoWMqnBLOrvLsHh/BdA3ZK4Gxhhp2t3pKz63qBBR/jLnPPjf6MSg6u0Za
         dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZsmcwnCT2q8h9s9SPNns6ro/4x1OcKakDFOtNMqb0E=;
        b=NoRCInm+jY5eL9Ce8DnjXCm/wDCKcGktjJt7eJ/k/bqmNU0WGJL8BufSQ+raR4upNI
         2g1e7gCsHdANuZ1O+9Ia2Ej6WCLWi9FKXGspQw1rjU4whyZlyroHLv2uO9SRNi5natoG
         OMJxHaEiOJEXlvv7HIPGRx15UxEKof9TZmo+pSRFSFreLdKTkU8egRFKEadNGxjdeRoR
         1k4wCS+PRIcdDM3nc6aVGq7LaansoTcCgfk/pN3sfKjizIwFKnJtOoKin0w2XyRBkMFH
         bJdG0Tof9Os69EX7a3q4fpxC3L8v5EsmUsC+JG2msQ8LBzo82qPLGoSTj1URLlooZ8lK
         COrg==
X-Gm-Message-State: AOPr4FUqqhHkgDQ3GDZNWovIPyoDThHCJoegnNUpC0oh8RWwbgpWHvcPiuTbg9bXD7QJ8A==
X-Received: by 10.66.228.201 with SMTP id sk9mr19151928pac.5.1463916024899;
        Sun, 22 May 2016 04:20:24 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id br5sm22059494pab.39.2016.05.22.04.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 04:20:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 18:20:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295281>

I recently got a taste of a busy github repository where many branches
are created (for Pull Requests) every day. Because branch names should
be descriptive, branch names could range from 10 to 60 chars long.
This makes "git fetch" output really messy.

So I resurrect a patch (1/2) I sent two years ago to keep alignment
somewhat better. 2/2 is some more fancy adjustment to make sure one
really long branch name will not make the rest of ref list suffer. But
I think 1/2 is good enough most of the time.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  fetch: better alignment in ref summary
  fetch: reduce ref column size when there are enough short ref names

 builtin/fetch.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--=20
2.8.2.524.g6ff3d78
