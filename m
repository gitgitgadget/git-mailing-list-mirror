From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Mon, 23 Feb 2009 08:33:37 -0800
Message-ID: <7v8wnxun8e.fsf@gitster.siamese.dyndns.org>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
 <20090222230620.GB19011@coredump.intra.peff.net>
 <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org>
 <20090223031631.GC22348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdmR-0004d0-Fs
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbZBWQdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbZBWQdu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:33:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbZBWQdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:33:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EF749CC95;
	Mon, 23 Feb 2009 11:33:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BED829CC88; Mon,
 23 Feb 2009 11:33:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE54972A-01C7-11DE-B87B-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111153>

Jeff King <peff@peff.net> writes:

> I thought about that, but I wanted to keep the maximum size down for
> column output (like in git-blame). Which is why I bumped the "use
> months" limit to 24 months instead of 12.
>
> And that limit can also be tweaked.  Surely at some point there is a
> range where you no longer care about the months and "N years" has high
> enough resolution. But there is also a point where "N months" gets
> cumbersome (75 months is a more annoying than "around 6 years"). The
> question is whether we reach the "cumbersome" point before we reach the
> "don't care about months" point.

Yes, "75 months" is unacceptable.  I suspect people's mind would not work
well with anything larger than 60 months.  I've actually thought about
"don't care about months" point, but 12 months is a long time.  You
certainly remember there still was a noticeable maturity difference
between classmates who were born in the earliest months of the school year
and in the last months before graduating grade school.  Perhaps after 20
years.

> Another option would to give higher resolution in number of years, like
> "3.5 years" or even "3.1 years".

But I do not think people think of years in terms of decimal fraction.
