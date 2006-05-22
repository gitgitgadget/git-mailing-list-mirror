From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Mon, 22 May 2006 15:23:44 -0700
Message-ID: <447239F0.9030705@zytor.com>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE> <44722A8F.9020609@zytor.com> <20060522220206.GA10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 00:24:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiIos-0003gd-Qv
	for gcvg-git@gmane.org; Tue, 23 May 2006 00:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWEVWYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWEVWYH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 18:24:07 -0400
Received: from terminus.zytor.com ([192.83.249.54]:59271 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751275AbWEVWYF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 18:24:05 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k4MMNkHT005470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 May 2006 15:23:47 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060522220206.GA10488@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20541>

Petr Baudis wrote:
> 
> What about incremental fetches using git-fetch? From a quick scan of the
> git-fetch automagic tags following code, it seems to be even
> significantly more expensive than Cogito's (in terms of number of
> forks).
> 

Well, I haven't used git-fetch, so I can't comment on that one.

> git-clone has an advantage here since it clones _everything_ while
> Cogito fetches only stuff related to the branch you are cloning, and
> verifying if what it fetches is sensible for you unfortunately takes a
> lot of time. :/ I guess there is no way to verify presence of multiple
> objects at once and there is also no way to order local fetch of
> multiple objects at once.

Note that non-local cg-clones are at least an order of magnitude faster, even when the 
nonlocal is just git+ssh:.  One could presumably do the same thing over a pipe.

	-hpa
