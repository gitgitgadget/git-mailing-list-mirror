From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 01:35:59 -0800
Message-ID: <7v1vu1webk.fsf@gitster.siamese.dyndns.org>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGxv-0003Ef-Ut
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbZBNJgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZBNJgK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:36:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZBNJgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:36:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D68C992B2;
	Sat, 14 Feb 2009 04:36:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B5DB992B1; Sat,
 14 Feb 2009 04:36:01 -0500 (EST)
In-Reply-To: <7vab8pweod.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 14 Feb 2009 01:28:18 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7124D5A-FA7A-11DD-8032-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109850>

Junio C Hamano <gitster@pobox.com> writes:

>> +	OPT_STRING(0, "get-color", &get_color_name, "name", "find the color configured: [default]"),
>
> get-color is used to get the defined color for a given slot.  Please do not
> rename it to "name" (see the original).
>
>> +	OPT_STRING(0, "get-colorbool", &get_colorbool_name, "name", "find the color setting: [stdout-is-tty]"),
>
> get-colorbool is used to get the boolean setting for a given configuration
> variable.  Please do not rename it to "name" (see the original).
>

By the way, I think it might be more appropriate if you categorize the
above two (especially the "colorbool" one) in the "Types" section, as that
really is what is happening.  Instead of doing the usual "print the value
as a string", it does something magical.

> Overall, with the same number of lines, we lost a lot of error checking in
> exchange for an ability to say "git config --remove-sec" instead of "git
> config --remove-section", and "git config --help" may give an easier to
> read message.

And I forgot to mention the "option categorization" merit.

> Given that "git config" is primarily meant for script use, this particular
> round does not look like a good tradeoff to me.

Don't take this too negatively.  The tradeoff will improve if there aren't
these obvious bugs you can spot without even running the code.
