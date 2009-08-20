From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and symbolic links
Date: Thu, 20 Aug 2009 08:03:09 -0700 (PDT)
Message-ID: <m3tz02mssz.fsf@localhost.localdomain>
References: <2367E9DF-6FB1-48E6-AC9A-73E84C9D54E1@math.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Gualtieri <mgualt@math.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me9Ad-00041p-OA
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 17:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbZHTPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbZHTPDK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 11:03:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:57008 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbZHTPDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 11:03:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so26506fga.17
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=e3sO9O79vsk6yA1CPprGyZm005hi9kxWb68JQQRotyY=;
        b=tXHqAuKMoWcaQGoHh8foJllS32lSfYaW5ckP4qjQ6rTroHMgpQJXmrcey3Pgaiugz1
         TK1dRrmMGhLczf/awWbwUu2rLIv503xv8xcZIAz6DMWQhnERjqR5SQ2Fbc/K3vlDQb98
         b43O5ONWF6zJl4ZUmgY7zX7j4SkIeAsGnToBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KCv9Pgoy4rc5yxNrnRL5YMkNcUoLVD13o1AOyJ2crHn+ljfhHYaW9aRqlH7tBXvIWT
         heOWRjlXh6SNX4eHtg3ztDbbyEtU8GJUXXnRlO97MCYA6DZC5gyDH3W+FJSf32ME+XuD
         5GKtIcCLBCmKyfd430jAqaVywNzvvompOLeDM=
Received: by 10.86.232.33 with SMTP id e33mr5170520fgh.71.1250780590334;
        Thu, 20 Aug 2009 08:03:10 -0700 (PDT)
Received: from localhost.localdomain (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id 3sm390276fge.11.2009.08.20.08.03.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 08:03:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7KF39Hk030776;
	Thu, 20 Aug 2009 17:03:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7KF38Nr030772;
	Thu, 20 Aug 2009 17:03:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2367E9DF-6FB1-48E6-AC9A-73E84C9D54E1@math.utoronto.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126645>

Marco Gualtieri <mgualt@math.utoronto.ca> writes:

> Hello,
> 
> I am wondering about a possibly easy bug which you may be aware of.
> 
> For some reason if I place a symbolic link in a directory under the
> project root,  gitweb is no longer able to find the project.  I was
> looking through the .cgi file but I don't know enough perl to fix the
> problem myself.
> 
> Let me know if this makes sense.

WORKSFORME.  I have gitweb setup so some of repositories are in
$projectroot directory via symlink, either to repository itself, or
with symlinked earlier part of path, and it works correctly and shows
all those repositories.

I suspect that your web server is configured to not follow symbolic
links, or your user account used by web server is not allowed (doesn't
have permissions) to follow symbolic links.

P.S. You should look into source file gitweb/gitweb.perl, not
installed script gitweb.cgi

-- 
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
