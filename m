From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 01:42:21 -0700
Message-ID: <7v8wirirki.fsf@alter.siamese.dyndns.org>
References: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net>
 <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com>
 <20090714082059.GA13808@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdbs-0001wV-Jg
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbZGNImf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbZGNImf
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:42:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZGNImc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 04:42:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 801581201;
	Tue, 14 Jul 2009 04:42:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D68A011FE; Tue,
 14 Jul 2009 04:42:24 -0400 (EDT)
In-Reply-To: <20090714082059.GA13808@vidovic> (Nicolas Sebrecht's message of
 "Tue\, 14 Jul 2009 10\:20\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43391102-7052-11DE-94FC-BF7EB3670A22-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123230>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> And why should we accept "From "?

You are going totally in a wrong way around with this.

Berkeley mbox format is what we support, and "From " is the _only_
delimiter between pieces of e-mail in the file.  We happen to allow "From:
" in order to merely be extra nice for people who create mbox looking file
by hand; I think it is an improvement not to require an optional SP after
the colon there, but that is totally an independent issue.

I cannot offhand say if allowing anything but "From:" is necessarily an
improvement, or making the format detection unnecessarily risky of
misidentification.  I do not particularly like the idea of allowing only
some randomly selected fields like Return-Path and Delibered-To and not
accepting others, let alone totally nonstandard X-Foo fields.
