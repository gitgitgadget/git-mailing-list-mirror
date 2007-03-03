From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 03:57:18 +0100
Message-ID: <200703030357.18822.jnareb@gmail.com>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <7vabyweypw.fsf@assigned-by-dhcp.cox.net> <E1HNATn-0005Y6-HW@flower>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Li Yang-r58472" <LeoLi@freescale.com>, rea-git@codelabs.ru,
	"Raimund Bauer" <ray@softwarelandschaft.com>, git@vger.kernel.org,
	Alp Toker <alp@atoker.com>
To: Oleg Verych <olecom@flower.upol.cz>
X-From: git-owner@vger.kernel.org Sat Mar 03 03:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNKOl-0000pe-ML
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 03:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992922AbXCCCzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 21:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992933AbXCCCzA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 21:55:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:54066 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992922AbXCCCzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 21:55:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so868834uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 18:54:58 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZjIUHzN8Pb+WLuQfYalT/UlHMx+1YjW28xJdlw1s422Dx8pVbejiCy+tdqQSNuhRPo5B5ra8/WCUyHv1MwGU7j+/KRanZrsfbcaxlXzHK3qsY2vKvqQAYVWU4+jLHSTW3XKNAmybL44xV0DxuG9wz093h/yEqSOtM0ZiqAmj0dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EJgTOgpW3Bico5xgrZrmtCUzODv+lbESA/clFEh5keUOSqkOePcuCYRXyQAFKCL3EMWuDvdT/wKUuGm3LR0zhb6ru/2NRd7xMs7QOE4pNZ7DrmgJILIjiSBCosAtbpJcanVi6neKf62W3YnhLHuv+ZvWYtYyUnDfhBgAxkwRoI8=
Received: by 10.66.232.9 with SMTP id e9mr4365783ugh.1172890498781;
        Fri, 02 Mar 2007 18:54:58 -0800 (PST)
Received: from host-81-190-30-210.torun.mm.pl ( [81.190.30.210])
        by mx.google.com with ESMTP id g1sm8023243muf.2007.03.02.18.54.56;
        Fri, 02 Mar 2007 18:54:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <E1HNATn-0005Y6-HW@flower>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41267>

Oleg Verych wrote:
>> From: Junio C Hamano
>> Newsgroups: gmane.comp.version-control.git
>> Subject: Re: gitweb not friendly to firefox?
>> Date: Fri, 02 Mar 2007 02:17:31 -0800
>[]
>>
>> This is puzzling....
> 
> Guys, changing content to "application/xhtml+xml" was a bad idea.
> Here i see FF doesn't working, but i have lynx not working at all :(
> 
> "text/html" is OK, unless you have shiny modern AJAX sh1t on board...

Well, change from text/html to (sometimes) application/xhtml+xml was
made in commit f6801d669 by Alp Toker with the following explanation:

    "The 'text/html' media type [RFC2854] is primarily for HTML, not for
    XHTML. In general, this media type is NOT suitable for XHTML."
    
    This patch makes gitweb use content negotiation to conservatively send
    pages as Content-Type 'application/xhtml+xml' when the user agent
    explicitly claims to support it.

By "conservatively" it means that it uses 'application/xhtml+xml' only when
client explicitly claims that it accepts its, and it is not due to for
example */* accept globbing.

So if lynx isn't working, it is its damn fault...
-- 
Jakub Narebski
Poland
