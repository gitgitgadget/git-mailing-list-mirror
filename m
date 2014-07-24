From: Steffen Nurpmeso <sdaoden@yandex.com>
Subject: `ab | (cd cd && git apply -)' fails with v2.0.0
Date: Thu, 24 Jul 2014 15:29:45 +0200
Message-ID: <20140724142945.iERQ798d%sdaoden@yandex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 15:38:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAJDl-0007jm-P5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 15:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758959AbaGXNh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 09:37:58 -0400
Received: from forward4h.mail.yandex.net ([84.201.186.22]:56522 "EHLO
	forward4h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbaGXNh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2014 09:37:56 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2014 09:37:56 EDT
Received: from smtp3h.mail.yandex.net (smtp3h.mail.yandex.net [84.201.186.20])
	by forward4h.mail.yandex.net (Yandex) with ESMTP id 36D121B21D2A
	for <git@vger.kernel.org>; Thu, 24 Jul 2014 17:29:48 +0400 (MSK)
Received: from smtp3h.mail.yandex.net (localhost [127.0.0.1])
	by smtp3h.mail.yandex.net (Yandex) with ESMTP id EA6DC1B44D2D
	for <git@vger.kernel.org>; Thu, 24 Jul 2014 17:29:47 +0400 (MSK)
Received: from unknown (unknown [89.204.154.76])
	by smtp3h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id symGFvoHfm-TkQmAVmu;
	Thu, 24 Jul 2014 17:29:47 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 391dd5a1-3686-4d12-834a-62f1c79d213a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail; t=1406208587;
	bh=yR4wIz7LIfSTn0tb8YPXsQWGeBAhgbxUo/P5v+3Shic=;
	h=Date:From:To:Subject:Message-ID:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	b=J1YxX2PbtuuW/CnKe9CW7QPqlUNiOYBJjGmj9NsKkFuH8tqViT41rHyYbBvzmoHbu
	 HTZw9eyiHuxb8U42pLF59ouRaYlUznSt8CWh6l6oPra+bl1i7iS1lDtb/BSkH013k+
	 IfJSeZFraHI6ZflZUqdsCiBULtmNjBjgKxDQwR9Y=
Authentication-Results: smtp3h.mail.yandex.net; dkim=pass header.i=@yandex.com
User-Agent: s-nail v14.7.4-3-g32d76ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254156>

Hello (again, psssssst, after a long time),

it happened yesterday that i needed to do

  $ git diff HEAD:FILE COMMIT:SAME-FILE |
  > (cd src && git apply -) 

but found that didn't work with v2.0.0 (silently succeeds?, doing
nothing).  It works without the subshell and the cd(1); i had to
use `(cd src && patch -p2)' instead to keep in going.
Just in case that is not known yet (i've updated my git(1) repo,
but in the 1466 commits in between nothing sprung into my eye
regarding apply, and a Gmane search didn't, too).
No need to Cc: me, please just fix it; thank you.
Ciao,

--steffen
