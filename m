From: Pete Wyckoff <pw@padd.com>
Subject: Re: "git grep" parallelism question
Date: Sun, 5 May 2013 11:40:01 -0400
Message-ID: <20130505154001.GA25257@padd.com>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
 <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
 <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 05 17:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ12r-00088F-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 17:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab3EEPkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 11:40:06 -0400
Received: from honk.padd.com ([74.3.171.149]:52208 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab3EEPkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 11:40:05 -0400
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 6028920C2;
	Sun,  5 May 2013 08:40:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DF77B226B7; Sun,  5 May 2013 11:40:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223405>

torvalds@linux-foundation.org wrote on Fri, 26 Apr 2013 13:31 -0700:
> Anyway, I think your patch is good if for no other reason that it
> allows this kind of testing, but at least for my machine, clearly the
> current default of eight threads is actually "good enough". Maybe
> somebody with a very different machine might want to run the above
> script and see if how sensitive other machines are to this parameter..

NFS numbers behave as expected:  IO concurrency is key.

WARM
1 real 0m23.147s
2 real 0m13.913s
4 real 0m6.958s
8 real 0m4.104s
16 real 0m3.588s
32 real 0m3.212s
64 real 0m3.173s

COLD
1 real 1m36.969s
2 real 0m51.627s
4 real 0m32.994s
8 real 0m25.657s
16 real 0m21.260s
32 real 0m18.138s
64 real 0m17.265s

I am tempted to change the default locally from 8 to 32.

		-- Pete
