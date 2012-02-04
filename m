From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Installing git-svn on Linux without root
Date: Sat, 04 Feb 2012 03:32:18 -0800 (PST)
Message-ID: <m3mx8yltq9.fsf@localhost.localdomain>
References: <35EF289A-1408-4B70-A25F-8194A8884A4D@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 12:32:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtdr5-0002eN-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 12:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab2BDLcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 06:32:23 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58884 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2BDLcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 06:32:20 -0500
Received: by eekc14 with SMTP id c14so1477597eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 03:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=cCDyHVh+eJpXHr4ujsv3MhDzIwD6g2OgBg8AUE140Sg=;
        b=X0yKOb4i0YZ/U+udfDuKfAmqA71LPiu1USnuKsRkeHWLLTktb/pyF9VU5L7m0xAHfv
         gEr3k+/MuL+7abZSmRJXZOeLgUDknNYPpUW1eKa9DgytNhekYMop1/Nj42gnrgY+apLv
         VEw8KnotpfaHPpyhnZNqDvS5iQYxH0w7excS8=
Received: by 10.14.50.206 with SMTP id z54mr3327800eeb.127.1328355138802;
        Sat, 04 Feb 2012 03:32:18 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id b3sm33816996een.2.2012.02.04.03.32.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 03:32:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q14BWG4E028563;
	Sat, 4 Feb 2012 12:32:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q14BWFYg028560;
	Sat, 4 Feb 2012 12:32:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <35EF289A-1408-4B70-A25F-8194A8884A4D@kellerfarm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189862>

Andrew Keller <andrew@kellerfarm.com> writes:

> I am attempting to install git, including the ability to access
> subversion repositories on a Linux machine.  I do not have root
> access on the machine, so I prepended my PATH with a folder in my
> home directory.
> 
> Installing Git worked just fine, but when I try to clone a
> subversion repository, I get:
> 
> $ git svn clone file:///svn --prefix=svn/ --no-metadata --trunk=dba/trunk --branches=dba/branches --tags=dba/tags dba
> Initialized empty Git repository in /home/kelleran/Documents/togit/converted/dba/.git/
> Can't locate SVN/Core.pm in @INC (@INC contains: /homedirs/kelleran/local/lib/perl5/site_perl/5.8.8 /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/site_perl/5.8.8 /usr/lib/perl5/site_perl /usr/lib64/perl5/vendor_perl/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.8 /usr/lib/perl5/vendor_perl /usr/lib64/perl5/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/5.8.8 .) at /homedirs/kelleran/local/libexec/git-core/git-svn line 41.
> 
> Google suggested that the above error could be due to missing perl
> bindings.  So, I installed swig, and followed the instructions for
> installing the perl bindings:
> http://svn.apache.org/repos/asf/subversion/trunk/subversion/bindings/swig/INSTALL
> (I used the alternate build steps, since I had to set the prefix).
> 
> Unfortunately, I still get exactly the same error.  So, I looked to
> see whether or not the missing library was installed:
> 
> $ find ~/local -iname Core.pm
> /homedirs/kelleran/local/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/SVN/Core.pm
> 
> So, the module does exist, but not in a location included by @INC.

>From the above error message it looks like

  /homedirs/kelleran/local/lib/perl5/site_perl/5.8.8

is in @INC, but

  /homedirs/kelleran/local/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/

is not.  Strange.

Do you use local::lib?

> This sounds like a simple misconfiguration during the installation
> on my part, but after reading the manuals and searching the web, I
> was unable to find a parameter that gets git to be able to see the
> perl bindings.

Add missing directory to PATH-like PERL5LIB environment variable
before running git-svn.
 
-- 
Jakub Narebski
