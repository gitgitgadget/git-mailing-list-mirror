From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: preserve permissions?
Date: Sat, 03 Mar 2012 11:15:58 -0800 (PST)
Message-ID: <m3wr71ts0i.fsf@localhost.localdomain>
References: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
	<m3fx27g6i8.fsf@localhost.localdomain>
	<1330801530552-7340464.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: snk <shank76@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 20:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3uRE-00031Q-W3
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 20:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab2CCTQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 14:16:02 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33879 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2CCTQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 14:16:00 -0500
Received: by eaaq12 with SMTP id q12so959534eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 11:15:59 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.101.141 as permitted sender) client-ip=10.14.101.141;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.101.141 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.101.141])
        by 10.14.101.141 with SMTP id b13mr8402315eeg.92.1330802159595 (num_hops = 1);
        Sat, 03 Mar 2012 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=k9Bx848+rkGYwwbzV901nHHZA59I/KY37FogGqzXKHk=;
        b=TJgnbVTCbOHW/vH6bTIEiibNBCXTlh5j1zkFrwkJ/nqWhQI0bcYdL//Ou/zi0xvSXq
         nRowuLeomJLx1XgdDkWQz2pVGdVffXJ1yGOMP8OfDp2AxipdN5/8aUb0Lft91kMOMDEE
         3yTj53GgrY5EWGotGkI4ys6Oq1AefhdWNKJHpRXG5aJWf6G9adN8wJ4/QCTPlkhT8qK2
         xGnFT5TAaRu1eD+U7UQ79dJuPWlT5/HX7DtHVWF0+mxRXreyNTa1XMn5SuzTbbPEFiBZ
         4hI5Hev0F1AziTCIl9IlMxXAKZsGmrn/zeDYwQk5PU28W4kF6OSpHMr6HQlt1pdeeN5X
         zMkw==
Received: by 10.14.101.141 with SMTP id b13mr6420935eeg.92.1330802159444;
        Sat, 03 Mar 2012 11:15:59 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id r5sm37750860eef.6.2012.03.03.11.15.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 11:15:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q23JFvqM024041;
	Sat, 3 Mar 2012 20:15:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q23JFvtj024038;
	Sat, 3 Mar 2012 20:15:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1330801530552-7340464.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192131>

snk <shank76@gmail.com> writes:

> > Therefore git does not store ownership, and only basic permissions 
> > (only executable bit for ordinary files, and the symlink bit). 
> 
> Fine.  "git diff" reports wrong new permissions though: 755 instead of 764. 

"Executable bit" is not "executable permissions"
 
> shanker@linux-0tix:~/test/play2> git reset --hard HEAD
> HEAD is now at 85d4483 test
> shanker@linux-0tix:~/test/play2> git config core.filemode
> true
> shanker@linux-0tix:~/test/play2> ls -l x
> -rw-rw-r-- 1 shanker users 0 Mar  3 11:00 x
> shanker@linux-0tix:~/test/play2> chmod u+x x
> shanker@linux-0tix:~/test/play2> git diff x
> diff --git a/x b/x
> old mode 100644
> new mode 100755
> shanker@linux-0tix:~/test/play2> ls -l x
> -rwxrw-r-- 1 shanker users 0 Mar  3 11:00 x
> shanker@linux-0tix:~/test/play2> 

Git stores only whether file is executable or not.  To be more exact
git uses only a few modes: one for submodule (commit), one for
directory, one for symbolic link, one for ordinary executable file,
and one for ordinary file (non-executable).

-- 
Jakub Narebski
