From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: Version independent mod_perl woes
Date: Thu, 21 Dec 2006 18:51:28 +0100
Message-ID: <200612211851.28807.jnareb@gmail.com>
References: <200612211807.54668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 18:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxS2H-0005sN-T8
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 18:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422969AbWLURsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 12:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWLURsu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 12:48:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:39283 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422969AbWLURsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 12:48:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2719385uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 09:48:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZQtJmmVLb0QswO7UCdaFDDPv+zgjukEki8JbL4isq3Yvwiq23y5fWrSrypbEcIBDHUdPAy2/1iXx6hrsTDUqZ2JWmycbS1bLMblr8osA98atc854OuD2KsDO2F5SXVMTmHoDAKkRriLJWNggEaYhDl9G5pY8hm5eeovaXReI83s=
Received: by 10.67.19.20 with SMTP id w20mr12410748ugi.1166723327814;
        Thu, 21 Dec 2006 09:48:47 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id j33sm12109969ugc.2006.12.21.09.48.47;
        Thu, 21 Dec 2006 09:48:47 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612211807.54668.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35075>

> Can anyone tell me what I'm doing wrong?

Ah, I forgot to add:

Apache 2.0.54 (httpd-2.0.54-10.3)
mod_perl 2.0.1 (mod_perl-2.0.1-1.fc4)
Perl 5.8.6 (perl-5.8.6-24)

$Apache2::RequestRec::VERSION = 2.000001
$Apache2::ServerRec::VERSION  = 2.000001

-- >8 -- [fragment of httpd.conf] ---
Alias /perl "/var/www/perl"
<Directory "/var/www/perl">
    SetHandler perl-script
    PerlResponseHandler ModPerl::Registry
    PerlOptions +ParseHeaders
    Options Indexes FollowSymlinks +ExecCGI
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
-- >8 --

P.S. The goal is for gitweb to work with
    PerlOptions -SetupEnv -ParseHeaders
-- 
Jakub Narebski
Poland
