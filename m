From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Wed, 12 Aug 2009 17:55:39 -0700
Message-ID: <7vzla4r0qc.fsf@alter.siamese.dyndns.org>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
 <1250036031-32272-3-git-send-email-johan@herland.net>
 <20090812021017.GB62301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	barkalow@iabervon.org, Johannes.Schindelin@gmx.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbObm-0005WZ-B6
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 02:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbZHMAzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 20:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZHMAzs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 20:55:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZHMAzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 20:55:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72E0327F29;
	Wed, 12 Aug 2009 20:55:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 812A027F28; Wed, 12 Aug 2009
 20:55:41 -0400 (EDT)
In-Reply-To: <20090812021017.GB62301@gmail.com> (David Aguilar's message of
 "Tue\, 11 Aug 2009 19\:10\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A4527F0-87A4-11DE-B22C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125762>

David Aguilar <davvid@gmail.com> writes:

> This also had me wondering about the following:
> 	git uses tabs for indentation

Not relevant.  That is a rule for our "C" source code.  We also use it in
our Perl scripts and shell scripts because there is no single "one right
way" that is strongly defined and everybody adheres to, like the 4-space
rule Python folks have.

> BUT, the python convention is to use 4-space indents ala PEP-8
> http://www.python.org/dev/peps/pep-0008/
>
> It might be appealing to when-in-Rome (Rome being Python) here
> and do things the python way when we code in Python.

Yes, this is more important.

>> +		if len(msg) > 25: msg = msg[:22] + "..." # Max 25 chars long
>> +		return "<Changeset @(%s) by %s (%s) updating %i files>" % (
>> +			self.date, self.author, msg, len(self.revs))
>
> Similar to the git coding style, this might be better written:

So is this one.  If experienced Python folks also frown on single-line
conditionals, then by all means please update this.  But if this
suggestion is solely because we don't do a single-line conditional in our
C source code, then please do not insist on it too strongly.  The code
should look familiar to Pythonistas with good tastes (if such a class of
people exist, that is ;-)).
