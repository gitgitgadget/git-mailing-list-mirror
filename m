From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Running gitweb under mod_perl
Date: Tue, 05 Sep 2006 22:32:21 +0200
Organization: At home
Message-ID: <edkms4$mr9$1@sea.gmane.org>
References: <eck6sq$agn$1@sea.gmane.org> <20060824140525.G638085b@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 05 22:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKhar-00088J-2g
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 22:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWIEUcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWIEUcW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 16:32:22 -0400
Received: from main.gmane.org ([80.91.229.2]:5343 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161049AbWIEUcU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 16:32:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKhal-000868-Ca
	for git@vger.kernel.org; Tue, 05 Sep 2006 22:32:19 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 22:32:19 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 22:32:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26486>

Dennis Stosberg wrote:

> Jakub Narebski wrote:
> 
>> What should I put in Apache configuration (Apache 2.0.54 if this
>> matters, mod_perl 2.0.1) 
> 
> From my configuration:
> 
>   <Directory /home/dennis/public_html/perl>
>     Options -Indexes +ExecCGI
>     AllowOverride None
>     PerlSendHeader On
>     SetHandler perl-script
>     PerlHandler ModPerl::Registry
>   </Directory>

I use mod_perl 2.0 version

   Alias /perl /var/www/perl
   <Directory /var/www/perl>
       SetHandler perl-script
       PerlResponseHandler ModPerl::Registry
       PerlOptions +ParseHeaders
       Options +ExecCGI
   </Directory>

What is strange that ApacheBench is showing that mod_perl is _slower_ than
CGI version: 3003.305 [ms] (mean) CGI vs 3500.589 [ms] (mean) mod_perl
for summary page for git.git repository (my copy that is).

I wonder if I misconfigured something...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
