From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvs import and internal plumbing commands
Date: Tue, 21 Jul 2009 20:06:52 -0700
Message-ID: <7vfxcpv2k3.fsf@alter.siamese.dyndns.org>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
 <20090717214523.GA29955@coredump.intra.peff.net>
 <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
 <20090720153400.GE5347@coredump.intra.peff.net>
 <24155F0E-E467-48EC-9E83-254877B4E786@gmail.com>
 <7vmy6x35ur.fsf@alter.siamese.dyndns.org>
 <20090722025934.GB31254@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Stubbs <antony.stubbs@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 22 05:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTSAi-0005YJ-Bc
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 05:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbZGVDHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 23:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbZGVDHA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 23:07:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbZGVDHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 23:07:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DC51DDD8;
	Tue, 21 Jul 2009 23:06:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A458ADDD7; Tue, 21 Jul 2009
 23:06:54 -0400 (EDT)
In-Reply-To: <20090722025934.GB31254@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 21 Jul 2009 22\:59\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B86AB212-766C-11DE-A68C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123738>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 21, 2009 at 05:43:08PM -0700, Junio C Hamano wrote:
>
>> Note that my suggestion on $PATH=$(git --exec-path):$PATH was a response
>> to Jeff's message, which was the same message your patch was response to.
>> In other words, our messages crossed, and I do not have an issue with
>> fixing this either way.  If your patch fixes the issue correctly that
>> would be great.
>
> I am still confused about what the "issue" is. That is, why this is a
> bugfix for Anthony instead of simply a code modernization. IOW, I think
> there is something else broken about his install if cvsimport cannot
> find the dashed plumbing commands, and we may simply be papering over
> it.

I simply assumed that he was a correct install but for whatever crazy
reason is running /usr/local/libexec/git-core/git-cvsimport directly from
the command line.  That usage won't be helped with the git wrapper at all.

I suspect shell scripted Porcelains like "git-pull" have the same issue,
as we do not seem to have "prepend to PATH" in git-sh-setup.sh at all.
Some like git-gui and instaweb do protect themselves, though.

> That being said, I think the code modernization is of value itself, so
> let's do it.

Agreed, and thanks.
