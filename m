From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 12:40:43 -0700
Message-ID: <7vfxbodi6c.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181357330.6044@xanadu.home>
 <7vk511dk11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUYG-0006WC-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 21:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZHRTkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbZHRTkw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 15:40:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHRTkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 15:40:52 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3785FAAC;
	Tue, 18 Aug 2009 15:40:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93360FAA5; Tue, 18 Aug
 2009 15:40:44 -0400 (EDT)
In-Reply-To: <7vk511dk11.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 18 Aug 2009 12\:00\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A9ED9B4-8C2F-11DE-997A-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126443>

Junio C Hamano <gitster@pobox.com> writes:

> Another issue, especially with your "openssl sha1 removal" patch, is if we
> can assume gcc everywhere.  As far as I can tell, block-sha1/sha1.c will
> be the first unconditional use of inline asm or statement expression on
> i386/amd64.  Are folks on Solaris and other platforms Ok with this?

Ahhh, your bswap.h is a no-op unless you use gcc, so my worry was
unfounded.
