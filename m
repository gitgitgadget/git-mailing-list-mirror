From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Fri, 14 May 2010 23:22:06 +0200
Message-ID: <201005142322.08241.jnareb@gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com> <201005141707.26416.jnareb@gmail.com> <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:22:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2Ks-0007gH-D2
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0ENVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:22:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45724 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0ENVWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 17:22:16 -0400
Received: by fxm6 with SMTP id 6so1955159fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RZKwaQgLzBZOcSmgl0uyOmirax38WNXfvHkYkjox4Y8=;
        b=s+DWYOEIPr7QgEWNyXq1LPiRYnPUGxgc7ofd4PVA/16uaisguxp/aJpfJ8Jc+zahVL
         kdA5aXQW25vs9brUtTaOvaDANXmljIHe53rh8uFWwzHlMXNaAr0o/DrTOY3jx54AQPG8
         JX6O7bITYdTVK0eVAMtW+JGSV+ECyqfyhaNDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pmJD1ka2J2FMF03GXHH55sOX0vnu8zyvAugLjgQnkgo2xaypgLjMEF6Ydt/XT2O8e0
         dVbDiHDrA856v8vvXEX3lxLFMFjJZIBYM4NxJoQTAIi2bsDMMLsgSu9uOLGhKL6C11Pp
         Fkted50KfAfIDHeIK2j31jvtJI63zd+4I3k/M=
Received: by 10.223.92.136 with SMTP id r8mr2280260fam.40.1273872134871;
        Fri, 14 May 2010 14:22:14 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id 15sm12588424fad.10.2010.05.14.14.22.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 14:22:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147118>

On Fri, May 14, 2010, Pavan Kumar Sunkara wrote:
> On Fri, May 14, 2010 at 8:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Cc-ed Eric Wong, the main author and maintainer of git-instaweb
> >
> > In short: I think that this patch should be split into two patches, one
> > which sets default value of 'gitwebdir' (in Makefile or gitweb/Makefile;
> > please explain why you chosen one or the other), and second that "fixes"
> > git-instaweb (and might include installing gitweb, in $(gitwebdir) or in
> > $(sharedir)/gitweb).
> 
> Yes, I agree. This is the first patch.
>
> The second patch which fixes git-instaweb is in discussion with my
> mentors. after that I will be sending it to the git mailing list.

I agree about splitting the patch.

What I disagree with is having addition of installing gitweb in first
patch. Especially that (as I think was shown in discussion) git-instaweb
must know where gitweb.cgi it can use is installed, so it has to be
synchronized.


P.S. About whether to add default value for 'gitwebdir' to Makefile or
to gitweb/Makefile - why not add it to both?

-- 
Jakub Narebski
Poland
