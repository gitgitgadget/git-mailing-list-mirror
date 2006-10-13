From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Fri, 13 Oct 2006 17:09:08 +0200
Message-ID: <200610131709.08515.jnareb@gmail.com>
References: <20061011172553.GA1147@linux-mips.org> <200610122321.18630.jnareb@gmail.com> <200610131605.56913.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 17:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYOeq-0004aU-D2
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 17:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWJMPJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWJMPJE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 11:09:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:28689 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751125AbWJMPJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 11:09:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so461283ugd
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 08:09:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tFF/cDQMyGGFEihSbs9dPQOUd6kuxoMCO+zO4oxiipgMzF/pZHiWI2+TtAtBzULsl/Ez4+5dl3OGX4MT2YQBbIcXCloYafHCxu9uFpuvhZE920QVxtnxP2TEB2BYhnL4arrMqLtpiVVEuX9NRCt3RetktWwCfwKSh0hfqW4CiXc=
Received: by 10.66.252.4 with SMTP id z4mr4473767ugh;
        Fri, 13 Oct 2006 08:09:01 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id k30sm238457ugc.2006.10.13.08.09.00;
        Fri, 13 Oct 2006 08:09:01 -0700 (PDT)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
User-Agent: KMail/1.9.3
In-Reply-To: <200610131605.56913.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28851>

Robin Rosenberg wrote:
> torsdag 12 oktober 2006 23:21 skrev Jakub Narebski:
>> Robin Rosenberg wrote:
>>> onsdag 11 oktober 2006 23:27 skrev Jakub Narebski:
>>>> Pazu wrote:
>>>>> The XML declaration forces IE6 into quirks mode, breaking our
>>>>> nice standards compliant stylesheet.
>>>>
>>>> But isn't it _required_ by XML/XHTML?
>>>
>>> For pure XML document it is required, but not for XHTML, unless the
>>> encoding is something other than UTF-8 or (shudder) UTF-16. W3C
>>> recommends it though.
>>
>> So what should be our decision? Honor IE quirks ;-) and either remove
>> XML declaration, or use Transitional DTD? Add back SPC to &nbsp; conversion
>> in esc_html? Ignore broken browsers?
> 
> It isn't required by the standard. Why not just drop it?

>From http://www.w3.org/TR/xhtml1/#docconf

 An XML declaration is not required in all XML documents; however XHTML
 document authors are strongly encouraged to use XML declarations in all
 their documents. Such a declaration is required when the character
 encoding of the document is other than the default UTF-8 or UTF-16 and
 no encoding was determined by a higher-level protocol.

So even if it is not required, it is recommended. But yes, removing
<?xml?> for bug-compatibility conformance is better idea than mucking
with browser detection... if we sould need browser detection to avoid
other bugs (like non-W3C CSS box model in IE), then perhaps we could
reintroduce <?xml?> in standards-conforming browsers.
-- 
Jakub Narebski
Poland
