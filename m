From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 20:16:12 +0100
Message-ID: <20110427191612.GB2667@jakstys.lt>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
 <BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
 <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFADr-0007Sd-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893Ab1D0TQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:16:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37925 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759888Ab1D0TQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:16:17 -0400
Received: by wya21 with SMTP id 21so1513710wya.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MjL8hOUy+02Jr49whLAS4EpGOzPQuhuAIMYScfKUXWA=;
        b=tKhgMlrLrQKkBpuDjltKRm+7PKnNHeumrL/BZOJzxz2fK9aMY7klHnN2ej3qV43dVe
         zdgF/kMAAmnAGWWeppJzyFxdAZCWKd7Sx4N1KdVVGIDmvYP/VRId0zcroOuFYFZJSXHu
         /Dt4zsnV+zNE6xR+Fr8sYqVP2iD9oatu9j72E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cVV33AFg00qae17PX+fSSFqXrPhwbl+u3YlHWAu5cYXsjL2Y/onnFf4eLSUlQsaPMz
         8CVDgYDAoAbYyrIH100JDiRuJ/ymGia/kLGzwLWxpJajKlI9upEzO93LLTMuJ2udr7sY
         3Q4q9t7yI6zd5tHbV2srPC+JPo/G3jCi3/0ho=
Received: by 10.227.71.200 with SMTP id i8mr2508890wbj.176.1303931775609;
        Wed, 27 Apr 2011 12:16:15 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id y29sm645764wbd.38.2011.04.27.12.16.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 12:16:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172261>

On Thu, Apr 28, 2011 at 02:13:56AM +1000, Jon Seymour wrote:
> Platform specific concerns such as building and (most) dependency
> management will be delegated to platform specific package managers.
> 
> The overriding objective is to allow a git user to install a git
> plugin called foobar with 4 words:
> 
>      git pm install foobar
> 
> given that someone, somwhere, has done the work to create a plugin
> descriptor and create an installable package of some kind for whatever
> package managers are required in order to successfully install the
> plugin on the target platform.
> 
> The same command should work whether your git platform is hosted on
> MAC OSX, cygwin, Debian, Fedora, AIX or Windows.
> 
> Where git can be used as the underlying package manager, it will be
> (for extensions which really are just source repos). If more
> sophisticated build support is required, then that will be delegated
> to a platform specific package manager via one of a small number of
> package manager adapters.

Ok, I write my "git logx", which is a single file -- git-logx.c.
Compilation steps:
    $ gcc -lz git-logx.c. 

> then that will be delegated to a platform specific package manager 

Which one? Say I am on debian. dpkg-buildpackage? So I would get a
git-logx.deb, which I should install as root? In that case, you forgot
one word:

      sudo git pm install foobar

Or I got it wrong?

Motiejus
