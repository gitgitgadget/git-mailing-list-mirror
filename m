From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH&RFC] get_short_ref(): add strict mode
Date: Sat, 11 Apr 2009 12:23:03 -0700
Message-ID: <7vr5zzdmg8.fsf@gitster.siamese.dyndns.org>
References: <36ca99e90810172355n2c578b07pd2868b15e6631ef7@mail.gmail.com>
 <1239470086-13818-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipG-0004sO-Pe
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939AbZDKTXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758936AbZDKTXL
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:23:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919AbZDKTXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:23:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A14EAA9E62;
	Sat, 11 Apr 2009 15:23:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 53956A9E61; Sat,
 11 Apr 2009 15:23:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31169CD8-26CE-11DE-AB86-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116326>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> I think of 3 alternatives to use this mode for the "refname" format (and
> probably others):
>
>   a) Use core.warnAmbiguousRefs to control strict mode.
>      This would change the current default behaviour, because this is true
>      by default.
>
>   b) Introduce a new core config variable to control this, either for
>      for-each-ref alone ore globally.
>
>   c) Introduce a "refname:short-strict" format to get the strict abbreviation.
>
> I'm currently slighty in favour for option b).

Your earlier http://thread.gmane.org/gmane.comp.version-control.git/96464
made a lot of sense to me.  The request "refname:short" cannot be for use
by scripts (well, scripts may pass it to for-each-ref but that has to be
for final consumption by humans wanting to view the names in a format not
overly long, as opposed to scripts using for-each-ref to extract
unambiguous names to be used for further processing, in which case they
would be using "refname" without ":short"), so I do not see "change the
current default behaviour" is a bad thing at all.  If anything, it is an
improvement, isn't it?
