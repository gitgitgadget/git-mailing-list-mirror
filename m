From: Victor Porton <porton@narod.ru>
Subject: A small Git bug
Date: Sun, 10 Apr 2016 18:17:29 +0300
Message-ID: <1460301449.7971.4.camel@narod.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 17:17:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apH7R-0002zc-6J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 17:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbcDJPRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 11:17:40 -0400
Received: from forward10o.cmail.yandex.net ([37.9.109.60]:58265 "EHLO
	forward10o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900AbcDJPRj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2016 11:17:39 -0400
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward10o.cmail.yandex.net (Yandex) with ESMTP id BD7A121976
	for <git@vger.kernel.org>; Sun, 10 Apr 2016 18:17:33 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id 98D83DE01ED
	for <git@vger.kernel.org>; Sun, 10 Apr 2016 18:17:33 +0300 (MSK)
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 4w01mN2jLM-HW7mQb6F;
	Sun, 10 Apr 2016 18:17:32 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1460301452;
	bh=B3IwHXZ8MKCl2lP2ng9QgbXVIpVACWlqKAdbBoLDFhc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:X-Mailer:
	 Mime-Version:Content-Transfer-Encoding;
	b=rnaKRegPw+NEktxJ0+4TnSsLBWr3HI+xt0+L+fDqkj6FxTpGpmXEOGWAT8qm0ej8N
	 t2CBHld8gzgdC5IFZii0fNWHn6BApyJpHdxXFbsoC/tH2B4RLeL2wauM2rwEML51eW
	 7aAow0bh7ihppgPf5jTxZyajrdZgRpaYtStq4z2M=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@narod.ru
X-Yandex-Suid-Status: 1 0
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291176>

I have three branches: master, prerelease, and devel.

Suppose now we are in master.

I often run the following command (in fact it is an alias, to save
typing):

git push && git checkout prerelease && git merge master && git push &&
git checkout devel && git merge prerelease && git push && git checkout
master

There is a small problem: After running this command my text editor
proposes me to reload changed files.

So, it seems that the above command marks some files as changed. It is
wrong, because it is inconvenient a little to reload a file or two
every time after I submit the changes.
