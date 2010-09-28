From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/6] Introduct pathspec struct
Date: Tue, 28 Sep 2010 22:00:23 +1000
Message-ID: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:33:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ijY-00036b-KO
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0I1WdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:33:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55020 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab0I1WdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:33:03 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so35176pvg.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=FWvNAVfhWJJQtgMtWtuB2UGLkXM+wfoADXo4x9rpdY4=;
        b=l1I0rtaZ3is5j/ZYNolMJUaS0jBWj0b2EB2Kp3+o6uluucWJDmBAimMAUJgDZhRded
         Y+XhtXzAvkCpVe+I+XhkZgVOgAqTxEVw1K8LoVzFpmQAYdHwHMWOYggbmAQqqIg94R1P
         9gLdXI7M93mk6Pd0peninS4U7xiB2iDhb0hlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=qhMMWegp/gkysF7h4xhPMsvhOKKMaLQCkg+mxscS5wr2nO8H40AxWvnjy9WZ1cXdr2
         1qIHoQHCVXO7kaIDHWbzvTCAQIaB6Yd1CfHultKpb4h8PDQg3ncGTH/HsM7QidD6P6ri
         35kr2lloUQG1JOtebYbTrJGiiCYBvVQ3TQp7c=
Received: by 10.114.131.13 with SMTP id e13mr823220wad.81.1285713166843;
        Tue, 28 Sep 2010 15:32:46 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id x9sm13302645waj.15.2010.09.28.15.32.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 15:32:45 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 22:00:30 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157488>

Just minor changes from Junio's comments. A comment managed to
sneak in cache.h, to briefly explain "raw" field.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Add struct pathspec
  diff-no-index: use diff_tree_setup_paths()
  pathspec: cache string length when initializing pathspec
  Convert struct diff_options to use struct pathspec
  tree_entry_interesting(): remove dependency on struct diff_options
  Move tree_entry_interesting() to tree-walk.c and export it

 builtin/diff-files.c |    2 +-
 builtin/diff.c       |    4 +-
 builtin/log.c        |    2 +-
 cache.h              |   10 +++
 diff-lib.c           |    2 +-
 diff-no-index.c      |   13 ++--
 diff.h               |    4 +-
 dir.c                |   29 +++++++++
 revision.c           |    6 +--
 tree-diff.c          |  157 +++---------------------------------------=
--------
 tree-walk.c          |  111 +++++++++++++++++++++++++++++++++++
 tree-walk.h          |    2 +
 12 files changed, 175 insertions(+), 167 deletions(-)
