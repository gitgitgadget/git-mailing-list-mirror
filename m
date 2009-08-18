From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 15:29:35 -0500
Message-ID: <08Paa_FqYXS4u78q8DsW-e7xpWkmcOdrkJUSHb8zhns8DwkPS-Rpxw@cipher.nrlssc.navy.mil>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181147510.6044@xanadu.home> <alpine.LFD.2.00.0908181240400.6044@xanadu.home> <7v1vn9f4mz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181357330.6044@xanadu.home> <7vk511dk11.fsf@alter.siamese.dyndns.org> <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0908181607240.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVJm-0005n8-UT
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbZHRU37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbZHRU36
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:29:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47041 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbZHRU36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:29:58 -0400
Received: by mail.nrlssc.navy.mil id n7IKTaLm027246; Tue, 18 Aug 2009 15:29:36 -0500
In-Reply-To: <alpine.LFD.2.00.0908181607240.6044@xanadu.home>
X-OriginalArrivalTime: 18 Aug 2009 20:29:35.0338 (UTC) FILETIME=[99C734A0:01CA2042]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126452>

Nicolas Pitre wrote:
> On Tue, 18 Aug 2009, Brandon Casey wrote:
> 
>> The SUNWspro compiler doesn't set __i386__.  Instead it sets __i386, and
>> I think __x86_64 and __amd64 where appropriate.  So, compilation with
>> the SUNWspro compiler on x86 is currently unaffected by these changes and
>> falls back to the generic routines.
>>
>> It seems that v5.10 of the compiler can grok both the __asm__ statements
>> and the ({...}) naked block notation and passes all of the tests when the
>> block_sha1 code is modified to add defined(__i386) to each of the macro
>> statements.
> 
> Does it really implement the gcc inline assembly syntax?

Yes, I think it does.  I actually extracted the assembly from sha1.c and tested
in a separate test program.  The v5.10 sunwspro compiler compiles and executes
it correctly.

-brandon
