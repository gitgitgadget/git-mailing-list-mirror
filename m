From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn won't remember pem password
Date: Sat, 18 Feb 2012 03:30:00 -0800 (PST)
Message-ID: <m3zkcgqt0g.fsf@localhost.localdomain>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Igor <mrigor83@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 12:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyiV4-0005S7-0H
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 12:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab2BRLaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 06:30:05 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64793 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2BRLaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 06:30:03 -0500
Received: by eekc14 with SMTP id c14so1646795eek.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 03:30:02 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.3.201 as permitted sender) client-ip=10.213.3.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.3.201 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.3.201])
        by 10.213.3.201 with SMTP id 9mr455375ebo.93.1329564602198 (num_hops = 1);
        Sat, 18 Feb 2012 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=d+ie1WRMxMKi28dP+cd0xdNP1tQybBWBEWvI5qn7uJE=;
        b=eF6I31bUfPqniBwS3Ccbt589bTJBpT7ACW3zJxbP6hx2KUsr5KYYCIKnlQ+Jk3DANp
         iHqjEHdFDUFAZI9AkUDtx8CNa0U80j1GCn8IzXDbI8ncFgaIQb/fnpMlXVS9DBPhENz3
         ZNa9Hs67H0KQxKZQKL7GqX3IVyml0NTaZchg8=
Received: by 10.213.3.201 with SMTP id 9mr377138ebo.93.1329564600716;
        Sat, 18 Feb 2012 03:30:00 -0800 (PST)
Received: from localhost.localdomain (abwr227.neoplus.adsl.tpnet.pl. [83.8.241.227])
        by mx.google.com with ESMTPS id s48sm47859768eem.0.2012.02.18.03.29.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 03:30:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1IBTkvG008726;
	Sat, 18 Feb 2012 12:29:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1IBTZgG008723;
	Sat, 18 Feb 2012 12:29:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191005>

Igor <mrigor83@gmail.com> writes:

> I'm running into an issue where I have to enter my pem certificate
> password every time I git-svn fetch or git-svn dcommit. Vanilla svn
> uses OS X KeyChain and remembers my password just fine. Is there a
> known solution for this? Other users have ran into same issue as
> described here:
>
>   http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords

> However, that solution of removing .subversion folder did not work
> for me.

I don't know if it is svn that has to remember password, or git that
has to remember password.  Git 1.7.9 learned "credentials API" that
allows integration with platform native keychain mechanisms, and I
think OS X Keychain is one of examples / supported platforms (but it
might not made it into core git)... though I am not sure if it affects
git-svn, or only HTTP(S) transport.

-- 
Jakub Narebski
