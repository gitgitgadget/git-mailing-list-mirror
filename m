From: Yuri <yuri@rawbw.com>
Subject: Re: git quietly fails on https:// URL, https errors are never reported
 to user
Date: Thu, 16 Jan 2014 11:28:11 -0800
Message-ID: <52D832CB.1010403@rawbw.com>
References: <52D7D017.107@rawbw.com> <20140116180310.GA27180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sby-0001Sx-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaAPT2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:28:14 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:57307 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaAPT2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 14:28:13 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0GJSCtN092182;
	Thu, 16 Jan 2014 11:28:12 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140116180310.GA27180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240523>

On 01/16/2014 10:03, Jeff King wrote:
> We used to print "Reading from helper 'git-remote-https' failed" in this
> instance. But in the majority of cases, remote-https has printed a
> useful message already to stderr, and the extra line just confused
> people. The downside, as you noticed, is that when the helper dies
> without printing an error, the user is left with no message.

In my case it was some random misconfiguration of the libraries handling 
https that caused them to fail in some way silently. Full update of the 
supporting libraries fixed this. But previous forced git update didn't 
fix it.

I think your should bring back this printout. Errors only happen in a 
very low percentage of cases, and printing some more would be very 
helpful for troubleshooting. I am not sure what happened in 
git-remote-https, stream may have looked legit to it, or maybe it got 
some error from the supporting libraries and didn't report it. I can't 
tell now because I updated and the problem is gone.

Yuri
