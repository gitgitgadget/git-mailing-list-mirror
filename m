From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 12:41:38 +0100
Message-ID: <4CEBA872.2020001@drmicha.warpmail.net>
References: <m2oc9hkurl.fsf@gmail.com>	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>	<m2k4k5ks0b.fsf@gmail.com>	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>	<m2zkt0jsha.fsf@gmail.com> <4CEB9109.4000008@drmicha.warpmail.net> <m2vd3ojna1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 12:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKrHr-0001J5-2w
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 12:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab0KWLnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 06:43:46 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36969 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410Ab0KWLnp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 06:43:45 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2AC88207C;
	Tue, 23 Nov 2010 06:43:45 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 23 Nov 2010 06:43:45 -0500
X-Sasl-enc: 9rMOlovZ06zZH6onOyhVaPluxgAji/nJX335tygHUZxT 1290512624
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A80FD5EB4C8;
	Tue, 23 Nov 2010 06:43:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <m2vd3ojna1.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161944>

Francis Moreau venit, vidit, dixit 23.11.2010 12:24:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Francis Moreau venit, vidit, dixit 23.11.2010 10:32:
>>>
>>>   $ make prefix=/usr/local NO_CURL=1 ASCIIDOC8=y DOCBOOK2X_TEXI=db2x_docbook2texi ASCIIDOC_NO_ROFF=y XMLTO_EXTRA="--skip-validation" V=1 doc
>>>   make -C Documentation all
>>>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>>>   make -C ../  GIT-VERSION-FILE
>>>   make[2]: Entering directory `/home/fmoreau/git'
>>>   make[2]: `GIT-VERSION-FILE' is up to date.
>>>   make[2]: Leaving directory `/home/fmoreau/git'
>>>   rm -f git-fetch.1 && \
>>>   xmlto -m manpage-normal.xsl --skip-validation man git-fetch.xml
>>>   I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>   warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
>>>   compilation error: file /tmp/xmlto-xsl.A7kzn5 line 4 element import
>>>   xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>   make[1]: *** [git-fetch.1] Error 1
>>>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
>>>   make: *** [doc] Error 2
>>
>> This is weird for several reasons.
>>
>> Can you wget or curl these files?
> 
> Yes I can.
> 
>>
>> Besides, I can build the doc even without network access, even though my
>> /tmp/xmlto... has the same import statement.
>>
>> Can you check with which options your xmlto calls your xsltproc? Mine
>> has "--nonet".
> 
> I can see the following ones:
> 
>   --nonet
>   --xinclude
> 
>> Do you have libxslt-1.1.26-3.fc14.x86_64, and is your xsltproc the one
>> from that package?
> 
>   $ rpm -qa | grep libxslt
>   libxslt-devel-1.1.26-3.fc14.x86_64
>   libxslt-1.1.26-3.fc14.x86_64
> 
>   $ which xsltproc
>   /usr/bin/xsltproc
> 
>   $ rpm -qf /usr/bin/xsltproc
>   libxslt-1.1.26-3.fc14.x86_64
> 

I'm pretty stomped then. The only remaining suggestions:

- remove xml-commons-resolver and try again
- try as a different user

Otherwise, an strace of xsltproc might give some hints...

Michael
