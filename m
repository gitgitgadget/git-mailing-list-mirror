From: David Kastrup <dak@gnu.org>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Thu, 09 Aug 2007 01:27:07 +0200
Message-ID: <85fy2tppys.fsf@lola.goethe.zz>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	<7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
	<7v643p1vbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuwN-0002Z9-Ux
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937061AbXHHX1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937027AbXHHX1L
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:27:11 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:35826 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763451AbXHHX1J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 19:27:09 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 5935F4C882;
	Thu,  9 Aug 2007 01:27:08 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 49B185BF58;
	Thu,  9 Aug 2007 01:27:08 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 285721D3161;
	Thu,  9 Aug 2007 01:27:08 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B19021C3C79D; Thu,  9 Aug 2007 01:27:07 +0200 (CEST)
In-Reply-To: <7v643p1vbr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 08 Aug 2007 16\:05\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3901/Wed Aug  8 23:29:55 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55397>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> @@ -139,6 +154,18 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
>>>  user-manual.html: user-manual.xml
>>>  	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
>>>  
>>> +git.info: user-manual.xml
>>> +	$(RM) $@ $*.texi
>>> +	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
>>> +	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\

[...]

> Aside from possible portability issue of multi-line script, there is
> another slight problem I am not sure if it is worth fixing.  If you
> do not have docbook2x-texi installed, nobody notices that resulting
> $*.texi was a garbage and an almost empty git.info is generated.

Good catch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
