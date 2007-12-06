From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Wed, 5 Dec 2007 23:50:53 -0800
Message-ID: <602F3FCF-C761-4E0A-9854-723F9F8F96F7@midwinter.com>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203021333.GC8322@coredump.intra.peff.net> <7vlk8csetl.fsf@gitster.siamese.dyndns.org> <5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com> <7vhciwn5rl.fsf@gitster.siamese.dyndns.org> <20071206055723.GB23309@coredump.intra.peff.net> <7veje0gwru.fsf@gitster.siamese.dyndns.org> <20071206063626.GA18698@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0BVs-0002K3-Ml
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbXLFHuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbXLFHuz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:50:55 -0500
Received: from tater.midwinter.com ([216.32.86.90]:52137 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753301AbXLFHuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:50:54 -0500
Received: (qmail 25216 invoked from network); 6 Dec 2007 07:50:54 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=et3sMri1Befq6H3kR0mDf6bBzfGJzp0NnURhgNdHTLDzNLbmFTsZcch7dI/UFP+W  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 6 Dec 2007 07:50:54 -0000
In-Reply-To: <20071206063626.GA18698@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67267>

On Dec 5, 2007, at 10:36 PM, Jeff King wrote:
> Ah, I thought his argument was "we have to send back a bit, so why not
> just send the hash we made for informational purposes? It doesn't  
> hurt,
> and maybe we can make use of it later."

Yeah, that was more or less my thinking. Keep it simple for now, but  
it seems like that information is bound to be useful at some point. In  
particular, if you don't send it down, it's really difficult to  
unambiguously get back after the fact (given that a fetch might  
contain subsequent revisions unrelated to yours.)

My v3 patch (which I will combine with a modified form of the  
documentation update now that it sounds like transmitting the SHA1  
isn't objectionable) actually sent it down twice: once in the protocol  
message and once in the human-readable push status report.

-Steve
