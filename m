From: Junio C Hamano <gitster@pobox.com>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 09:29:06 -0800
Message-ID: <7v1vxeb4il.fsf@gitster.siamese.dyndns.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
 <20081106213711.GA4334@blimp.localdomain>
 <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
 <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
 <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
 <20081109102528.GA5463@blimp.localdomain>
 <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
 <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com>
 <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
 <20081114050822.GA23963@foursquare.net>
 <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Frey <cdfrey@foursquare.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12VZ-0001Iq-JF
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbYKNR3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 12:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYKNR3s
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:29:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYKNR3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 12:29:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E2FE67D17D;
	Fri, 14 Nov 2008 12:29:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF8C27D171; Fri,
 14 Nov 2008 12:29:13 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 14 Nov 2008 08:11:41 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D405B72A-B271-11DD-A431-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So we could make a '{ }' in the argument space basically do a SHA1 
> expansion of the range inside, and imply --no-walk. It's _not_ entirely 
> trivial, because we'd need to handle the fact that object flags are 
> sticky, and clear them in between invocations of multiple ranges, but it's 
> not _fundmanetally_ difficult. It's just that somebody would need to do 
> it.

Wouldn't you lose the nice streaming output (iow short latency)?
