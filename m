From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Fri, 15 May 2009 23:36:48 +0200
Message-ID: <200905152336.49319.jnareb@gmail.com>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com> <20090515211611.27697.82605.stgit@localhost.localdomain> <4A0DDD94.1010901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M555O-0003Po-MF
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbZEOVgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZEOVgt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:36:49 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:50919 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbZEOVgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:36:48 -0400
Received: by mu-out-0910.google.com with SMTP id i2so851227mue.1
        for <git@vger.kernel.org>; Fri, 15 May 2009 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5gj40uHzrZNEANqXwH8h7eFyrXU6HNqD82aP+tnWvLc=;
        b=GZ58RJavs0Qya+xZ0WKidFAeqxKEhHP0HWk31PBHTXWtWhT1OwWen9uF6x8Ho+9VOV
         bnrgciZcJJGML2UB0MU+TOlRyBMVtDGo6DeTyGcEQuRCc+dp0u0emD+C7BnI23CvTwWr
         rOFR6CJUHJkMk00lkL6+9kB99fBURnkL5vVbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QtstqYJcWCDCTqcLCJ+LP+4/4JBaZHY29z+ho/StwELA9vEwePs0Lg/yQmRik/WMf7
         QWiGHPfSY/v5xAe1Es/iplqwSQAqMan4z0doZx3NVML1pqE2nOhj9UZdrXB7fwTiAlh1
         jpDWNpQrgYUyW7nSZ/O6YTZgIXG52jTdy+l1I=
Received: by 10.103.92.8 with SMTP id u8mr2582744mul.12.1242423408790;
        Fri, 15 May 2009 14:36:48 -0700 (PDT)
Received: from ?192.168.1.13? (abvj81.neoplus.adsl.tpnet.pl [83.8.207.81])
        by mx.google.com with ESMTPS id b9sm244729mug.9.2009.05.15.14.36.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 14:36:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A0DDD94.1010901@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119301>

On Fri, 15 May 2009, Timur Tabi wrote:
> Jakub Narebski wrote:
> 
> > Does this explanation help?
> 
> Yes, it does, but I wish it weren't true.  I don't see why gitweb
> can't be enhanced to support non-bare repositories without using
> symlinks or other hackery.  

Actually the patch I have sent is not formulated as well as I wish.
That is why I didn't send it earlier (and I probably should have marked
it as RFC; still it is better than now).

Gitweb can deal with non-bare repositories. It is only that because 
gitweb is not interested in working area, it shows $GIT_DIR (path to 
repository itself) as name/path to repository. Therefore repo/.git
for non-bare repositories, because it is repository itself that matters.

> 
> To avoid the overhead of gitweb scanning all of my repositories for
> other respitories, I use a packages_list, which is automatically
> recreated whenever I add a new repo.  However, I think having to
> create a shadow bare repository with a cron job to keep it
> more-or-less update is wrong.    

If you use gitweb only for yourself, take a look at git-instaweb

If you provide access for others, i.e. if those repositories shown in 
gitweb are public repositories, it is much better to use bare 
repositories for that.

-- 
Jakub Narebski
Poland
