From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 07:55:59 -0800
Message-ID: <45B7818F.6020805@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 16:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9kTv-0006uF-Bu
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 16:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXAXP4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 10:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXAXP4L
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 10:56:11 -0500
Received: from terminus.zytor.com ([192.83.249.54]:40236 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXAXP4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 10:56:10 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0OFtxm5031192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jan 2007 07:55:59 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <ep78r0$h2u$1@sea.gmane.org>
X-Virus-Scanned: ClamAV 0.88.7/2486/Wed Jan 24 06:47:09 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37646>

Jakub Narebski wrote:
> H. Peter Anvin wrote:
> 
>> Would it be an incompatible change to add the commit date (and perhaps 
>> the author date) to .git/info/refs?  I believe that would make it 
>> possible to dramatically (orders of magnitude) speed up the generation 
>> of the gitweb index page, which is easily the most expensive gitweb page 
>> to generate.
> 
> With new gitweb and new git it is not that expensive. It is now one call
> to git-for-each-ref per repository.

That IS hugely expensive.  On kernel.org, that is 24175 calls to git.

> Besides, we can't rely that .git/info/refs is up to date, or even exists.
> It is for dumb protocols, not for gitweb.

Well, SOMETHING needs to be done for this page, since it can take 15 
minutes or more to generate.  Caching doesn't help one iota, since it's 
stale before being generated.

	-hpa
