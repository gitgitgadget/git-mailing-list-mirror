From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Wed, 20 Mar 2013 19:16:13 +0700
Message-ID: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:16:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHwu-0003Cf-5J
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab3CTMQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:29 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:52459 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3CTMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:26 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so584907pdi.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=z6kBx0YufmwYHFnAQ1jtQEBvqjeJoj4NZ4ChLooTM6A=;
        b=SnfoGGBRU/UbhiZpAvpBWda5K5HotRyKSIZ2rAgqn5/eSNof6W4S3kxWhM+OSAyJl2
         070JKk/Q/8tp4378zqV8xSjSOHbVJZx8fhQU6CP6g5/Bma2tQJ5WRpu577lqtP5CWexd
         3w6CyaUipSfdGf2gapMcT2Bm5IEKewaACI0R43E8Uk0y+AIrebGJ5Os+bqlU2Tm6bAuv
         IUwGfvznBdT1Jl3y97ijqBIEdjywyqEYacGO63ZSaJjFdyfvCapUK74D5Py0Q6l8UYL1
         Mb6m4TfI+jt9vDIFapcCsajdy2YDqpm0tUNcV/OuUQ3UV62pc27iHVVPeZhXuuLwhnIP
         9PrA==
X-Received: by 10.66.196.209 with SMTP id io17mr8769010pac.22.1363781786248;
        Wed, 20 Mar 2013 05:16:26 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id xs10sm2072395pac.8.2013.03.20.05.16.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218588>

Junio please pull the series from github [1]. I don't want to spam the
list with 45 patches again so I only send patches that are substantiall=
y
different from v1:

 - documentation for parse_pathspec
 - fix wrong operator precendence in git-reset
 - fix initialization that may lead to crashes in git-grep (and
   probably the failure in t7300-clean.sh)

Typos found by Eric are also fixed, just not sent here.

[1] https://github.com/pclouds/git/commits/parse-pathspec

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Add parse_pathspec() that converts cmdline args to struct pathspec
  parse_pathspec: support stripping submodule trailing slashes
  parse_pathspec: support stripping/checking submodule paths
  Guard against new pathspec magic in pathspec matching code
  Convert run_add_interactive to use struct pathspec
  parse_pathspec: make sure the prefix part is wildcard-free
--=20
1.8.0.rc0.19.g7bbb31d
