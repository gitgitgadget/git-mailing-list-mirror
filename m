From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb
Date: Fri, 12 Sep 2008 06:27:30 -0700 (PDT)
Message-ID: <m3r67po5ps.fsf@localhost.localdomain>
References: <19455112.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: delux <jared@2ndnaturestudio.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 15:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke8ho-0003Qa-F9
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 15:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYILN1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 09:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbYILN1g
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 09:27:36 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41066 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYILN1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 09:27:35 -0400
Received: by gxk9 with SMTP id 9so19015035gxk.13
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=JQQgJsmBSxqZCLlpcRhgidYaFfVBcKq6lY511m4RXQ8=;
        b=IIi8jrrb0KKUgrPGFYPYPip+2w8BIADwb7RRQy+93ItHDcd7fFm3eI1+QzH+MqrQvC
         yw7UYVSETbKLpsIDQaxNpbIl0lf8ZIAyIvgmtkBOjNwmPvg4idmaWzg9w7gcU0BO75b6
         b2kGtCgRjaCVnQE3RsolGPEnJemXIyataU1Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=bhJMJMQKsjzQqj/0jEDwRxbgYWYMKZt8IGOROCJQpF0FXzoKFzzkjQ2gtLkdHUamR3
         p/6wT8clCk1cIM2oagpGr7+3AnvrzPxJN83l8kA+TZZunMssTo/O84q9VWTahPprQ3xy
         e2HmzO+V0KX7OS8jMGa8zWP1MMExpPWuRDTN4=
Received: by 10.103.213.10 with SMTP id p10mr2967606muq.46.1221226051487;
        Fri, 12 Sep 2008 06:27:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.228])
        by mx.google.com with ESMTPS id s10sm19350633muh.12.2008.09.12.06.27.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 06:27:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8CDQupa018135;
	Fri, 12 Sep 2008 15:27:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8CDQduj018127;
	Fri, 12 Sep 2008 15:26:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19455112.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95725>

delux <jared@2ndnaturestudio.com> writes:

> I posted on another subject before and thanks to all who replied to
> that, Now I want to put gitweb on my server and have read everything
> to do it but cant seem to find the files. I know that it is supposed
> to be bundled with git but I am not the one who installed git, so is
> there anywhere I can get the gitweb files?

First, what operating system, and in the case of Linux what
distribution do you use?  For example both Fedora Core and Debian (so
also all Debian-derived distributions like Ubuntu) have gitweb*
package; so it should be very simple to install this.

Because installing CGI script (or legacy mod_perl script) differs from
distribution to distribution, therefore stock RPMS from kernel.org
doesn't create gitweb package.  So you would have to either download
source tarball, or clone git repository, read gitweb/INSTALL and then
run 
  $ make gitweb/gitweb.cgi <options>
or 
  $ make configure && ./configure && make gitweb/gitweb.cgi
and simply copy the files (there is no install target for gitweb) as
described, ensuring that web server is configured to run CGI scripts
(or mod_perl scripts).


You can see gitweb at work at http://git.debian.org, and modified
gitweb at http://git.kernel.org and http://repo.or.cz.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
