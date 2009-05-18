From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii
 filenames
Date: Mon, 18 May 2009 21:35:19 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0905182132170.27823@reaper.quantumfyre.co.uk>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org>
 <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com> <20090518095044.GB910@heiko-voigts-macbook.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 22:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M69ZB-0002sS-FS
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 22:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZERUgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 16:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZERUgA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 16:36:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36972 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbZERUf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 16:35:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C24C1110A87
	for <git@vger.kernel.org>; Mon, 18 May 2009 21:35:59 +0100 (BST)
Received: (qmail 7469 invoked by uid 103); 18 May 2009 21:35:19 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9365. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026266 secs); 18 May 2009 20:35:19 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 18 May 2009 21:35:19 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20090518095044.GB910@heiko-voigts-macbook.local>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119463>

On Mon, 18 May 2009, Heiko Voigt wrote:

> +if [ "$allownonascii" != "true" ]
> +then
> +	# until git can handle non-ascii filenames gracefully
> +	# prevent them to be added into the repository
> +	if ! git diff --cached --name-only --diff-filter=A -z \
> +	   | tr "\0" "\n" | is_ascii; then
> +		echo "Error: Preventing to add a non-ascii filename."

This would read better as:

+		echo "Error: Attempt to add a non-ascii filename."

(after all the prevention itself is a result of the error, not the cause 
of it)

If you want to keep the preventing, then you need to at least correct the 
english:

> +		echo "Error: Preventing addition of a non-ascii filename."

-- 
Julian

  ---
QOTD:
 	Money isn't everything, but at least it keeps the kids in touch.
