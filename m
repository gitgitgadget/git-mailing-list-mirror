From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb sets incorrect <base> header
Date: Wed, 29 Apr 2009 02:33:01 -0700 (PDT)
Message-ID: <m3k553oldj.fsf@localhost.localdomain>
References: <877i15uf14.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Wed Apr 29 11:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz6AI-0007ku-Jt
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 11:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZD2JdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZD2JdF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 05:33:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:52432 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZD2JdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 05:33:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so933862qwd.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Io5NyCdcMjnmjpoKi0YyhvIBYcEUz/tm4z1/3q7W5PM=;
        b=AAjNZsgsxP4IjdmHG9d5VTAUD6kEYbM21cAo+fhBjAhocCpFKWs+1VYfBs7+NgQs4e
         aLh2taGcCXYNAdHLmSW+rPaxPONCUdV+S79AZ4GH2+AVPWDmspRlAMx5r4EClpwK8pAM
         uE3vp4D7pzB47o+JHv6xXH/BFIWPv5LxN1New=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tfiyM8vND/L+uRd4aqJy5Zh2ynaNOZTAb24BQqB+KBIcgXthQGNgrGuj0yTiIu+mI7
         Pe4xPLFbfL9TDpAIAKB05jwmDMHmot0ldfjZg1yu/jesU8PjJxvxyKVhChPxYvUfNEpS
         e1HeD8Qq6GPcXhNEIgqlKijtcFBH+GiudJ/9E=
Received: by 10.224.20.76 with SMTP id e12mr110397qab.47.1240997582547;
        Wed, 29 Apr 2009 02:33:02 -0700 (PDT)
Received: from localhost.localdomain (abwr45.neoplus.adsl.tpnet.pl [83.8.241.45])
        by mx.google.com with ESMTPS id 6sm1364200qwk.28.2009.04.29.02.33.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 02:33:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3T9Wvgg002429;
	Wed, 29 Apr 2009 11:32:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3T9Wugr002426;
	Wed, 29 Apr 2009 11:32:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <877i15uf14.fsf@write-only.cryp.to>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117873>

Peter Simons <simons@cryp.to> writes:

> Hi,
> 
> after a recent gitweb update to revision v1.6.3-rc3-12-gb79376c, the CGI now
> generates an incorrect <base> header. For example, the first "patch" on the
> page
> 
>   http://git.cryp.to/fastcgi/commitdiff/9ad9965b3fa293c458df14391f181f2f8f1197cd
> 
> erroneously refer to http://git.cryp.to/cgi-bin/gitweb.cgi#patch1, but that
> page doesn't exist. It appears that $base_url is not determined correctly.
> 
> Does anyone have a clue how that problem can be fixed?

See gitweb/README:

 * $my_url, $my_uri
   Full URL and absolute URL of gitweb script;
   in earlier versions of gitweb you might have need to set those
   variables, now there should be no need to do it.

Or you can set up $base_url in your gitweb configuration file (which
is not mentioned in the gitweb/README, unfortunately).


Since 81d3fe9 (gitweb: fix wrong base URL when non-root DirectoryIndex)
by Giuseppe Bilotta (I have CC-ed him) gitweb tries to set $base_url
using $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'} if we use $path_info,
and if both $my_url and $my_uri begin with $path_info.

I do not know CGI.pm well enough to think up a better solution, but
when $base_url was introduced I have posted email on git mailing list
about slight mismatch between what CGI.pm thinks as absolute URL and
the notion of absolute URL and absolute _paths_ in appropriate RFC,
see e.g. 
  http://thread.gmane.org/gmane.comp.version-control.git/107344/focus=107437
  http://thread.gmane.org/gmane.comp.version-control.git/107898/focus=108010

P.S. I didn't look at the site in question.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
