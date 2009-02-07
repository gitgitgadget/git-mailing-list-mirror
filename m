From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 07 Feb 2009 00:48:43 -0800
Message-ID: <7v7i42y6ms.fsf@gitster.siamese.dyndns.org>
References: <200902022204.46651.toralf.foerster@gmx.de>
 <200902061149.16210.jnareb@gmail.com>
 <7vd4duzo07.fsf@gitster.siamese.dyndns.org>
 <200902070934.50555.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?utf-8?Q?F?= =?utf-8?Q?=C3=B6rster?= 
	<toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 09:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVitI-0002LS-J7
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 09:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZBGIsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 03:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbZBGIsw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 03:48:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZBGIsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 03:48:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F7812A9C0;
	Sat,  7 Feb 2009 03:48:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 53A6C2A9BE; Sat, 
 7 Feb 2009 03:48:45 -0500 (EST)
In-Reply-To: <200902070934.50555.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 7 Feb 2009 09:34:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2488517A-F4F4-11DD-8EB8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108833>

Jakub Narebski <jnareb@gmail.com> writes:

> It would unfortunately falsely match... but we cannot eliminate this
> case (well, at least not checking if hexnumber is followed by dot),
> because of totally legitimate
>
>    ... at commit 8457bb9e.
>
> So even with that we would have still false matches...

Yeah, so what's the value in v2 over v1?  It is still wrong but it is less
wrong than it used to be?  I think the word-boundary one made a good
sense.  I do not see the @lookahead adding much value at all.
