From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git daemon directory munging?
Date: Sun, 04 Jun 2006 16:08:51 -0700
Message-ID: <44836803.5070405@zytor.com>
References: <E1FmgFV-0001i6-Kc@jdl.com> <Pine.LNX.4.64.0606031722340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 01:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn1ia-0007Gl-GI
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 01:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWFDXJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 19:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFDXJJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 19:09:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:63429 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932305AbWFDXJI
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 19:09:08 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k54N8p2x016113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 16:08:52 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606031722340.5498@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21292>

Linus Torvalds wrote:
> 
> On Sat, 3 Jun 2006, Jon Loeliger wrote:
>> <jdl> Thus, I'd use something like:
>>       --map-base=www.foo.com/pub/scm:/pub/foo/scm
>>       --map-base=www.bar.com/pub/scm=/pub/bar/scm
> 
> The bigger problem is that nothing actually passes in the hostname to 
> git-daemon in the first place. By the time the git-daemon is contacted, 
> the hostname is long gone ;(

Well, you can bind different git daemons to different IP addresses 
(IP-based vhosting) or different ports (with SRV records in DNS.)

> Now, you can just extend the git protocol to just pass in the host too. 
> 
> You can in fact do this in a backwards-compatible manner (old git-daemons 
> will just ignore it, and new git daemons will automatically notice new 
> clients) with something evil like the appended.
> 

That's actually what was done to HTTP.

> Not tested (and this actualyl doesn't make the daemon _use_ the data, it 
> just adds a comment - the rest "is left as an exercise for the reader")


	-hpa
