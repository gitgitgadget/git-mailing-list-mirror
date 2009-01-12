From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/git-mailsplit.txt: Emphasize -o more
Date: Mon, 12 Jan 2009 14:06:28 -0800
Message-ID: <7vhc44gowr.fsf@gitster.siamese.dyndns.org>
References: <877i50jjs8.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Jan 12 23:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUxQ-0007HG-5a
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbZALWGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbZALWGh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:06:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322AbZALWGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:06:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 129971C57C;
	Mon, 12 Jan 2009 17:06:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C83DD1C57B; Mon,
 12 Jan 2009 17:06:30 -0500 (EST)
In-Reply-To: <877i50jjs8.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Tue, 13 Jan 2009 05:28:55 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46378448-E0F5-11DD-B53C-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105399>

jidanni@jidanni.org writes:

> The need for -o cannot be overstated. Else the arguments get
> interpreted differently.

I do not think there is any ambiguity with the existing SYNOPSIS.

'git mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>|<Maildir>...]

> +REQUIRED OPTIONS
> +-------
> +-o<directory>::
> +	Directory in which to place the individual messages.
> +	-o is required or else arguments may be misinterpreted in a
> +	backwards compatibility mode.
> +

I think you are being overly alarmist without being helpful.

You hint that there is a backwards compatible syntax but you do not say
what it is, and you hint that the backwards compatible syntax is bad in
some unspecified way by saying "misinterpreted", without substantiating
the claim in any way.

The worst part in the new description is "may be", which only injects FUD
("is my use trigger that pitfall? how do I decide? the manual page does
not say!") without being helpful at all to the readers.

Probably a better alternative would be to describe what the backward
compatible syntax is and what it does (which I won't do here), and mention
something like the attached patchlet, without moving where -o<dir> is
described, _if_ you want to talk about it.

diff --git i/Documentation/git-mailsplit.txt w/Documentation/git-mailsplit.txt
index 5cc94ec..1b12014 100644
--- i/Documentation/git-mailsplit.txt
+++ w/Documentation/git-mailsplit.txt
@@ -28,7 +28,10 @@ OPTIONS
 	and new subdirectories.
 
 -o<directory>::
-	Directory in which to place the individual messages.
+	Directory in which to place the individual messages.  This option
+	is required in a modern usage of the command; when omitted, the
+	arguments are parsed differently and the command works in a
+	backward compatible mode (see below).
 
 -b::
 	If any file doesn't begin with a From line, assume it is a
