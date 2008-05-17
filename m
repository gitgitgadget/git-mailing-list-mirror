From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 17:06:13 -0700
Message-ID: <482E2175.8030904@thorn.ws>
References: <482BE5F7.2050108@thorn.ws>  <alpine.DEB.1.00.0805161139530.30431@racer>  <alpine.DEB.1.00.0805161148010.30431@racer>  <alpine.DEB.1.00.0805161403130.30431@racer>  <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>  <alpine.DEB.1.00.0805161529390.30431@racer> <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com> <alpine.DEB.1.00.0805170058160.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 02:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9xA-0004TU-0l
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYEQAGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYEQAGV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:06:21 -0400
Received: from server204.webhostingpad.com ([69.65.0.218]:59701 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862AbYEQAGU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 20:06:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=hRJ2D8AShCS7gWpxLbUXSPuFTlwFU2clfnx/r2cW3dulJImjvKfS773c9v77iAy1u/ZfIbzloK1aADGowy/xckz/9M5xjmEeiGPonBrg7FFniElKDjGB10WjyfjKHarM;
Received: from [216.228.112.21] (helo=dhcp-172-16-171-95.nvidia.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1Jx9wF-0006if-6Y; Fri, 16 May 2008 19:06:15 -0500
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0805170058160.30431@racer>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82324>

Johannes Schindelin wrote:
> +/*
> + *  This is an ugly hack to avoid fgetc(), which is slow, as it is locking.
> + *  The argument "in" must be the same for all calls to this function!
> + */
> +static int fast_fgetc(FILE *in)
> +{
>   

Looks great to me, but shouldn't you add an "inline" for this one? Also, 
maybe a double the buffer size.

Tommy
