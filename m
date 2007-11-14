From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clean won't read global ignore
Date: Wed, 14 Nov 2007 01:03:05 -0800
Message-ID: <7vzlxhjj1y.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org> <473AB508.4090109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsE9j-0004D3-6K
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXKNJDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 04:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbXKNJDN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:03:13 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54510 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbXKNJDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:03:12 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C7C6A2EF;
	Wed, 14 Nov 2007 04:03:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 375DF94565;
	Wed, 14 Nov 2007 04:03:29 -0500 (EST)
In-Reply-To: <473AB508.4090109@op5.se> (Andreas Ericsson's message of "Wed, 14
	Nov 2007 09:42:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64966>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> (this is against 'maint', as I was in the middle of
>> something else that is based on 'maint' when I started reading
>> this thread).
>>
>
> That's probably not a bad idea, as it really is a bug, and one
> that can cause data-loss at that.

I agree that "git clean" needs to be fixed in 'maint', but the
thing is, setup_standard_excludes() approach would not apply to
anything in 'maint', 'master', nor 'next', and it is more of the
longer term thing to go together with the git-clean in C.

The scripted version needs to be fixed independently in a way
with lessor impact, like the patch Shunichi just posted.
