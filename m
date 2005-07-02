From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Sat, 02 Jul 2005 10:37:38 -0700
Message-ID: <42C6D0E2.8000909@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com> <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org> <42C61351.10306@zytor.com> <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org> <42C61818.30109@zytor.com> <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DolxF-0002Qx-5n
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGBRi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVGBRi2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:38:28 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17096 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261236AbVGBRiM
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 13:38:12 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j62Hbc5N018713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2005 10:37:39 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> ..but that's not what we're looking for. I'm not looking for kernel.org to
> be my distributed backup tape.
> 
> For it to be useful, it must do more than just log all activity and mirror
> it out via rsync. It must also be usable for people pulling on it. Which
> means that it has to be a valid git archive or at least easily
> incrementally unpackable, so that people can actually use the end result.
> 
> A log of packs that are just incremented is certainly unpackable: you
> teach git-unpack-objects to just unpack several packs after each other.  
> But since it's not seekable, you'd have to unpack a 100MB compressed
> archive just to get the last tip of it that you don't have unpacked yet.
> 

Agreed, you also need an index file.  The index file can be recreated 
from the log file in case of corruption, but is what you'd use to seek 
directly to an object.

	-hpa
