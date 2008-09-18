From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Thu, 18 Sep 2008 01:35:57 -0700
Message-ID: <7vbpylzw9e.fsf@gitster.siamese.dyndns.org>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
 <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil> <7vod2m1464.fsf@gitster.siamese.dyndns.org> <48D1F80C.5030502@op5.se> <7vod2myljk.fsf@gitster.siamese.dyndns.org> <48D20C04.1020703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 18 10:38:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgF1T-0005V3-As
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 10:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYIRIgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 04:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbYIRIgT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 04:36:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYIRIgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 04:36:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9191762AB2;
	Thu, 18 Sep 2008 04:36:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB1FB62AB0; Thu, 18 Sep 2008 04:36:04 -0400 (EDT)
In-Reply-To: <48D20C04.1020703@op5.se> (Andreas Ericsson's message of "Thu,
 18 Sep 2008 10:06:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAD412AA-855C-11DD-90A9-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96182>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
> ...
> I think it makes perfect sense to use whatever we pass when compiling
> the regex. I wouldn't dare try to hack up something that pre-mangles
> a regular expression and assume it gets it right everywhere anyway, so
> I'm quite happy with leaving it all to regcomp(3) and friends.

Oh, I never meant pre-mangling or anything funky like that.

What I was envisioning we might want to make more flexible was what we
build on top of regexp, such as the way how these multi-line stuff is
treated for example.  Currently more than one positive regexp concatenated
with "\n" are ANDed together and the captured string from the last one is
used, but it is plausible we might want to say "first positive capturing
match yields result for this pattern string", or something like that.

>> Thanks --- I am bit under the weather and not thinking quite straight.
>
> Mix 2cc's of 7yo Havana Club into a large cup of tea. Drink one such
> cup every hour and eat a fresh fruit with it. I haven't been ill a day
> in my life since I came up with that most excellent cure for absolutely
> everything. If nothing else, it makes it a bit less boring to be ill.

Heh, unfortunately I happen to live in the US.
