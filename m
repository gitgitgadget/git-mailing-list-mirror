From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Mon, 26 Jan 2009 20:58:30 -0800
Message-ID: <7vskn51h1l.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>
 <7vpribdszr.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
 <alpine.DEB.1.00.0901261141070.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 06:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRg3Q-0002y5-7T
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 06:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbZA0E6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZA0E6k
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:58:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbZA0E6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:58:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BA61B1D60D;
	Mon, 26 Jan 2009 23:58:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DCA891D5BF; Mon,
 26 Jan 2009 23:58:32 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901261141070.14855@racer> (Johannes
 Schindelin's message of "Mon, 26 Jan 2009 11:41:30 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27DEA8EC-EC2F-11DD-AE1D-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107311>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> curl strdup's it, so this is safe.
>
> I might have mentioned that things like this _need_ to go into the commit 
> message.

Yeah, and let's not forget advice from Daniel Stenberg.

    I'm not sure what the oldest possibly libcurl version git can deal
    with, but here's a related quote from the curl_easy_setopt man page:

           NOTE: before 7.17.0 strings were  not  copied.  Instead  the  user  was
           forced keep them available until libcurl no longer needed them.
