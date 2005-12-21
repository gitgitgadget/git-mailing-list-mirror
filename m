From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] off-by-one bugs found by valgrind
Date: Wed, 21 Dec 2005 13:17:08 -0800
Message-ID: <43A9C654.2010009@zytor.com>
References: <1135197348.3046.7.camel@dv> <7vr7865fq5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 22:18:09 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpBLY-0001iK-3R
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 22:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVLUVRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 16:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVRz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 16:17:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:19616 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750745AbVLUVRy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 16:17:54 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBLLHDsZ020593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Dec 2005 13:17:14 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7865fq5.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13901>

Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> 
>>Insufficient memory is allocated in index-pack.c to hold the *.idx name.
>>One more byte should be allocated to hold the terminating 0.
> 
> Thanks.
> 
> 
>>quote_c_style_counted() in quote.c uses a dangerous construct, when a
>>variable is incremented once and used twice in the same expression.
> 
> Sorry, I do not follow you.  Isn't && a sequence point?
> 

&& is a sequence point.  The code is techically fine, but it's harder 
than necessary to read.

	-hpa
