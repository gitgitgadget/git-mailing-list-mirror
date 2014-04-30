From: Matthias-Christian Ott <ott@mirix.org>
Subject: git send-email doesn't work with IPv6 and STARTTLS
Date: Wed, 30 Apr 2014 21:43:21 +0200
Message-ID: <53615259.90200@mirix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 22:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfagH-0002U0-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398AbaD3UAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:00:24 -0400
Received: from a.mirix.org ([78.46.130.147]:58762 "EHLO a.mirix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbaD3UAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:00:22 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2014 16:00:20 EDT
Received: from [2003:5c:ad40:a300:a578:42a5:1981:375e]
	by a.mirix.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <ott@mirix.org>)
	id 1WfaOq-0001c6-Hr
	for git@vger.kernel.org; Wed, 30 Apr 2014 21:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247769>

$ git --version
git version 1.8.5.5

git send-email uses Net::SMTP connections that use STARTTLS. Net::SMTP
does not support IPv6. I patched Net:SMTP to use IO::Socket::INET6 and
it worked.

- Matthias-Christian Ott
