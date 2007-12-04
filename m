From: Reid Barton <rwbarton@MIT.EDU>
Subject: Re: git-add--interactive works only in top level
Date: Tue, 4 Dec 2007 01:07:12 -0500
Message-ID: <4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu> <7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 07:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzQv6-00014Z-Ar
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 07:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXLDGFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 01:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXLDGFw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 01:05:52 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44650 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522AbXLDGFv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 01:05:51 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lB465nQY022862;
	Tue, 4 Dec 2007 01:05:49 -0500 (EST)
Received: from [192.168.1.153] (pool-96-233-67-106.bstnma.fios.verizon.net [96.233.67.106])
	(authenticated bits=0)
        (User authenticated as rwbarton@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lB465mm3028844
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 4 Dec 2007 01:05:49 -0500 (EST)
In-Reply-To: <7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 4, 2007, at 12:44 AM, Junio C Hamano wrote:
> Sheesh, you got me worried.
>
> This is a non issue; git-add--interactive is not for direct end user
> consumption.  It relies on being run from git-add wrapper, which does
> cdup to the top of the work tree before launching add--interactive
> helper.

Ah, OK.  Would it not be easy then to add a check to the beginning of  
git-add--interactive to verify that it is indeed being run from the  
top of the work tree?  A user may well discover git-add--interactive  
before git-add --interactive (e.g. by shell completion) and if git- 
add--interactive is going to fail, it should do so right away so as  
to not confuse the user.

I understand that programs such as git-add--interactive will be moved  
out of the executable path not too long from now, which will also  
ameliorate the situation.

Regards,
Reid Barton
