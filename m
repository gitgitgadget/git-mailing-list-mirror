From: Christian Taube <lists@hcf.yourweb.de>
Subject: Broken handling of URL with literal IPv6 address
Date: Thu, 18 Sep 2014 13:29:11 +0200 (CEST)
Message-ID: <2004412952.561305.1411039751559.open-xchange@app02.ox.hosteurope.de>
Reply-To: Christian Taube <lists@hcf.yourweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 13:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUZtt-0000xq-9X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 13:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbaIRL3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 07:29:16 -0400
Received: from wp148.webpack.hosteurope.de ([80.237.132.155]:52818 "EHLO
	wp148.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756307AbaIRL3P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2014 07:29:15 -0400
Received: from app02.ox.hosteurope.de ([92.51.170.9]); authenticated
	by wp148.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	id 1XUZtf-00039E-Ka; Thu, 18 Sep 2014 13:29:11 +0200
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.4.2-Rev33
X-bounce-key: webpack.hosteurope.de;lists@hcf.yourweb.de;1411039755;4e51fac5;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257258>


Hello,

I was sent here from the IRC channel.


Using git 2.1.0, the command

  git clone ssh://[2001:db8::1]/repo.git

succeeds, but adding a username to the URL like this

  git clone ssh://user@[2001:db8::1]/repo.git

fails with an invalid hostname message:

Cloning into 'repo.git'...
ssh: Could not resolve hostname [2001: Name or service not known
fatal: Could not read from remote repository.


I found this workaround:

  git clone ssh://[user@2001:db8::1]/repo.git

but this seems to be contrary to the definition of URLs in RFC 3986.

http://tools.ietf.org/html/rfc3986


Please have a look at this. Thank you!


--
Christian Taube
