From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 09:50:12 -0700
Message-ID: <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRtO-00014D-4F
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759381AbZHRQuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759379AbZHRQuY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:50:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZHRQuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:50:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25E0E2E1F3;
	Tue, 18 Aug 2009 12:50:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DC002E1F2; Tue, 18 Aug 2009
 12:50:14 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0908181240400.6044@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 18 Aug 2009 12\:43\:08 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 394DBDBA-8C17-11DE-AF3D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126416>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 18 Aug 2009, Nicolas Pitre wrote:
>
>> Well...  Given that git already uses ntohl/htonl quite extensively in 
>> its core already, I'd suggest making this more globally available 
>> instead.
>
> What about something like this?

For git's own use, I would be much happier with this change.

But given that there are some people wanting to snarf block-sha1/*.[ch]
out to use them standalone, I have a slight hesitation against introducing
the dependency to git-compat-util.h, making it unclear to them that all
this file wants from outside are ntohl, htonl and memcpy.
