From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 13:22:34 +0200
Message-ID: <vpq3acm6n7p.fsf@bauges.imag.fr>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
	<20090405T001239Z@curie.orbis-terrarum.net>
	<20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
	<20090405190213.GA12929@vidovic>
	<alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	<20090405225954.GA18730@vidovic>
	<alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
	<alpine.LFD.2.00.0904052326090.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 13:29:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqn0r-0001m3-22
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 13:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbZDFL1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 07:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbZDFL1l
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 07:27:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:52987 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940AbZDFL1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 07:27:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n36BMZO6026583
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Apr 2009 13:22:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LqmuQ-0006cg-F4; Mon, 06 Apr 2009 13:22:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LqmuQ-00079I-Cm; Mon, 06 Apr 2009 13:22:34 +0200
In-Reply-To: <alpine.LFD.2.00.0904052326090.6741@xanadu.home> (Nicolas Pitre's message of "Sun\, 05 Apr 2009 23\:34\:32 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Apr 2009 13:22:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115806>

Nicolas Pitre <nico@cam.org> writes:

> If for example you have a single pack because your repo is already fully 
> packed, then the "packing operation" involved during a clone should 
> merely copy the existing pack over with no further attempt at delta 
> compression.

There's still the question if your repository has too many objects
(for example, a branch that you deleted without garbage-collecting
it). Then, sending the whole pack sends data that one may have
considered as "secret".

To me, this is a non-issue (if the content of these objects are
secret, then why are they here at all on a public server?), but I
think there were discussions here about it (can't find the right
keywords to dig the archives though), and other people may think
differently.

Jeff King's answer in <20090405195714.GA4716@coredump.intra.peff.net>
tackles this problem too.

-- 
Matthieu
