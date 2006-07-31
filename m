From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16] gitweb: Remove characters entities entirely when shortening string
Date: Mon, 31 Jul 2006 18:59:08 +0200
Organization: At home
Message-ID: <ealcsb$88c$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200607302236.06686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 19:00:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7b7h-0000hV-CK
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 19:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWGaRAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWGaRAF
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 13:00:05 -0400
Received: from main.gmane.org ([80.91.229.2]:22183 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030246AbWGaRAD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 13:00:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7b7E-0000Zi-K8
	for git@vger.kernel.org; Mon, 31 Jul 2006 18:59:40 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 18:59:40 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 18:59:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jakub Narebski wrote:

> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.cgi
> @@ -776,6 +776,7 @@ sub chop_str {
>       my $tail = $2;
>       if (length($tail) > 4) {
>               $tail = " ...";
> +             $body =~ s/&[^;]$//; # remove chopped character entities
>       }
>       return "$body$tail";
>  }

Of course it should be

+               $body =~ s/&[^;]*$//; # remove chopped character entities

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
