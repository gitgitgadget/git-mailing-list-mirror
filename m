X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on
 many OSes other than Linux
Date: Tue, 19 Dec 2006 19:50:22 -0500
Message-ID: <458888CE.2000203@garzik.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org> <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191027270.18171@xanadu.home> <7vk60npv7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191409500.18171@xanadu.home> <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org> <4588453A.3060904@garzik.org> <7vzm9jo1df.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191640010.6766@w
 oody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 00:50:58 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34877>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpfZ-0005Gh-Uc for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932750AbWLTAug (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLTAug
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:50:36 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57147 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932750AbWLTAuf
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 19:50:35 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1Gwpf4-0000TV-Vg; Wed, 20 Dec 2006 00:50:23 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Dec 2006, Junio C Hamano wrote:
> 
>> Jeff Garzik <jeff@garzik.org> writes:
>>
>>> If you are going to do this, you have to audit -every- file, to make
>>> sure git-compat-util.h is -always- the first header.
>> Will do.
> 
> Well, since any cases where it isn't (and where we'd care) will  show up 
> as just a compiler warning, I doubt we really even need to. We can fix 
> things up as they get reported too..

I wouldn't assume that is always the case.  Mostly true, I would 
suppose.  But some of those defines turn on and off 64-bit file 
size/offset gadgets for example.

	Jeff

