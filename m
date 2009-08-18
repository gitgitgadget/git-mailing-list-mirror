From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 13:25:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908181316330.3158@localhost.localdomain>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home> <7v1vn9f4mz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181357330.6044@xanadu.home> <7vk511dk11.fsf@alter.siamese.dyndns.org> <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0908181607240.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVFy-0003ie-V8
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZHRU0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbZHRU0A
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:26:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40394 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbZHRU0A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 16:26:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IKPXdY029892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 13:25:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IKPWRu001751;
	Tue, 18 Aug 2009 13:25:32 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908181607240.6044@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.463 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126451>



On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> 
> Does it really implement the gcc inline assembly syntax?

A fair number of compilers do. The Intel compiler does too.

The reason? The gcc inline asm is as close to a standard there is, and is 
fairly expressive without being the mess that is MSC. So if you do inline 
asm at all (and considering the target market for a C compiler, most do), 
gcc asm is a good thing to aim for.

			Linus
