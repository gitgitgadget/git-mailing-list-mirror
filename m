From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 08:25:32 -0700
Message-ID: <4A2E7EEC.2050807@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	 <7vskidcf9s.fsf@alter.siamese.dyndns.org>	 <200906070932.36913.chriscool@tuxfamily.org>	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com> <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:54:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME5Wl-0008QH-Ea
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZFIRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 13:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbZFIRyR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:54:17 -0400
Received: from terminus.zytor.com ([198.137.202.10]:59995 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZFIRyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 13:54:17 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n59FPXSV013890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 08:26:43 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n59FPXT7016903;
	Tue, 9 Jun 2009 08:25:33 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n59FPW7C001389;
	Tue, 9 Jun 2009 08:25:32 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9442/Tue Jun  9 05:14:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121195>

Christian Couder wrote:
> On Tue, Jun 9, 2009 at 6:24 AM, Christian
> Couder<christian.couder@gmail.com> wrote:
>> So I would be ok to implement a config option or a switch to "git
>> bisect start" to let people use a PRNG instead of my algorithm but I
>> think something like my algorithm should be the default.
> 
> Another reason to have 2 algorithms is that when you use "git bisect
> run" you might want to use the PRNG one because:
> 
> - you don't care much if the bisection use some more steps (as long as
> it does not get stuck)
> - you can't do much if it get stuck
> 
> On the other hand, when you bisect manually:
> 
> - you probably won't like it if you are asked to test some commits
> that won't give a lot of information
> - if it get stuck, you can manually use "git bisect visualize" and/or
> "git bisect skip <range>" and/or some other manual commands to do
> something about it
> 

Sort-of-kind-of.  I doubt most users will be able to recover from a
stuck situation, and unless we have extremely high cost of testing
(which is true for some applications) then expecting the user to
optimizing manually is really bad user design.

My main objection to the "skip in goodness space" is exactly the same as
Junio's... it doesn't really buy you what it claims to sell.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
