From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 18:33:38 -0800
Message-ID: <4797F902.4000104@zytor.com>
References: <20080123212613.GN2230@yugib.highrise.ca>	<alpine.LSU.1.00.0801232346010.5731@racer.site> <7vsl0oax42.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 03:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHrvE-0002px-Pv
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 03:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYAXCd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 21:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYAXCd6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 21:33:58 -0500
Received: from terminus.zytor.com ([198.137.202.10]:43409 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbYAXCd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 21:33:57 -0500
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.1/8.14.1) with ESMTP id m0O2Xgj6022181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 18:33:42 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m0O2XfLs004502;
	Wed, 23 Jan 2008 18:33:41 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m0O2XdRQ007716;
	Wed, 23 Jan 2008 18:33:39 -0800
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vsl0oax42.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.91.2/5532/Wed Jan 23 13:08:36 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71581>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> FWIW we had the same problem in MinGW, and Hannes Sixt solved it:
>>
>> http://repo.or.cz/w/git/mingw/j6t.git?a=commitdiff;h=b8e84a68f01a2386b2071e1bdc8e24de809a3f6d
>>
>> That might give you an idea how to solve the issue.  Maybe you even make a 
>> git patch out of it?  With a Makefile variable BROKEN_SNPRINTF=YesPlease, 
>> maybe?
> 
> Hmmm.  Looking at that change makes me wonder if that solution
> is Kosher.  The value of the va_list you pass to vsnprintf() is
> unspecified after the call.
> 
> It may be Ok as mingw-only "compatibility wrapper", but I think
> you have to be a bit careful.  It is not a general solution for
> any BROKEN_SNPRINTF.
> 

That's what va_copy() is for.

	-hpa
