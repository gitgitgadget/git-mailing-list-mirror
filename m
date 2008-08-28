From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Wed, 27 Aug 2008 21:58:05 -0700
Message-ID: <48B6305D.1080004@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <48B62B6F.7010103@zytor.com> <20080828044205.GB10238@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 06:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYZbM-00083o-QV
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 06:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbYH1E6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 00:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYH1E6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 00:58:16 -0400
Received: from terminus.zytor.com ([198.137.202.10]:36484 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbYH1E6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 00:58:16 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7S4wFxg032091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 21:58:15 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7S4wEbH021587;
	Wed, 27 Aug 2008 21:58:14 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7S4w5n4004328;
	Wed, 27 Aug 2008 21:58:06 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080828044205.GB10238@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8104/Wed Aug 27 19:11:35 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94039>

Shawn O. Pearce wrote:
> 
>> Just an implementation detail for the server, however: for an *empty*  
>> repository (one which has no refs at all), the server needs to *not*  
>> transmit the redirect, or there will be a loop :)  It is unnecessary,  
>> anyway, since there is inherently nothing to do.
> 
> Actually that's not true.  A correct client won't loop.
> 
> An empty repository is required to send "refs" section header.
> So the client will see the "refs" header and know that the complete
> set of refs is following.  Only nothing follows, so it knows the
> complete set is the empty set.
> 
> A redirect with no ref data won't have the "refs" section header.
> So the client knows that it cannot conclude anything from that
> exchange and must follow the redirect.
> 

Ah, good point.

	-hpa
