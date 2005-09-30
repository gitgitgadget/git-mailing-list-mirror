From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Fri, 30 Sep 2005 15:16:48 -0700
Message-ID: <433DB950.3010909@zytor.com>
References: <1128026765.24397.46.camel@dv>	 <7vek779kg0.fsf@assigned-by-dhcp.cox.net> <1128087662.14543.14.camel@dv>	 <433D8FA6.2080808@zytor.com> <1128118469.7352.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 00:18:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELTCE-0006dZ-KQ
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 00:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVI3WRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 18:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVI3WRW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 18:17:22 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9120 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030476AbVI3WRV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 18:17:21 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8UMGraZ029367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Sep 2005 15:16:53 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1128118469.7352.15.camel@dv>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9575>

Pavel Roskin wrote:
> 
> I know.  That's what I'm using in the wrapper (plus -m64 and some
> warnings).  But it should be the default.  Until then, hassle-free
> sparse support in the Makefile is only possible for the projects that
> already know the architecture (e.g. the Linux kernel).
> 

I think that's debatable.  It introduces main-compiler dependencies into 
sparse which is undesirable.

A much simpler option would be to write a "sparsegcc" script which would 
be invoked just like gcc, extract the appropriate macro information 
based on options, and then invoke sparse.

	-hpa
