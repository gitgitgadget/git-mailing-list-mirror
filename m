From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] git-svn: fix commiting renames over DAV with funky file
 names
Date: Mon, 16 Jul 2007 08:36:27 +0200
Message-ID: <469B11EB.8020003@dawes.za.net>
References: <46938594.2010607@dawes.za.net> <20070711082000.GA29371@muzzle> <20070712090635.GA18155@mayonaise> <20070716045350.GA15307@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 08:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAKDQ-0005nZ-Dq
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 08:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbXGPGht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 02:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbXGPGhs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 02:37:48 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:39918 "EHLO
	spunkymail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753249AbXGPGhs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 02:37:48 -0400
Received: from [192.168.201.103] (dsl-146-26-37.telkomadsl.co.za [165.146.26.37])
	by spunkymail-a18.g.dreamhost.com (Postfix) with ESMTP id 8FF9D5B532;
	Sun, 15 Jul 2007 23:37:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <20070716045350.GA15307@mayonaise>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52646>

Eric Wong wrote:
> Renaming files with non-URI friendly characters caused
> breakage when committing to DAV repositories (over http(s)).
> 
> Even if I try leaving out the $self->{url} from the return value
> of url_path(), a partial (without host), unescaped path name
> does not work.
> 
> Filenames for DAV repos need to be URI-encoded before being
> passed to the library.  Since this bug did not affect file://
> and svn:// repos, the git-svn test library needed to be expanded
> to include support for starting Apache with mod_dav_svn enabled.
> 
> This new test is not enabled by default, but can be enabled by
> setting SVN_HTTPD_PORT to any available TCP/IP port on
> 127.0.0.1.
> 
> Additionally, for running this test, the following variables
> (with defaults shown) can be changed for the suitable system.
> The default values are set for Debian systems:
> 
>   SVN_HTTPD_MODULE_PATH=/usr/lib/apache2/modules
>   SVN_HTTPD_PATH=/usr/sbin/apache2
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> 
>  Rogan: the patch should help, a single space anywhere in the
>  path causes SVN to screw up the file names.  Of course I'm at a
>  loss as to why only DAV repositories need it and why the SVN
>  libraries don't abstract that away from me.
> 

Hi Eric,

Unfortunately, I cannot test this patch, as I have since worked around 
the problem, and it has not reappeared.

If it does, I'll be sure to test and let you know. Unless this patch 
makes it into the version of git I am using, of course!

Rogan
