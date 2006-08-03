From: Sam Vilain <sam@vilain.net>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 03 Aug 2006 23:42:21 +1200
Message-ID: <44D1E11D.1090409@vilain.net>
References: <20060803075403.GA5238@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 13:43:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8bbZ-0007qh-DR
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 13:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWHCLnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 07:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHCLm7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 07:42:59 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:1755 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932474AbWHCLm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 07:42:59 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 2F9E84844; Thu,  3 Aug 2006 23:42:56 +1200 (NZST)
Received: from [192.168.1.4] (unknown [203.110.28.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 071EB3EC8;
	Thu,  3 Aug 2006 23:42:47 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Marc Singer <elf@buici.com>
In-Reply-To: <20060803075403.GA5238@buici.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24718>

Marc Singer wrote:
> I would like to use gitweb with the Cherokee web server because the
> host that I have on hand has very limited RAM, 32MiB.  Neither the
> version of gitweb available on Debian (v264) nor the latest in the git
> repo works.

Marc,

I use lighttpd on utsl.gen.nz, which is only a wee box, too.  I hacked
FastCGI support into gitweb.cgi, my changes are available at
git://utsl.gen.nz/gitweb (gitweb url at
http://utsl.gen.nz/gitweb/?p=gitweb).

I just set up the /git path to redirect to /git/ in the web server.

Sam.

> 
> I did some debugging on the latest repo version.  The lines
> 
>   our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
>   if (defined $project) {
>      ...
> 
> are being executed even though the url is
> 
>   http://server/git
> 
> I think that the problem is that Cherokee translates the request URL
> into
> 
>   http://server/git/
> 
> which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> being undefined.
> 
> The error I'm seeing is that the request path is forbidden, but I
> suspect that this is some sort of misunderstanding between the web
> server and the script.
> 
> So, I wonder if someone who has a working gitweb would be willing to
> test with Cherokee or some other resource conservative web server.
> 
> Cheers.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
