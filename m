From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moved files and merges
Date: Mon, 05 Sep 2005 09:37:42 -0700
Message-ID: <431C7456.80907@zytor.com>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net> <7vek867e29.fsf@assigned-by-dhcp.cox.net> <7vy86erntu.fsf@assigned-by-dhcp.cox.net> <20050903190500.GB8379@mars.ravnborg.org> <7voe7arlqk.fsf@assigned-by-dhcp.cox.net> <20050903220355.GA1895@mars.ravnborg.org> <7v64thl248.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509041329340.23242@iabervon.org> <7vvf1gejjf.fsf@assigned-by-dhcp.cox.net> <431C6167.4070703@zytor.com> <Pine.LNX.4.58.0509050825170.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 18:41:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJz4-000201-L9
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 18:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVIEQiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVIEQiL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 12:38:11 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:61593 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932332AbVIEQiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 12:38:10 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j85GbgJv031429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2005 09:37:43 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050825170.3568@evo.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8102>

Linus Torvalds wrote:
> 
> It's a totally broken model. Really.
> 
> You think it solves issues, but it just creates more bugs and problems 
> than it solves.
> 
> Trust me. The whole point of git is that "content is the only thing that 
> matters", and that there isn't any other meta-data. If you break that 
> fundamental assumption, everything git does so well will break. 
> 
> I think we've already shown that the "content matters" approach works.  I
> claim that the git rename tracking works better than any other SCM out 
> there, _exactly_ because it doesn't make the mistake of trying to track 
> anything but content.
> 
> The "moved + modified files" is not anything special. The current 
> automatic merger may not handle it, but that's not because it _can't_ 
> handle it, it's because it tries to be simple and efficient. 
> 
> And because it's so _incredibly_ fast for all the normal cases, you can 
> now spend some effort on figuring out renames dynamically for the few 
> cases where it fails. Does it do so now? No. Would adding UUID's help? 
> Hell no. It would be just an unmitigated disaster.
> 

Okay, how about keeping a cache (derived from the contents) of these 
types of data, to assist the merge if necessary?  If it doesn't exist 
when needed, it can just be created, which may take O(n) time.

	-hpa
