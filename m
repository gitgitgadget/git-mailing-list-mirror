From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff bug?
Date: Mon, 06 Apr 2009 10:56:41 -0700
Message-ID: <7vskkl64yu.fsf@gitster.siamese.dyndns.org>
References: <m2ocvdkyul.fsf@boostpro.com>
 <20090404014527.GA13350@coredump.intra.peff.net>
 <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
 <20090406155303.GA3275@sigill.intra.peff.net>
 <vpqeiw53cpy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Abrahams <dave@boostpro.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 06 19:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqt5T-0003HX-Hx
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbZDFR4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbZDFR4w
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:56:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZDFR4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:56:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4146A89EC;
	Mon,  6 Apr 2009 13:56:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CCF7A89E9; Mon,
  6 Apr 2009 13:56:42 -0400 (EDT)
In-Reply-To: <vpqeiw53cpy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 06 Apr 2009 19:37:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D112802-22D4-11DE-A926-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115860>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> But the latter two lines are about preference: "here is how _I_ would
>> like to generate diffs for el files".
>
> ... and they are commands to be executed. If they were in the
> repository, and propagated with clone, then doing
>
> git clone git://some.git/repo
> cd repo
> git diff
>
> would execute arbitrary commands, which wouldn't be acceptable for
> security reasons.

Other configuration variables have such security implications, but diff
hunk header bit doesn't.  You are a bit overly cautious in this particular
case.
