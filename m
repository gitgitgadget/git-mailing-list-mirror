From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 09:02:44 -0800
Message-ID: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
References: <20071220203211.GA12296@bit.office.eurotux.com>
	<1198237002-21470-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luciano@eurotux.com, git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lHK-000374-43
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbXLURCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXLURCz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:02:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXLURCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:02:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DC45B0E;
	Fri, 21 Dec 2007 12:02:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A587B5B0D;
	Fri, 21 Dec 2007 12:02:46 -0500 (EST)
In-Reply-To: <1198237002-21470-1-git-send-email-hendeby@isy.liu.se> (Gustaf
	Hendeby's message of "Fri, 21 Dec 2007 12:36:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69074>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> Junio, even if this is technically not a bug fix, it would be nice to
> get this fix into the 1.5.4 so that the usage of $EDITOR becomes more
> consistent throughout git.

I can buy that, but at least a single line comment in front of that
system() explaining why this is safe to do so would be beneficial.  I
suspect that somebody would propose moving $compse_filename inside
$GIT_DIR, now people realized $compose_filename is currently "./.msg.$$",
and $GIT_DIR could be anything.  Quotemeta would probably be better as the
code you are touching won't be affected by a future change to the value of
that constant defined far away in the source.
