From: Brandon Philips <brandon@ifup.org>
Subject: gitweb.cgi, $my_uri and too many slashes in url
Date: Sat, 20 May 2006 15:58:21 -0700
Message-ID: <20060520225821.GT30658@osuosl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 00:58:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhaOx-0006xb-PD
	for gcvg-git@gmane.org; Sun, 21 May 2006 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWETW6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWETW6Z
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 18:58:25 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:62337 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S964779AbWETW6Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 18:58:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ns1.osuosl.org (Postfix) with ESMTP id 1F5A5336700
	for <git@vger.kernel.org>; Sat, 20 May 2006 15:58:24 -0700 (PDT)
Received: from ns1.osuosl.org ([127.0.0.1])
	by localhost (ns1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00543-03 for <git@vger.kernel.org>;
	Sat, 20 May 2006 15:58:21 -0700 (PDT)
Received: from shell.osuosl.org (shell.osuosl.org [140.211.166.149])
	by ns1.osuosl.org (Postfix) with ESMTP id C6DD03366FF
	for <git@vger.kernel.org>; Sat, 20 May 2006 15:58:21 -0700 (PDT)
Received: by shell.osuosl.org (Postfix, from userid 1000)
	id A2FA52F4027; Sat, 20 May 2006 15:58:21 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at osuosl.org
X-Spam-Status: No, hits=-5.7 tagged_above=-999.0 required=5.0
	tests=ALL_TRUSTED, AWL, BAYES_00
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20402>

gitweb.cgi creates bad URLs when too many slashes are put in a URL.

Visiting http://kernel.org///git/ causes all URL prefixes to be
http://git/ 

Explicitly setting $my_uri fixes the problem so it is likely a bug in
the CGI library.

my $my_uri =            $cgi->url(-absolute => 1);

I reproduced the bug on a system with the latest version of gitweb and
Perl's CGI in Debian Unstable to ensure it wasn't just a kernel.org bug.

Thanks,

Brandon

--
http://ifup.org
