From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 10:04:47 +0100
Message-ID: <vpq3aelcpjk.fsf@bauges.imag.fr>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	<etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
	<38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
	<20090210230054.GD26954@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio Augusto Dal Castel <fdcastel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:15:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBBS-0006mV-MV
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZBKJNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZBKJNk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:13:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:40538 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbZBKJNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:13:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1B94mWL012277
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Feb 2009 10:04:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LXB1T-0005Mk-A4; Wed, 11 Feb 2009 10:04:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LXB1T-0001ga-6J; Wed, 11 Feb 2009 10:04:47 +0100
In-Reply-To: <20090210230054.GD26954@coredump.intra.peff.net> (Jeff King's message of "Tue\, 10 Feb 2009 18\:00\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 11 Feb 2009 10:04:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109386>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 10, 2009 at 06:40:34PM -0200, Fabio Augusto Dal Castel wrote:
>
>> Remember that 'stash' is actually TWO commands in one:
>> * Save current state
>> * Reset to HEAD
>> 
>> My primary reason to use snapshots is to AVOID the second step.
>
> Doesn't that argue for "git stash --no-reset" or similar instead of a
> separate command?

I also think adding options to "git stash" would be better than
creating a new command. The "git has too many commands" is already one
of the blocking factors for newcommers.

And indeed, I don't think the choice in the comparison table between
stash and snapshot should be all-or-nothing. There could be individual
options like --save-untracked, --per-branch, ... (--no-reset would
probably be redundant with stash create, but maybe stash create needs
a --keep-object-somewhere-in-a-reference like option). Then, having
"git snapshot" would just be a matter of creating the accurate alias.

-- 
Matthieu
