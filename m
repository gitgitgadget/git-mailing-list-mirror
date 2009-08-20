From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Wed, 19 Aug 2009 19:30:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908191929350.3158@localhost.localdomain>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home> <7v1vn9f4mz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908181357330.6044@xanadu.home> <7vk511dk11.fsf@alter.siamese.dyndns.org> <XJM0H8pTiCJpryS-arPltHCHwsm0djqVixaH1NwBqT2pci2MA9karw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0908192201180.6044@xanadu.home>
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
X-From: git-owner@vger.kernel.org Thu Aug 20 04:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdxQo-0005bd-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 04:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZHTCbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 22:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbZHTCbF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 22:31:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851AbZHTCbE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 22:31:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7K2UXsD012713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 19:30:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7K2UXwU022683;
	Wed, 19 Aug 2009 19:30:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908192201180.6044@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.464 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126604>



On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> 
> I think the best solution in this case might simply be to add something 
> like this somewhere at the top of git-compat-util.h after the system 
> includes:

I think we can just test __i386.

Gcc defines that one too (in fact, in general, gcc always defines both the 
__x and the __x__ versions, although I'm sure there are exceptions)

		Linus
