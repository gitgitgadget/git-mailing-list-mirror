From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvs import and internal plumbing commands
Date: Sun, 19 Jul 2009 19:43:28 -0700
Message-ID: <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
 <20090717214523.GA29955@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Stubbs <antony.stubbs@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 04:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSiqu-00015t-D2
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 04:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbZGTCnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 22:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbZGTCne
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 22:43:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZGTCne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 22:43:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A8024AD76;
	Sun, 19 Jul 2009 22:43:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 10FD8AD75; Sun,
 19 Jul 2009 22:43:29 -0400 (EDT)
In-Reply-To: <20090717214523.GA29955@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 17 Jul 2009 17\:45\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DF03AF4-74D7-11DE-9D40-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123566>

Jeff King <peff@peff.net> writes:

> Yes, I think it is reasonable to migrate it in any case, if only because
> it serves as an example when people read it, and we are trying to
> encourage the dashless form.

Hmm, I am of two minds.

We encourage script writers to just prepend "git --exec-path" at the
beginning of their PATH and give guarantee that this simple procedure will
keep their scripts working, so it might be a good idea to have an example
for that as well.

So the preferred fix might be just the matter of adding one line

	$ENV{'PATH'} = `git --exec-path`. ":$ENV{'PATH'}";

at the beginning of the script.
