From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 13 Jun 2009 12:57:38 -0700
Message-ID: <4A3404B2.5080700@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>	<7vtz2nlrfs.fsf@alter.siamese.dyndns.org>	<200906110602.54861.chriscool@tuxfamily.org>	<4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com>	<c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>	<4A33F7E4.4020201@zytor.com> <m3r5xo2ajc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZMZ-0000bW-2R
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 21:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968AbZFMT5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 15:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbZFMT5w
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 15:57:52 -0400
Received: from terminus.zytor.com ([198.137.202.10]:48864 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZFMT5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 15:57:51 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5DJvgdL009406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Jun 2009 12:57:43 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n5DJvgq1024465;
	Sat, 13 Jun 2009 12:57:42 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n5DJvc00006053;
	Sat, 13 Jun 2009 12:57:39 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <m3r5xo2ajc.fsf@localhost.localdomain>
X-Virus-Scanned: ClamAV 0.94.2/9464/Sat Jun 13 00:44:17 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121519>

Jakub Narebski wrote:
> 
> Why not borrow one of algorithms, e.g. taus[1] from GSL (GNU
> Scientific Library)?
> 
> If I understand "Random Number Generator Performance" chapter in GSL
> Manual it is of comparable performance of the above BSD `rand`
> generator, and is of simulation quality.
> 
> [1] maximally equidistributed combined Tausworthe generator by L'Ecuyer
> 

Interesting paper (the algorithm is on page 8):

http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=F2BD39FF5C24221B424E12D9ED4E68B7?doi=10.1.1.43.4155&rep=rep1&type=pdf

The reason I suggested SHA-1 is because we already have SHA-1 code
involved (in fact, we even have a bunch of precalculated SHA-1s
available to us) and performance matters not one iota in this application.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
