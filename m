From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: (unknown)
Date: Wed, 05 Aug 2015 15:47:25 +0300
Message-ID: <349031438778845@web22j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 14:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMyDx-0004qh-G2
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 14:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbbHEMzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 08:55:05 -0400
Received: from forward12j.cmail.yandex.net ([5.255.227.176]:52969 "EHLO
	forward12j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294AbbHEMzE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 08:55:04 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2015 08:55:04 EDT
Received: from web22j.yandex.ru (web22j.yandex.ru [IPv6:2a02:6b8:0:1619::322])
	by forward12j.cmail.yandex.net (Yandex) with ESMTP id 7DBA0216DF
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 15:47:26 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web22j.yandex.ru (Yandex) with ESMTP id 1A95B4800144;
	Wed,  5 Aug 2015 15:47:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1438778846; bh=Bd5GwMNTCLv1v7kfJmvC0Lh7683IhtBmXdM0nvJ8a/o=;
	h=From:To:Date;
	b=czp7DGfkmjpd7WIKiiJH/IJbvLdpFnhZA2+D+T0BYl/xMLt1kXJMvon8ckRa0d889
	 2zMCjZo45myxHxsMI4YmtIIz/JuDlCLP2LWyCvX4HEETf0U7LqWfldE1hxQsHeYnNV
	 Dn8Vu6PZx7ynlSbKUN4gxWSuiSze2YvZ62QM9nGE=
Received: by web22j.yandex.ru with HTTP;
	Wed, 05 Aug 2015 15:47:25 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275367>

Dear community,

For some time I'm wondering why there's no "--grep" option to the "git branch" command, which would request to print only branches having specified string/regexp in their history.

So for example:

    $ git branch -r --grep=BUG12345

should be roughly equivalent to following expression I'm using now for the same task:

    $ for r in `git rev-list --grep=BUG12345 --remotes=origin`; do git branch -r --list --contains=$r 'origin/*'; done | sort -u

Am I missing something, is there some smarter/simpler way to do this?

Thanks a lot in advance!

-- 
  Ivan
