From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow OFS_DELTA objects during a push
Date: Fri, 01 May 2009 16:49:26 -0700
Message-ID: <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 02 01:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M02U9-0007SV-HV
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 01:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZEAXte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 19:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbZEAXte
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 19:49:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZEAXtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 19:49:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41D46131B2;
	Fri,  1 May 2009 19:49:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 907EC131B1; Fri, 
 1 May 2009 19:49:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0905011616130.6741@xanadu.home> (Nicolas
 Pitre's message of "Fri, 01 May 2009 16:56:47 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7BC2A78-36AA-11DE-94B1-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118108>

Thanks.

The code looks correct, I am reasonably sure updated server-client
combination would work fine, and use of the capability mechanism means
other combinations like old pusher and new receiver, and/or new pusher and
old receiver, should be also Ok.

I see Shawn did the same to jgit.

But I'd like to queue this in 'next', and make it official after 1.6.3
happens.

I just do not want to repeat silly mistakes, this close to the final,
similar to the "github needs to get stuck forever at 1.6.1" we made with
40c155f (push: prepare sender to receive extended ref information from the
receiver, 2008-09-09); it was done as a good change after a discussion
among Shawn, Daniel and I.  We managed to botch it and had to later fix
with 02322e1 (send-pack: do not send unknown object name from ".have" to
pack-objects, 2009-01-27).

(references)

  http://thread.gmane.org/gmane.comp.version-control.git/95351
  http://thread.gmane.org/gmane.comp.version-control.git/95072
  http://thread.gmane.org/gmane.comp.version-control.git/107417/focus=107500
