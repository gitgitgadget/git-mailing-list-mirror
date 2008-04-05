From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: sunos nay install nay ginstall nay
Date: Sat, 05 Apr 2008 05:08:58 -0700 (PDT)
Message-ID: <m3lk3stsfh.fsf@localhost.localdomain>
References: <alpine.LNX.1.10.0804050653570.14919@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sat Apr 05 14:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji7DR-0005oJ-3I
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 14:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYDEMJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYDEMJE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 08:09:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:21521 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYDEMJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 08:09:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so507906fgb.17
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=m6CiklQ3Y8le+JDISoWzvTud5/4kSgAUkpj0CoS6cp0=;
        b=PzoYlN+6GMkMr2LqXiOimdKY6W3zc2NAugMz0ST8jNdQjldaavn7B34wxiczb7hewufoyliygoCLkikzFLq9WeNlTV/Y4mf651J1ovacHWvZINK3cMzgAy6uYRiaLodmRIIyeDVQcTfje5fIpeOXqp/lOss7f7C0LCjVqv8MHb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=O5pQLFsarpJbTG7Bb1gnavQ5bH67mjVlbVHSuR09PTcW0J1hoQ71R+rk5EMkqkfZpih80zQnlJLhEdiD1G1SuIlEk45oirLcscQLVdVfj7As24+Utq4mnjI6oVQX9/2R+lD3E9Lj8m3Hoo0J7odJ3+nRLB3B+bU2fROlf38dPfI=
Received: by 10.82.184.2 with SMTP id h2mr5257755buf.1.1207397340823;
        Sat, 05 Apr 2008 05:09:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.237.132])
        by mx.google.com with ESMTPS id 4sm4429536fge.3.2008.04.05.05.08.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Apr 2008 05:08:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m35C8pth022244;
	Sat, 5 Apr 2008 14:08:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m35C8ovJ022241;
	Sat, 5 Apr 2008 14:08:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.1.10.0804050653570.14919@fbirervta.pbzchgretzou.qr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78844>

Jan Engelhardt <jengelh@computergmbh.de> writes:

> I found myself in a position to compile Git on Nexenta, and ran into
> the incredibly smart Makefile logic to pick "ginstall" when `uname -s`
> equals SunOS. Except that on GNU/*, it's install, not ginstall.
> Would not it be time to completely use automake?

First, you can use ./configure when installing git, but as a way to
set Makefile variables rather than as a way to build Makefile.  By
decision autoconf is _optional_.

Now autoconf macro AC_PROG_INSTALL requires to have ubstall-sh or
install.sh fallback script version of install in sources.  We need to
have minimal version; it doesn't need to be insanely portable, just as
portable as git would be enough.  So if you are interested in
./configure detecting proper 'install' binary (or fallback to script),
please propose (e.g. via patch) some install.sh to use.


Second, you can always use INSTALL=install when compiling, or set it
up in config.mak, the Makefile configuration file.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
