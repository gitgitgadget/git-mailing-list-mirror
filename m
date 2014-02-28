From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 00/11] Use ALLOC_GROW() instead of inline code
Date: Fri, 28 Feb 2014 13:29:11 +0400
Message-ID: <531056E7.3010305@yandex.ru>
References: <530FA3E7.8020200@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJts-0000Vr-TP
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbaB1Jia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:38:30 -0500
Received: from forward4h.mail.yandex.net ([84.201.186.22]:53305 "EHLO
	forward4h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaB1Ji2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:38:28 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 04:38:28 EST
Received: from smtp4h.mail.yandex.net (smtp4h.mail.yandex.net [84.201.186.21])
	by forward4h.mail.yandex.net (Yandex) with ESMTP id 022761B21814
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:29:48 +0400 (MSK)
Received: from smtp4h.mail.yandex.net (localhost [127.0.0.1])
	by smtp4h.mail.yandex.net (Yandex) with ESMTP id C14B62C33CC
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:29:48 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp4h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BH5HrC3hbm-Tm5Sv7sF;
	Fri, 28 Feb 2014 13:29:48 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d7159a43-4a71-4d3a-a88c-94dbbcef4dd7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393579788;
	bh=jWZ5T1jHUGz/eEPXFQP6HVrxJ1v0hy0jowaI4v3uDA4=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=B4uuAmsPr61k9aZnyTl4ejzSRY8NYa2g2tGSMDBeaFnpVtwz+YpD6d5mjWvHba+H2
	 UJBGTiJS7QXe5zl8TJw8G8AH0qu44gm2ziW6Wo9uArnKKYGS1EGFIW5yyQ4cT+70RD
	 VmgTy10Gqa8RruwyGJupTvwpyAZTGQpZvV5LX634=
Authentication-Results: smtp4h.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530FA3E7.8020200@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242919>

Thank you for your remarks. In this patch I tried to take them into account.

Dmitry S. Dolzhenko (11):
  builtin/pack-objects.c: change check_pbase_path() to use ALLOC_GROW()
  bundle.c: change add_to_ref_list() to use ALLOC_GROW()
  cache-tree.c: change find_subtree() to use ALLOC_GROW()
  commit.c: change register_commit_graft() to use ALLOC_GROW()
  diff.c: use ALLOC_GROW() instead of inline code
  diffcore-rename.c: use ALLOC_GROW() instead of inline code
  patch-ids.c: change add_commit() to use ALLOC_GROW()
  replace_object.c: change register_replace_object() to use ALLOC_GROW()
  reflog-walk.c: use ALLOC_GROW() instead of inline code
  dir.c: change create_simplify() to use ALLOC_GROW()
  attr.c: change handle_attr_line() to use ALLOC_GROW()

 attr.c                 |  7 +------
 builtin/pack-objects.c |  7 +------
 bundle.c               |  6 +-----
 cache-tree.c           |  6 +-----
 commit.c               |  8 ++------
 diff.c                 | 12 ++----------
 diffcore-rename.c      | 12 ++----------
 dir.c                  |  5 +----
 patch-ids.c            |  5 +----
 reflog-walk.c          | 13 +++----------
 replace_object.c       |  8 ++------
 11 files changed, 17 insertions(+), 72 deletions(-)

-- 
1.8.5.3
