From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Wed, 10 Jun 2009 22:05:07 -0700
Message-ID: <4A309083.9090907@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com> <7vtz2nlrfs.fsf@alter.siamese.dyndns.org> <200906110602.54861.chriscool@tuxfamily.org> <4A308B5D.2010704@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 07:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEcTf-0006Hi-3k
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 07:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbZFKFFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 01:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbZFKFFR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 01:05:17 -0400
Received: from terminus.zytor.com ([198.137.202.10]:44861 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZFKFFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 01:05:16 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5B5584x008076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2009 22:05:08 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n5B558Ug030500;
	Wed, 10 Jun 2009 22:05:08 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n5B557GX032451;
	Wed, 10 Jun 2009 22:05:07 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <4A308B5D.2010704@zytor.com>
X-Virus-Scanned: ClamAV 0.94.2/9451/Wed Jun 10 11:05:54 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121327>

H. Peter Anvin wrote:
> 
> After playing around with Wolfram Alpha for way too long, it seems that
> a suitable bias function would be to take the fourth root of the PRNG
> value, i.e. raise it to the power 0.25.
> 

Urk, I managed to get myself completely confused -- I did the series
approximation on the wrong side of inverting the function.  The correct
power is actually 1.5 (over the range 0 to 1), a value > 1 is necessary
to bias the PRNG toward the beginning (x = 0) of the list.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
