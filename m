From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cygwin and git 1.5.1
Date: Tue, 10 Apr 2007 15:44:29 -0700
Message-ID: <461C134D.8020803@zytor.com>
References: <461BCBC0.2000705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbP4t-00028z-E9
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965724AbXDJWoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965765AbXDJWoh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:44:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38271 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbXDJWog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:44:36 -0400
Received: from [172.27.0.16] (c-67-180-238-171.hsd1.ca.comcast.net [67.180.238.171])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3AMiTi1027409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2007 15:44:30 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <461BCBC0.2000705@ramsay1.demon.co.uk>
X-Virus-Scanned: ClamAV 0.88.7/3064/Tue Apr 10 09:25:23 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44193>

Ramsay Jones wrote:
> Hi Junio,
> 
> I recently upgraded to 1.5.1, via tarball as usual, without much problem.
> The only problem being the "printf format warnings" issue, which prevents
> me building with -Werror.
> 
> I have included, below, an updated version of my patch from the 1.5.0 
> series.
> We agreed last time that this patch is not the correct solution to this
> problem in general (but it works on cygwin!), so this is *not* intended
> for submission. I just wanted to document the problem. As before, I don't
> really have a solution; I suppose I will just have to carry this patch
> forward with each release - no big deal.
> 
> Note that the patch has grown larger. This is due to the increased use of
> uint32_t (in combination with printf/die/error etc).
> I guess not many others use -Werror to build on cygwin! ;-)

The excruciatingly correct way to do this is to use the macros defined 
in <inttypes.h>, so for uint32_t one should use %"PRNu32" instead of %u, 
for example.

	-hpa
