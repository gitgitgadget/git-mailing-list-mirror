From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a
 bit
Date: Mon, 13 Apr 2009 13:51:59 -0700
Message-ID: <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtT9w-0000hc-SU
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZDMUwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbZDMUwH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:52:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZDMUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 16:52:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BAFCEECD1;
	Mon, 13 Apr 2009 16:52:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0E975ECCF; Mon,
 13 Apr 2009 16:52:00 -0400 (EDT)
In-Reply-To: <1239647037-15381-6-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Mon, 13 Apr 2009 13:23:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F149A0F0-286C-11DE-BBF3-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116484>

Michael Witten <mfwitten@gmail.com> writes:

> All usage text lines should be < 80 characters.
>
> A port number in --smtp-server is no longer handled,
> so the suggestion has been removed.

That makes it sound like there is a regression.

	require Net::SMTP;
	$smtp ||= Net::SMTP->new((defined $smtp_server_port)
				 ? "$smtp_server:$smtp_server_port"
				 : $smtp_server);

and because Net::SMTP is a subclass of IO::Socket::INET, I'd assume that
this use will accept smtp_server=there:submission when $smtp_server_port
is undef.

> ---in-reply-to=<identifier>::
> +--in-reply-to=<message-id>::

Changes along this line in your patch looked sensible, except for the
"identity" one which is a bit iffy.

Other than that I think the patch is sane.
