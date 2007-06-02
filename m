From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Sat, 2 Jun 2007 10:22:31 +0200
Message-ID: <200706021022.31812.jnareb@gmail.com>
References: <200704241705.19661.ismail@pardus.org.tr> <7vsladzp29.fsf@assigned-by-dhcp.cox.net> <87zm3ju6tg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 13:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuRV0-0003sj-2w
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 13:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbXFBLKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 07:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755883AbXFBLKO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 07:10:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62134 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbXFBLKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 07:10:12 -0400
Received: by ug-out-1314.google.com with SMTP id j3so394593ugf
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 04:10:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RgOL/ZJQjU0vd/UYpvBQzJQpY11+F1rwyy47jAPbZwIOV8oJC03gHTSWFPXvuLb/rtVqPdzcT530AnW4vOw4XLGFzjvyNWZCOT9mlGzKtzCdqwO5Qw6TXXMkFFL9BUZZJ7XqUmJznu+Co5XtGyRX7S7Ic9bHkPnssVXMnNlQFA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r+E4pRMkgpBcaWJ8fFI6gfRYrutxPsSgvHXedTa3j80a3xkPflBVdtqDxXWyF2fzFHR6P96FUo82YMN+IWKB+q1m2qoafgLUgCNEeFKS2MV+AAOUmz4JyAJiQGI4wZ9IWWmJBERS5w7a+pqctYM3Pu+VzSCLrwfdpoCNAkD7NMw=
Received: by 10.67.19.17 with SMTP id w17mr1510200ugi.1180782610948;
        Sat, 02 Jun 2007 04:10:10 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm1830083muf.2007.06.02.04.10.05;
        Sat, 02 Jun 2007 04:10:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <87zm3ju6tg.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48924>

On Fri, 1 Jun 2007, Alexandre Julliard wrote:
 
> The cause is apparently that decode_utf8() returns undef for invalid
> sequences instead of substituting a replacement char like
> decode("utf8") does.
> 
> That may be considered an Encode bug since we are running a fairly old
> version (1.99, coming with Debian 3.1), but I'd rather not upgrade
> perl on the server. Could the patch be reverted, or done differently?

Could you put modern (without this decode_utf8 bug) version of Encode.pm
in the directory with gitweb.cgi, so gitweb uses new local version and
not the one that is installed system-wide?
-- 
Jakub Narebski
Poland
