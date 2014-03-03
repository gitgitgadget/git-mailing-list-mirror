From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 00/11] Use ALLOC_GROW() instead of inline code
Date: Mon, 03 Mar 2014 11:18:17 +0400
Message-ID: <53142CB9.80100@yandex.ru>
References: <530FA3E7.8020200@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKN9b-000869-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbaCCHS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:18:56 -0500
Received: from forward13.mail.yandex.net ([95.108.130.120]:57219 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaCCHS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:18:56 -0500
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward13.mail.yandex.net (Yandex) with ESMTP id 9D384140803
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:18:53 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id 7B5787E00DB
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:18:53 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id knrht7BchS-Iqmq8TMk;
	Mon,  3 Mar 2014 11:18:53 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0e6bb312-c2bf-4033-a221-2fed5b853688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831133;
	bh=0Hjo23hbRMOpS4lkMF8J9ynwA9qIjG/n2MXWmrruWkY=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=K3Iv75Nz5idIgXw5sz6j8bLPhgKTvVPnPM5yDUm9uBeCFzh26qADOzMUJT56+7pJN
	 bVzYVrV7jpKj97Tuj78lkKENPTqcZqVczkdDw/4Oelkb/pyUsttLk6i62Rco0DlW0F
	 laMshNHydbOrx/m3iR0jmD8oUUW2s903SSF3s/z8=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530FA3E7.8020200@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243179>

Dmitry S. Dolzhenko (11):
  builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
  bundle.c: use ALLOC_GROW() in add_to_ref_list()
  cache-tree.c: use ALLOC_GROW() in find_subtree()
  commit.c: use ALLOC_GROW() in register_commit_graft()
  diff.c: use ALLOC_GROW()
  diffcore-rename.c: use ALLOC_GROW()
  patch-ids.c: use ALLOC_GROW() in add_commit()
  replace_object.c: use ALLOC_GROW() in register_replace_object()
  reflog-walk.c: use ALLOC_GROW()
  dir.c: use ALLOC_GROW() in create_simplify()
  attr.c: use ALLOC_GROW() in handle_attr_line()

 attr.c                 |  7 +------
 builtin/pack-objects.c |  9 +++------
 bundle.c               |  6 +-----
 cache-tree.c           |  6 +-----
 commit.c               |  8 ++------
 diff.c                 | 12 ++----------
 diffcore-rename.c      | 12 ++----------
 dir.c                  |  5 +----
 patch-ids.c            |  5 +----
 reflog-walk.c          | 12 ++----------
 replace_object.c       |  8 ++------
 11 files changed, 18 insertions(+), 72 deletions(-)

-- 
1.8.5.3

This version differs from previous only minor changes:
  - update commit messages
  - keep code lines within 80 columns
