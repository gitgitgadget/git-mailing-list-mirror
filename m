From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Sun, 22 Feb 2009 17:44:37 -0800
Message-ID: <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
 <20090222230620.GB19011@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 02:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbPth-0006oz-Br
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 02:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbZBWBot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 20:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZBWBot
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 20:44:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZBWBos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 20:44:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4DE39C5A0;
	Sun, 22 Feb 2009 20:44:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CF9D9C59F; Sun,
 22 Feb 2009 20:44:38 -0500 (EST)
In-Reply-To: <20090222230620.GB19011@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 22 Feb 2009 18:06:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C6D2AFA-014B-11DE-A851-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111070>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 20, 2009 at 01:23:54PM -0800, eletuchy@gmail.com wrote:
>
>> From: Eugene Letuchy <eugene@facebook.com>
>> 
>> In the context of sizing the git blame time column, it doesn't make a
>> lot of sense to see "12 months ago" next to an exact timestamp +
>> timezone for something 13 months ago. This commit makes commits older
>> than 12 months display the date only, not the time.
>
> I think this is an improvement, though I was thinking of taking it a
> step further:
> ...
> +		/* Otherwise, years. Centuries is probably overkill. */
> +		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
> +		return timebuf;
>  	}
>  
>  	if (mode == DATE_LOCAL)
>
>
> but maybe other people actually like seeing the absolute time. I've
> always found it jarring when reading relative times (but part of that
> _was_ because it was so long and exact).

I agree this is an improvement.  It irritated me, too.  And I do not think
this change falls into the category of bad backward incompatibility.

I was hoping somebody would do a "N years M months", though.
