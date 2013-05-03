From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/4] check_everything_connected replacement
Date: Fri,  3 May 2013 19:35:10 +0700
Message-ID: <1367584514-19806-1-git-send-email-pclouds@gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 14:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFC4-0001df-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761723Ab3ECMeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:34:25 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49798 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761545Ab3ECMeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 08:34:24 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so784135dak.33
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GxLbI1rHkm8IDhohyaVnHxJjxEBqVBOFyJmhrUwEJx4=;
        b=htlPbsib9Qv0YKuz6e9SFob5HVT0MQMAITowbewvc03Mjarm/ahbwxIdYz9JZWuLwb
         YM76DVWfG6H+D4Hllg/kaQecuvXFHCer8j8YZpBMG3pYPC1b2Bga9/qN4X4NmpXaL79k
         17O/8ttdqRt2DtkJ+n6+sozCdc+THcbgnP77ErfWTCAPYLBtkVo4VtYisiTJbsSYYV0y
         NxKfKYbwxbt3SD1FrLU/aQtnD5DI4luIibPMVzFKzwbPr2FIemFArXi2awcepZzClUCy
         4itchhs+2XYTpOtn9KQdNA50pJmNbseEB7+sGbBb4pYrp1pL4k5OpiV4iqsu2lqiMJYY
         ng5g==
X-Received: by 10.68.252.227 with SMTP id zv3mr13978910pbc.14.1367584463663;
        Fri, 03 May 2013 05:34:23 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id fx2sm12704565pac.4.2013.05.03.05.34.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 05:34:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 03 May 2013 19:35:15 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223304>

v3 is more like check_everything_connected's special case for clone
because check_everything_connected is not really replaced.
GIT_SHALLOW_FILE in 2/4 is now replaced by --shallow-file to avoid
unintended propagation to child processes.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  clone: let the user know when check_everything_connected is run
  fetch-pack: prepare updated shallow file before fetching the pack
  index-pack: remove dead code (it should never happen)
  clone: open a shortcut for connectivity check

 Documentation/git-index-pack.txt |  3 ++
 builtin/clone.c                  | 15 ++++++--
 builtin/index-pack.c             | 38 +++++++++++++------
 commit.h                         |  2 +
 connected.c                      | 34 ++++++++++++++++-
 connected.h                      |  5 +++
 fetch-pack.c                     | 80 ++++++++++++++++++++++----------=
--------
 fetch-pack.h                     |  4 +-
 git.c                            |  5 +++
 shallow.c                        | 45 +++++++++++++++++++++-
 t/t5500-fetch-pack.sh            |  7 ++++
 transport.c                      |  4 ++
 transport.h                      |  2 +
 13 files changed, 190 insertions(+), 54 deletions(-)

--=20
1.8.2.83.gc99314b
