From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git send-email: turn --compose on when more than one
 patch.
Date: Tue, 04 Nov 2008 23:03:42 -0800
Message-ID: <7viqr2mz75.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <1225815858-30617-4-git-send-email-madcoder@debian.org>
 <1225815858-30617-5-git-send-email-madcoder@debian.org>
 <1225815858-30617-6-git-send-email-madcoder@debian.org>
 <7vprlbnj1t.fsf@gitster.siamese.dyndns.org>
 <20081105033151.GB24886@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 08:05:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxcSZ-0002n6-JT
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 08:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbYKEHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 02:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYKEHEH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 02:04:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYKEHEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 02:04:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D486079642;
	Wed,  5 Nov 2008 02:04:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9FD9A7963D; Wed,
  5 Nov 2008 02:03:49 -0500 (EST)
In-Reply-To: <20081105033151.GB24886@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 4 Nov 2008 22:31:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EEAE25BA-AB07-11DD-8CD4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100149>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 04, 2008 at 03:54:54PM -0800, Junio C Hamano wrote:
>
>> Pierre Habouzit <madcoder@debian.org> writes:
>> 
>> > Automatically turn --compose on when there is more than one patch, and
>> > that the output is a tty.
>> 
>> I do not think this is a good idea.  I suspect I am not the only person
>> who uses "format-patch --cover-letter", edit the files to review and
>> prepare, and runs send-email to fire them off.
>
> Maybe a config option to turn this behavior on? It seems specific to
> different workflows (i.e., whether or not you are using "git send-email
> $REVS" or using format-patch first).

Yeah, if send-email did not have --compose to begin with, we could just
say "don't use --compose; use --cover-letter when you use send-email to
front-end format-patch instead", but some people perhaps are used to run
format-patch separately without --cover-letter and then create the cover
letter from scratch with --compose (which seems a bit more work to me,
though).

So I am not opposed to a sendemail.foo configuration option.
