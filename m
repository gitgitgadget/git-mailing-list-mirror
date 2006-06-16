From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 13:56:29 -0700
Message-ID: <44931AFD.4070809@zytor.com>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>  <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>  <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com> <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 22:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrLN1-0002cR-Sq
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 22:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWFPU4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWFPU4h
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 16:56:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14999 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751225AbWFPU4g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 16:56:36 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k5GKuTbU011882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Jun 2006 13:56:29 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21970>

Linus Torvalds wrote:
> 
> Actually, the really irritating thing is that we actually generate all 
> these nice status updates, which just makes pulling and cloning a lot more 
> comfortable, because you actually see what is going on, and what to 
> expect. 
> 
> Except they only work over ssh, where we have a separate channel (for 
> stderr), and with the native git protocol all that nice status work just 
> gets flushed to /dev/null :(
> 
> Dang. It's literally the most irritating part of the thing: the protocol 
> itself is exactly the same whether you go over ssh:// or over git://, but 
> that visual information about what is going on is missing, and it's 
> surprisingly important from a usability standpoint.
> 

Perhaps we shouldn't rely on stderr, and instead have a backchannel as part of the 
protocol itself.  After all, the protocol already does packetization, so all it needs is a 
reliable way to pick out the error/status packets; we could even combine that with a 
machine-readable code (like SMTP et al) that could get interpreted by the other side as 
needed.

	-hpa
