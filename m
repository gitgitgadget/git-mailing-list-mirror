From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 18:08:00 -0700
Message-ID: <7viqtkbpcf.fsf@gitster.siamese.dyndns.org>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
 <20080828231547.GD29609@coredump.intra.peff.net>
 <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
 <20080828235420.GB30195@coredump.intra.peff.net>
 <d77df1110808281710r6d58739fl2acb93e1940c7433@mail.gmail.com>
 <20080829005458.GA4248@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 03:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYsUG-0002LW-OL
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 03:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYH2BIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 21:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYH2BIM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 21:08:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYH2BIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 21:08:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FB7655A22;
	Thu, 28 Aug 2008 21:08:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 45D0755A1B; Thu, 28 Aug 2008 21:08:02 -0400 (EDT)
In-Reply-To: <20080829005458.GA4248@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 28 Aug 2008 20:54:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F22391E8-7566-11DD-9675-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94240>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2008 at 07:10:45PM -0500, Nathan W. Panike wrote:
>
>> The genesis of this patch was the documentation says that %ad
>> represents 'author date' without any more specific information.  I
>> thought that I could do
>> 
>> git show --date=short --pretty=format:"%ad %h"
>> 
>> and get the date in short form---but alas, this did not work.  So I
>
> Regardless of expansions to --pretty=format:, that is something we
> should probably be doing _anyway_. The current behavior is just
> confusing, and %ad is simply documented as "date", not in any particular
> format (and I think anyone relying on it _ignoring_ --date= is insane,
> since that --date is otherwise not doing anything).
>
> So how about this?
>
> -- >8 --
> pretty=format: respect date format options
>
> When running a command like:
>
>   git log --pretty=format:%ad --date=short
>
> the date option was ignored. This patch causes it to use
> whatever format was specified by --date (or by
> --relative-date, etc), just as the non-user formats would
> do.
>
> Signed-off-by: Jeff King <peff@peff.net>

Like the idea; haven't looked at the patch yet, though.
